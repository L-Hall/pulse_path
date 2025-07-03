import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Log levels for different types of messages
enum LogLevel {
  debug,
  info,
  warning,
  error,
  critical,
}

/// Error categories for better organization and filtering
enum ErrorCategory {
  ble,
  hrv,
  camera,
  database,
  sync,
  ui,
  network,
  auth,
  general,
}

/// Centralized error handling and logging service for PulsePath
/// Provides structured error reporting, user feedback, and debugging support
class ErrorHandlingService {
  static final ErrorHandlingService _instance = ErrorHandlingService._internal();
  factory ErrorHandlingService() => _instance;
  ErrorHandlingService._internal() {
    _initializeCrashlytics();
  }

  // Error statistics tracking
  final Map<ErrorCategory, int> _errorCountByCategory = {};
  final Map<LogLevel, int> _errorCountByLevel = {};
  final List<String> _recentErrors = [];
  late final DateTime _sessionStart;
  bool _crashlyticsInitialized = false;

  /// Initialize the error handling service
  void initialize() {
    _sessionStart = DateTime.now();
    _initializeCrashlytics();
    logInfo('ErrorHandlingService initialized', context: {
      'session_start': _sessionStart.toIso8601String(),
    });
  }

  /// Log an error with context and optional user notification
  void logError(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    ErrorCategory category = ErrorCategory.general,
    Map<String, dynamic>? context,
    bool notifyUser = false,
    String? userMessage,
  }) {
    _log(
      level: LogLevel.error,
      message: message,
      error: error,
      stackTrace: stackTrace,
      category: category,
      context: context,
    );

    if (notifyUser) {
      _showUserNotification(
        userMessage ?? 'An error occurred. Please try again.',
        isError: true,
      );
    }
  }

  /// Log a warning with optional context
  void logWarning(
    String message, {
    ErrorCategory category = ErrorCategory.general,
    Map<String, dynamic>? context,
  }) {
    _log(
      level: LogLevel.warning,
      message: message,
      category: category,
      context: context,
    );
  }

  /// Log informational message
  void logInfo(
    String message, {
    ErrorCategory category = ErrorCategory.general,
    Map<String, dynamic>? context,
  }) {
    _log(
      level: LogLevel.info,
      message: message,
      category: category,
      context: context,
    );
  }

  /// Log debug message (only in debug mode)
  void logDebug(
    String message, {
    ErrorCategory category = ErrorCategory.general,
    Map<String, dynamic>? context,
  }) {
    if (kDebugMode) {
      _log(
        level: LogLevel.debug,
        message: message,
        category: category,
        context: context,
      );
    }
  }

  /// Log critical errors that might require immediate attention
  void logCritical(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    ErrorCategory category = ErrorCategory.general,
    Map<String, dynamic>? context,
    bool notifyUser = true,
  }) {
    _log(
      level: LogLevel.critical,
      message: message,
      error: error,
      stackTrace: stackTrace,
      category: category,
      context: context,
    );

    if (notifyUser) {
      _showUserNotification(
        'A critical error occurred. Please restart the app.',
        isError: true,
      );
    }

    // TODO: Send critical errors to crash reporting service
    _reportCriticalError(message, error, stackTrace, context);
  }

  /// Handle BLE-specific errors with context
  void handleBleError(
    String operation,
    Object error, {
    StackTrace? stackTrace,
    String? deviceName,
    bool notifyUser = true,
  }) {
    final context = <String, dynamic>{
      'operation': operation,
      if (deviceName != null) 'deviceName': deviceName,
    };

    logError(
      'BLE operation failed: $operation',
      error: error,
      stackTrace: stackTrace,
      category: ErrorCategory.ble,
      context: context,
      notifyUser: notifyUser,
      userMessage: _getBleUserMessage(operation, error),
    );
  }

  /// Handle HRV calculation errors
  void handleHrvError(
    String operation,
    Object error, {
    StackTrace? stackTrace,
    int? rrIntervalCount,
    bool notifyUser = true,
  }) {
    final context = <String, dynamic>{
      'operation': operation,
      if (rrIntervalCount != null) 'rrIntervalCount': rrIntervalCount,
    };

    logError(
      'HRV operation failed: $operation',
      error: error,
      stackTrace: stackTrace,
      category: ErrorCategory.hrv,
      context: context,
      notifyUser: notifyUser,
      userMessage: 'HRV analysis failed. Please try capturing data again.',
    );
  }

  /// Handle camera/PPG errors
  void handleCameraError(
    String operation,
    Object error, {
    StackTrace? stackTrace,
    bool notifyUser = true,
  }) {
    final context = <String, dynamic>{
      'operation': operation,
    };

    logError(
      'Camera operation failed: $operation',
      error: error,
      stackTrace: stackTrace,
      category: ErrorCategory.camera,
      context: context,
      notifyUser: notifyUser,
      userMessage: 'Camera access failed. Please check permissions and try again.',
    );
  }

  /// Handle database errors
  void handleDatabaseError(
    String operation,
    Object error, {
    StackTrace? stackTrace,
    bool notifyUser = false,
  }) {
    final context = <String, dynamic>{
      'operation': operation,
    };

    logError(
      'Database operation failed: $operation',
      error: error,
      stackTrace: stackTrace,
      category: ErrorCategory.database,
      context: context,
      notifyUser: notifyUser,
      userMessage: 'Data operation failed. Your data is safe.',
    );
  }

  /// Internal logging method
  void _log({
    required LogLevel level,
    required String message,
    Object? error,
    StackTrace? stackTrace,
    ErrorCategory category = ErrorCategory.general,
    Map<String, dynamic>? context,
  }) {
    // Update statistics
    _updateErrorStatistics(level, category, message);
    
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = _formatLogMessage(
      timestamp: timestamp,
      level: level,
      category: category,
      message: message,
      context: context,
    );

    // Use developer.log for structured logging
    developer.log(
      logMessage,
      time: DateTime.now(),
      level: _getLogLevelValue(level),
      name: 'PulsePath.${category.name}',
      error: error,
      stackTrace: stackTrace,
    );

    // Send to Crashlytics for errors and critical issues
    if ((level == LogLevel.error || level == LogLevel.critical) && _crashlyticsInitialized) {
      _sendToCrashlytics(message, error, stackTrace, category, context);
    }

    // In debug mode, also print for immediate visibility
    if (kDebugMode) {
      debugPrint(logMessage);
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }

  /// Format log message for consistency
  String _formatLogMessage({
    required String timestamp,
    required LogLevel level,
    required ErrorCategory category,
    required String message,
    Map<String, dynamic>? context,
  }) {
    final buffer = StringBuffer();
    buffer.write('[${level.name.toUpperCase()}] ');
    buffer.write('[${category.name.toUpperCase()}] ');
    buffer.write(message);
    
    if (context != null && context.isNotEmpty) {
      buffer.write(' | Context: ${context.toString()}');
    }
    
    return buffer.toString();
  }

  /// Get numeric log level for developer.log
  int _getLogLevelValue(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
      case LogLevel.critical:
        return 1200;
    }
  }

  /// Show user notification (placeholder - implement with your UI framework)
  void _showUserNotification(String message, {bool isError = false}) {
    // TODO: Implement user notification system
    // This could integrate with SnackBar, Toast, or custom dialog system
    if (kDebugMode) {
      debugPrint('USER NOTIFICATION: $message');
    }
  }

  /// Get user-friendly BLE error messages
  String _getBleUserMessage(String operation, Object error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('permission')) {
      return 'Bluetooth permission is required. Please enable it in settings.';
    } else if (errorString.contains('disabled') || errorString.contains('off')) {
      return 'Please turn on Bluetooth and try again.';
    } else if (errorString.contains('timeout')) {
      return 'Connection timed out. Make sure your device is nearby and in pairing mode.';
    } else if (errorString.contains('disconnect')) {
      return 'Device disconnected. Please reconnect and try again.';
    } else {
      return 'Bluetooth connection failed. Please try again.';
    }
  }

  /// Initialize Firebase Crashlytics
  void _initializeCrashlytics() {
    try {
      if (!kDebugMode) {
        // Only enable Crashlytics in release mode
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
        _crashlyticsInitialized = true;
        
        // Set up Flutter error handling
        FlutterError.onError = (FlutterErrorDetails details) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        };
        
        // Set up platform error handling
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
      }
    } catch (e) {
      debugPrint('Failed to initialize Crashlytics: $e');
    }
  }

  /// Send error to Crashlytics with context
  void _sendToCrashlytics(
    String message,
    Object? error,
    StackTrace? stackTrace,
    ErrorCategory category,
    Map<String, dynamic>? context,
  ) {
    try {
      // Set custom keys for better error grouping
      FirebaseCrashlytics.instance.setCustomKey('error_category', category.name);
      FirebaseCrashlytics.instance.setCustomKey('app_section', category.name);
      
      if (context != null) {
        for (final entry in context.entries) {
          FirebaseCrashlytics.instance.setCustomKey(
            'context_${entry.key}',
            entry.value.toString(),
          );
        }
      }

      // Record the error
      if (error != null && stackTrace != null) {
        FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
          reason: message,
          fatal: false,
        );
      } else {
        FirebaseCrashlytics.instance.log(message);
      }
    } catch (e) {
      debugPrint('Failed to send error to Crashlytics: $e');
    }
  }

  /// Update error statistics
  void _updateErrorStatistics(LogLevel level, ErrorCategory category, String message) {
    // Update counters
    _errorCountByLevel[level] = (_errorCountByLevel[level] ?? 0) + 1;
    _errorCountByCategory[category] = (_errorCountByCategory[category] ?? 0) + 1;
    
    // Track recent errors (keep last 50)
    _recentErrors.add('${DateTime.now().toIso8601String()}: [$level] $message');
    if (_recentErrors.length > 50) {
      _recentErrors.removeAt(0);
    }
  }

  /// Report critical errors to external service
  void _reportCriticalError(
    String message,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  ) {
    // Send to Crashlytics as a non-fatal error
    _sendToCrashlytics(message, error, stackTrace, ErrorCategory.general, context);
    
    // Set user identifier for better debugging (if available)
    if (context?['userId'] != null) {
      FirebaseCrashlytics.instance.setUserIdentifier(context!['userId'].toString());
    }
    
    if (kDebugMode) {
      debugPrint('CRITICAL ERROR REPORTED: $message');
    }
  }

  /// Get comprehensive error statistics for debugging/monitoring
  Map<String, dynamic> getErrorStats() {
    final totalErrors = _errorCountByLevel.values.fold(0, (sum, count) => sum + count);
    
    return {
      'session_start': _sessionStart.toIso8601String(),
      'session_duration_minutes': DateTime.now().difference(_sessionStart).inMinutes,
      'total_errors': totalErrors,
      'crashlytics_enabled': _crashlyticsInitialized,
      'by_level': Map.fromEntries(
        _errorCountByLevel.entries.map((e) => MapEntry(e.key.name, e.value)),
      ),
      'by_category': Map.fromEntries(
        _errorCountByCategory.entries.map((e) => MapEntry(e.key.name, e.value)),
      ),
      'recent_errors': _recentErrors.take(10).toList(), // Last 10 errors
      'error_rate_per_minute': totalErrors > 0 && _sessionStart != null
          ? (totalErrors / DateTime.now().difference(_sessionStart).inMinutes.clamp(1, double.infinity))
          : 0.0,
    };
  }

  /// Clear error statistics (useful for testing)
  void clearStats() {
    _errorCountByCategory.clear();
    _errorCountByLevel.clear();
    _recentErrors.clear();
  }

  /// Get health check status
  Map<String, dynamic> getHealthStatus() {
    final stats = getErrorStats();
    final errorRate = stats['error_rate_per_minute'] as double;
    final totalErrors = stats['total_errors'] as int;
    
    return {
      'healthy': errorRate < 5.0 && totalErrors < 100, // Thresholds for health
      'error_rate': errorRate,
      'total_errors': totalErrors,
      'session_duration': stats['session_duration_minutes'],
      'last_error': _recentErrors.isNotEmpty ? _recentErrors.last : null,
    };
  }
}