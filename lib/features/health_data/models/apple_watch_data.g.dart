// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_watch_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppleWatchReadingImpl _$$AppleWatchReadingImplFromJson(
        Map<String, dynamic> json) =>
    _$AppleWatchReadingImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      heartRate: (json['heartRate'] as num).toDouble(),
      heartRateVariabilityRMSSD:
          (json['heartRateVariabilityRMSSD'] as num?)?.toDouble(),
      heartRateVariabilitySDNN:
          (json['heartRateVariabilitySDNN'] as num?)?.toDouble(),
      steps: (json['steps'] as num).toInt(),
      distance: (json['distance'] as num?)?.toDouble(),
      deviceModel: json['deviceModel'] as String,
      watchOSVersion: json['watchOSVersion'] as String,
      sourceBundleId: json['sourceBundleId'] as String,
      quality: $enumDecode(_$ReadingQualityEnumMap, json['quality']),
      workoutContext: json['workoutContext'] == null
          ? null
          : WorkoutContext.fromJson(
              json['workoutContext'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AppleWatchReadingImplToJson(
        _$AppleWatchReadingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'heartRate': instance.heartRate,
      'heartRateVariabilityRMSSD': instance.heartRateVariabilityRMSSD,
      'heartRateVariabilitySDNN': instance.heartRateVariabilitySDNN,
      'steps': instance.steps,
      'distance': instance.distance,
      'deviceModel': instance.deviceModel,
      'watchOSVersion': instance.watchOSVersion,
      'sourceBundleId': instance.sourceBundleId,
      'quality': _$ReadingQualityEnumMap[instance.quality]!,
      'workoutContext': instance.workoutContext,
      'metadata': instance.metadata,
    };

const _$ReadingQualityEnumMap = {
  ReadingQuality.high: 'high',
  ReadingQuality.medium: 'medium',
  ReadingQuality.low: 'low',
};

_$WorkoutContextImpl _$$WorkoutContextImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutContextImpl(
      workoutType: json['workoutType'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      duration: (json['duration'] as num?)?.toDouble(),
      averageHeartRate: (json['averageHeartRate'] as num?)?.toDouble(),
      maxHeartRate: (json['maxHeartRate'] as num?)?.toDouble(),
      calories: (json['calories'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WorkoutContextImplToJson(
        _$WorkoutContextImpl instance) =>
    <String, dynamic>{
      'workoutType': instance.workoutType,
      'startTime': instance.startTime.toIso8601String(),
      'duration': instance.duration,
      'averageHeartRate': instance.averageHeartRate,
      'maxHeartRate': instance.maxHeartRate,
      'calories': instance.calories,
      'distance': instance.distance,
    };

_$AppleWatchStatusImpl _$$AppleWatchStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$AppleWatchStatusImpl(
      isConnected: json['isConnected'] as bool,
      isReachable: json['isReachable'] as bool,
      deviceModel: json['deviceModel'] as String?,
      watchOSVersion: json['watchOSVersion'] as String?,
      batteryLevel: (json['batteryLevel'] as num?)?.toDouble(),
      lastDataSync: json['lastDataSync'] == null
          ? null
          : DateTime.parse(json['lastDataSync'] as String),
      lastCommunication: json['lastCommunication'] == null
          ? null
          : DateTime.parse(json['lastCommunication'] as String),
      supportedCapabilities: (json['supportedCapabilities'] as List<dynamic>)
          .map((e) => $enumDecode(_$WatchCapabilityEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$$AppleWatchStatusImplToJson(
        _$AppleWatchStatusImpl instance) =>
    <String, dynamic>{
      'isConnected': instance.isConnected,
      'isReachable': instance.isReachable,
      'deviceModel': instance.deviceModel,
      'watchOSVersion': instance.watchOSVersion,
      'batteryLevel': instance.batteryLevel,
      'lastDataSync': instance.lastDataSync?.toIso8601String(),
      'lastCommunication': instance.lastCommunication?.toIso8601String(),
      'supportedCapabilities': instance.supportedCapabilities
          .map((e) => _$WatchCapabilityEnumMap[e]!)
          .toList(),
    };

const _$WatchCapabilityEnumMap = {
  WatchCapability.heartRate: 'heartRate',
  WatchCapability.heartRateVariability: 'heartRateVariability',
  WatchCapability.steps: 'steps',
  WatchCapability.distance: 'distance',
  WatchCapability.workoutDetection: 'workoutDetection',
  WatchCapability.backgroundDelivery: 'backgroundDelivery',
  WatchCapability.realTimeStreaming: 'realTimeStreaming',
};

_$AppleWatchStreamDataImpl _$$AppleWatchStreamDataImplFromJson(
        Map<String, dynamic> json) =>
    _$AppleWatchStreamDataImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      instantHeartRate: (json['instantHeartRate'] as num?)?.toDouble(),
      rrIntervals: (json['rrIntervals'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      currentSteps: (json['currentSteps'] as num?)?.toInt(),
      isInWorkout: json['isInWorkout'] as bool?,
      workoutType: json['workoutType'] as String?,
    );

Map<String, dynamic> _$$AppleWatchStreamDataImplToJson(
        _$AppleWatchStreamDataImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'instantHeartRate': instance.instantHeartRate,
      'rrIntervals': instance.rrIntervals,
      'currentSteps': instance.currentSteps,
      'isInWorkout': instance.isInWorkout,
      'workoutType': instance.workoutType,
    };
