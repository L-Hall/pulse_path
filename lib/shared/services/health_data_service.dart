import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/daily_health_metrics.dart';

/// Service for integrating with HealthKit (iOS) and Health Connect (Android)
class HealthDataService {
  static const Duration _defaultSyncPeriod = Duration(days: 30);
  
  final Health _healthFactory = Health();
  bool _isInitialized = false;
  
  /// Initialize the health data service
  Future<bool> initialize() async {
    try {
      // Configure health data types we want to access
      final types = _getRequiredHealthDataTypes();
      
      // Request permissions for all health data types
      final hasPermissions = await _healthFactory.hasPermissions(
        types,
        permissions: [
          HealthDataAccess.READ,
        ],
      );
      
      if (hasPermissions == null || !hasPermissions) {
        final granted = await _healthFactory.requestAuthorization(
          types,
          permissions: [
            HealthDataAccess.READ,
          ],
        );
        
        if (!granted) {
          return false;
        }
      }
      
      _isInitialized = true;
      return true;
    } catch (e) {
      if (kDebugMode) print('Error initializing health data service: $e');

      return false;
    }
  }
  
  /// Get the health data types we want to access
  List<HealthDataType> _getRequiredHealthDataTypes() {
    return [
      // Step and movement data
      HealthDataType.STEPS,
      HealthDataType.DISTANCE_WALKING_RUNNING,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.FLIGHTS_CLIMBED,
      
      // Sleep data
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_AWAKE,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.SLEEP_DEEP,
      HealthDataType.SLEEP_REM,
      
      // Workout data
      HealthDataType.WORKOUT,
      HealthDataType.HEART_RATE,
      
      // Additional metrics
      HealthDataType.RESTING_HEART_RATE,
      HealthDataType.HEART_RATE_VARIABILITY_SDNN,
    ];
  }
  
  /// Fetch daily health metrics for a specific date
  Future<DailyHealthMetrics?> getDailyHealthMetrics(DateTime date) async {
    if (!_isInitialized) {
      throw StateError('HealthDataService not initialized');
    }
    
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      
      // Fetch step count
      final stepCount = await _getStepCount(startOfDay, endOfDay);
      
      // Fetch distance
      final distance = await _getDistance(startOfDay, endOfDay);
      
      // Fetch active minutes (approximate from active energy)
      final activeMinutes = await _getActiveMinutes(startOfDay, endOfDay);
      
      // Fetch flights climbed
      final flightsClimbed = await _getFlightsClimbed(startOfDay, endOfDay);
      
      // Fetch sleep data
      final sleepData = await _getSleepData(startOfDay, endOfDay);
      
      // Fetch workout sessions
      final workouts = await _getWorkoutSessions(startOfDay, endOfDay);
      
      // Fetch menstrual data
      final menstrualData = await _getMenstrualData(startOfDay, endOfDay);
      
      return DailyHealthMetrics(
        id: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
        date: startOfDay,
        stepCount: stepCount,
        distanceKm: distance,
        activeMinutes: activeMinutes,
        flightsClimbed: flightsClimbed,
        sleepData: sleepData,
        workouts: workouts,
        menstrualData: menstrualData,
        isComplete: true,
        dataSources: ['health_kit'], // Will be platform-specific
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      if (kDebugMode) print('Error fetching daily health metrics: $e');

      return null;
    }
  }
  
  /// Fetch health metrics for a date range
  Future<List<DailyHealthMetrics>> getHealthMetricsRange(
    DateTime startDate, 
    DateTime endDate,
  ) async {
    final metrics = <DailyHealthMetrics>[];
    
    for (var date = startDate; 
         date.isBefore(endDate) || date.isAtSameMomentAs(endDate); 
         date = date.add(const Duration(days: 1))) {
      final dailyMetrics = await getDailyHealthMetrics(date);
      if (dailyMetrics != null) {
        metrics.add(dailyMetrics);
      }
    }
    
    return metrics;
  }
  
  /// Get step count for a time period
  Future<int> _getStepCount(DateTime start, DateTime end) async {
    try {
      final healthData = await _healthFactory.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: start,
        endTime: end,
      );
      
      return healthData
          .where((data) => data.type == HealthDataType.STEPS)
          .fold<int>(0, (sum, data) => sum + (data.value as num).toInt());
    } catch (e) {
      if (kDebugMode) print('Error getting step count: $e');

      return 0;
    }
  }
  
  /// Get walking/running distance in kilometers
  Future<double> _getDistance(DateTime start, DateTime end) async {
    try {
      final healthData = await _healthFactory.getHealthDataFromTypes(
        types: [HealthDataType.DISTANCE_WALKING_RUNNING],
        startTime: start,
        endTime: end,
      );
      
      final totalMeters = healthData
          .where((data) => data.type == HealthDataType.DISTANCE_WALKING_RUNNING)
          .fold<double>(0, (sum, data) => sum + (data.value as num).toDouble());
      
      return totalMeters / 1000; // Convert to kilometers
    } catch (e) {
      if (kDebugMode) print('Error getting distance: $e');

      return 0.0;
    }
  }
  
  /// Get approximate active minutes from active energy burned
  Future<int> _getActiveMinutes(DateTime start, DateTime end) async {
    try {
      final healthData = await _healthFactory.getHealthDataFromTypes(
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
        startTime: start,
        endTime: end,
      );
      
      // Approximate: assume 5 calories per minute for active time
      final totalCalories = healthData
          .where((data) => data.type == HealthDataType.ACTIVE_ENERGY_BURNED)
          .fold<double>(0, (sum, data) => sum + (data.value as num).toDouble());
      
      return (totalCalories / 5).round();
    } catch (e) {
      if (kDebugMode) print('Error getting active minutes: $e');

      return 0;
    }
  }
  
  /// Get flights of stairs climbed
  Future<int> _getFlightsClimbed(DateTime start, DateTime end) async {
    try {
      final healthData = await _healthFactory.getHealthDataFromTypes(
        types: [HealthDataType.FLIGHTS_CLIMBED],
        startTime: start,
        endTime: end,
      );
      
      return healthData
          .where((data) => data.type == HealthDataType.FLIGHTS_CLIMBED)
          .fold<int>(0, (sum, data) => sum + (data.value as num).toInt());
    } catch (e) {
      if (kDebugMode) print('Error getting flights climbed: $e');

      return 0;
    }
  }
  
  /// Get sleep data for the night
  Future<SleepData?> _getSleepData(DateTime start, DateTime end) async {
    try {
      final sleepTypes = [
        HealthDataType.SLEEP_ASLEEP,
        HealthDataType.SLEEP_AWAKE,
        HealthDataType.SLEEP_IN_BED,
        HealthDataType.SLEEP_DEEP,
        HealthDataType.SLEEP_REM,
      ];
      
      final healthData = await _healthFactory.getHealthDataFromTypes(
        types: sleepTypes,
        startTime: start.subtract(const Duration(hours: 12)), // Include previous night
        endTime: end,
      );
      
      if (healthData.isEmpty) return null;
      
      // Process sleep data to create SleepData object
      final sleepSessions = healthData
          .where((data) => data.type == HealthDataType.SLEEP_ASLEEP)
          .toList();
      
      if (sleepSessions.isEmpty) return null;
      
      // Find the main sleep session (longest one)
      sleepSessions.sort((a, b) => 
          (b.dateTo.difference(b.dateFrom)).compareTo(a.dateTo.difference(a.dateFrom)));
      
      final mainSleep = sleepSessions.first;
      final bedTime = mainSleep.dateFrom;
      final wakeTime = mainSleep.dateTo;
      final totalSleepTime = wakeTime.difference(bedTime);
      
      // Get deep sleep and REM sleep if available
      final deepSleepData = healthData
          .where((data) => data.type == HealthDataType.SLEEP_DEEP)
          .toList();
      final remSleepData = healthData
          .where((data) => data.type == HealthDataType.SLEEP_REM)
          .toList();
      
      Duration? deepSleepTime;
      Duration? remSleepTime;
      
      if (deepSleepData.isNotEmpty) {
        deepSleepTime = Duration(
          minutes: deepSleepData.fold<int>(
            0, 
            (sum, data) => sum + data.dateTo.difference(data.dateFrom).inMinutes,
          ),
        );
      }
      
      if (remSleepData.isNotEmpty) {
        remSleepTime = Duration(
          minutes: remSleepData.fold<int>(
            0, 
            (sum, data) => sum + data.dateTo.difference(data.dateFrom).inMinutes,
          ),
        );
      }
      
      return SleepData(
        bedTime: bedTime,
        wakeTime: wakeTime,
        totalSleepTime: totalSleepTime,
        deepSleepTime: deepSleepTime,
        remSleepTime: remSleepTime,
        source: 'health_kit',
      );
    } catch (e) {
      if (kDebugMode) print('Error getting sleep data: $e');

      return null;
    }
  }
  
  /// Get workout sessions for the day
  Future<List<WorkoutSession>> _getWorkoutSessions(DateTime start, DateTime end) async {
    try {
      final healthData = await _healthFactory.getHealthDataFromTypes(
        types: [HealthDataType.WORKOUT],
        startTime: start,
        endTime: end,
      );
      
      final workouts = <WorkoutSession>[];
      
      for (final data in healthData.where((d) => d.type == HealthDataType.WORKOUT)) {
        final workoutType = _mapHealthWorkoutType(data.workoutSummary?.workoutType.toString());
        
        final workout = WorkoutSession(
          id: '${data.dateFrom.millisecondsSinceEpoch}',
          startTime: data.dateFrom,
          endTime: data.dateTo,
          type: workoutType,
          duration: data.dateTo.difference(data.dateFrom),
          source: 'health_kit',
          createdAt: DateTime.now(),
        );
        
        workouts.add(workout);
      }
      
      return workouts;
    } catch (e) {
      if (kDebugMode) print('Error getting workout sessions: $e');

      return [];
    }
  }
  
  /// Get menstrual cycle data
  Future<MenstrualCycleData?> _getMenstrualData(DateTime start, DateTime end) async {
    try {
      // Menstrual data not available in current health package version
      // final healthData = await _healthFactory.getHealthDataFromTypes(
      //   types: [HealthDataType.MENSTRUATION],
      //   startTime: start,
      //   endTime: end,
      // );
      
      return null; // Skip menstrual data for now
      
    } catch (e) {
      if (kDebugMode) print('Error getting menstrual data: $e');

      return null;
    }
  }
  
  /// Map HealthKit workout types to our WorkoutType enum
  WorkoutType _mapHealthWorkoutType(String? healthTypeName) {
    if (healthTypeName == null) return WorkoutType.other;
    
    switch (healthTypeName.toLowerCase()) {
      case 'walking':
        return WorkoutType.walking;
      case 'running':
        return WorkoutType.running;
      case 'cycling':
        return WorkoutType.cycling;
      case 'swimming':
        return WorkoutType.swimming;
      case 'yoga':
        return WorkoutType.yoga;
      case 'strength_training':
      case 'weight_training':
        return WorkoutType.strengthTraining;
      default:
        return WorkoutType.other;
    }
  }
  
  /// Check if health permissions are granted
  Future<bool> hasPermissions() async {
    final types = _getRequiredHealthDataTypes();
    final hasPermissions = await _healthFactory.hasPermissions(
      types,
      permissions: [HealthDataAccess.READ],
    );
    return hasPermissions ?? false;
  }
  
  /// Request health permissions
  Future<bool> requestPermissions() async {
    final types = _getRequiredHealthDataTypes();
    return await _healthFactory.requestAuthorization(
      types,
      permissions: [HealthDataAccess.READ],
    );
  }
  
  /// Get available health data types on this device
  Future<List<HealthDataType>> getAvailableTypes() async {
    try {
      final allTypes = _getRequiredHealthDataTypes();
      final availableTypes = <HealthDataType>[];
      
      for (final type in allTypes) {
        final hasPermission = await _healthFactory.hasPermissions(
          [type],
          permissions: [HealthDataAccess.READ],
        );
        
        if (hasPermission == true) {
          availableTypes.add(type);
        }
      }
      
      return availableTypes;
    } catch (e) {
      if (kDebugMode) print('Error getting available types: $e');

      return [];
    }
  }
}