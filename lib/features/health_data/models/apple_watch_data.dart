import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health/health.dart' as health;
import 'health_data_point.dart';

part 'apple_watch_data.freezed.dart';
part 'apple_watch_data.g.dart';

/// Specialized model for Apple Watch health data with Watch-specific metadata
@freezed
class AppleWatchReading with _$AppleWatchReading {
  const factory AppleWatchReading({
    required String id,
    required DateTime timestamp,
    required double heartRate,
    double? heartRateVariabilityRMSSD,
    double? heartRateVariabilitySDNN,
    required int steps,
    double? distance, // in meters
    required String deviceModel, // e.g., "Apple Watch Series 9"
    required String watchOSVersion,
    required String sourceBundleId,
    required ReadingQuality quality,
    WorkoutContext? workoutContext,
    Map<String, dynamic>? metadata,
  }) = _AppleWatchReading;

  factory AppleWatchReading.fromJson(Map<String, dynamic> json) => 
      _$AppleWatchReadingFromJson(json);

  /// Creates an AppleWatchReading from HealthKit data points
  factory AppleWatchReading.fromHealthData({
    required List<health.HealthDataPoint> healthData,
    required String deviceModel,
    required String watchOSVersion,
  }) {
    final timestamp = DateTime.now();
    final id = 'apple_watch_${timestamp.millisecondsSinceEpoch}';
    
    // Extract heart rate data
    final heartRatePoints = healthData
        .where((point) => point.type == health.HealthDataType.HEART_RATE)
        .toList();
    
    final avgHeartRate = heartRatePoints.isNotEmpty
        ? heartRatePoints
            .map((p) => double.tryParse(p.value.toString()) ?? 0.0)
            .reduce((a, b) => a + b) / heartRatePoints.length
        : 0.0;

    // Extract HRV data (currently only SDNN available in health package v10.2.0)
    final hrvPoints = healthData
        .where((point) => point.type == health.HealthDataType.HEART_RATE_VARIABILITY_SDNN)
        .toList();
    
    final hrvSDNN = hrvPoints.isNotEmpty
        ? double.tryParse(hrvPoints.first.value.toString())
        : null;

    // Extract steps data
    final stepsPoints = healthData
        .where((point) => point.type == health.HealthDataType.STEPS)
        .toList();
    
    final totalSteps = stepsPoints.isNotEmpty
        ? stepsPoints
            .map((p) => int.tryParse(p.value.toString()) ?? 0)
            .reduce((a, b) => a + b)
        : 0;

    // Extract distance data
    final distancePoints = healthData
        .where((point) => 
            point.type == health.HealthDataType.DISTANCE_WALKING_RUNNING)
        .toList();
    
    final totalDistance = distancePoints.isNotEmpty
        ? distancePoints
            .map((p) => double.tryParse(p.value.toString()) ?? 0.0)
            .reduce((a, b) => a + b)
        : null;

    // Determine data quality based on available metrics and recency
    ReadingQuality quality = ReadingQuality.low;
    if (heartRatePoints.isNotEmpty && hrvPoints.isNotEmpty) {
      quality = ReadingQuality.high;
    } else if (heartRatePoints.isNotEmpty || hrvPoints.isNotEmpty) {
      quality = ReadingQuality.medium;
    }

    // Extract source bundle ID (Apple Watch typically uses com.apple.health)
    final sourceBundleId = healthData.isNotEmpty 
        ? healthData.first.sourceId 
        : 'com.apple.health';

    return AppleWatchReading(
      id: id,
      timestamp: timestamp,
      heartRate: avgHeartRate,
      heartRateVariabilitySDNN: hrvSDNN,
      steps: totalSteps,
      distance: totalDistance,
      deviceModel: deviceModel,
      watchOSVersion: watchOSVersion,
      sourceBundleId: sourceBundleId,
      quality: quality,
    );
  }
}

/// Context about any ongoing workout when the reading was taken
@freezed
class WorkoutContext with _$WorkoutContext {
  const factory WorkoutContext({
    required String workoutType,
    required DateTime startTime,
    double? duration, // in minutes
    double? averageHeartRate,
    double? maxHeartRate,
    double? calories,
    double? distance,
  }) = _WorkoutContext;

  factory WorkoutContext.fromJson(Map<String, dynamic> json) => 
      _$WorkoutContextFromJson(json);
}

/// Quality level of the Apple Watch reading
enum ReadingQuality {
  high,    // All metrics available, recent data
  medium,  // Some metrics missing or slightly stale
  low,     // Limited metrics or old data
}

/// Apple Watch connectivity status
@freezed
class AppleWatchStatus with _$AppleWatchStatus {
  const factory AppleWatchStatus({
    required bool isConnected,
    required bool isReachable,
    String? deviceModel,
    String? watchOSVersion,
    double? batteryLevel,
    DateTime? lastDataSync,
    DateTime? lastCommunication,
    required List<WatchCapability> supportedCapabilities,
  }) = _AppleWatchStatus;

  factory AppleWatchStatus.fromJson(Map<String, dynamic> json) => 
      _$AppleWatchStatusFromJson(json);

  /// Create disconnected status
  factory AppleWatchStatus.disconnected() => const AppleWatchStatus(
    isConnected: false,
    isReachable: false,
    supportedCapabilities: [],
  );

  /// Create connected status with basic info
  factory AppleWatchStatus.connected({
    required String deviceModel,
    required String watchOSVersion,
    double? batteryLevel,
  }) => AppleWatchStatus(
    isConnected: true,
    isReachable: true,
    deviceModel: deviceModel,
    watchOSVersion: watchOSVersion,
    batteryLevel: batteryLevel,
    lastCommunication: DateTime.now(),
    supportedCapabilities: _defaultCapabilities,
  );
}

/// Capabilities supported by the Apple Watch
enum WatchCapability {
  heartRate,
  heartRateVariability,
  steps,
  distance,
  workoutDetection,
  backgroundDelivery,
  realTimeStreaming,
}

/// Default capabilities for modern Apple Watches
const List<WatchCapability> _defaultCapabilities = [
  WatchCapability.heartRate,
  WatchCapability.heartRateVariability,
  WatchCapability.steps,
  WatchCapability.distance,
  WatchCapability.workoutDetection,
  WatchCapability.backgroundDelivery,
];

/// Real-time streaming data from Apple Watch
@freezed
class AppleWatchStreamData with _$AppleWatchStreamData {
  const factory AppleWatchStreamData({
    required DateTime timestamp,
    double? instantHeartRate,
    List<double>? rrIntervals, // R-R intervals in milliseconds
    int? currentSteps,
    bool? isInWorkout,
    String? workoutType,
  }) = _AppleWatchStreamData;

  factory AppleWatchStreamData.fromJson(Map<String, dynamic> json) => 
      _$AppleWatchStreamDataFromJson(json);
}

/// Extension to provide human-readable names for reading quality
extension ReadingQualityExtension on ReadingQuality {
  String get displayName {
    switch (this) {
      case ReadingQuality.high:
        return 'High Quality';
      case ReadingQuality.medium:
        return 'Medium Quality';
      case ReadingQuality.low:
        return 'Low Quality';
    }
  }

  String get description {
    switch (this) {
      case ReadingQuality.high:
        return 'All metrics available with recent, accurate data';
      case ReadingQuality.medium:
        return 'Most metrics available with good data quality';
      case ReadingQuality.low:
        return 'Limited metrics or older data available';
    }
  }
}

/// Extension to provide human-readable names for watch capabilities
extension WatchCapabilityExtension on WatchCapability {
  String get displayName {
    switch (this) {
      case WatchCapability.heartRate:
        return 'Heart Rate';
      case WatchCapability.heartRateVariability:
        return 'Heart Rate Variability';
      case WatchCapability.steps:
        return 'Step Counting';
      case WatchCapability.distance:
        return 'Distance Tracking';
      case WatchCapability.workoutDetection:
        return 'Workout Detection';
      case WatchCapability.backgroundDelivery:
        return 'Background Data Delivery';
      case WatchCapability.realTimeStreaming:
        return 'Real-time Data Streaming';
    }
  }
}