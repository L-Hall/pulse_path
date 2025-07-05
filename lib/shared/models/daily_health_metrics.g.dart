// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_health_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyHealthMetricsImpl _$$DailyHealthMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyHealthMetricsImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      stepCount: (json['stepCount'] as num?)?.toInt() ?? 0,
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0.0,
      activeMinutes: (json['activeMinutes'] as num?)?.toInt() ?? 0,
      flightsClimbed: (json['flightsClimbed'] as num?)?.toInt() ?? 0,
      sleepData: json['sleepData'] == null
          ? null
          : SleepData.fromJson(json['sleepData'] as Map<String, dynamic>),
      workouts: (json['workouts'] as List<dynamic>?)
              ?.map((e) => WorkoutSession.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      menstrualData: json['menstrualData'] == null
          ? null
          : MenstrualCycleData.fromJson(
              json['menstrualData'] as Map<String, dynamic>),
      energyLevel: (json['energyLevel'] as num?)?.toInt() ?? null,
      stressLevel: (json['stressLevel'] as num?)?.toInt() ?? null,
      symptoms: (json['symptoms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notes: json['notes'] as String? ?? '',
      isComplete: json['isComplete'] as bool? ?? true,
      dataSources: (json['dataSources'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$DailyHealthMetricsImplToJson(
        _$DailyHealthMetricsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'stepCount': instance.stepCount,
      'distanceKm': instance.distanceKm,
      'activeMinutes': instance.activeMinutes,
      'flightsClimbed': instance.flightsClimbed,
      'sleepData': instance.sleepData,
      'workouts': instance.workouts,
      'menstrualData': instance.menstrualData,
      'energyLevel': instance.energyLevel,
      'stressLevel': instance.stressLevel,
      'symptoms': instance.symptoms,
      'notes': instance.notes,
      'isComplete': instance.isComplete,
      'dataSources': instance.dataSources,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isSynced': instance.isSynced,
    };

_$SleepDataImpl _$$SleepDataImplFromJson(Map<String, dynamic> json) =>
    _$SleepDataImpl(
      bedTime: DateTime.parse(json['bedTime'] as String),
      wakeTime: DateTime.parse(json['wakeTime'] as String),
      totalSleepTime:
          Duration(microseconds: (json['totalSleepTime'] as num).toInt()),
      deepSleepTime: json['deepSleepTime'] == null
          ? null
          : Duration(microseconds: (json['deepSleepTime'] as num).toInt()),
      remSleepTime: json['remSleepTime'] == null
          ? null
          : Duration(microseconds: (json['remSleepTime'] as num).toInt()),
      lightSleepTime: json['lightSleepTime'] == null
          ? null
          : Duration(microseconds: (json['lightSleepTime'] as num).toInt()),
      sleepQuality: (json['sleepQuality'] as num?)?.toInt() ?? null,
      awakenings: (json['awakenings'] as num?)?.toInt() ?? 0,
      timeToFallAsleep: json['timeToFallAsleep'] == null
          ? null
          : Duration(microseconds: (json['timeToFallAsleep'] as num).toInt()),
      source: json['source'] as String? ?? 'unknown',
    );

Map<String, dynamic> _$$SleepDataImplToJson(_$SleepDataImpl instance) =>
    <String, dynamic>{
      'bedTime': instance.bedTime.toIso8601String(),
      'wakeTime': instance.wakeTime.toIso8601String(),
      'totalSleepTime': instance.totalSleepTime.inMicroseconds,
      'deepSleepTime': instance.deepSleepTime?.inMicroseconds,
      'remSleepTime': instance.remSleepTime?.inMicroseconds,
      'lightSleepTime': instance.lightSleepTime?.inMicroseconds,
      'sleepQuality': instance.sleepQuality,
      'awakenings': instance.awakenings,
      'timeToFallAsleep': instance.timeToFallAsleep?.inMicroseconds,
      'source': instance.source,
    };

_$WorkoutSessionImpl _$$WorkoutSessionImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSessionImpl(
      id: json['id'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      type: $enumDecode(_$WorkoutTypeEnumMap, json['type']),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      perceivedExertion: (json['perceivedExertion'] as num?)?.toInt() ?? null,
      averageHeartRate: (json['averageHeartRate'] as num?)?.toDouble() ?? null,
      maxHeartRate: (json['maxHeartRate'] as num?)?.toDouble() ?? null,
      caloriesBurned: (json['caloriesBurned'] as num?)?.toInt() ?? null,
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? null,
      steps: (json['steps'] as num?)?.toInt() ?? null,
      avgSpeed: (json['avgSpeed'] as num?)?.toDouble() ?? null,
      elevationGain: (json['elevationGain'] as num?)?.toDouble() ?? null,
      recoveryHeartRate: (json['recoveryHeartRate'] as num?)?.toInt() ?? null,
      recoveryTime: json['recoveryTime'] == null
          ? null
          : Duration(microseconds: (json['recoveryTime'] as num).toInt()),
      notes: json['notes'] as String? ?? '',
      source: json['source'] as String? ?? 'unknown',
      createdAt: DateTime.parse(json['createdAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$WorkoutSessionImplToJson(
        _$WorkoutSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'type': _$WorkoutTypeEnumMap[instance.type]!,
      'duration': instance.duration.inMicroseconds,
      'perceivedExertion': instance.perceivedExertion,
      'averageHeartRate': instance.averageHeartRate,
      'maxHeartRate': instance.maxHeartRate,
      'caloriesBurned': instance.caloriesBurned,
      'distanceKm': instance.distanceKm,
      'steps': instance.steps,
      'avgSpeed': instance.avgSpeed,
      'elevationGain': instance.elevationGain,
      'recoveryHeartRate': instance.recoveryHeartRate,
      'recoveryTime': instance.recoveryTime?.inMicroseconds,
      'notes': instance.notes,
      'source': instance.source,
      'createdAt': instance.createdAt.toIso8601String(),
      'isSynced': instance.isSynced,
    };

const _$WorkoutTypeEnumMap = {
  WorkoutType.walking: 'walking',
  WorkoutType.running: 'running',
  WorkoutType.cycling: 'cycling',
  WorkoutType.swimming: 'swimming',
  WorkoutType.strengthTraining: 'strength_training',
  WorkoutType.yoga: 'yoga',
  WorkoutType.pilates: 'pilates',
  WorkoutType.taiChi: 'tai_chi',
  WorkoutType.stretching: 'stretching',
  WorkoutType.meditation: 'meditation',
  WorkoutType.breathingExercises: 'breathing_exercises',
  WorkoutType.physicalTherapy: 'physical_therapy',
  WorkoutType.householdActivities: 'household_activities',
  WorkoutType.gardening: 'gardening',
  WorkoutType.other: 'other',
};

_$MenstrualCycleDataImpl _$$MenstrualCycleDataImplFromJson(
        Map<String, dynamic> json) =>
    _$MenstrualCycleDataImpl(
      date: DateTime.parse(json['date'] as String),
      phase: $enumDecode(_$MenstrualPhaseEnumMap, json['phase']),
      flowIntensity:
          $enumDecodeNullable(_$FlowIntensityEnumMap, json['flowIntensity']) ??
              null,
      symptoms: (json['symptoms'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MenstrualSymptomEnumMap, e))
              .toList() ??
          const [],
      moodRating: (json['moodRating'] as num?)?.toInt() ?? null,
      energyRating: (json['energyRating'] as num?)?.toInt() ?? null,
      painLevel: (json['painLevel'] as num?)?.toInt() ?? null,
      notes: json['notes'] as String? ?? '',
      source: json['source'] as String? ?? 'unknown',
      predictedNextPeriod: json['predictedNextPeriod'] == null
          ? null
          : DateTime.parse(json['predictedNextPeriod'] as String),
      predictedOvulation: json['predictedOvulation'] == null
          ? null
          : DateTime.parse(json['predictedOvulation'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$MenstrualCycleDataImplToJson(
        _$MenstrualCycleDataImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'phase': _$MenstrualPhaseEnumMap[instance.phase]!,
      'flowIntensity': _$FlowIntensityEnumMap[instance.flowIntensity],
      'symptoms':
          instance.symptoms.map((e) => _$MenstrualSymptomEnumMap[e]!).toList(),
      'moodRating': instance.moodRating,
      'energyRating': instance.energyRating,
      'painLevel': instance.painLevel,
      'notes': instance.notes,
      'source': instance.source,
      'predictedNextPeriod': instance.predictedNextPeriod?.toIso8601String(),
      'predictedOvulation': instance.predictedOvulation?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'isSynced': instance.isSynced,
    };

const _$MenstrualPhaseEnumMap = {
  MenstrualPhase.menstrual: 'menstrual',
  MenstrualPhase.follicular: 'follicular',
  MenstrualPhase.ovulatory: 'ovulatory',
  MenstrualPhase.luteal: 'luteal',
  MenstrualPhase.unknown: 'unknown',
};

const _$FlowIntensityEnumMap = {
  FlowIntensity.spotting: 'spotting',
  FlowIntensity.light: 'light',
  FlowIntensity.medium: 'medium',
  FlowIntensity.heavy: 'heavy',
  FlowIntensity.veryHeavy: 'very_heavy',
};

const _$MenstrualSymptomEnumMap = {
  MenstrualSymptom.cramps: 'cramps',
  MenstrualSymptom.headache: 'headache',
  MenstrualSymptom.bloating: 'bloating',
  MenstrualSymptom.moodSwings: 'mood_swings',
  MenstrualSymptom.fatigue: 'fatigue',
  MenstrualSymptom.breastTenderness: 'breast_tenderness',
  MenstrualSymptom.backPain: 'back_pain',
  MenstrualSymptom.nausea: 'nausea',
  MenstrualSymptom.acne: 'acne',
  MenstrualSymptom.foodCravings: 'food_cravings',
  MenstrualSymptom.insomnia: 'insomnia',
  MenstrualSymptom.hotFlashes: 'hot_flashes',
};
