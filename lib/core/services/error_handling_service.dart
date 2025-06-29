import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

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
  ErrorHandlingService._internal();

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

  /// Report critical errors to external service
  void _reportCriticalError(
    String message,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  ) {
    // TODO: Integrate with Firebase Crashlytics or similar service
    if (kDebugMode) {
      debugPrint('CRITICAL ERROR REPORTED: $message');
    }
  }

  /// Get error statistics for debugging/monitoring
  Map<String, dynamic> getErrorStats() {
    // TODO: Implement error statistics tracking
    return {
      'session_start': DateTime.now().toIso8601String(),
      'total_errors': 0,
      'by_category': <String, int>{},
    };
  }
}