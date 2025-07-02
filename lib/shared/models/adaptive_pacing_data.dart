import 'package:freezed_annotation/freezed_annotation.dart';
import 'daily_health_metrics.dart';
import '../../../features/settings/domain/models/user_preferences.dart';

part 'adaptive_pacing_data.freezed.dart';
part 'adaptive_pacing_data.g.dart';

/// Adaptive pacing assessment combining HRV and lifestyle data
@freezed
class AdaptivePacingAssessment with _$AdaptivePacingAssessment {
  const factory AdaptivePacingAssessment({
    required String id,
    required DateTime date,
    
    // Current state assessment
    required PacingState currentState,
    required PemRiskLevel pemRisk,
    required int energyEnvelopePercentage, // 0-100% of personal energy envelope
    
    // Contributing factors
    required HrvContribution hrvContribution,
    required ActivityContribution activityContribution,
    required SleepContribution sleepContribution,
    @Default(null) MenstrualContribution? menstrualContribution,
    
    // Recommendations
    required List<PacingRecommendation> recommendations,
    required ActivityGuidance activityGuidance,
    
    // Trend analysis
    @Default([]) List<String> trendWarnings,
    @Default(0) int consecutiveHighRiskDays,
    @Default(0.0) double sevenDayEnergyTrend, // -1.0 to 1.0
    
    // Personalization factors
    required ChronicConditionProfile conditionProfile,
    @Default(1.0) double personalSensitivity, // 0.5-2.0 multiplier
    
    // Metadata
    required DateTime createdAt,
    @Default(false) bool isSynced,
  }) = _AdaptivePacingAssessment;

  factory AdaptivePacingAssessment.fromJson(Map<String, dynamic> json) =>
      _$AdaptivePacingAssessmentFromJson(json);
}

/// Current pacing state based on multiple factors
@freezed
class PacingState with _$PacingState {
  const factory PacingState({
    required PacingStateType type,
    required int overallScore, // 0-100
    required String description,
    @Default('') String reasoning,
    @Default(null) DateTime? recommendedActivityTime,
    @Default(null) Duration? recommendedRestDuration,
  }) = _PacingState;

  factory PacingState.fromJson(Map<String, dynamic> json) =>
      _$PacingStateFromJson(json);
}

/// HRV contribution to pacing assessment
@freezed
class HrvContribution with _$HrvContribution {
  const factory HrvContribution({
    required double currentHrvScore, // 0-100
    required double sevenDayAverage,
    required double personalBaseline,
    required double percentageOfBaseline, // Current vs baseline
    required TrendDirection trend,
    @Default(0.4) double weight, // Weight in overall assessment
  }) = _HrvContribution;

  factory HrvContribution.fromJson(Map<String, dynamic> json) =>
      _$HrvContributionFromJson(json);
}

/// Activity contribution to pacing assessment
@freezed
class ActivityContribution with _$ActivityContribution {
  const factory ActivityContribution({
    required int yesterdaySteps,
    required int sevenDayAverageSteps,
    required List<WorkoutSession> recentWorkouts,
    required int cumulativeIntensityScore, // Last 3 days
    required ActivityLoadLevel loadLevel,
    @Default(0.3) double weight,
  }) = _ActivityContribution;

  factory ActivityContribution.fromJson(Map<String, dynamic> json) =>
      _$ActivityContributionFromJson(json);
}

/// Sleep contribution to pacing assessment
@freezed
class SleepContribution with _$SleepContribution {
  const factory SleepContribution({
    @Default(null) Duration? lastNightSleep,
    @Default(null) int? sleepQuality, // 1-10
    required Duration sevenDayAverageSleep,
    required SleepDebtLevel sleepDebt,
    @Default(0.2) double weight,
  }) = _SleepContribution;

  factory SleepContribution.fromJson(Map<String, dynamic> json) =>
      _$SleepContributionFromJson(json);
}

/// Menstrual cycle contribution to pacing assessment
@freezed
class MenstrualContribution with _$MenstrualContribution {
  const factory MenstrualContribution({
    required MenstrualPhase currentPhase,
    required int energyImpact, // 1-10 scale
    @Default([]) List<MenstrualSymptom> activeSymptoms,
    required int totalSymptomImpact, // Sum of symptom impacts
    @Default(0.1) double weight,
  }) = _MenstrualContribution;

  factory MenstrualContribution.fromJson(Map<String, dynamic> json) =>
      _$MenstrualContributionFromJson(json);
}

/// Specific pacing recommendation
@freezed
class PacingRecommendation with _$PacingRecommendation {
  const factory PacingRecommendation({
    required RecommendationType type,
    required String title,
    required String description,
    required PriorityLevel priority,
    @Default(null) Duration? duration,
    @Default([]) List<String> specificActions,
    @Default('') String reasoning,
  }) = _PacingRecommendation;

  factory PacingRecommendation.fromJson(Map<String, dynamic> json) =>
      _$PacingRecommendationFromJson(json);
}

/// Activity guidance for the day
@freezed
class ActivityGuidance with _$ActivityGuidance {
  const factory ActivityGuidance({
    required ActivityRecommendation mainRecommendation,
    @Default(null) int? maxRecommendedSteps,
    @Default(null) Duration? maxRecommendedActivity,
    @Default([]) List<WorkoutType> recommendedActivities,
    @Default([]) List<WorkoutType> activitiesToAvoid,
    @Default(null) int? maxPerceivedExertion, // 1-10 RPE scale
    @Default([]) List<String> specificGuidance,
  }) = _ActivityGuidance;

  factory ActivityGuidance.fromJson(Map<String, dynamic> json) =>
      _$ActivityGuidanceFromJson(json);
}

/// Chronic condition profile for personalized algorithms
@freezed
class ChronicConditionProfile with _$ChronicConditionProfile {
  const factory ChronicConditionProfile({
    @Default([]) List<ChronicCondition> conditions,
    @Default(1.0) double pemSensitivity, // 0.5-2.0
    @Default(1.0) double recoveryTimeMultiplier, // 0.5-3.0
    @Default(50) int baselineEnergyLevel, // 0-100
    @Default([]) List<String> triggerActivities,
    @Default([]) List<String> safetActivities,
  }) = _ChronicConditionProfile;

  factory ChronicConditionProfile.fromJson(Map<String, dynamic> json) =>
      _$ChronicConditionProfileFromJson(json);
}

// Enums for adaptive pacing

enum PacingStateType {
  @JsonValue('excellent')
  excellent, // Green - high energy, low PEM risk
  @JsonValue('good')
  good, // Light green - good energy, minimal risk
  @JsonValue('moderate')
  moderate, // Yellow - moderate energy, some caution needed
  @JsonValue('caution')
  caution, // Orange - low energy, elevated PEM risk
  @JsonValue('rest_required')
  restRequired, // Red - very low energy, high PEM risk
  @JsonValue('recovery_mode')
  recoveryMode, // Deep red - post-crash recovery
}

enum TrendDirection {
  @JsonValue('improving')
  improving,
  @JsonValue('stable')
  stable,
  @JsonValue('declining')
  declining,
  @JsonValue('concerning')
  concerning,
}

enum ActivityLoadLevel {
  @JsonValue('very_low')
  veryLow,
  @JsonValue('low')
  low,
  @JsonValue('moderate')
  moderate,
  @JsonValue('high')
  high,
  @JsonValue('very_high')
  veryHigh,
  @JsonValue('overload')
  overload,
}

enum SleepDebtLevel {
  @JsonValue('well_rested')
  wellRested,
  @JsonValue('slight_deficit')
  slightDeficit,
  @JsonValue('moderate_deficit')
  moderateDeficit,
  @JsonValue('significant_deficit')
  significantDeficit,
  @JsonValue('severe_deficit')
  severeDeficit,
}

enum RecommendationType {
  @JsonValue('rest')
  rest,
  @JsonValue('gentle_activity')
  gentleActivity,
  @JsonValue('moderate_activity')
  moderateActivity,
  @JsonValue('pacing_strategy')
  pacingStrategy,
  @JsonValue('sleep_optimization')
  sleepOptimization,
  @JsonValue('stress_management')
  stressManagement,
  @JsonValue('energy_conservation')
  energyConservation,
}

enum PriorityLevel {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

enum ActivityRecommendation {
  @JsonValue('full_rest')
  fullRest,
  @JsonValue('gentle_movement')
  gentleMovement,
  @JsonValue('light_activity')
  lightActivity,
  @JsonValue('moderate_activity')
  moderateActivity,
  @JsonValue('normal_activity')
  normalActivity,
  @JsonValue('can_push_slightly')
  canPushSlightly,
}

enum ChronicCondition {
  @JsonValue('me_cfs')
  meCfs, // Myalgic Encephalomyelitis/Chronic Fatigue Syndrome
  @JsonValue('pots')
  pots, // Postural Orthostatic Tachycardia Syndrome
  @JsonValue('long_covid')
  longCovid,
  @JsonValue('fibromyalgia')
  fibromyalgia,
  @JsonValue('lupus')
  lupus,
  @JsonValue('multiple_sclerosis')
  multipleSclerosis,
  @JsonValue('ehlers_danlos')
  ehlersDanlos,
  @JsonValue('chronic_pain')
  chronicPain,
  @JsonValue('autoimmune')
  autoimmune,
  @JsonValue('other')
  other,
}

// Extensions for display and logic

extension PacingStateTypeExtension on PacingStateType {
  String get displayName {
    switch (this) {
      case PacingStateType.excellent:
        return 'Excellent Energy';
      case PacingStateType.good:
        return 'Good Energy';
      case PacingStateType.moderate:
        return 'Moderate Energy';
      case PacingStateType.caution:
        return 'Use Caution';
      case PacingStateType.restRequired:
        return 'Rest Required';
      case PacingStateType.recoveryMode:
        return 'Recovery Mode';
    }
  }
  
  String get colorCode {
    switch (this) {
      case PacingStateType.excellent:
        return '#4CAF50'; // Green
      case PacingStateType.good:
        return '#8BC34A'; // Light Green
      case PacingStateType.moderate:
        return '#FFC107'; // Yellow
      case PacingStateType.caution:
        return '#FF9800'; // Orange
      case PacingStateType.restRequired:
        return '#F44336'; // Red
      case PacingStateType.recoveryMode:
        return '#B71C1C'; // Dark Red
    }
  }
  
  String get emoji {
    switch (this) {
      case PacingStateType.excellent:
        return '💚';
      case PacingStateType.good:
        return '🟢';
      case PacingStateType.moderate:
        return '🟡';
      case PacingStateType.caution:
        return '🟠';
      case PacingStateType.restRequired:
        return '🔴';
      case PacingStateType.recoveryMode:
        return '🆘';
    }
  }
}

extension ActivityRecommendationExtension on ActivityRecommendation {
  String get displayName {
    switch (this) {
      case ActivityRecommendation.fullRest:
        return 'Complete Rest Day';
      case ActivityRecommendation.gentleMovement:
        return 'Gentle Movement Only';
      case ActivityRecommendation.lightActivity:
        return 'Light Activity OK';
      case ActivityRecommendation.moderateActivity:
        return 'Moderate Activity';
      case ActivityRecommendation.normalActivity:
        return 'Normal Activity';
      case ActivityRecommendation.canPushSlightly:
        return 'Can Push Slightly';
    }
  }
  
  String get description {
    switch (this) {
      case ActivityRecommendation.fullRest:
        return 'Focus on rest and recovery. Avoid all strenuous activities.';
      case ActivityRecommendation.gentleMovement:
        return 'Gentle stretching or breathing exercises only. Listen to your body.';
      case ActivityRecommendation.lightActivity:
        return 'Light activities like easy walking or household tasks are OK.';
      case ActivityRecommendation.moderateActivity:
        return 'Moderate activities are fine, but pace yourself and take breaks.';
      case ActivityRecommendation.normalActivity:
        return 'You can engage in your normal activities with confidence.';
      case ActivityRecommendation.canPushSlightly:
        return 'Good energy levels - you can push slightly beyond your usual routine.';
    }
  }
}

extension ChronicConditionExtension on ChronicCondition {
  String get displayName {
    switch (this) {
      case ChronicCondition.meCfs:
        return 'ME/CFS';
      case ChronicCondition.pots:
        return 'POTS';
      case ChronicCondition.longCovid:
        return 'Long COVID';
      case ChronicCondition.fibromyalgia:
        return 'Fibromyalgia';
      case ChronicCondition.lupus:
        return 'Lupus';
      case ChronicCondition.multipleSclerosis:
        return 'Multiple Sclerosis';
      case ChronicCondition.ehlersDanlos:
        return 'Ehlers-Danlos Syndrome';
      case ChronicCondition.chronicPain:
        return 'Chronic Pain';
      case ChronicCondition.autoimmune:
        return 'Autoimmune Condition';
      case ChronicCondition.other:
        return 'Other';
    }
  }
  
  /// PEM sensitivity multiplier for this condition
  double get pemSensitivity {
    switch (this) {
      case ChronicCondition.meCfs:
        return 1.8; // Very high PEM sensitivity
      case ChronicCondition.pots:
        return 1.4; // High sensitivity to exertion
      case ChronicCondition.longCovid:
        return 1.6; // High PEM risk
      case ChronicCondition.fibromyalgia:
        return 1.3; // Moderate-high sensitivity
      case ChronicCondition.lupus:
        return 1.2; // Moderate sensitivity
      case ChronicCondition.multipleSclerosis:
        return 1.3; // Moderate-high sensitivity
      case ChronicCondition.ehlersDanlos:
        return 1.4; // High sensitivity due to fatigue
      case ChronicCondition.chronicPain:
        return 1.2; // Moderate impact
      case ChronicCondition.autoimmune:
        return 1.3; // Variable but generally elevated
      case ChronicCondition.other:
        return 1.0; // Default
    }
  }
  
  /// Recovery time multiplier after activities
  double get recoveryMultiplier {
    switch (this) {
      case ChronicCondition.meCfs:
        return 2.5; // Much longer recovery needed
      case ChronicCondition.pots:
        return 1.8; // Extended recovery
      case ChronicCondition.longCovid:
        return 2.2; // Significantly longer recovery
      case ChronicCondition.fibromyalgia:
        return 1.6; // Longer recovery
      case ChronicCondition.lupus:
        return 1.5; // Moderately longer recovery
      case ChronicCondition.multipleSclerosis:
        return 1.7; // Extended recovery
      case ChronicCondition.ehlersDanlos:
        return 1.4; // Somewhat longer recovery
      case ChronicCondition.chronicPain:
        return 1.3; // Slightly longer recovery
      case ChronicCondition.autoimmune:
        return 1.5; // Variable but generally longer
      case ChronicCondition.other:
        return 1.0; // Default
    }
  }
}