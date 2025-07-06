import 'dart:math';
import 'package:pulse_path/shared/models/hrv_reading.dart';
import 'package:pulse_path/features/dashboard/domain/models/dashboard_data.dart';
import 'package:pulse_path/features/dashboard/data/repositories/simple_hrv_repository.dart';
import 'package:pulse_path/core/services/error_handling_service.dart';

/// Log Level enum for MockDataService
enum LogLevel {
  debug,
  info,
  warning,
  error,
  critical
}

/// Comprehensive mock data service for testing across all PulsePath features
/// Provides realistic test data that matches production patterns
class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  final Random _random = Random(42); // Fixed seed for reproducible tests

  /// Generate a single mock HRV reading with realistic values
  HrvReading generateMockHrvReading({
    DateTime? timestamp,
    String method = 'camera',
    String? deviceName,
    double? overrideRmssd,
    int? overrideRrIntervalCount,
  }) {
    final now = timestamp ?? DateTime.now();
    
    // Generate realistic RR intervals (in milliseconds)
    final baseRr = 800 + _random.nextDouble() * 400; // 600-1200ms (50-100 BPM)
    final rrIntervals = <double>[];
    
    final intervalCount = overrideRrIntervalCount ?? (180 + _random.nextInt(60)); // 3 minutes ± 30s
    
    for (int i = 0; i < intervalCount; i++) {
      // Add natural heart rate variability
      final variation = (_random.nextDouble() - 0.5) * 100; // ±50ms variation
      final rrInterval = (baseRr + variation).clamp(400, 1500);
      rrIntervals.add(rrInterval.toDouble());
    }

    // Calculate realistic metrics or use override
    final rmssd = overrideRmssd ?? _calculateRealisticRmssd(rrIntervals);
    final meanRr = rrIntervals.isNotEmpty ? rrIntervals.reduce((a, b) => a + b) / rrIntervals.length : 800.0;
    
    // Generate HRV metrics
    final metrics = HrvMetrics(
      rmssd: rmssd,
      meanRr: meanRr,
      sdnn: rmssd * 1.2 + _random.nextDouble() * 10,
      lowFrequency: _random.nextDouble() * 1000 + 500,
      highFrequency: _random.nextDouble() * 1000 + 300,
      lfHfRatio: 0.5 + _random.nextDouble() * 2.0,
      baevsky: 50 + _random.nextDouble() * 100,
      coefficientOfVariance: _random.nextDouble() * 10 + 2,
      mxdmn: _random.nextDouble() * 200 + 100,
      moda: meanRr,
      amo50: _random.nextDouble() * 50 + 10,
      pnn50: _random.nextDouble() * 30,
      pnn20: _random.nextDouble() * 50,
      totalPower: _random.nextDouble() * 5000 + 1000,
      dfaAlpha1: 0.8 + _random.nextDouble() * 0.5,
    );

    // Generate HRV scores
    final scores = HrvScores(
      stress: _calculateStressScore(rmssd),
      recovery: _calculateRecoveryScore(rmssd),
      energy: _calculateEnergyScore(rmssd),
      confidence: 0.7 + _random.nextDouble() * 0.3,
    );

    
    return HrvReading(
      id: 'mock_${now.millisecondsSinceEpoch}',
      timestamp: now,
      durationSeconds: 180, // 3 minutes
      metrics: metrics,
      rrIntervals: rrIntervals,
      scores: scores,
      notes: deviceName != null ? 'Recorded with $deviceName' : null,
      tags: method == 'camera' ? ['camera', 'ppg'] : ['ble', 'hrm'],

    );
  }

  /// Generate multiple HRV readings over a time period
  List<HrvReading> generateHrvTimeSeries({
    required DateTime startDate,
    required DateTime endDate,
    int averageReadingsPerDay = 2,
    String method = 'camera',
    String? deviceName,
  }) {
    final readings = <HrvReading>[];
    final totalDays = endDate.difference(startDate).inDays;
    final totalReadings = totalDays * averageReadingsPerDay;
    
    for (int i = 0; i < totalReadings; i++) {
      // Spread readings evenly across the time period
      final dayProgress = i / totalReadings;
      final readingTime = startDate.add(
        Duration(milliseconds: (endDate.difference(startDate).inMilliseconds * dayProgress).round()),
      );
      
      // Add some random variation to timing
      final variance = Duration(hours: _random.nextInt(6) - 3); // ±3 hours
      final finalTime = readingTime.add(variance);
      
      readings.add(generateMockHrvReading(
        timestamp: finalTime,
        method: method,
        deviceName: deviceName,
      ));
    }
    
    // Sort by timestamp
    readings.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return readings;
  }

  /// Generate mock dashboard data with trend analysis
  DashboardData generateMockDashboardData({
    int trendDays = 30,
    HrvReading? latestReading,
  }) {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(Duration(days: trendDays));
    
    // Generate trend readings
    final trendReadings = generateHrvTimeSeries(
      startDate: startDate,
      endDate: endDate,
      averageReadingsPerDay: 2,
    );
    
    // Use provided latest reading or generate one
    final latest = latestReading ?? generateMockHrvReading();
    
    // Calculate trend metrics
    final averageRmssd = trendReadings.map((r) => r.metrics.rmssd).reduce((a, b) => a + b) / trendReadings.length;
    final trendDirection = latest.metrics.rmssd > averageRmssd ? 'improving' : 'declining';

    
    return DashboardData(
      latestReading: latest,
      trendReadings: trendReadings,
      statistics: DashboardStatistics(
        totalReadings: trendReadings.length,
        averageStress: (trendReadings.map((r) => r.scores.stress).reduce((a, b) => a + b) / trendReadings.length).round(),
        averageRecovery: (trendReadings.map((r) => r.scores.recovery).reduce((a, b) => a + b) / trendReadings.length).round(),
        averageEnergy: (trendReadings.map((r) => r.scores.energy).reduce((a, b) => a + b) / trendReadings.length).round(),
        averageRmssd: averageRmssd,
        averageHeartRate: trendReadings.map((r) => 60000 / r.metrics.meanRr).reduce((a, b) => a + b) / trendReadings.length,
        streakDays: 7,
      ),
      lastUpdated: endDate,

    );
  }

  /// Generate mock error scenarios for testing error handling
  List<Map<String, dynamic>> generateMockErrorScenarios() {
    return [
      {
        'category': ErrorCategory.ble,
        'message': 'Failed to connect to heart rate monitor',
        'error': 'BluetoothConnectionException: Device not found',
        'context': {'device_name': 'Polar H10', 'retry_count': 3},
      },
      {
        'category': ErrorCategory.camera,
        'message': 'Camera permission denied',
        'error': 'PlatformException: Camera access denied',
        'context': {'permission_status': 'denied', 'platform': 'iOS'},
      },
      {
        'category': ErrorCategory.hrv,
        'message': 'Insufficient data for HRV calculation',
        'error': 'InsufficientDataException: Need at least 30 RR intervals',
        'context': {'rr_interval_count': 15, 'minimum_required': 30},
      },
      {
        'category': ErrorCategory.database,
        'message': 'Database encryption key missing',
        'error': 'DatabaseException: Encryption key not found in secure storage',
        'context': {'operation': 'read_hrv_data', 'table': 'hrv_readings'},
      },
      {
        'category': ErrorCategory.sync,
        'message': 'Cloud sync failed due to network timeout',
        'error': 'TimeoutException: Network request timed out after 30 seconds',
        'context': {'operation': 'upload_hrv_data', 'records_pending': 25},
      },
    ];
  }

  /// Generate mock performance metrics for testing
  Map<String, List<double>> generateMockPerformanceMetrics() {
    return {
      'app_startup': _generateMetricValues(baseValue: 2000, variance: 500, count: 10), // 2s ± 500ms
      'widget_build': _generateMetricValues(baseValue: 12, variance: 4, count: 100), // 12ms ± 4ms
      'hrv_calculation': _generateMetricValues(baseValue: 250, variance: 100, count: 50), // 250ms ± 100ms
      'database_query': _generateMetricValues(baseValue: 50, variance: 20, count: 200), // 50ms ± 20ms
      'ble_connection': _generateMetricValues(baseValue: 3000, variance: 2000, count: 20), // 3s ± 2s
    };
  }

  /// Generate mock BLE device data
  List<Map<String, dynamic>> generateMockBleDevices() {
    return [
      {
        'name': 'Polar H10',
        'address': '00:11:22:33:44:55',
        'rssi': -45,
        'services': ['180D'], // Heart Rate Service
        'connected': true,
        'battery_level': 85,
      },
      {
        'name': 'Garmin HRM-Pro',
        'address': '00:11:22:33:44:66',
        'rssi': -52,
        'services': ['180D', '180F'], // Heart Rate + Battery Service
        'connected': false,
        'battery_level': 72,
      },
      {
        'name': 'Wahoo TICKR',
        'address': '00:11:22:33:44:77',
        'rssi': -38,
        'services': ['180D'],
        'connected': false,
        'battery_level': 91,
      },
    ];
  }

  /// Generate mock user profiles for testing different scenarios
  List<Map<String, dynamic>> generateMockUserProfiles() {
    return [
      {
        'id': 'user_healthy_adult',
        'age': 30,
        'gender': 'male',
        'fitness_level': 'moderate',
        'baseline_rmssd': 45.0,
        'typical_hr': 70,
        'use_case': 'general_fitness',
      },
      {
        'id': 'user_athlete',
        'age': 25,
        'gender': 'female',
        'fitness_level': 'high',
        'baseline_rmssd': 65.0,
        'typical_hr': 55,
        'use_case': 'performance_training',
      },
      {
        'id': 'user_chronic_illness',
        'age': 35,
        'gender': 'female',
        'fitness_level': 'low',
        'baseline_rmssd': 25.0,
        'typical_hr': 85,
        'use_case': 'pacing_management',
      },
      {
        'id': 'user_elderly',
        'age': 65,
        'gender': 'male',
        'fitness_level': 'low',
        'baseline_rmssd': 20.0,
        'typical_hr': 75,
        'use_case': 'health_monitoring',
      },
    ];
  }

  /// Generate edge case scenarios for robust testing
  List<HrvReading> generateEdgeCaseReadings() {
    final now = DateTime.now();
    
    return [
      // Minimum viable reading
      generateMockHrvReading(
        timestamp: now.subtract(const Duration(hours: 1)),
        overrideRrIntervalCount: 30, // Minimum required
        overrideRmssd: 5.0, // Very low but valid
      ),
      
      // Maximum realistic reading
      generateMockHrvReading(
        timestamp: now.subtract(const Duration(hours: 2)),
        overrideRrIntervalCount: 300, // Long reading
        overrideRmssd: 120.0, // Very high but realistic
      ),
      
      // Poor quality reading
      generateMockHrvReading(
        timestamp: now.subtract(const Duration(hours: 3)),
        overrideRrIntervalCount: 45, // Short but usable
        overrideRmssd: 15.0, // Low variability
      ),
      
      // Excellent quality reading
      generateMockHrvReading(
        timestamp: now.subtract(const Duration(hours: 4)),
        overrideRrIntervalCount: 200,
        overrideRmssd: 85.0, // High variability
      ),
    ];
  }

  /// Helper: Generate metric values with realistic distribution
  List<double> _generateMetricValues({required double baseValue, required double variance, required int count}) {
    return List.generate(count, (index) {
      // Use normal distribution approximation
      final random1 = _random.nextDouble();
      final random2 = _random.nextDouble();
      final normalRandom = sqrt(-2 * log(random1)) * cos(2 * pi * random2);
      
      return (baseValue + normalRandom * variance).clamp(0, baseValue * 3);
    });
  }

  /// Helper: Calculate realistic RMSSD from RR intervals
  double _calculateRealisticRmssd(List<double> rrIntervals) {
    if (rrIntervals.length < 2) return 0.0;
    
    final squaredDiffs = <double>[];
    for (int i = 1; i < rrIntervals.length; i++) {
      final diff = rrIntervals[i] - rrIntervals[i - 1];
      squaredDiffs.add(diff * diff);
    }
    
    final meanSquaredDiff = squaredDiffs.reduce((a, b) => a + b) / squaredDiffs.length;
    return sqrt(meanSquaredDiff);
  }

  /// Helper: Calculate SDNN
  double _calculateSdnn(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) return 0.0;
    
    final mean = rrIntervals.reduce((a, b) => a + b) / rrIntervals.length;
    final squaredDiffs = rrIntervals.map((rr) => (rr - mean) * (rr - mean));
    final variance = squaredDiffs.reduce((a, b) => a + b) / rrIntervals.length;
    return sqrt(variance);
  }

  /// Helper: Calculate pNN50
  double _calculatePnn50(List<double> rrIntervals) {
    if (rrIntervals.length < 2) return 0.0;
    
    int count = 0;
    for (int i = 1; i < rrIntervals.length; i++) {
      if ((rrIntervals[i] - rrIntervals[i - 1]).abs() > 50) {
        count++;
      }
    }
    
    return (count / (rrIntervals.length - 1)) * 100;
  }

  /// Helper: Calculate HRV index
  double _calculateHrvIndex(double rmssd) {
    return (rmssd * 128 / 256).clamp(0, 100);
  }

  /// Helper: Calculate stress score (inverse of HRV)
  int _calculateStressScore(double rmssd) {
    return (100 - (rmssd * 2)).clamp(0, 100).round();
  }

  /// Helper: Calculate recovery score
  int _calculateRecoveryScore(double rmssd) {
    return (rmssd * 1.5).clamp(0, 100).round();
  }

  /// Helper: Calculate energy score
  int _calculateEnergyScore(double rmssd) {
    return (rmssd * 1.2 + _random.nextDouble() * 10).clamp(0, 100).round();
  }

  /// Generate mock dashboard statistics
  DashboardStatistics generateMockStatistics() {
    return const DashboardStatistics(
      totalReadings: 45,
      averageStress: 35,
      averageRecovery: 65,
      averageEnergy: 70,
      averageRmssd: 42.5,
      averageHeartRate: 72.0,
      streakDays: 12,
    );
  }

}