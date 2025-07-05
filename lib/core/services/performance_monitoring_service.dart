import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'error_handling_service.dart';
import 'logging_service.dart';

/// Performance metric types for categorization
enum PerformanceMetric {
  appStartup,
  widgetBuild,
  databaseQuery,
  networkRequest,
  hrvCalculation,
  imageProcessing,
  bleConnection,
  fileOperation,
  memoryUsage,
  batteryUsage,
}

/// Performance monitoring and health check service for PulsePath
/// Tracks app performance metrics, system health, and provides alerting
class PerformanceMonitoringService {
  static final PerformanceMonitoringService _instance = PerformanceMonitoringService._internal();
  factory PerformanceMonitoringService() => _instance;
  PerformanceMonitoringService._internal();

  final ErrorHandlingService _errorHandler = ErrorHandlingService();
  late final LoggingService _logger;
  
  // Performance tracking
  final Map<String, Stopwatch> _activeTimers = {};
  final Map<PerformanceMetric, List<double>> _performanceHistory = {};
  final Map<String, int> _operationCounts = {};
  
  // System health monitoring
  Timer? _healthCheckTimer;
  final Map<String, dynamic> _systemHealth = {};
  final List<String> _performanceAlerts = [];
  
  // Performance thresholds (in milliseconds)
  static const Map<PerformanceMetric, double> _performanceThresholds = {
    PerformanceMetric.appStartup: 3000,      // 3 seconds
    PerformanceMetric.widgetBuild: 16,       // 16ms for 60fps
    PerformanceMetric.databaseQuery: 100,    // 100ms
    PerformanceMetric.networkRequest: 5000,  // 5 seconds
    PerformanceMetric.hrvCalculation: 500,   // 500ms
    PerformanceMetric.imageProcessing: 1000, // 1 second
    PerformanceMetric.bleConnection: 10000,  // 10 seconds
    PerformanceMetric.fileOperation: 1000,   // 1 second
  };

  bool _initialized = false;
  late DateTime _sessionStart;

  /// Initialize the performance monitoring service
  Future<void> initialize({LoggingService? logger}) async {
    if (_initialized) return;
    
    _logger = logger ?? LoggingService();
    _sessionStart = DateTime.now();
    
    // Initialize performance history
    for (final metric in PerformanceMetric.values) {
      _performanceHistory[metric] = [];
    }
    
    // Start system health monitoring
    _startHealthMonitoring();
    
    _initialized = true;
    
    _errorHandler.logInfo(
      'PerformanceMonitoringService initialized',
      context: {
        'session_start': _sessionStart.toIso8601String(),
        'platform': Platform.operatingSystem,
        'debug_mode': kDebugMode,
      },
    );
  }

  /// Start timing a performance-critical operation
  void startTimer(String operationId, PerformanceMetric metric, {Map<String, dynamic>? context}) {
    final stopwatch = Stopwatch()..start();
    _activeTimers[operationId] = stopwatch;
    
    _errorHandler.logInfo(
      'Performance timer started',
      category: ErrorCategory.general,
      context: {
        'operation_id': operationId,
        'metric': metric.name,
        'start_time': DateTime.now().toIso8601String(),
        ...?context,
      },
    );
  }

  /// Stop timing and record performance metric
  double? stopTimer(String operationId, PerformanceMetric metric, {Map<String, dynamic>? context}) {
    final stopwatch = _activeTimers.remove(operationId);
    if (stopwatch == null) {
      _errorHandler.logWarning(
        'Timer not found for operation',
        context: {'operation_id': operationId, 'metric': metric.name},
      );
      return null;
    }
    
    stopwatch.stop();
    final duration = stopwatch.elapsedMilliseconds.toDouble();
    
    // Record the metric
    _recordMetric(metric, duration, context);
    
    // Update operation count
    _operationCounts[metric.name] = (_operationCounts[metric.name] ?? 0) + 1;
    
    // Check for performance issues
    _checkPerformanceThreshold(metric, duration, operationId);
    
    _errorHandler.logInfo(
      'Performance timer stopped',
      category: ErrorCategory.general,
      context: {
        'operation_id': operationId,
        'metric': metric.name,
        'duration_ms': duration,
        'end_time': DateTime.now().toIso8601String(),
        ...?context,
      },
    );
    
    return duration;
  }

  /// Record a performance metric directly
  void recordMetric(PerformanceMetric metric, double value, {Map<String, dynamic>? context}) {
    _recordMetric(metric, value, context);
    _checkPerformanceThreshold(metric, value, 'direct_record');
  }

  /// Time an async operation and automatically record the result
  Future<T> timeAsyncOperation<T>(
    String operationId,
    PerformanceMetric metric,
    Future<T> Function() operation, {
    Map<String, dynamic>? context,
  }) async {
    startTimer(operationId, metric, context: context);
    
    try {
      final result = await operation();
      stopTimer(operationId, metric, context: context);
      return result;
    } catch (error, stackTrace) {
      stopTimer(operationId, metric, context: {'error': error.toString(), ...?context});
      
      _errorHandler.logError(
        'Timed operation failed',
        error: error,
        stackTrace: stackTrace,
        context: {
          'operation_id': operationId,
          'metric': metric.name,
          ...?context,
        },
      );
      
      rethrow;
    }
  }

  /// Time a synchronous operation
  T timeSyncOperation<T>(
    String operationId,
    PerformanceMetric metric,
    T Function() operation, {
    Map<String, dynamic>? context,
  }) {
    startTimer(operationId, metric, context: context);
    
    try {
      final result = operation();
      stopTimer(operationId, metric, context: context);
      return result;
    } catch (error, stackTrace) {
      stopTimer(operationId, metric, context: {'error': error.toString(), ...?context});
      
      _errorHandler.logError(
        'Timed operation failed',
        error: error,
        stackTrace: stackTrace,
        context: {
          'operation_id': operationId,
          'metric': metric.name,
          ...?context,
        },
      );
      
      rethrow;
    }
  }

  /// Get performance statistics for a specific metric
  Map<String, dynamic> getMetricStatistics(PerformanceMetric metric) {
    final values = _performanceHistory[metric] ?? [];
    
    if (values.isEmpty) {
      return {
        'metric': metric.name,
        'count': 0,
        'average': 0.0,
        'min': 0.0,
        'max': 0.0,
        'threshold': _performanceThresholds[metric],
        'threshold_violations': 0,
      };
    }
    
    final sum = values.reduce((a, b) => a + b);
    final average = sum / values.length;
    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    final threshold = _performanceThresholds[metric] ?? double.infinity;
    final violations = values.where((v) => v > threshold).length;
    
    return {
      'metric': metric.name,
      'count': values.length,
      'average': average,
      'min': min,
      'max': max,
      'threshold': threshold,
      'threshold_violations': violations,
      'violation_rate': violations / values.length,
      'last_value': values.last,
    };
  }

  /// Get comprehensive performance report
  Map<String, dynamic> getPerformanceReport() {
    final report = <String, dynamic>{
      'session_start': _sessionStart.toIso8601String(),
      'session_duration_minutes': DateTime.now().difference(_sessionStart).inMinutes,
      'metrics': {},
      'system_health': _systemHealth,
      'alerts': _performanceAlerts,
      'operation_counts': _operationCounts,
    };
    
    for (final metric in PerformanceMetric.values) {
      report['metrics'][metric.name] = getMetricStatistics(metric);
    }
    
    return report;
  }

  /// Get system health status
  Map<String, dynamic> getSystemHealth() {
    return Map.from(_systemHealth);
  }

  /// Get recent performance alerts
  List<String> getPerformanceAlerts({int? limit}) {
    final alerts = List<String>.from(_performanceAlerts);
    if (limit != null && alerts.length > limit) {
      return alerts.take(limit).toList();
    }
    return alerts;
  }

  /// Clear performance data (useful for testing)
  void clearMetrics() {
    for (final metric in PerformanceMetric.values) {
      _performanceHistory[metric]?.clear();
    }
    _operationCounts.clear();
    _performanceAlerts.clear();
    
    _errorHandler.logInfo(
      'Performance metrics cleared',
      context: {'cleared_at': DateTime.now().toIso8601String()},
    );
  }

  /// Dispose of the service and cleanup resources
  void dispose() {
    _healthCheckTimer?.cancel();
    _activeTimers.clear();
    _initialized = false;
  }

  /// Record a metric value internally
  void _recordMetric(PerformanceMetric metric, double value, Map<String, dynamic>? context) {
    final values = _performanceHistory[metric] ??= [];
    values.add(value);
    
    // Keep only last 1000 values per metric to prevent memory bloat
    if (values.length > 1000) {
      values.removeAt(0);
    }
    
    // Log the metric via error handler
    _errorHandler.logInfo(
      'Performance metric recorded',
      category: ErrorCategory.general,
      context: {
        'metric': metric.name,
        'value': value,
        'unit': 'ms',
        ...?context,
      },
    );
  }

  /// Check if a performance metric exceeds its threshold
  void _checkPerformanceThreshold(PerformanceMetric metric, double value, String operationId) {
    final threshold = _performanceThresholds[metric];
    if (threshold != null && value > threshold) {
      final alert = 'Performance threshold exceeded: ${metric.name} took ${value.toStringAsFixed(2)}ms (threshold: ${threshold}ms) for operation: $operationId';
      
      _performanceAlerts.add('${DateTime.now().toIso8601String()}: $alert');
      
      // Keep only last 100 alerts
      if (_performanceAlerts.length > 100) {
        _performanceAlerts.removeAt(0);
      }
      
      _errorHandler.logWarning(
        'Performance threshold exceeded',
        context: {
          'metric': metric.name,
          'value': value,
          'threshold': threshold,
          'operation_id': operationId,
          'violation_percent': ((value - threshold) / threshold * 100).toStringAsFixed(1),
        },
      );
    }
  }

  /// Start periodic system health monitoring
  void _startHealthMonitoring() {
    _healthCheckTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateSystemHealth();
    });
    
    // Initial health check
    _updateSystemHealth();
  }

  /// Update system health metrics
  void _updateSystemHealth() {
    try {
      // Memory usage
      if (!kIsWeb) {
        try {
          final memoryMB = ProcessInfo.currentRss / (1024 * 1024);
          _systemHealth['memory_usage_mb'] = memoryMB;
          
          // Alert on high memory usage (>500MB)
          if (memoryMB > 500) {
            _performanceAlerts.add(
              '${DateTime.now().toIso8601String()}: High memory usage: ${memoryMB.toStringAsFixed(1)}MB'
            );
          }
        } catch (e) {
          _systemHealth['memory_usage_mb'] = 'unavailable';
        }
      }
      
      // Active timers (potential memory leaks)
      _systemHealth['active_timers'] = _activeTimers.length;
      if (_activeTimers.length > 10) {
        _performanceAlerts.add(
          '${DateTime.now().toIso8601String()}: High number of active timers: ${_activeTimers.length}'
        );
      }
      
      // Performance history size
      final totalMetrics = _performanceHistory.values.fold(0, (sum, list) => sum + list.length);
      _systemHealth['total_metrics_stored'] = totalMetrics;
      
      // Session duration
      _systemHealth['session_duration_minutes'] = DateTime.now().difference(_sessionStart).inMinutes;
      
      // Overall health score (0-100)
      _systemHealth['health_score'] = _calculateHealthScore();
      
      _systemHealth['last_update'] = DateTime.now().toIso8601String();
      
    } catch (e, stackTrace) {
      _errorHandler.logError(
        'Failed to update system health',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Calculate overall health score based on various metrics
  int _calculateHealthScore() {
    int score = 100;
    
    // Deduct points for performance violations
    for (final metric in PerformanceMetric.values) {
      final stats = getMetricStatistics(metric);
      final violationRate = stats['violation_rate'] as double;
      if (violationRate > 0.1) { // More than 10% violations
        score -= (violationRate * 20).round(); // Up to 20 points deduction
      }
    }
    
    // Deduct points for memory usage
    final memoryUsage = _systemHealth['memory_usage_mb'];
    if (memoryUsage is double && memoryUsage > 300) {
      score -= ((memoryUsage - 300) / 10).round(); // 1 point per 10MB over 300MB
    }
    
    // Deduct points for active timer leaks
    final activeTimers = _systemHealth['active_timers'] as int? ?? 0;
    if (activeTimers > 5) {
      score -= (activeTimers - 5) * 2; // 2 points per extra timer
    }
    
    return score.clamp(0, 100);
  }
}