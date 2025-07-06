// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_data_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthDataPointImpl _$$HealthDataPointImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthDataPointImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
      dateFrom: DateTime.parse(json['dateFrom'] as String),
      dateTo: DateTime.parse(json['dateTo'] as String),
      sourcePlatform: json['sourcePlatform'] as String,
      sourceId: json['sourceId'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$HealthDataPointImplToJson(
        _$HealthDataPointImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'unit': instance.unit,
      'dateFrom': instance.dateFrom.toIso8601String(),
      'dateTo': instance.dateTo.toIso8601String(),
      'sourcePlatform': instance.sourcePlatform,
      'sourceId': instance.sourceId,
      'metadata': instance.metadata,
    };

_$HealthDataSummaryImpl _$$HealthDataSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthDataSummaryImpl(
      date: DateTime.parse(json['date'] as String),
      steps: (json['steps'] as num).toInt(),
      activeEnergyBurned: (json['activeEnergyBurned'] as num).toDouble(),
      restingHeartRate: (json['restingHeartRate'] as num).toDouble(),
      averageHeartRate: (json['averageHeartRate'] as num).toDouble(),
      sleepHours: (json['sleepHours'] as num).toDouble(),
      sleepEfficiency: (json['sleepEfficiency'] as num).toDouble(),
      workouts: (json['workouts'] as List<dynamic>)
          .map((e) => WorkoutSession.fromJson(e as Map<String, dynamic>))
          .toList(),
      menstrualCycle: json['menstrualCycle'] == null
          ? null
          : MenstrualCycleData.fromJson(
              json['menstrualCycle'] as Map<String, dynamic>),
      additionalMetrics: json['additionalMetrics'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$HealthDataSummaryImplToJson(
        _$HealthDataSummaryImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'steps': instance.steps,
      'activeEnergyBurned': instance.activeEnergyBurned,
      'restingHeartRate': instance.restingHeartRate,
      'averageHeartRate': instance.averageHeartRate,
      'sleepHours': instance.sleepHours,
      'sleepEfficiency': instance.sleepEfficiency,
      'workouts': instance.workouts,
      'menstrualCycle': instance.menstrualCycle,
      'additionalMetrics': instance.additionalMetrics,
    };

_$WorkoutSessionImpl _$$WorkoutSessionImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSessionImpl(
      id: json['id'] as String,
      type: $enumDecode(_$WorkoutTypeEnumMap, json['type']),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      duration: (json['duration'] as num).toDouble(),
      caloriesBurned: (json['caloriesBurned'] as num).toDouble(),
      averageHeartRate: (json['averageHeartRate'] as num?)?.toDouble(),
      maxHeartRate: (json['maxHeartRate'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$WorkoutSessionImplToJson(
        _$WorkoutSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$WorkoutTypeEnumMap[instance.type]!,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'duration': instance.duration,
      'caloriesBurned': instance.caloriesBurned,
      'averageHeartRate': instance.averageHeartRate,
      'maxHeartRate': instance.maxHeartRate,
      'distance': instance.distance,
      'metadata': instance.metadata,
    };

const _$WorkoutTypeEnumMap = {
  WorkoutType.walking: 'walking',
  WorkoutType.running: 'running',
  WorkoutType.cycling: 'cycling',
  WorkoutType.swimming: 'swimming',
  WorkoutType.yoga: 'yoga',
  WorkoutType.strengthTraining: 'strengthTraining',
  WorkoutType.cardio: 'cardio',
  WorkoutType.sports: 'sports',
  WorkoutType.dance: 'dance',
  WorkoutType.climbing: 'climbing',
  WorkoutType.skiing: 'skiing',
  WorkoutType.tennis: 'tennis',
  WorkoutType.golf: 'golf',
  WorkoutType.hiking: 'hiking',
  WorkoutType.other: 'other',
};

_$MenstrualCycleDataImpl _$$MenstrualCycleDataImplFromJson(
        Map<String, dynamic> json) =>
    _$MenstrualCycleDataImpl(
      date: DateTime.parse(json['date'] as String),
      flow: $enumDecode(_$MenstrualFlowEnumMap, json['flow']),
      symptoms: (json['symptoms'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MenstrualSymptomEnumMap, e))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MenstrualCycleDataImplToJson(
        _$MenstrualCycleDataImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'flow': _$MenstrualFlowEnumMap[instance.flow]!,
      'symptoms':
          instance.symptoms?.map((e) => _$MenstrualSymptomEnumMap[e]!).toList(),
      'metadata': instance.metadata,
    };

const _$MenstrualFlowEnumMap = {
  MenstrualFlow.none: 'none',
  MenstrualFlow.light: 'light',
  MenstrualFlow.medium: 'medium',
  MenstrualFlow.heavy: 'heavy',
};

const _$MenstrualSymptomEnumMap = {
  MenstrualSymptom.cramps: 'cramps',
  MenstrualSymptom.bloating: 'bloating',
  MenstrualSymptom.headache: 'headache',
  MenstrualSymptom.moodChanges: 'moodChanges',
  MenstrualSymptom.fatigue: 'fatigue',
  MenstrualSymptom.backPain: 'backPain',
  MenstrualSymptom.breastTenderness: 'breastTenderness',
  MenstrualSymptom.nausea: 'nausea',
  MenstrualSymptom.other: 'other',
};
