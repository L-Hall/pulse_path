import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'error_handling_service.dart';

/// Enhanced logging service for PulsePath with structured logging and performance tracking
class LoggingService {
  static final LoggingService _instance = LoggingService._internal();
  factory LoggingService() => _instance;
  LoggingService._internal();

  final ErrorHandlingService _errorHandler = ErrorHandlingService();
  File? _logFile;
  bool _fileLoggingEnabled = false;
  LogLevel _minimumLogLevel = LogLevel.info;
  final List<String> _logBuffer = [];
  static const int _maxLogBufferSize = 1000;
  static const int _maxLogFileSize = 5 * 1024 * 1024; // 5MB

  /// Initialize the logging service with file logging
  Future<void> initialize({
    LogLevel minimumLogLevel = LogLevel.info,
    bool enableFileLogging = true,
  }) async {
    _minimumLogLevel = minimumLogLevel;
    
    if (enableFileLogging && !kIsWeb) {
      await _initializeFileLogging();
    }
    
    _errorHandler.logInfo(
      'LoggingService initialized',
      context: {
        'file_logging_enabled': _fileLoggingEnabled,
        'minimum_log_level': minimumLogLevel.name,
      },
    );
  }

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

  /// Initialize file logging
  Future<void> _initializeFileLogging() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logDir = Directory('${directory.path}/logs');
      
      if (!await logDir.exists()) {
        await logDir.create(recursive: true);
      }
      
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      _logFile = File('${logDir.path}/pulsepath_$timestamp.log');
      _fileLoggingEnabled = true;
      
      // Write initial log entry
      await _writeToFile('=== PulsePath Logging Session Started ===');
      await _writeToFile('Timestamp: ${DateTime.now().toIso8601String()}');
      await _writeToFile('Platform: ${Platform.operatingSystem}');
      await _writeToFile('Debug Mode: $kDebugMode');
      await _writeToFile('==========================================');
      
    } catch (e) {
      debugPrint('Failed to initialize file logging: $e');
      _fileLoggingEnabled = false;
    }
  }

  /// Write log entry to file
  Future<void> _writeToFile(String logEntry) async {
    if (!_fileLoggingEnabled || _logFile == null) return;
    
    try {
      // Check file size and rotate if necessary
      if (await _logFile!.exists()) {
        final fileSize = await _logFile!.length();
        if (fileSize > _maxLogFileSize) {
          await _rotateLogFile();
        }
      }
      
      // Write to file
      await _logFile!.writeAsString(
        '$logEntry\n',
        mode: FileMode.append,
      );
      
      // Maintain buffer for quick access
      _logBuffer.add(logEntry);
      if (_logBuffer.length > _maxLogBufferSize) {
        _logBuffer.removeAt(0);
      }
      
    } catch (e) {
      debugPrint('Failed to write to log file: $e');
    }
  }

  /// Rotate log file when it gets too large
  Future<void> _rotateLogFile() async {
    if (_logFile == null) return;
    
    try {
      final directory = _logFile!.parent;
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final archiveName = '${directory.path}/pulsepath_$timestamp}_archived.log';
      
      await _logFile!.rename(archiveName);
      
      // Create new log file
      _logFile = File('${directory.path}/pulsepath_current.log');
      await _writeToFile('=== Log File Rotated ===');
      
    } catch (e) {
      debugPrint('Failed to rotate log file: $e');
    }
  }

  /// Enhanced log method with file writing
  Future<void> _logToFile({
    required LogLevel level,
    required String message,
    ErrorCategory category = ErrorCategory.general,
    Map<String, dynamic>? context,
  }) async {
    // Check if we should log this level
    if (_getLogLevelValue(level) < _getLogLevelValue(_minimumLogLevel)) {
      return;
    }
    
    final timestamp = DateTime.now().toIso8601String();
    final logEntry = _formatFileLogEntry(
      timestamp: timestamp,
      level: level,
      category: category,
      message: message,
      context: context,
    );
    
    await _writeToFile(logEntry);
  }

  /// Format log entry for file output
  String _formatFileLogEntry({
    required String timestamp,
    required LogLevel level,
    required ErrorCategory category,
    required String message,
    Map<String, dynamic>? context,
  }) {
    final buffer = StringBuffer();
    buffer.write('[$timestamp] ');
    buffer.write('[${level.name.toUpperCase()}] ');
    buffer.write('[${category.name.toUpperCase()}] ');
    buffer.write(message);
    
    if (context != null && context.isNotEmpty) {
      buffer.write(' | Context: ${context.toString()}');
    }
    
    return buffer.toString();
  }

  /// Get numeric log level value
  int _getLogLevelValue(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 1;
      case LogLevel.info:
        return 2;
      case LogLevel.warning:
        return 3;
      case LogLevel.error:
        return 4;
      case LogLevel.critical:
        return 5;
    }
  }

  /// Enhanced memory usage tracking
  void trackMemoryUsage(String operation) {
    if (kDebugMode) {
      try {
        // Get memory info from dart:io if available
        final info = ProcessInfo.currentRss;
        final memoryMB = info / (1024 * 1024);
        
        logPerformanceMetric(
          metric: 'memory_usage',
          value: memoryMB,
          unit: 'MB',
          context: {
            'operation': operation,
            'timestamp': DateTime.now().toIso8601String(),
          },
        );
        
        developer.log(
          'Memory: ${memoryMB.toStringAsFixed(2)}MB for $operation',
          name: 'PulsePath.Performance',
        );
      } catch (e) {
        developer.log(
          'Memory tracking failed for: $operation - $e',
          name: 'PulsePath.Performance',
        );
      }
    }
  }

  /// Get recent logs for debugging
  List<String> getRecentLogs({int count = 50}) {
    return _logBuffer.take(count).toList();
  }

  /// Get log file path for sharing/debugging
  String? getLogFilePath() {
    return _logFile?.path;
  }

  /// Clear old log files (keep last N files)
  Future<void> cleanupOldLogs({int keepFiles = 5}) async {
    if (_logFile == null) return;
    
    try {
      final directory = _logFile!.parent;
      final logFiles = directory
          .listSync()
          .whereType<File>()
          .where((file) => file.path.contains('pulsepath_'))
          .toList();
      
      // Sort by modification time (newest first)
      logFiles.sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));
      
      // Delete old files beyond keepFiles limit
      for (int i = keepFiles; i < logFiles.length; i++) {
        await logFiles[i].delete();
      }
      
      _errorHandler.logInfo(
        'Log cleanup completed',
        context: {
          'total_files_found': logFiles.length,
          'files_kept': keepFiles,
          'files_deleted': (logFiles.length - keepFiles).clamp(0, logFiles.length),
        },
      );
      
    } catch (e) {
      _errorHandler.logWarning(
        'Log cleanup failed',
        context: {'error': e.toString()},
      );
    }
  }

  /// Export logs for support/debugging
  Future<String?> exportLogsForSupport() async {
    if (_logFile == null || !_fileLoggingEnabled) return null;
    
    try {
      final directory = await getTemporaryDirectory();
      final exportFile = File('${directory.path}/pulsepath_logs_export.txt');
      
      final buffer = StringBuffer();
      buffer.writeln('=== PulsePath Support Log Export ===');
      buffer.writeln('Export Time: ${DateTime.now().toIso8601String()}');
      buffer.writeln('Platform: ${Platform.operatingSystem}');
      buffer.writeln('Debug Mode: $kDebugMode');
      buffer.writeln('======================================');
      buffer.writeln();
      
      // Add recent in-memory logs
      buffer.writeln('=== Recent In-Memory Logs ===');
      for (final log in _logBuffer) {
        buffer.writeln(log);
      }
      buffer.writeln();
      
      // Add current log file content
      if (await _logFile!.exists()) {
        buffer.writeln('=== Current Log File ===');
        final fileContent = await _logFile!.readAsString();
        buffer.write(fileContent);
      }
      
      await exportFile.writeAsString(buffer.toString());
      return exportFile.path;
      
    } catch (e) {
      _errorHandler.logError(
        'Failed to export logs for support',
        error: e,
        context: {'operation': 'export_logs'},
      );
      return null;
    }
  }
}