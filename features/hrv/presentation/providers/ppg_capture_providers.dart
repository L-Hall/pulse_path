import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/camera_ppg_datasource.dart';
import '../../domain/services/ppg_processing_service.dart';
import '../../../../core/di/injection_container.dart';

/// Provider for camera PPG data source
final cameraPpgDataSourceProvider = Provider<CameraPpgDataSource>((ref) {
  return sl<CameraPpgDataSource>();
});

/// Provider for PPG processing service
final ppgProcessingServiceProvider = Provider<PpgProcessingService>((ref) {
  return sl<PpgProcessingService>();
});

/// State class for PPG capture data
class PpgCaptureData {
  final bool isInitialized;
  final bool isCapturing;
  final PpgProcessingResult? processingResult;
  final String? error;

  const PpgCaptureData({
    required this.isInitialized,
    required this.isCapturing,
    this.processingResult,
    this.error,
  });

  PpgCaptureData copyWith({
    bool? isInitialized,
    bool? isCapturing,
    PpgProcessingResult? processingResult,
    String? error,
  }) {
    return PpgCaptureData(
      isInitialized: isInitialized ?? this.isInitialized,
      isCapturing: isCapturing ?? this.isCapturing,
      processingResult: processingResult ?? this.processingResult,
      error: error ?? this.error,
    );
  }
}

/// State notifier for PPG capture management
class PpgCaptureNotifier extends StateNotifier<AsyncValue<PpgCaptureData?>> {
  PpgCaptureNotifier(this._ref) : super(const AsyncValue.data(null));

  final Ref _ref;
  StreamSubscription<PpgProcessingResult>? _processingSubscription;

  /// Initialize camera and prepare for capture
  Future<void> initialize() async {
    state = const AsyncValue.loading();
    
    try {
      final dataSource = _ref.read(cameraPpgDataSourceProvider);
      final success = await dataSource.initialize();
      
      if (success) {
        state = AsyncValue.data(
          const PpgCaptureData(
            isInitialized: true,
            isCapturing: false,
          ),
        );
      } else {
        state = const AsyncValue.error(
          'Failed to initialize camera',
          StackTrace.empty,
        );
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('Camera initialization failed: $e', stackTrace);
    }
  }

  /// Start PPG capture and processing
  Future<void> startCapture() async {
    final currentState = state.value;
    if (currentState == null || !currentState.isInitialized) {
      await initialize();
    }

    try {
      final dataSource = _ref.read(cameraPpgDataSourceProvider);
      final processingService = _ref.read(ppgProcessingServiceProvider);

      // Start camera capture
      final frameStream = dataSource.startCapture();
      
      // Start PPG processing
      final processingStream = processingService.processFrameStream(frameStream);
      
      // Update state to capturing
      state = AsyncValue.data(
        (state.value ?? const PpgCaptureData(isInitialized: true, isCapturing: false))
            .copyWith(isCapturing: true),
      );
      
      // Listen to processing results
      _processingSubscription = processingStream.listen(
        (result) {
          final currentData = state.value;
          if (currentData != null) {
            state = AsyncValue.data(
              currentData.copyWith(processingResult: result),
            );
          }
        },
        onError: (Object error) {
          state = AsyncValue.error(
            'PPG processing error: $error',
            StackTrace.current,
          );
        },
      );
      
    } catch (e, stackTrace) {
      state = AsyncValue.error('Failed to start capture: $e', stackTrace);
    }
  }

  /// Stop capture and return final results
  Future<PpgCaptureResult?> stopCapture() async {
    try {
      final dataSource = _ref.read(cameraPpgDataSourceProvider);
      final processingService = _ref.read(ppgProcessingServiceProvider);
      
      // Stop camera capture
      await dataSource.stopCapture();
      
      // Stop PPG processing
      processingService.stopProcessing();
      
      // Cancel processing subscription
      await _processingSubscription?.cancel();
      _processingSubscription = null;
      
      // Get final results
      final rrIntervals = processingService.getFinalRrIntervals();
      final stats = processingService.getProcessingStats();
      
      // Update state
      state = AsyncValue.data(
        (state.value ?? const PpgCaptureData(isInitialized: true, isCapturing: false))
            .copyWith(isCapturing: false),
      );
      
      return PpgCaptureResult(
        rrIntervals: rrIntervals,
        stats: stats,
        success: rrIntervals.length >= 30, // Minimum for HRV analysis
      );
      
    } catch (e, stackTrace) {
      state = AsyncValue.error('Failed to stop capture: $e', stackTrace);
      return null;
    }
  }

  /// Dispose resources
  @override
  void dispose() {
    _processingSubscription?.cancel();
    final dataSource = _ref.read(cameraPpgDataSourceProvider);
    dataSource.dispose();
    super.dispose();
  }
}

/// Provider for PPG capture notifier
final ppgCaptureNotifierProvider = StateNotifierProvider<PpgCaptureNotifier, AsyncValue<PpgCaptureData?>>((ref) {
  return PpgCaptureNotifier(ref);
});

/// Result class for completed PPG capture
class PpgCaptureResult {
  final List<double> rrIntervals;
  final PpgProcessingStats stats;
  final bool success;

  const PpgCaptureResult({
    required this.rrIntervals,
    required this.stats,
    required this.success,
  });
}

/// Provider for camera initialization status
final cameraInitializationProvider = FutureProvider<bool>((ref) async {
  final dataSource = ref.watch(cameraPpgDataSourceProvider);
  return await dataSource.initialize();
});

/// Provider for camera permission status
final cameraPermissionProvider = FutureProvider<bool>((ref) async {
  // This would typically check permission status
  // For now, we'll assume it's part of the initialization
  return true;
});

/// Provider for PPG capture capability check
final ppgCaptureCapabilityProvider = Provider<bool>((ref) {
  // Check if device supports camera PPG capture
  // This could check for camera availability, flash support, etc.
  return true; // Simplified for now
});

/// Provider for current capture session duration
final captureSessionDurationProvider = StateProvider<Duration>((ref) {
  return Duration.zero;
});

/// Provider for capture session timer
final captureTimerProvider = StreamProvider.autoDispose<int>((ref) {
  return Stream.periodic(
    const Duration(seconds: 1),
    (count) => count,
  );
});