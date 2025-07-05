import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health/health.dart' as health;

part 'health_data_point.freezed.dart';
part 'health_data_point.g.dart';

/// Represents a unified health data point that can contain different types of health metrics
@freezed
class HealthDataPoint with _$HealthDataPoint {
  const factory HealthDataPoint({
    required String id,
    required String type,
    required double value,
    required String unit,
    required DateTime dateFrom,
    required DateTime dateTo,
    required String sourcePlatform,
    required String sourceId,
    Map<String, dynamic>? metadata,
  }) = _HealthDataPoint;

  factory HealthDataPoint.fromJson(Map<String, dynamic> json) => _$HealthDataPointFromJson(json);
  
  /// Creates a HealthDataPoint from a Health package HealthDataPoint
  factory HealthDataPoint.fromHealthPackage(health.HealthDataPoint healthPoint) {
    return HealthDataPoint(
      id: '${healthPoint.type.name}_${healthPoint.dateFrom.millisecondsSinceEpoch}',
      type: healthPoint.type.name,
      value: double.tryParse(healthPoint.value.toString()) ?? 0.0,
      unit: healthPoint.unit.name,
      dateFrom: healthPoint.dateFrom,
      dateTo: healthPoint.dateTo,
      sourcePlatform: healthPoint.sourcePlatform.name,
      sourceId: healthPoint.sourceId,
      metadata: <String, dynamic>{}, // Health package doesn't have metadata in v10.2.0
    );
  }
}

/// Aggregated health data for a specific time period
@freezed
class HealthDataSummary with _$HealthDataSummary {
  const factory HealthDataSummary({
    required DateTime date,
    required int steps,
    required double activeEnergyBurned, // in calories
    required double restingHeartRate,
    required double averageHeartRate,
    required double sleepHours,
    required double sleepEfficiency, // percentage
    required List<WorkoutSession> workouts,
    MenstrualCycleData? menstrualCycle,
    Map<String, dynamic>? additionalMetrics,
  }) = _HealthDataSummary;

  factory HealthDataSummary.fromJson(Map<String, dynamic> json) => _$HealthDataSummaryFromJson(json);
  
  /// Creates an empty summary for a given date
  factory HealthDataSummary.empty(DateTime date) {
    return HealthDataSummary(
      date: date,
      steps: 0,
      activeEnergyBurned: 0.0,
      restingHeartRate: 0.0,
      averageHeartRate: 0.0,
      sleepHours: 0.0,
      sleepEfficiency: 0.0,
      workouts: [],
    );
  }
}

/// Represents a workout session
@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required WorkoutType type,
    required DateTime startTime,
    required DateTime endTime,
    required double duration, // in minutes
    required double caloriesBurned,
    double? averageHeartRate,
    double? maxHeartRate,
    double? distance, // in meters
    Map<String, dynamic>? metadata,
  }) = _WorkoutSession;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) => _$WorkoutSessionFromJson(json);
  
  /// Creates a WorkoutSession from a Health package HealthDataPoint
  factory WorkoutSession.fromHealthDataPoint(health.HealthDataPoint healthPoint) {
    final duration = healthPoint.dateTo.difference(healthPoint.dateFrom).inMinutes.toDouble();
    
    return WorkoutSession(
      id: '${healthPoint.type.name}_${healthPoint.dateFrom.millisecondsSinceEpoch}',
      type: _mapHealthDataTypeToWorkoutType(healthPoint.type),
      startTime: healthPoint.dateFrom,
      endTime: healthPoint.dateTo,
      duration: duration,
      caloriesBurned: double.tryParse(healthPoint.value.toString()) ?? 0.0,
      metadata: <String, dynamic>{}, // Health package doesn't have metadata in v10.2.0
    );
  }
}

/// Represents menstrual cycle data
@freezed
class MenstrualCycleData with _$MenstrualCycleData {
  const factory MenstrualCycleData({
    required DateTime date,
    required MenstrualFlow flow,
    List<MenstrualSymptom>? symptoms,
    Map<String, dynamic>? metadata,
  }) = _MenstrualCycleData;

  factory MenstrualCycleData.fromJson(Map<String, dynamic> json) => _$MenstrualCycleDataFromJson(json);
}

/// Enum for workout types
enum WorkoutType {
  walking,
  running,
  cycling,
  swimming,
  yoga,
  strengthTraining,
  cardio,
  sports,
  dance,
  climbing,
  skiing,
  tennis,
  golf,
  hiking,
  other,
}

/// Enum for menstrual flow levels
enum MenstrualFlow {
  none,
  light,
  medium,
  heavy,
}

/// Enum for menstrual symptoms
enum MenstrualSymptom {
  cramps,
  bloating,
  headache,
  moodChanges,
  fatigue,
  backPain,
  breastTenderness,
  nausea,
  other,
}

/// Helper function to map Health package workout types to our WorkoutType enum
WorkoutType _mapHealthDataTypeToWorkoutType(health.HealthDataType type) {
  switch (type) {
    case health.HealthDataType.WORKOUT:
      return WorkoutType.other;
    case health.HealthDataType.STEPS:
      return WorkoutType.walking;
    default:
      return WorkoutType.other;
  }
}

/// Extension to provide human-readable names for workout types
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
      case WorkoutType.yoga:
        return 'Yoga';
      case WorkoutType.strengthTraining:
        return 'Strength Training';
      case WorkoutType.cardio:
        return 'Cardio';
      case WorkoutType.sports:
        return 'Sports';
      case WorkoutType.dance:
        return 'Dance';
      case WorkoutType.climbing:
        return 'Climbing';
      case WorkoutType.skiing:
        return 'Skiing';
      case WorkoutType.tennis:
        return 'Tennis';
      case WorkoutType.golf:
        return 'Golf';
      case WorkoutType.hiking:
        return 'Hiking';
      case WorkoutType.other:
        return 'Other';
    }
  }
}

/// Extension to provide human-readable names for menstrual flow
extension MenstrualFlowExtension on MenstrualFlow {
  String get displayName {
    switch (this) {
      case MenstrualFlow.none:
        return 'None';
      case MenstrualFlow.light:
        return 'Light';
      case MenstrualFlow.medium:
        return 'Medium';
      case MenstrualFlow.heavy:
        return 'Heavy';
    }
  }
}