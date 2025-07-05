import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'error_handling_service.dart';

/// Enhanced logging service for PulsePath with structured logging and performance tracking
class LoggingService {
  static final LoggingService _instance = LoggingService._internal();
  factory LoggingService() => _instance;
  LoggingService._internal();

  final ErrorHandlingService _errorHandler = ErrorHandlingService();

  /// Log HRV capture start with device info
  void logHrvCaptureStart({
    required String method, // 'camera' or 'ble'
    String? deviceName,
    Duration? expectedDuration,
  }) {
    _errorHandler.logInfo(
      'HRV capture started',
      category: ErrorCategory.hrv,
      context: {
        'method': method,
        if (deviceName != null) 'deviceName': deviceName,
        if (expectedDuration != null) 'expectedDurationSeconds': expectedDuration.inSeconds,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Log HRV capture completion with metrics
  void logHrvCaptureComplete({
    required String method,
    required Duration actualDuration,
    required int rrIntervalCount,
    required Map<String, double> metrics,
  }) {
    _errorHandler.logInfo(
      'HRV capture completed successfully',
      category: ErrorCategory.hrv,
      context: {
        'method': method,
        'actualDurationSeconds': actualDuration.inSeconds,
        'rrIntervalCount': rrIntervalCount,
        'rmssd': metrics['rmssd'],
        'meanRr': metrics['meanRr'],
        'sdnn': metrics['sdnn'],
        'qualityScore': _calculateDataQuality(rrIntervalCount, actualDuration),
      },
    );
  }

  /// Log BLE device connection events
  void logBleDeviceConnection({
    required String deviceName,
    required String deviceAddress,
    required bool success,
    Duration? connectionTime,
    String? error,
  }) {
    if (success) {
      _errorHandler.logInfo(
        'BLE device connected successfully',
        category: ErrorCategory.ble,
        context: {
          'deviceName': deviceName,
          'deviceAddress': deviceAddress,
          if (connectionTime != null) 'connectionTimeMs': connectionTime.inMilliseconds,
        },
      );
    } else {
      _errorHandler.logWarning(
        'BLE device connection failed',
        category: ErrorCategory.ble,
        context: {
          'deviceName': deviceName,
          'deviceAddress': deviceAddress,
          'error': error,
        },
      );
    }
  }

  /// Log BLE heart rate data quality
  void logBleDataQuality({
    required int rrIntervalCount,
    required Duration elapsed,
    required double averageHeartRate,
    required int droppedPackets,
  }) {
    final quality = _calculateDataQuality(rrIntervalCount, elapsed);
    
    _errorHandler.logInfo(
      'BLE data quality report',
      category: ErrorCategory.ble,
      context: {
        'rrIntervalCount': rrIntervalCount,
        'elapsedSeconds': elapsed.inSeconds,
        'averageHeartRate': averageHeartRate,
        'droppedPackets': droppedPackets,
        'qualityScore': quality,
        'qualityLevel': _getQualityLevel(quality),
      },
    );

    if (quality < 0.7) {
      _errorHandler.logWarning(
        'Poor BLE data quality detected',
        category: ErrorCategory.ble,
        context: {
          'qualityScore': quality,
          'recommendation': 'Check device connection and positioning',
        },
      );
    }
  }

  /// Log camera PPG capture quality
  void logCameraPpgQuality({
    required int frameCount,
    required Duration captureTime,
    required double averageSignalStrength,
    required int validFrames,
  }) {
    final quality = validFrames / frameCount;
    
    _errorHandler.logInfo(
      'Camera PPG quality report',
      category: ErrorCategory.camera,
      context: {
        'totalFrames': frameCount,
        'validFrames': validFrames,
        'captureTimeSeconds': captureTime.inSeconds,
        'averageSignalStrength': averageSignalStrength,
        'qualityScore': quality,
        'qualityLevel': _getQualityLevel(quality),
      },
    );

    if (quality < 0.8) {
      _errorHandler.logWarning(
        'Suboptimal camera PPG quality',
        category: ErrorCategory.camera,
        context: {
          'qualityScore': quality,
          'recommendation': 'Ensure steady finger placement and good lighting',
        },
      );
    }
  }

  /// Log database operations with performance metrics
  void logDatabaseOperation({
    required String operation,
    required bool success,
    Duration? duration,
    int? recordCount,
    String? error,
  }) {
    if (success) {
      _errorHandler.logInfo(
        'Database operation completed',
        category: ErrorCategory.database,
        context: {
          'operation': operation,
          if (duration != null) 'durationMs': duration.inMilliseconds,
          if (recordCount != null) 'recordCount': recordCount,
        },
      );

      // Log performance warnings for slow operations
      if (duration != null && duration.inMilliseconds > 1000) {
        _errorHandler.logWarning(
          'Slow database operation detected',
          category: ErrorCategory.database,
          context: {
            'operation': operation,
            'durationMs': duration.inMilliseconds,
            'threshold': 1000,
          },
        );
      }
    } else {
      _errorHandler.logError(
        'Database operation failed',
        category: ErrorCategory.database,
        context: {
          'operation': operation,
          'error': error,
        },
      );
    }
  }

  /// Log sync operations
  void logSyncOperation({
    required String operation,
    required bool success,
    int? recordsSynced,
    Duration? duration,
    String? error,
  }) {
    if (success) {
      _errorHandler.logInfo(
        'Sync operation completed',
        category: ErrorCategory.sync,
        context: {
          'operation': operation,
          if (recordsSynced != null) 'recordsSynced': recordsSynced,
          if (duration != null) 'durationMs': duration.inMilliseconds,
        },
      );
    } else {
      _errorHandler.logWarning(
        'Sync operation failed',
        category: ErrorCategory.sync,
        context: {
          'operation': operation,
          'error': error,
        },
      );
    }
  }

  /// Log app performance metrics
  void logPerformanceMetric({
    required String metric,
    required double value,
    String? unit,
    Map<String, dynamic>? context,
  }) {
    _errorHandler.logInfo(
      'Performance metric',
      context: {
        'metric': metric,
        'value': value,
        if (unit != null) 'unit': unit,
        'timestamp': DateTime.now().toIso8601String(),
        ...?context,
      },
    );
  }

  /// Log user actions for analytics
  void logUserAction({
    required String action,
    String? screen,
    Map<String, dynamic>? parameters,
  }) {
    _errorHandler.logInfo(
      'User action',
      category: ErrorCategory.ui,
      context: {
        'action': action,
        if (screen != null) 'screen': screen,
        'timestamp': DateTime.now().toIso8601String(),
        ...?parameters,
      },
    );
  }

  /// Calculate data quality score based on RR intervals and duration
  double _calculateDataQuality(int rrIntervalCount, Duration duration) {
    // Expected RR intervals for a given duration (assuming ~60 BPM baseline)
    final expectedIntervals = duration.inSeconds;
    final ratio = rrIntervalCount / expectedIntervals;
    
    // Quality score from 0.0 to 1.0
    // - 1.0 = perfect capture (60+ intervals per minute)
    // - 0.8 = good (40-59 intervals per minute)
    // - 0.6 = acceptable (30-39 intervals per minute)
    // - < 0.6 = poor (< 30 intervals per minute)
    return (ratio * 0.8).clamp(0.0, 1.0);
  }

  /// Get quality level string for human-readable logging
  String _getQualityLevel(double quality) {
    if (quality >= 0.9) return 'excellent';
    if (quality >= 0.8) return 'good';
    if (quality >= 0.7) return 'acceptable';
    if (quality >= 0.5) return 'poor';
    return 'very_poor';
  }

  /// Performance timing helper
  Future<T> timeOperation<T>(
    String operationName,
    Future<T> Function() operation, {
    ErrorCategory? category,
  }) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final result = await operation();
      stopwatch.stop();
      
      logPerformanceMetric(
        metric: '${operationName}_duration',
        value: stopwatch.elapsedMilliseconds.toDouble(),
        unit: 'ms',
        context: {'operation': operationName, 'success': true},
      );
      
      return result;
    } catch (error, stackTrace) {
      stopwatch.stop();
      
      _errorHandler.logError(
        'Operation failed: $operationName',
        error: error,
        stackTrace: stackTrace,
        category: category ?? ErrorCategory.general,
        context: {
          'operation': operationName,
          'durationMs': stopwatch.elapsedMilliseconds,
        },
      );
      
      rethrow;
    }
  }

  /// Debug performance tracking
  void trackMemoryUsage(String operation) {
    if (kDebugMode) {
      // TODO: Implement memory usage tracking for debug builds
      developer.log(
        'Memory tracking for: $operation',
        name: 'PulsePath.Performance',
      );
    }
  }
}