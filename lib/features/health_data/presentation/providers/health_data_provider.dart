import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/health_data_service.dart';
import '../../models/health_data_point.dart';
import '../../../../core/di/injection_container.dart';

/// Provider for HealthDataService
final healthDataServiceProvider = Provider<HealthDataService>((ref) {
  return sl<HealthDataService>();
});

/// Provider for daily health data summary
final dailyHealthDataProvider = FutureProvider.family<HealthDataSummary, DateTime>((ref, date) async {
  final service = ref.watch(healthDataServiceProvider);
  return await service.getHealthDataSummary(date);
});

/// Provider for weekly health data trend
final weeklyHealthDataProvider = FutureProvider.family<List<HealthDataSummary>, DateTime>((ref, startDate) async {
  final service = ref.watch(healthDataServiceProvider);
  final weeklyData = <HealthDataSummary>[];
  
  for (int i = 0; i < 7; i++) {
    final date = startDate.add(Duration(days: i));
    try {
      final summary = await service.getHealthDataSummary(date);
      weeklyData.add(summary);
    } catch (e) {
      // Add empty summary for failed days
      weeklyData.add(HealthDataSummary.empty(date));
    }
  }
  
  return weeklyData;
});

/// Provider for today's health data
final todayHealthDataProvider = FutureProvider<HealthDataSummary>((ref) async {
  final today = DateTime.now();
  final startOfDay = DateTime(today.year, today.month, today.day);
  return ref.watch(dailyHealthDataProvider(startOfDay).future);
});

/// Provider for health data permissions status
final healthPermissionsProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(healthDataServiceProvider);
  return await service.hasPermissions();
});

/// Provider for steps data over a date range
final stepsDataProvider = FutureProvider.family<List<HealthDataPoint>, DateRange>((ref, dateRange) async {
  final service = ref.watch(healthDataServiceProvider);
  return await service.getStepsData(dateRange.start, dateRange.end);
});

/// Provider for workout data over a date range
final workoutDataProvider = FutureProvider.family<List<WorkoutSession>, DateRange>((ref, dateRange) async {
  final service = ref.watch(healthDataServiceProvider);
  return await service.getWorkoutData(dateRange.start, dateRange.end);
});

/// Provider for sleep data over a date range
final sleepDataProvider = FutureProvider.family<List<HealthDataPoint>, DateRange>((ref, dateRange) async {
  final service = ref.watch(healthDataServiceProvider);
  return await service.getSleepData(dateRange.start, dateRange.end);
});

/// Provider for heart rate data over a date range
final heartRateDataProvider = FutureProvider.family<List<HealthDataPoint>, DateRange>((ref, dateRange) async {
  final service = ref.watch(healthDataServiceProvider);
  return await service.getHeartRateData(dateRange.start, dateRange.end);
});

/// Helper class for date range parameters
class DateRange {
  final DateTime start;
  final DateTime end;

  const DateRange({required this.start, required this.end});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DateRange && 
           other.start == start && 
           other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  /// Create a date range for the last 7 days
  factory DateRange.lastWeek() {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfWeek = startOfToday.subtract(const Duration(days: 6));
    return DateRange(
      start: startOfWeek, 
      end: startOfToday.add(const Duration(days: 1)),
    );
  }

  /// Create a date range for the last 30 days
  factory DateRange.lastMonth() {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfMonth = startOfToday.subtract(const Duration(days: 29));
    return DateRange(
      start: startOfMonth, 
      end: startOfToday.add(const Duration(days: 1)),
    );
  }

  /// Create a date range for today
  factory DateRange.today() {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final endOfToday = startOfToday.add(const Duration(days: 1));
    return DateRange(
      start: startOfToday, 
      end: endOfToday,
    );
  }
}

/// Provider for weekly health metrics aggregate
final weeklyHealthMetricsProvider = FutureProvider<WeeklyHealthMetrics>((ref) async {
  final weeklyData = await ref.watch(weeklyHealthDataProvider(
    DateTime.now().subtract(const Duration(days: 6)),
  ).future);
  
  return WeeklyHealthMetrics.fromWeeklyData(weeklyData);
});

/// Aggregate health metrics for a week
class WeeklyHealthMetrics {
  final int totalSteps;
  final double totalActiveEnergy;
  final double averageHeartRate;
  final double averageSleepHours;
  final double averageSleepEfficiency;
  final int totalWorkouts;
  final double totalWorkoutDuration;

  const WeeklyHealthMetrics({
    required this.totalSteps,
    required this.totalActiveEnergy,
    required this.averageHeartRate,
    required this.averageSleepHours,
    required this.averageSleepEfficiency,
    required this.totalWorkouts,
    required this.totalWorkoutDuration,
  });

  factory WeeklyHealthMetrics.fromWeeklyData(List<HealthDataSummary> weeklyData) {
    final validDays = weeklyData.where((day) => day.steps > 0 || day.sleepHours > 0).toList();
    
    if (validDays.isEmpty) {
      return const WeeklyHealthMetrics(
        totalSteps: 0,
        totalActiveEnergy: 0,
        averageHeartRate: 0,
        averageSleepHours: 0,
        averageSleepEfficiency: 0,
        totalWorkouts: 0,
        totalWorkoutDuration: 0,
      );
    }

    final totalSteps = validDays.fold<int>(0, (sum, day) => sum + day.steps);
    final totalActiveEnergy = validDays.fold<double>(0, (sum, day) => sum + day.activeEnergyBurned);
    final averageHeartRate = validDays.fold<double>(0, (sum, day) => sum + day.averageHeartRate) / validDays.length;
    final averageSleepHours = validDays.fold<double>(0, (sum, day) => sum + day.sleepHours) / validDays.length;
    final averageSleepEfficiency = validDays.fold<double>(0, (sum, day) => sum + day.sleepEfficiency) / validDays.length;
    final totalWorkouts = validDays.fold<int>(0, (sum, day) => sum + day.workouts.length);
    final totalWorkoutDuration = validDays.fold<double>(0, (sum, day) => 
      sum + day.workouts.fold<double>(0, (workoutSum, workout) => workoutSum + workout.duration),);

    return WeeklyHealthMetrics(
      totalSteps: totalSteps,
      totalActiveEnergy: totalActiveEnergy,
      averageHeartRate: averageHeartRate,
      averageSleepHours: averageSleepHours,
      averageSleepEfficiency: averageSleepEfficiency,
      totalWorkouts: totalWorkouts,
      totalWorkoutDuration: totalWorkoutDuration,
    );
  }

  /// Get formatted step count with commas
  String get formattedSteps => totalSteps.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  );

  /// Get formatted active energy with one decimal place
  String get formattedActiveEnergy => totalActiveEnergy.toStringAsFixed(1);

  /// Get formatted average heart rate as integer
  String get formattedHeartRate => averageHeartRate.round().toString();

  /// Get formatted average sleep hours with one decimal place
  String get formattedSleepHours => averageSleepHours.toStringAsFixed(1);

  /// Get formatted sleep efficiency as percentage
  String get formattedSleepEfficiency => '${averageSleepEfficiency.round()}%';

  /// Get formatted total workout duration in hours and minutes
  String get formattedWorkoutDuration {
    final hours = totalWorkoutDuration ~/ 60;
    final minutes = (totalWorkoutDuration % 60).round();
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }
}