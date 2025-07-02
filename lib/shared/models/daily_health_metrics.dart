import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_health_metrics.freezed.dart';
part 'daily_health_metrics.g.dart';

/// Daily health metrics aggregated from various sources
@freezed
class DailyHealthMetrics with _$DailyHealthMetrics {
  const factory DailyHealthMetrics({
    required String id,
    required DateTime date,
    
    // Step and movement data
    @Default(0) int stepCount,
    @Default(0.0) double distanceKm,
    @Default(0) int activeMinutes,
    @Default(0) int flightsClimbed,
    
    // Sleep data
    @Default(null) SleepData? sleepData,
    
    // Workout sessions
    @Default([]) List<WorkoutSession> workouts,
    
    // Menstrual cycle data (optional)
    @Default(null) MenstrualCycleData? menstrualData,
    
    // Energy and symptoms (user-reported)
    @Default(null) int? energyLevel, // 1-10 scale
    @Default(null) int? stressLevel, // 1-10 scale
    @Default([]) List<String> symptoms,
    @Default('') String notes,
    
    // Data quality indicators
    @Default(true) bool isComplete,
    @Default([]) List<String> dataSources, // 'health_kit', 'google_fit', 'manual'
    
    // Metadata
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isSynced,
  }) = _DailyHealthMetrics;

  factory DailyHealthMetrics.fromJson(Map<String, dynamic> json) =>
      _$DailyHealthMetricsFromJson(json);
}

/// Sleep data for a single night
@freezed
class SleepData with _$SleepData {
  const factory SleepData({
    required DateTime bedTime,
    required DateTime wakeTime,
    required Duration totalSleepTime,
    @Default(null) Duration? deepSleepTime,
    @Default(null) Duration? remSleepTime,
    @Default(null) Duration? lightSleepTime,
    @Default(null) int? sleepQuality, // 1-10 scale if available
    @Default(0) int awakenings,
    @Default(null) Duration? timeToFallAsleep,
    @Default('unknown') String source, // 'health_kit', 'google_fit', 'manual'
  }) = _SleepData;

  factory SleepData.fromJson(Map<String, dynamic> json) =>
      _$SleepDataFromJson(json);
}

/// Individual workout/exercise session
@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required DateTime startTime,
    required DateTime endTime,
    required WorkoutType type,
    required Duration duration,
    
    // Intensity and effort
    @Default(null) int? perceivedExertion, // RPE 1-10 scale
    @Default(null) double? averageHeartRate,
    @Default(null) double? maxHeartRate,
    @Default(null) int? caloriesBurned,
    
    // Activity-specific metrics
    @Default(null) double? distanceKm,
    @Default(null) int? steps,
    @Default(null) double? avgSpeed, // km/h
    @Default(null) double? elevationGain, // meters
    
    // Recovery metrics
    @Default(null) int? recoveryHeartRate, // BPM after 1 minute
    @Default(null) Duration? recoveryTime, // Time to return to resting HR
    
    @Default('') String notes,
    @Default('unknown') String source,
    
    // Metadata
    required DateTime createdAt,
    @Default(false) bool isSynced,
  }) = _WorkoutSession;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSessionFromJson(json);
}

/// Menstrual cycle tracking data
@freezed
class MenstrualCycleData with _$MenstrualCycleData {
  const factory MenstrualCycleData({
    required DateTime date,
    required MenstrualPhase phase,
    @Default(null) FlowIntensity? flowIntensity,
    @Default([]) List<MenstrualSymptom> symptoms,
    @Default(null) int? moodRating, // 1-10 scale
    @Default(null) int? energyRating, // 1-10 scale
    @Default(null) int? painLevel, // 1-10 scale
    @Default('') String notes,
    @Default('unknown') String source,
    
    // Cycle predictions
    @Default(null) DateTime? predictedNextPeriod,
    @Default(null) DateTime? predictedOvulation,
    
    // Metadata
    required DateTime createdAt,
    @Default(false) bool isSynced,
  }) = _MenstrualCycleData;

  factory MenstrualCycleData.fromJson(Map<String, dynamic> json) =>
      _$MenstrualCycleDataFromJson(json);
}

// Enums for workout and health data

enum WorkoutType {
  @JsonValue('walking')
  walking,
  @JsonValue('running')
  running,
  @JsonValue('cycling')
  cycling,
  @JsonValue('swimming')
  swimming,
  @JsonValue('strength_training')
  strengthTraining,
  @JsonValue('yoga')
  yoga,
  @JsonValue('pilates')
  pilates,
  @JsonValue('tai_chi')
  taiChi,
  @JsonValue('stretching')
  stretching,
  @JsonValue('meditation')
  meditation,
  @JsonValue('breathing_exercises')
  breathingExercises,
  @JsonValue('physical_therapy')
  physicalTherapy,
  @JsonValue('household_activities')
  householdActivities,
  @JsonValue('gardening')
  gardening,
  @JsonValue('other')
  other,
}

enum MenstrualPhase {
  @JsonValue('menstrual')
  menstrual,
  @JsonValue('follicular')
  follicular,
  @JsonValue('ovulatory')
  ovulatory,
  @JsonValue('luteal')
  luteal,
  @JsonValue('unknown')
  unknown,
}

enum FlowIntensity {
  @JsonValue('spotting')
  spotting,
  @JsonValue('light')
  light,
  @JsonValue('medium')
  medium,
  @JsonValue('heavy')
  heavy,
  @JsonValue('very_heavy')
  veryHeavy,
}

enum MenstrualSymptom {
  @JsonValue('cramps')
  cramps,
  @JsonValue('headache')
  headache,
  @JsonValue('bloating')
  bloating,
  @JsonValue('mood_swings')
  moodSwings,
  @JsonValue('fatigue')
  fatigue,
  @JsonValue('breast_tenderness')
  breastTenderness,
  @JsonValue('back_pain')
  backPain,
  @JsonValue('nausea')
  nausea,
  @JsonValue('acne')
  acne,
  @JsonValue('food_cravings')
  foodCravings,
  @JsonValue('insomnia')
  insomnia,
  @JsonValue('hot_flashes')
  hotFlashes,
}

// Extensions for display values

extension WorkoutTypeExtension on WorkoutType {
  String get displayName {
    switch (this) {
      case WorkoutType.walking:
        return 'Walking';
      case WorkoutType.running:
        return 'Running';
      case WorkoutType.cycling:
        return 'Cycling';
      case WorkoutType.swimming:
        return 'Swimming';
      case WorkoutType.strengthTraining:
        return 'Strength Training';
      case WorkoutType.yoga:
        return 'Yoga';
      case WorkoutType.pilates:
        return 'Pilates';
      case WorkoutType.taiChi:
        return 'Tai Chi';
      case WorkoutType.stretching:
        return 'Stretching';
      case WorkoutType.meditation:
        return 'Meditation';
      case WorkoutType.breathingExercises:
        return 'Breathing Exercises';
      case WorkoutType.physicalTherapy:
        return 'Physical Therapy';
      case WorkoutType.householdActivities:
        return 'Household Activities';
      case WorkoutType.gardening:
        return 'Gardening';
      case WorkoutType.other:
        return 'Other';
    }
  }
  
  /// Returns the typical intensity level for chronic illness patients
  int get chronicIllnessIntensity {
    switch (this) {
      case WorkoutType.walking:
        return 3; // Light intensity
      case WorkoutType.running:
        return 7; // High intensity - caution needed
      case WorkoutType.cycling:
        return 5; // Moderate intensity
      case WorkoutType.swimming:
        return 4; // Low-moderate intensity
      case WorkoutType.strengthTraining:
        return 6; // Moderate-high intensity
      case WorkoutType.yoga:
        return 2; // Very light intensity
      case WorkoutType.pilates:
        return 3; // Light intensity
      case WorkoutType.taiChi:
        return 2; // Very light intensity
      case WorkoutType.stretching:
        return 1; // Minimal intensity
      case WorkoutType.meditation:
        return 1; // Minimal intensity
      case WorkoutType.breathingExercises:
        return 1; // Minimal intensity
      case WorkoutType.physicalTherapy:
        return 3; // Light intensity
      case WorkoutType.householdActivities:
        return 4; // Variable intensity
      case WorkoutType.gardening:
        return 4; // Variable intensity
      case WorkoutType.other:
        return 3; // Default to light
    }
  }
}

extension MenstrualPhaseExtension on MenstrualPhase {
  String get displayName {
    switch (this) {
      case MenstrualPhase.menstrual:
        return 'Menstrual';
      case MenstrualPhase.follicular:
        return 'Follicular';
      case MenstrualPhase.ovulatory:
        return 'Ovulatory';
      case MenstrualPhase.luteal:
        return 'Luteal';
      case MenstrualPhase.unknown:
        return 'Unknown';
    }
  }
  
  /// Returns the typical energy level during this phase (1-10 scale)
  int get typicalEnergyLevel {
    switch (this) {
      case MenstrualPhase.menstrual:
        return 4; // Lower energy due to bleeding
      case MenstrualPhase.follicular:
        return 7; // Rising energy
      case MenstrualPhase.ovulatory:
        return 8; // Peak energy
      case MenstrualPhase.luteal:
        return 5; // Declining energy
      case MenstrualPhase.unknown:
        return 6; // Average
    }
  }
}

extension FlowIntensityExtension on FlowIntensity {
  String get displayName {
    switch (this) {
      case FlowIntensity.spotting:
        return 'Spotting';
      case FlowIntensity.light:
        return 'Light';
      case FlowIntensity.medium:
        return 'Medium';
      case FlowIntensity.heavy:
        return 'Heavy';
      case FlowIntensity.veryHeavy:
        return 'Very Heavy';
    }
  }
  
  /// Returns the impact on activity capacity (1-5 scale, 5 = high impact)
  int get activityImpact {
    switch (this) {
      case FlowIntensity.spotting:
        return 1;
      case FlowIntensity.light:
        return 2;
      case FlowIntensity.medium:
        return 3;
      case FlowIntensity.heavy:
        return 4;
      case FlowIntensity.veryHeavy:
        return 5;
    }
  }
}

extension MenstrualSymptomExtension on MenstrualSymptom {
  String get displayName {
    switch (this) {
      case MenstrualSymptom.cramps:
        return 'Cramps';
      case MenstrualSymptom.headache:
        return 'Headache';
      case MenstrualSymptom.bloating:
        return 'Bloating';
      case MenstrualSymptom.moodSwings:
        return 'Mood Swings';
      case MenstrualSymptom.fatigue:
        return 'Fatigue';
      case MenstrualSymptom.breastTenderness:
        return 'Breast Tenderness';
      case MenstrualSymptom.backPain:
        return 'Back Pain';
      case MenstrualSymptom.nausea:
        return 'Nausea';
      case MenstrualSymptom.acne:
        return 'Acne';
      case MenstrualSymptom.foodCravings:
        return 'Food Cravings';
      case MenstrualSymptom.insomnia:
        return 'Insomnia';
      case MenstrualSymptom.hotFlashes:
        return 'Hot Flashes';
    }
  }
  
  /// Returns the impact on activity capacity (1-5 scale, 5 = high impact)
  int get activityImpact {
    switch (this) {
      case MenstrualSymptom.cramps:
        return 4;
      case MenstrualSymptom.headache:
        return 3;
      case MenstrualSymptom.bloating:
        return 2;
      case MenstrualSymptom.moodSwings:
        return 2;
      case MenstrualSymptom.fatigue:
        return 5;
      case MenstrualSymptom.breastTenderness:
        return 1;
      case MenstrualSymptom.backPain:
        return 4;
      case MenstrualSymptom.nausea:
        return 4;
      case MenstrualSymptom.acne:
        return 1;
      case MenstrualSymptom.foodCravings:
        return 1;
      case MenstrualSymptom.insomnia:
        return 4;
      case MenstrualSymptom.hotFlashes:
        return 3;
    }
  }
}