import 'dart:async';
import 'package:flutter/foundation.dart';
import 'ble_heart_rate_service.dart';
import '../../../hrv/domain/services/hrv_calculation_service.dart';
import '../../../hrv/domain/services/hrv_scoring_service.dart';
import '../../../dashboard/data/repositories/hrv_repository_interface.dart';
import '../../../../shared/models/hrv_reading.dart';

/// Service that integrates BLE heart rate data with HRV analysis
/// 
/// Creates a real-time pipeline: BLE HR → RR intervals → HRV analysis → Storage
class BleHrvIntegrationService {
  final BleHeartRateService _bleService;
  final HrvCalculationService _calculationService;
  final HrvScoringService _scoringService;
  final HrvRepositoryInterface _repository;

  StreamSubscription<HeartRateReading>? _heartRateSubscription;
  final List<double> _rrIntervalBuffer = [];
  final StreamController<BleHrvCaptureProgress> _progressController = 
      StreamController<BleHrvCaptureProgress>.broadcast();
  
  Timer? _captureTimer;
  DateTime? _captureStartTime;
  bool _isCapturing = false;

  BleHrvIntegrationService({
    required BleHeartRateService bleService,
    required HrvCalculationService calculationService,
    required HrvScoringService scoringService,
    required HrvRepositoryInterface repository,
  })  : _bleService = bleService,
        _calculationService = calculationService,
        _scoringService = scoringService,
        _repository = repository;

  /// Stream of capture progress updates
  Stream<BleHrvCaptureProgress> get progressStream => _progressController.stream;

  /// Check if BLE device is connected and ready for HRV capture
  bool get isReadyForCapture {
    return _bleService.connectionState == BleConnectionState.connected && !_isCapturing;
  }

  /// Start HRV capture from connected BLE device
  Future<BleHrvCaptureResult> startHrvCapture({
    Duration duration = const Duration(minutes: 3),
  }) async {
    if (!isReadyForCapture) {
      return BleHrvCaptureResult.failure('BLE device not connected or capture already in progress');
    }

    try {
      _isCapturing = true;
      _captureStartTime = DateTime.now();
      _rrIntervalBuffer.clear();

      if (kDebugMode) {
        debugPrint('🫀 Starting BLE HRV capture for ${duration.inSeconds} seconds');
      }

      // Start progress updates
      _progressController.add(const BleHrvCaptureProgress(
        status: BleHrvCaptureStatus.starting,
        progress: 0.0,
        duration: Duration.zero,
        rrIntervalsCollected: 0,
        message: 'Starting HRV capture...',
      ));

      // Subscribe to heart rate data
      _heartRateSubscription = _bleService.heartRateStream.listen(
        _processHeartRateReading,
        onError: (Object error) {
          if (kDebugMode) {
            debugPrint('❌ Error in heart rate stream: $error');
          }
          _stopCapture();
          _progressController.add(BleHrvCaptureProgress(
            status: BleHrvCaptureStatus.error,
            progress: 0.0,
            duration: Duration.zero,
            rrIntervalsCollected: _rrIntervalBuffer.length,
            message: 'Error reading heart rate data: $error',
          ),);
        },
      );

      // Set capture timer
      _captureTimer = Timer(duration, () {
        _finishCapture();
      });

      // Start periodic progress updates
      _startProgressUpdates(duration);

      // Wait for capture to complete
      final completer = Completer<BleHrvCaptureResult>();
      
      late StreamSubscription<BleHrvCaptureProgress> progressSub;
      progressSub = progressStream.listen((progress) {
        if (progress.status == BleHrvCaptureStatus.completed) {
          progressSub.cancel();
          completer.complete(BleHrvCaptureResult.success(progress.hrvReading!));
        } else if (progress.status == BleHrvCaptureStatus.error) {
          progressSub.cancel();
          completer.complete(BleHrvCaptureResult.failure(progress.message));
        }
      });

      return await completer.future;

    } catch (e) {
      _stopCapture();
      return BleHrvCaptureResult.failure('Failed to start HRV capture: $e');
    }
  }

  /// Stop ongoing HRV capture
  void stopCapture() {
    _stopCapture();
    _progressController.add(BleHrvCaptureProgress(
      status: BleHrvCaptureStatus.cancelled,
      progress: 0.0,
      duration: _getElapsedDuration(),
      rrIntervalsCollected: _rrIntervalBuffer.length,
      message: 'Capture cancelled by user',
    ),);
  }

  /// Process incoming heart rate reading
  void _processHeartRateReading(HeartRateReading reading) {
    if (!_isCapturing || reading.rrIntervals.isEmpty) return;

    // Add RR intervals to buffer
    for (final rrInterval in reading.rrIntervals) {
      if (_isValidRrInterval(rrInterval)) {
        _rrIntervalBuffer.add(rrInterval);
      }
    }

    if (kDebugMode && _rrIntervalBuffer.length % 10 == 0) {
      debugPrint('📈 Collected ${_rrIntervalBuffer.length} RR intervals');
    }
  }

  /// Start periodic progress updates
  void _startProgressUpdates(Duration totalDuration) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isCapturing) {
        timer.cancel();
        return;
      }

      final elapsed = _getElapsedDuration();
      final progress = elapsed.inMilliseconds / totalDuration.inMilliseconds;
      
      _progressController.add(BleHrvCaptureProgress(
        status: BleHrvCaptureStatus.capturing,
        progress: progress.clamp(0.0, 1.0),
        duration: elapsed,
        rrIntervalsCollected: _rrIntervalBuffer.length,
        message: 'Capturing HRV data... ${elapsed.inSeconds}s',
      ),);

      // Check if we have enough data early
      if (_rrIntervalBuffer.length >= 100 && elapsed.inSeconds >= 60) {
        timer.cancel();
        _finishCapture();
      }
    });
  }

  /// Finish capture and perform HRV analysis
  Future<void> _finishCapture() async {
    if (!_isCapturing) return;

    try {
      _progressController.add(BleHrvCaptureProgress(
        status: BleHrvCaptureStatus.analyzing,
        progress: 1.0,
        duration: _getElapsedDuration(),
        rrIntervalsCollected: _rrIntervalBuffer.length,
        message: 'Analyzing HRV data...',
      ),);

      if (_rrIntervalBuffer.length < 30) {
        throw Exception('Insufficient RR intervals for analysis (${_rrIntervalBuffer.length} < 30)');
      }

      // Calculate HRV metrics
      final metrics = _calculationService.calculateMetrics(_rrIntervalBuffer);
      
      // Calculate HRV scores
      final scores = _scoringService.calculateScores(metrics);

      // Create HRV reading
      final reading = HrvReading(
        id: 'ble_${DateTime.now().millisecondsSinceEpoch}',
        timestamp: _captureStartTime!,
        durationSeconds: _getElapsedDuration().inSeconds,
        metrics: metrics,
        rrIntervals: List.from(_rrIntervalBuffer),
        scores: scores,
        notes: 'Captured via BLE heart rate monitor',
        tags: ['ble', 'realtime'],
      );

      // Save to repository
      await _repository.saveReading(reading);

      if (kDebugMode) {
        debugPrint('✅ HRV analysis complete - RMSSD: ${metrics.rmssd.toStringAsFixed(1)}ms');
      }

      _progressController.add(BleHrvCaptureProgress(
        status: BleHrvCaptureStatus.completed,
        progress: 1.0,
        duration: _getElapsedDuration(),
        rrIntervalsCollected: _rrIntervalBuffer.length,
        message: 'HRV capture completed successfully!',
        hrvReading: reading,
      ),);

    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error during HRV analysis: $e');
      }
      
      _progressController.add(BleHrvCaptureProgress(
        status: BleHrvCaptureStatus.error,
        progress: 1.0,
        duration: _getElapsedDuration(),
        rrIntervalsCollected: _rrIntervalBuffer.length,
        message: 'Analysis failed: $e',
      ),);
    } finally {
      _stopCapture();
    }
  }

  /// Stop capture and cleanup
  void _stopCapture() {
    _isCapturing = false;
    _heartRateSubscription?.cancel();
    _heartRateSubscription = null;
    _captureTimer?.cancel();
    _captureTimer = null;
  }

  /// Get elapsed duration since capture start
  Duration _getElapsedDuration() {
    if (_captureStartTime == null) return Duration.zero;
    return DateTime.now().difference(_captureStartTime!);
  }

  /// Validate RR interval for reasonable physiological range
  bool _isValidRrInterval(double rrInterval) {
    // Valid range: 300ms (200 BPM) to 2000ms (30 BPM)
    return rrInterval >= 300.0 && rrInterval <= 2000.0;
  }

  /// Get capture statistics
  BleHrvCaptureStats getStats() {
    return BleHrvCaptureStats(
      isCapturing: _isCapturing,
      isConnected: _bleService.connectionState == BleConnectionState.connected,
      deviceInfo: _bleService.connectedDeviceInfo,
      currentRrCount: _rrIntervalBuffer.length,
      captureStartTime: _captureStartTime,
      elapsedDuration: _getElapsedDuration(),
    );
  }

  /// Dispose resources
  void dispose() {
    _stopCapture();
    _progressController.close();
  }
}

/// Progress information for BLE HRV capture
class BleHrvCaptureProgress {
  final BleHrvCaptureStatus status;
  final double progress; // 0.0 to 1.0
  final Duration duration;
  final int rrIntervalsCollected;
  final String message;
  final HrvReading? hrvReading; // Available when completed

  const BleHrvCaptureProgress({
    required this.status,
    required this.progress,
    required this.duration,
    required this.rrIntervalsCollected,
    required this.message,
    this.hrvReading,
  });

  @override
  String toString() => 'BleHrvCaptureProgress($status, ${(progress * 100).toStringAsFixed(1)}%, $rrIntervalsCollected RR)';
}

/// Status of BLE HRV capture
enum BleHrvCaptureStatus {
  starting,
  capturing,
  analyzing,
  completed,
  cancelled,
  error,
}

/// Result of BLE HRV capture operation
class BleHrvCaptureResult {
  final bool isSuccess;
  final HrvReading? reading;
  final String? errorMessage;

  const BleHrvCaptureResult._({
    required this.isSuccess,
    this.reading,
    this.errorMessage,
  });

  factory BleHrvCaptureResult.success(HrvReading reading) {
    return BleHrvCaptureResult._(isSuccess: true, reading: reading);
  }

  factory BleHrvCaptureResult.failure(String message) {
    return BleHrvCaptureResult._(isSuccess: false, errorMessage: message);
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'BleHrvCaptureResult.success(${reading?.id})';
    } else {
      return 'BleHrvCaptureResult.failure($errorMessage)';
    }
  }
}

/// Statistics for current BLE HRV capture session
class BleHrvCaptureStats {
  final bool isCapturing;
  final bool isConnected;
  final BleDeviceInfo? deviceInfo;
  final int currentRrCount;
  final DateTime? captureStartTime;
  final Duration elapsedDuration;

  const BleHrvCaptureStats({
    required this.isCapturing,
    required this.isConnected,
    required this.deviceInfo,
    required this.currentRrCount,
    required this.captureStartTime,
    required this.elapsedDuration,
  });

  @override
  String toString() => 'BleHrvCaptureStats(capturing: $isCapturing, connected: $isConnected, RR: $currentRrCount)';
}