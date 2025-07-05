import 'dart:async';
import 'dart:io';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/health_data_point.dart' as models;

/// Service for managing health data integration with HealthKit (iOS) and Health Connect (Android)
class HealthDataService {
  static final HealthDataService _instance = HealthDataService._internal();
  factory HealthDataService() => _instance;
  HealthDataService._internal();

  Health? _health;
  bool _isInitialized = false;
  
  /// List of health data types we want to read
  static const List<HealthDataType> _healthDataTypes = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.RESTING_HEART_RATE,
    HealthDataType.HEART_RATE,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_IN_BED,
    HealthDataType.WORKOUT,
    // Note: MENSTRUATION_FLOW is not available in health package v10.2.0
    // Note: HEART_RATE_VARIABILITY_RMSSD is not available in health package v10.2.0
    HealthDataType.HEART_RATE_VARIABILITY_SDNN, // Available HRV metric
  ];

  /// Initialize the health data service
  Future<bool> initialize() async {
    try {
      _health = Health();
      
      // Request permissions for health data
      final authorized = await _requestPermissions();
      if (!authorized) {
        return false;
      }
      
      _isInitialized = true;
      return true;
    } catch (e) {
      print('Error initializing HealthDataService: $e');
      return false;
    }
  }

  /// Request permissions for health data access
  Future<bool> _requestPermissions() async {
    try {
      // Request health data permissions
      final healthPermissions = await _health!.requestAuthorization(
        _healthDataTypes,
        permissions: [
          HealthDataAccess.READ,
          HealthDataAccess.WRITE, // For writing HRV data
        ],
      );

      if (!healthPermissions) {
        return false;
      }

      // Request activity recognition permission for step counting fallback
      if (Platform.isAndroid) {
        final activityPermission = await Permission.activityRecognition.request();
        if (activityPermission != PermissionStatus.granted) {
          print('Activity recognition permission not granted');
        }
      }

      return true;
    } catch (e) {
      print('Error requesting health permissions: $e');
      return false;
    }
  }

  /// Get steps data for a specific date range
  Future<List<models.HealthDataPoint>> getStepsData(DateTime start, DateTime end) async {
    if (!_isInitialized || _health == null) {
      throw Exception('HealthDataService not initialized');
    }

    try {
      final healthData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: start,
        endTime: end,
      );

      return healthData
          .map((point) => models.HealthDataPoint.fromHealthPackage(point))
          .toList();
    } catch (e) {
      print('Error getting steps data: $e');
      return [];
    }
  }

  /// Get workout data for a specific date range
  Future<List<models.WorkoutSession>> getWorkoutData(DateTime start, DateTime end) async {
    if (!_isInitialized || _health == null) {
      throw Exception('HealthDataService not initialized');
    }

    try {
      final healthData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.WORKOUT, HealthDataType.ACTIVE_ENERGY_BURNED],
        startTime: start,
        endTime: end,
      );

      // Group workout data by workout session
      final workoutSessions = <models.WorkoutSession>[];
      
      for (final point in healthData) {
        if (point.type == HealthDataType.WORKOUT) {
          workoutSessions.add(models.WorkoutSession.fromHealthDataPoint(point));
        }
      }

      return workoutSessions;
    } catch (e) {
      print('Error getting workout data: $e');
      return [];
    }
  }

  /// Get sleep data for a specific date range
  Future<List<models.HealthDataPoint>> getSleepData(DateTime start, DateTime end) async {
    if (!_isInitialized || _health == null) {
      throw Exception('HealthDataService not initialized');
    }

    try {
      final healthData = await _health!.getHealthDataFromTypes(
        types: [
          HealthDataType.SLEEP_ASLEEP,
          HealthDataType.SLEEP_AWAKE,
          HealthDataType.SLEEP_IN_BED,
        ],
        startTime: start,
        endTime: end,
      );

      return healthData
          .map((point) => models.HealthDataPoint.fromHealthPackage(point))
          .toList();
    } catch (e) {
      print('Error getting sleep data: $e');
      return [];
    }
  }

  /// Get menstrual cycle data for a specific date range
  /// Note: MENSTRUATION_FLOW is not available in health package v10.2.0
  /// This method returns empty list until the health package is updated
  Future<List<models.MenstrualCycleData>> getMenstrualCycleData(DateTime start, DateTime end) async {
    if (!_isInitialized || _health == null) {
      throw Exception('HealthDataService not initialized');
    }

    try {
      // TODO: Update when health package supports MENSTRUATION_FLOW
      // For now, return empty list as the constant is not available
      print('Warning: Menstrual flow data not available in health package v10.2.0');
      return [];
      
      // Future implementation when constant becomes available:
      // final healthData = await _health!.getHealthDataFromTypes(
      //   types: [HealthDataType.MENSTRUATION_FLOW],
      //   startTime: start,
      //   endTime: end,
      // );
      // return healthData.map((point) {
      //   final flow = _mapHealthValueToMenstrualFlow(point.value);
      //   return models.MenstrualCycleData(
      //     date: point.dateFrom,
      //     flow: flow,
      //     metadata: point.metadata,
      //   );
      // }).toList();
    } catch (e) {
      print('Error getting menstrual cycle data: $e');
      return [];
    }
  }

  /// Get heart rate data for a specific date range
  Future<List<models.HealthDataPoint>> getHeartRateData(DateTime start, DateTime end) async {
    if (!_isInitialized || _health == null) {
      throw Exception('HealthDataService not initialized');
    }

    try {
      final healthData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE, HealthDataType.RESTING_HEART_RATE],
        startTime: start,
        endTime: end,
      );

      return healthData
          .map((point) => models.HealthDataPoint.fromHealthPackage(point))
          .toList();
    } catch (e) {
      print('Error getting heart rate data: $e');
      return [];
    }
  }

  /// Get comprehensive health data summary for a specific date
  Future<models.HealthDataSummary> getHealthDataSummary(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    try {
      // Get all health data for the day
      final futures = await Future.wait([
        getStepsData(startOfDay, endOfDay),
        getWorkoutData(startOfDay, endOfDay),
        getSleepData(startOfDay, endOfDay),
        getHeartRateData(startOfDay, endOfDay),
        getMenstrualCycleData(startOfDay, endOfDay),
      ]);

      final steps = futures[0] as List<models.HealthDataPoint>;
      final workouts = futures[1] as List<models.WorkoutSession>;
      final sleepData = futures[2] as List<models.HealthDataPoint>;
      final heartRateData = futures[3] as List<models.HealthDataPoint>;
      final menstrualData = futures[4] as List<models.MenstrualCycleData>;

      // Calculate summary metrics
      final totalSteps = steps.fold<int>(0, (sum, point) => sum + point.value.toInt());
      final totalActiveEnergy = workouts.fold<double>(0, (sum, workout) => sum + workout.caloriesBurned);
      
      final restingHeartRate = heartRateData
          .where((point) => point.type == HealthDataType.RESTING_HEART_RATE)
          .fold<double>(0, (sum, point) => sum + point.value) / 
          heartRateData.where((point) => point.type == HealthDataType.RESTING_HEART_RATE).length;
      
      final averageHeartRate = heartRateData
          .where((point) => point.type == HealthDataType.HEART_RATE)
          .fold<double>(0, (sum, point) => sum + point.value) / 
          heartRateData.where((point) => point.type == HealthDataType.HEART_RATE).length;

      // Calculate sleep metrics
      final sleepHours = sleepData
          .where((point) => point.type == HealthDataType.SLEEP_ASLEEP)
          .fold<double>(0, (sum, point) => sum + point.value) / 60; // Convert minutes to hours

      final sleepEfficiency = _calculateSleepEfficiency(sleepData);

      return models.HealthDataSummary(
        date: date,
        steps: totalSteps,
        activeEnergyBurned: totalActiveEnergy,
        restingHeartRate: restingHeartRate.isNaN ? 0.0 : restingHeartRate,
        averageHeartRate: averageHeartRate.isNaN ? 0.0 : averageHeartRate,
        sleepHours: sleepHours.isNaN ? 0.0 : sleepHours,
        sleepEfficiency: sleepEfficiency,
        workouts: workouts,
        menstrualCycle: menstrualData.isNotEmpty ? menstrualData.first : null,
      );
    } catch (e) {
      print('Error getting health data summary: $e');
      return models.HealthDataSummary.empty(date);
    }
  }

  /// Write HRV data to HealthKit/Health Connect
  /// Note: Using HEART_RATE_VARIABILITY_SDNN as RMSSD is not available in health package v10.2.0
  Future<bool> writeHrvData(double sdnn, DateTime timestamp) async {
    if (!_isInitialized || _health == null) {
      throw Exception('HealthDataService not initialized');
    }

    try {
      final success = await _health!.writeHealthData(
        value: sdnn,
        type: HealthDataType.HEART_RATE_VARIABILITY_SDNN,
        startTime: timestamp,
        endTime: timestamp,
      );

      return success;
    } catch (e) {
      print('Error writing HRV data: $e');
      return false;
    }
  }

  /// Check if health data permissions are granted
  Future<bool> hasPermissions() async {
    if (_health == null) return false;
    
    try {
      final result = await _health!.hasPermissions(_healthDataTypes);
      return result ?? false;
    } catch (e) {
      print('Error checking health permissions: $e');
      return false;
    }
  }

  /// Map health value to menstrual flow enum
  /// Note: Currently unused as MENSTRUATION_FLOW is not available in health package v10.2.0
  /// Keep for future use when the constant becomes available
  models.MenstrualFlow _mapHealthValueToMenstrualFlow(dynamic value) {
    if (value is! num) return models.MenstrualFlow.none;
    
    switch (value.toInt()) {
      case 1:
        return models.MenstrualFlow.light;
      case 2:
        return models.MenstrualFlow.medium;
      case 3:
        return models.MenstrualFlow.heavy;
      default:
        return models.MenstrualFlow.none;
    }
  }

  /// Calculate sleep efficiency percentage
  double _calculateSleepEfficiency(List<models.HealthDataPoint> sleepData) {
    final timeAsleep = sleepData
        .where((point) => point.type == HealthDataType.SLEEP_ASLEEP)
        .fold<double>(0, (sum, point) => sum + point.value);
    
    final timeInBed = sleepData
        .where((point) => point.type == HealthDataType.SLEEP_IN_BED)
        .fold<double>(0, (sum, point) => sum + point.value);

    if (timeInBed == 0) return 0.0;
    return (timeAsleep / timeInBed) * 100;
  }

  /// Dispose of resources
  void dispose() {
    _health = null;
    _isInitialized = false;
  }
}