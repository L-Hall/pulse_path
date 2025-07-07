import '../../../../shared/models/hrv_reading.dart';
import 'hrv_repository_interface.dart';

/// Simple HRV repository for dashboard demo (in-memory storage)
class SimpleHrvRepository implements HrvRepositoryInterface {
  final List<HrvReading> _readings = [];

  /// Add a new reading
  @override
  Future<void> saveReading(HrvReading reading) async {
    _readings.add(reading);
    // Keep only the last 100 readings for memory efficiency
    if (_readings.length > 100) {
      _readings.removeAt(0);
    }
  }

  /// Get the most recent reading
  @override
  Future<HrvReading?> getLatestReading({bool? realDataOnly}) async {
    if (_readings.isEmpty) return null;
    
    var filteredReadings = _readings;
    if (realDataOnly == true) {
      filteredReadings = _readings.where((r) => r.isRealData).toList();
    } else if (realDataOnly == false) {
      filteredReadings = _readings.where((r) => !r.isRealData).toList();
    }
    
    if (filteredReadings.isEmpty) return null;
    filteredReadings.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return filteredReadings.first;
  }

  /// Get readings for the last N days
  @override
  Future<List<HrvReading>> getTrendReadings({int days = 7, bool? realDataOnly}) async {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    var filtered = _readings.where((r) => r.timestamp.isAfter(cutoff)).toList();
    
    if (realDataOnly == true) {
      filtered = filtered.where((r) => r.isRealData).toList();
    } else if (realDataOnly == false) {
      filtered = filtered.where((r) => !r.isRealData).toList();
    }
    
    filtered.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return filtered;
  }

  /// Get basic statistics
  @override
  Future<DashboardStatistics> getStatistics({int days = 30, bool? realDataOnly}) async {
    final readings = await getTrendReadings(days: days, realDataOnly: realDataOnly);
    
    if (readings.isEmpty) {
      return const DashboardStatistics(
        totalReadings: 0,
        averageStress: 0,
        averageRecovery: 0,
        averageEnergy: 0,
        averageRmssd: 0.0,
        averageHeartRate: 0.0,
        streakDays: 0,
      );
    }

    final stressSum = readings.map((r) => r.scores.stress).reduce((a, b) => a + b);
    final recoverySum = readings.map((r) => r.scores.recovery).reduce((a, b) => a + b);
    final energySum = readings.map((r) => r.scores.energy).reduce((a, b) => a + b);
    final rmssdSum = readings.map((r) => r.metrics.rmssd).reduce((a, b) => a + b);
    final meanRrSum = readings.map((r) => r.metrics.meanRr).reduce((a, b) => a + b);

    final count = readings.length;

    return DashboardStatistics(
      totalReadings: count,
      averageStress: (stressSum / count).round(),
      averageRecovery: (recoverySum / count).round(),
      averageEnergy: (energySum / count).round(),
      averageRmssd: rmssdSum / count,
      averageHeartRate: 60000 / (meanRrSum / count),
      streakDays: _calculateStreakDays(readings),
    );
  }

  /// Calculate consecutive days with readings
  int _calculateStreakDays(List<HrvReading> readings) {
    if (readings.isEmpty) return 0;
    
    final dates = <DateTime>{};
    for (final reading in readings) {
      final date = DateTime(
        reading.timestamp.year,
        reading.timestamp.month,
        reading.timestamp.day,
      );
      dates.add(date);
    }
    
    final sortedDates = dates.toList()..sort((a, b) => b.compareTo(a));
    
    int streak = 0;
    DateTime expectedDate = DateTime.now();
    expectedDate = DateTime(expectedDate.year, expectedDate.month, expectedDate.day);
    
    for (final date in sortedDates) {
      if (date.isAtSameMomentAs(expectedDate) || 
          date.isAtSameMomentAs(expectedDate.subtract(const Duration(days: 1)))) {
        streak++;
        expectedDate = date.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    
    return streak;
  }

  /// Add sample data for demo
  @override
  Future<void> addSampleData() async {
    final now = DateTime.now();
    
    for (int i = 0; i < 7; i++) {
      final timestamp = now.subtract(Duration(days: i));
      final baseStress = 20 + (i * 5);
      final baseRecovery = 80 - (i * 3);
      final baseEnergy = 70 + (i * 2);
      
      final reading = HrvReading(
        id: 'sample_$i',
        timestamp: timestamp,
        durationSeconds: 180,
        metrics: HrvMetrics(
          rmssd: 35.0 + (i * 2),
          meanRr: 850.0 + (i * 10),
          sdnn: 45.0 + (i * 1.5),
          lowFrequency: 120.0,
          highFrequency: 180.0,
          lfHfRatio: 0.67,
          baevsky: 85.0,
          coefficientOfVariance: 5.2,
          mxdmn: 180.0,
          moda: 850.0,
          amo50: 42.0,
          pnn50: 25.0,
          pnn20: 45.0,
          totalPower: 1500.0,
          dfaAlpha1: 1.1,
        ),
        rrIntervals: List.generate(100, (index) => 800.0 + (index % 20) * 5),
        scores: HrvScores(
          stress: baseStress.clamp(0, 100),
          recovery: baseRecovery.clamp(0, 100),
          energy: baseEnergy.clamp(0, 100),
          confidence: 0.85,
        ),
        notes: 'Sample reading $i',
        tags: ['demo', 'sample'],
        isRealData: false,
      );
      
      await saveReading(reading);
    }
  }

  /// Get real data count to check if user has captured any real readings
  @override
  Future<int> getRealDataCount({int days = 30}) async {
    final realReadings = await getTrendReadings(days: days, realDataOnly: true);
    return realReadings.length;
  }

  /// Clear all sample data, keeping only real user data
  @override
  Future<void> clearSampleData() async {
    _readings.removeWhere((reading) => !reading.isRealData);
  }

  /// Get data source breakdown for analytics
  @override
  Future<DataSourceBreakdown> getDataSourceBreakdown({int days = 30}) async {
    final allReadings = await getTrendReadings(days: days);
    final realReadings = allReadings.where((r) => r.isRealData).toList();
    final sampleReadings = allReadings.where((r) => !r.isRealData).toList();
    
    final totalCount = allReadings.length;
    final realCount = realReadings.length;
    final sampleCount = sampleReadings.length;
    final realPercentage = totalCount > 0 ? (realCount / totalCount) * 100 : 0.0;

    return DataSourceBreakdown(
      realDataCount: realCount,
      sampleDataCount: sampleCount,
      totalReadings: totalCount,
      realDataPercentage: realPercentage,
    );
  }
}

/// Simple statistics model
class DashboardStatistics {
  final int totalReadings;
  final int averageStress;
  final int averageRecovery;
  final int averageEnergy;
  final double averageRmssd;
  final double averageHeartRate;
  final int streakDays;

  const DashboardStatistics({
    required this.totalReadings,
    required this.averageStress,
    required this.averageRecovery,
    required this.averageEnergy,
    required this.averageRmssd,
    required this.averageHeartRate,
    required this.streakDays,
  });

  /// Create empty statistics for fallback scenarios
  factory DashboardStatistics.empty() {
    return const DashboardStatistics(
      totalReadings: 0,
      averageStress: 0,
      averageRecovery: 0,
      averageEnergy: 0,
      averageRmssd: 0.0,
      averageHeartRate: 0.0,
      streakDays: 0,
    );
  }
}