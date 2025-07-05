// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adaptive_pacing_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdaptivePacingAssessmentImpl _$$AdaptivePacingAssessmentImplFromJson(
        Map<String, dynamic> json) =>
    _$AdaptivePacingAssessmentImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      currentState:
          PacingState.fromJson(json['currentState'] as Map<String, dynamic>),
      pemRisk: $enumDecode(_$PemRiskLevelEnumMap, json['pemRisk']),
      energyEnvelopePercentage:
          (json['energyEnvelopePercentage'] as num).toInt(),
      hrvContribution: HrvContribution.fromJson(
          json['hrvContribution'] as Map<String, dynamic>),
      activityContribution: ActivityContribution.fromJson(
          json['activityContribution'] as Map<String, dynamic>),
      sleepContribution: SleepContribution.fromJson(
          json['sleepContribution'] as Map<String, dynamic>),
      menstrualContribution: json['menstrualContribution'] == null
          ? null
          : MenstrualContribution.fromJson(
              json['menstrualContribution'] as Map<String, dynamic>),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => PacingRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      activityGuidance: ActivityGuidance.fromJson(
          json['activityGuidance'] as Map<String, dynamic>),
      trendWarnings: (json['trendWarnings'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      consecutiveHighRiskDays:
          (json['consecutiveHighRiskDays'] as num?)?.toInt() ?? 0,
      sevenDayEnergyTrend:
          (json['sevenDayEnergyTrend'] as num?)?.toDouble() ?? 0.0,
      conditionProfile: ChronicConditionProfile.fromJson(
          json['conditionProfile'] as Map<String, dynamic>),
      personalSensitivity:
          (json['personalSensitivity'] as num?)?.toDouble() ?? 1.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$AdaptivePacingAssessmentImplToJson(
        _$AdaptivePacingAssessmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'currentState': instance.currentState,
      'pemRisk': _$PemRiskLevelEnumMap[instance.pemRisk]!,
      'energyEnvelopePercentage': instance.energyEnvelopePercentage,
      'hrvContribution': instance.hrvContribution,
      'activityContribution': instance.activityContribution,
      'sleepContribution': instance.sleepContribution,
      'menstrualContribution': instance.menstrualContribution,
      'recommendations': instance.recommendations,
      'activityGuidance': instance.activityGuidance,
      'trendWarnings': instance.trendWarnings,
      'consecutiveHighRiskDays': instance.consecutiveHighRiskDays,
      'sevenDayEnergyTrend': instance.sevenDayEnergyTrend,
      'conditionProfile': instance.conditionProfile,
      'personalSensitivity': instance.personalSensitivity,
      'createdAt': instance.createdAt.toIso8601String(),
      'isSynced': instance.isSynced,
    };

const _$PemRiskLevelEnumMap = {
  PemRiskLevel.low: 'low',
  PemRiskLevel.moderate: 'moderate',
  PemRiskLevel.high: 'high',
  PemRiskLevel.critical: 'critical',
};

_$PacingStateImpl _$$PacingStateImplFromJson(Map<String, dynamic> json) =>
    _$PacingStateImpl(
      type: $enumDecode(_$PacingStateTypeEnumMap, json['type']),
      overallScore: (json['overallScore'] as num).toInt(),
      description: json['description'] as String,
      reasoning: json['reasoning'] as String? ?? '',
      recommendedActivityTime: json['recommendedActivityTime'] == null
          ? null
          : DateTime.parse(json['recommendedActivityTime'] as String),
      recommendedRestDuration: json['recommendedRestDuration'] == null
          ? null
          : Duration(
              microseconds: (json['recommendedRestDuration'] as num).toInt()),
    );

Map<String, dynamic> _$$PacingStateImplToJson(_$PacingStateImpl instance) =>
    <String, dynamic>{
      'type': _$PacingStateTypeEnumMap[instance.type]!,
      'overallScore': instance.overallScore,
      'description': instance.description,
      'reasoning': instance.reasoning,
      'recommendedActivityTime':
          instance.recommendedActivityTime?.toIso8601String(),
      'recommendedRestDuration':
          instance.recommendedRestDuration?.inMicroseconds,
    };

const _$PacingStateTypeEnumMap = {
  PacingStateType.excellent: 'excellent',
  PacingStateType.good: 'good',
  PacingStateType.moderate: 'moderate',
  PacingStateType.caution: 'caution',
  PacingStateType.restRequired: 'rest_required',
  PacingStateType.recoveryMode: 'recovery_mode',
};

_$HrvContributionImpl _$$HrvContributionImplFromJson(
        Map<String, dynamic> json) =>
    _$HrvContributionImpl(
      currentHrvScore: (json['currentHrvScore'] as num).toDouble(),
      sevenDayAverage: (json['sevenDayAverage'] as num).toDouble(),
      personalBaseline: (json['personalBaseline'] as num).toDouble(),
      percentageOfBaseline: (json['percentageOfBaseline'] as num).toDouble(),
      trend: $enumDecode(_$TrendDirectionEnumMap, json['trend']),
      weight: (json['weight'] as num?)?.toDouble() ?? 0.4,
    );

Map<String, dynamic> _$$HrvContributionImplToJson(
        _$HrvContributionImpl instance) =>
    <String, dynamic>{
      'currentHrvScore': instance.currentHrvScore,
      'sevenDayAverage': instance.sevenDayAverage,
      'personalBaseline': instance.personalBaseline,
      'percentageOfBaseline': instance.percentageOfBaseline,
      'trend': _$TrendDirectionEnumMap[instance.trend]!,
      'weight': instance.weight,
    };

const _$TrendDirectionEnumMap = {
  TrendDirection.improving: 'improving',
  TrendDirection.stable: 'stable',
  TrendDirection.declining: 'declining',
  TrendDirection.concerning: 'concerning',
};

_$ActivityContributionImpl _$$ActivityContributionImplFromJson(
        Map<String, dynamic> json) =>
    _$ActivityContributionImpl(
      yesterdaySteps: (json['yesterdaySteps'] as num).toInt(),
      sevenDayAverageSteps: (json['sevenDayAverageSteps'] as num).toInt(),
      recentWorkouts: (json['recentWorkouts'] as List<dynamic>)
          .map((e) => WorkoutSession.fromJson(e as Map<String, dynamic>))
          .toList(),
      cumulativeIntensityScore:
          (json['cumulativeIntensityScore'] as num).toInt(),
      loadLevel: $enumDecode(_$ActivityLoadLevelEnumMap, json['loadLevel']),
      weight: (json['weight'] as num?)?.toDouble() ?? 0.3,
    );

Map<String, dynamic> _$$ActivityContributionImplToJson(
        _$ActivityContributionImpl instance) =>
    <String, dynamic>{
      'yesterdaySteps': instance.yesterdaySteps,
      'sevenDayAverageSteps': instance.sevenDayAverageSteps,
      'recentWorkouts': instance.recentWorkouts,
      'cumulativeIntensityScore': instance.cumulativeIntensityScore,
      'loadLevel': _$ActivityLoadLevelEnumMap[instance.loadLevel]!,
      'weight': instance.weight,
    };

const _$ActivityLoadLevelEnumMap = {
  ActivityLoadLevel.veryLow: 'very_low',
  ActivityLoadLevel.low: 'low',
  ActivityLoadLevel.moderate: 'moderate',
  ActivityLoadLevel.high: 'high',
  ActivityLoadLevel.veryHigh: 'very_high',
  ActivityLoadLevel.overload: 'overload',
};

_$SleepContributionImpl _$$SleepContributionImplFromJson(
        Map<String, dynamic> json) =>
    _$SleepContributionImpl(
      lastNightSleep: json['lastNightSleep'] == null
          ? null
          : Duration(microseconds: (json['lastNightSleep'] as num).toInt()),
      sleepQuality: (json['sleepQuality'] as num?)?.toInt() ?? null,
      sevenDayAverageSleep:
          Duration(microseconds: (json['sevenDayAverageSleep'] as num).toInt()),
      sleepDebt: $enumDecode(_$SleepDebtLevelEnumMap, json['sleepDebt']),
      weight: (json['weight'] as num?)?.toDouble() ?? 0.2,
    );

Map<String, dynamic> _$$SleepContributionImplToJson(
        _$SleepContributionImpl instance) =>
    <String, dynamic>{
      'lastNightSleep': instance.lastNightSleep?.inMicroseconds,
      'sleepQuality': instance.sleepQuality,
      'sevenDayAverageSleep': instance.sevenDayAverageSleep.inMicroseconds,
      'sleepDebt': _$SleepDebtLevelEnumMap[instance.sleepDebt]!,
      'weight': instance.weight,
    };

const _$SleepDebtLevelEnumMap = {
  SleepDebtLevel.wellRested: 'well_rested',
  SleepDebtLevel.slightDeficit: 'slight_deficit',
  SleepDebtLevel.moderateDeficit: 'moderate_deficit',
  SleepDebtLevel.significantDeficit: 'significant_deficit',
  SleepDebtLevel.severeDeficit: 'severe_deficit',
};

_$MenstrualContributionImpl _$$MenstrualContributionImplFromJson(
        Map<String, dynamic> json) =>
    _$MenstrualContributionImpl(
      currentPhase: $enumDecode(_$MenstrualPhaseEnumMap, json['currentPhase']),
      energyImpact: (json['energyImpact'] as num).toInt(),
      activeSymptoms: (json['activeSymptoms'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MenstrualSymptomEnumMap, e))
              .toList() ??
          const [],
      totalSymptomImpact: (json['totalSymptomImpact'] as num).toInt(),
      weight: (json['weight'] as num?)?.toDouble() ?? 0.1,
    );

Map<String, dynamic> _$$MenstrualContributionImplToJson(
        _$MenstrualContributionImpl instance) =>
    <String, dynamic>{
      'currentPhase': _$MenstrualPhaseEnumMap[instance.currentPhase]!,
      'energyImpact': instance.energyImpact,
      'activeSymptoms': instance.activeSymptoms
          .map((e) => _$MenstrualSymptomEnumMap[e]!)
          .toList(),
      'totalSymptomImpact': instance.totalSymptomImpact,
      'weight': instance.weight,
    };

const _$MenstrualPhaseEnumMap = {
  MenstrualPhase.menstrual: 'menstrual',
  MenstrualPhase.follicular: 'follicular',
  MenstrualPhase.ovulatory: 'ovulatory',
  MenstrualPhase.luteal: 'luteal',
  MenstrualPhase.unknown: 'unknown',
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

_$PacingRecommendationImpl _$$PacingRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$PacingRecommendationImpl(
      type: $enumDecode(_$RecommendationTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      priority: $enumDecode(_$PriorityLevelEnumMap, json['priority']),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      specificActions: (json['specificActions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      reasoning: json['reasoning'] as String? ?? '',
    );

Map<String, dynamic> _$$PacingRecommendationImplToJson(
        _$PacingRecommendationImpl instance) =>
    <String, dynamic>{
      'type': _$RecommendationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'priority': _$PriorityLevelEnumMap[instance.priority]!,
      'duration': instance.duration?.inMicroseconds,
      'specificActions': instance.specificActions,
      'reasoning': instance.reasoning,
    };

const _$RecommendationTypeEnumMap = {
  RecommendationType.rest: 'rest',
  RecommendationType.gentleActivity: 'gentle_activity',
  RecommendationType.moderateActivity: 'moderate_activity',
  RecommendationType.pacingStrategy: 'pacing_strategy',
  RecommendationType.sleepOptimization: 'sleep_optimization',
  RecommendationType.stressManagement: 'stress_management',
  RecommendationType.energyConservation: 'energy_conservation',
};

const _$PriorityLevelEnumMap = {
  PriorityLevel.low: 'low',
  PriorityLevel.medium: 'medium',
  PriorityLevel.high: 'high',
  PriorityLevel.critical: 'critical',
};

_$ActivityGuidanceImpl _$$ActivityGuidanceImplFromJson(
        Map<String, dynamic> json) =>
    _$ActivityGuidanceImpl(
      mainRecommendation: $enumDecode(
          _$ActivityRecommendationEnumMap, json['mainRecommendation']),
      maxRecommendedSteps:
          (json['maxRecommendedSteps'] as num?)?.toInt() ?? null,
      maxRecommendedActivity: json['maxRecommendedActivity'] == null
          ? null
          : Duration(
              microseconds: (json['maxRecommendedActivity'] as num).toInt()),
      recommendedActivities: (json['recommendedActivities'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$WorkoutTypeEnumMap, e))
              .toList() ??
          const [],
      activitiesToAvoid: (json['activitiesToAvoid'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$WorkoutTypeEnumMap, e))
              .toList() ??
          const [],
      maxPerceivedExertion:
          (json['maxPerceivedExertion'] as num?)?.toInt() ?? null,
      specificGuidance: (json['specificGuidance'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ActivityGuidanceImplToJson(
        _$ActivityGuidanceImpl instance) =>
    <String, dynamic>{
      'mainRecommendation':
          _$ActivityRecommendationEnumMap[instance.mainRecommendation]!,
      'maxRecommendedSteps': instance.maxRecommendedSteps,
      'maxRecommendedActivity': instance.maxRecommendedActivity?.inMicroseconds,
      'recommendedActivities': instance.recommendedActivities
          .map((e) => _$WorkoutTypeEnumMap[e]!)
          .toList(),
      'activitiesToAvoid': instance.activitiesToAvoid
          .map((e) => _$WorkoutTypeEnumMap[e]!)
          .toList(),
      'maxPerceivedExertion': instance.maxPerceivedExertion,
      'specificGuidance': instance.specificGuidance,
    };

const _$ActivityRecommendationEnumMap = {
  ActivityRecommendation.fullRest: 'full_rest',
  ActivityRecommendation.gentleMovement: 'gentle_movement',
  ActivityRecommendation.lightActivity: 'light_activity',
  ActivityRecommendation.moderateActivity: 'moderate_activity',
  ActivityRecommendation.normalActivity: 'normal_activity',
  ActivityRecommendation.canPushSlightly: 'can_push_slightly',
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

_$ChronicConditionProfileImpl _$$ChronicConditionProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$ChronicConditionProfileImpl(
      conditions: (json['conditions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ChronicConditionEnumMap, e))
              .toList() ??
          const [],
      pemSensitivity: (json['pemSensitivity'] as num?)?.toDouble() ?? 1.0,
      recoveryTimeMultiplier:
          (json['recoveryTimeMultiplier'] as num?)?.toDouble() ?? 1.0,
      baselineEnergyLevel: (json['baselineEnergyLevel'] as num?)?.toInt() ?? 50,
      triggerActivities: (json['triggerActivities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      safetActivities: (json['safetActivities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ChronicConditionProfileImplToJson(
        _$ChronicConditionProfileImpl instance) =>
    <String, dynamic>{
      'conditions': instance.conditions
          .map((e) => _$ChronicConditionEnumMap[e]!)
          .toList(),
      'pemSensitivity': instance.pemSensitivity,
      'recoveryTimeMultiplier': instance.recoveryTimeMultiplier,
      'baselineEnergyLevel': instance.baselineEnergyLevel,
      'triggerActivities': instance.triggerActivities,
      'safetActivities': instance.safetActivities,
    };

const _$ChronicConditionEnumMap = {
  ChronicCondition.meCfs: 'me_cfs',
  ChronicCondition.pots: 'pots',
  ChronicCondition.longCovid: 'long_covid',
  ChronicCondition.fibromyalgia: 'fibromyalgia',
  ChronicCondition.lupus: 'lupus',
  ChronicCondition.multipleSclerosis: 'multiple_sclerosis',
  ChronicCondition.ehlersDanlos: 'ehlers_danlos',
  ChronicCondition.chronicPain: 'chronic_pain',
  ChronicCondition.autoimmune: 'autoimmune',
  ChronicCondition.other: 'other',
};
