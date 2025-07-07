import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'health_data_service.dart';
import '../models/apple_watch_data.dart';
import '../models/health_data_point.dart' as models;

/// Enhanced health data service with Apple Watch specific functionality
/// 
/// Extends the base HealthDataService to provide:
/// - Real-time Apple Watch data streaming
/// - Background health data delivery
/// - Watch-specific HRV metrics
/// - Device identification and metadata
class AppleWatchService {
  static final AppleWatchService _instance = AppleWatchService._internal();
  factory AppleWatchService() => _instance;
  AppleWatchService._internal();

  // Stream controllers for real-time data
  final StreamController<AppleWatchReading> _readingController = 
      StreamController<AppleWatchReading>.broadcast();
  final StreamController<AppleWatchStatus> _statusController = 
      StreamController<AppleWatchStatus>.broadcast();
  final StreamController<AppleWatchStreamData> _streamController = 
      StreamController<AppleWatchStreamData>.broadcast();

  // Current watch status
  AppleWatchStatus _currentStatus = AppleWatchStatus.disconnected();
  
  // Background delivery setup
  bool _backgroundDeliveryEnabled = false;
  Timer? _backgroundSyncTimer;

  /// Stream of Apple Watch readings
  Stream<AppleWatchReading> get readingStream => _readingController.stream;

  /// Stream of Apple Watch connectivity status
  Stream<AppleWatchStatus> get statusStream => _statusController.stream;

  /// Stream of real-time Apple Watch data
  Stream<AppleWatchStreamData> get streamingDataStream => _streamController.stream;

  /// Current Apple Watch status
  AppleWatchStatus get currentStatus => _currentStatus;

  /// Whether Apple Watch is connected and reachable
  bool get isWatchConnected => _currentStatus.isConnected && _currentStatus.isReachable;

  /// Enhanced health data types for Apple Watch
  static const List<HealthDataType> _watchHealthDataTypes = [
    // Standard health data
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
    HealthDataType.RESTING_HEART_RATE,
    HealthDataType.HEART_RATE_VARIABILITY_SDNN,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.WORKOUT,
    
    // Sleep data
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_IN_BED,
    
    // Additional metrics available from Apple Watch  
    // Note: ELECTRODERMAL_ACTIVITY and VO2_MAX not available in health package v10.2.0
    // These will be added when package supports them
  ];

  /// Initialize Apple Watch service with enhanced permissions  
  Future<bool> initialize() async {
    try {
      // Initialize Health service instance
      final healthService = HealthDataService();
      final baseInitialized = await healthService.initialize();
      if (!baseInitialized) {
        return false;
      }

      if (!Platform.isIOS) {
        if (kDebugMode) {
          debugPrint('Apple Watch service only available on iOS');
        }
        return false;
      }

      // Request enhanced permissions for Apple Watch data
      final watchPermissions = await _requestWatchPermissions();
      if (!watchPermissions) {
        if (kDebugMode) {
          debugPrint('Apple Watch permissions not granted');
        }
        return false;
      }

      // Check for Apple Watch connectivity
      await _checkWatchConnectivity();

      // Enable background delivery for real-time updates
      await _enableBackgroundDelivery();

      // Start monitoring watch status
      _startStatusMonitoring();

      if (kDebugMode) {
        debugPrint('✅ AppleWatchService initialized successfully');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error initializing AppleWatchService: $e');
      }
      return false;
    }
  }

  /// Request enhanced permissions for Apple Watch data
  Future<bool> _requestWatchPermissions() async {
    try {
      final authorized = await Health().requestAuthorization(
        _watchHealthDataTypes,
        permissions: [
          HealthDataAccess.READ,
          HealthDataAccess.WRITE,
        ],
      );

      return authorized ?? false;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error requesting Apple Watch permissions: $e');
      }
      return false;
    }
  }

  /// Check Apple Watch connectivity status
  Future<void> _checkWatchConnectivity() async {
    try {
      // Query recent data to determine if Apple Watch is active
      final now = DateTime.now();
      final oneHourAgo = now.subtract(const Duration(hours: 1));

      final recentData = await Health().getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: oneHourAgo,
        endTime: now,
      );

      // Check if any recent data comes from Apple Watch
      final watchData = recentData.where((point) => 
        point.sourcePlatform == 'appleHealth' &&
        (point.sourceId.contains('Watch') || point.sourceId.contains('com.apple.health'))
      ).toList();

      if (watchData.isNotEmpty) {
        // Extract device information from metadata or assume modern Apple Watch
        _updateWatchStatus(AppleWatchStatus.connected(
          deviceModel: 'Apple Watch', // Could be enhanced with actual model detection
          watchOSVersion: 'Unknown',
        ));
      } else {
        _updateWatchStatus(AppleWatchStatus.disconnected());
      }

    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error checking watch connectivity: $e');
      }
      _updateWatchStatus(AppleWatchStatus.disconnected());
    }
  }

  /// Enable background delivery for real-time health updates
  Future<void> _enableBackgroundDelivery() async {
    try {
      if (_backgroundDeliveryEnabled) return;

      // Note: Background delivery setup would require native iOS implementation
      // For now, we'll use periodic polling as a fallback
      _backgroundSyncTimer?.cancel();
      _backgroundSyncTimer = Timer.periodic(
        const Duration(minutes: 5), 
        (_) => _performBackgroundSync(),
      );

      _backgroundDeliveryEnabled = true;

      if (kDebugMode) {
        debugPrint('✅ Background delivery enabled for Apple Watch');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Error enabling background delivery: $e');
      }
    }
  }

  /// Start monitoring Apple Watch status
  void _startStatusMonitoring() {
    Timer.periodic(const Duration(minutes: 2), (_) async {
      await _checkWatchConnectivity();
    });
  }

  /// Perform background sync of Apple Watch data
  Future<void> _performBackgroundSync() async {
    if (!isWatchConnected) return;

    try {
      final now = DateTime.now();
      final lastSync = _currentStatus.lastDataSync ?? now.subtract(const Duration(hours: 1));
      
      final newData = await getAppleWatchReading(
        startTime: lastSync,
        endTime: now,
      );

      if (newData != null) {
        _readingController.add(newData);
        
        // Update last sync time
        _updateWatchStatus(_currentStatus.copyWith(
          lastDataSync: now,
          lastCommunication: now,
        ));

        if (kDebugMode) {
          debugPrint('🔄 Background sync completed with new Apple Watch data');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Background sync error: $e');
      }
    }
  }

  /// Get comprehensive Apple Watch reading for a time period
  Future<AppleWatchReading?> getAppleWatchReading({
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    if (!isWatchConnected) {
      throw Exception('Apple Watch not connected');
    }

    try {
      final start = startTime ?? DateTime.now().subtract(const Duration(hours: 1));
      final end = endTime ?? DateTime.now();

      // Get health data from Apple Watch sources
      final healthData = await Health().getHealthDataFromTypes(
        types: _watchHealthDataTypes,
        startTime: start,
        endTime: end,
      );

      // Filter for Apple Watch data only
      final watchData = healthData.where((point) => 
        point.sourcePlatform == 'appleHealth' &&
        _isAppleWatchSource(point.sourceId)
      ).toList();

      if (watchData.isEmpty) {
        return null;
      }

      // Create Apple Watch reading from the data
      final reading = AppleWatchReading.fromHealthData(
        healthData: watchData,
        deviceModel: _currentStatus.deviceModel ?? 'Apple Watch',
        watchOSVersion: _currentStatus.watchOSVersion ?? 'Unknown',
      );

      return reading;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error getting Apple Watch reading: $e');
      }
      return null;
    }
  }

  /// Get real-time streaming data (simulated for now)
  Future<AppleWatchStreamData?> getCurrentStreamData() async {
    if (!isWatchConnected) return null;

    try {
      // Get the most recent heart rate data
      final now = DateTime.now();
      final fiveMinutesAgo = now.subtract(const Duration(minutes: 5));

      final recentHR = await Health().getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: fiveMinutesAgo,
        endTime: now,
      );

      final watchHR = recentHR.where((point) => 
        _isAppleWatchSource(point.sourceId)
      ).toList();

      if (watchHR.isEmpty) return null;

      final latestHR = watchHR.last;
      final heartRate = double.tryParse(latestHR.value.toString());

      return AppleWatchStreamData(
        timestamp: latestHR.dateFrom,
        instantHeartRate: heartRate,
        currentSteps: await _getCurrentSteps(),
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error getting stream data: $e');
      }
      return null;
    }
  }

  /// Get current step count from Apple Watch
  Future<int?> _getCurrentSteps() async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);

      final stepsData = await Health().getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: startOfDay,
        endTime: today,
      );

      final watchSteps = stepsData.where((point) => 
        _isAppleWatchSource(point.sourceId)
      ).toList();

      if (watchSteps.isEmpty) return null;

      return watchSteps
          .map((point) => int.tryParse(point.value.toString()) ?? 0)
          .reduce((a, b) => a + b);
    } catch (e) {
      return null;
    }
  }

  /// Check if a source ID indicates Apple Watch data
  bool _isAppleWatchSource(String sourceId) {
    final watchIndicators = [
      'Watch',
      'watch',
      'com.apple.health',
      'com.apple.Health',
      'Apple Watch',
    ];
    
    return watchIndicators.any((indicator) => sourceId.contains(indicator));
  }

  /// Update Apple Watch status and notify listeners
  void _updateWatchStatus(AppleWatchStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  /// Manually trigger Apple Watch data sync
  Future<AppleWatchReading?> triggerManualSync() async {
    if (kDebugMode) {
      debugPrint('🔄 Manual Apple Watch sync triggered');
    }

    try {
      await _checkWatchConnectivity();
      
      if (!isWatchConnected) {
        throw Exception('Apple Watch not connected');
      }

      final reading = await getAppleWatchReading();
      
      if (reading != null) {
        _readingController.add(reading);
        
        _updateWatchStatus(_currentStatus.copyWith(
          lastDataSync: DateTime.now(),
          lastCommunication: DateTime.now(),
        ));
      }

      return reading;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Manual sync failed: $e');
      }
      rethrow;
    }
  }

  /// Check if specific watch capabilities are supported
  bool supportsCapability(WatchCapability capability) {
    return _currentStatus.supportedCapabilities.contains(capability);
  }

  /// Get battery level if available (would require native implementation)
  Future<double?> getWatchBatteryLevel() async {
    // This would require native iOS implementation to query Watch battery
    // For now, return null indicating unavailable
    return null;
  }

  void dispose() {
    _backgroundSyncTimer?.cancel();
    _readingController.close();
    _statusController.close();
    _streamController.close();
  }
}