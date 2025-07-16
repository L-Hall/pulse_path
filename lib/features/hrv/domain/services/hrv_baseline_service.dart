import '../../../../shared/models/hrv_reading.dart';
import '../../../dashboard/data/repositories/hrv_repository_interface.dart';
import '../../../../core/di/injection_container.dart';

/// Service for managing HRV baseline calculations and personal normalization
class HrvBaselineService {
  HrvBaselineService._();
  
  static final HrvBaselineService _instance = HrvBaselineService._();
  factory HrvBaselineService() => _instance;

  /// Calculate user's personal baseline from historical data
  Future<HrvBaseline> calculateBaseline({
    required List<HrvReading> readings,
    int? age,
    String? gender,
    int days = 14, // Default to 14-day baseline
  }) async {
    if (readings.isEmpty) {
      return HrvBaseline.defaultBaseline(age: age, gender: gender);
    }

    // Filter readings to the specified time period
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    final recentReadings = readings
        .where((r) => r.timestamp.isAfter(cutoffDate))
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    if (recentReadings.isEmpty) {
      return HrvBaseline.defaultBaseline(age: age, gender: gender);
    }

    // Calculate medians for each metric
    return HrvBaseline(
      rmssdMedian: _calculateMedian(recentReadings.map((r) => r.metrics.rmssd).toList()),
      sdnnMedian: _calculateMedian(recentReadings.map((r) => r.metrics.sdnn).toList()),
      meanRrMedian: _calculateMedian(recentReadings.map((r) => r.metrics.meanRr).toList()),
      pnn50Median: _calculateMedian(recentReadings.map((r) => r.metrics.pnn50).toList()),
      lowFrequencyMedian: _calculateMedian(recentReadings.map((r) => r.metrics.lowFrequency).toList()),
      highFrequencyMedian: _calculateMedian(recentReadings.map((r) => r.metrics.highFrequency).toList()),
      totalPowerMedian: _calculateMedian(recentReadings.map((r) => r.metrics.totalPower).toList()),
      lfHfRatioMedian: _calculateMedian(recentReadings.map((r) => r.metrics.lfHfRatio).toList()),
      stressMedian: _calculateMedian(recentReadings.map((r) => r.scores.stress.toDouble()).toList()).round(),
      recoveryMedian: _calculateMedian(recentReadings.map((r) => r.scores.recovery.toDouble()).toList()).round(),
      energyMedian: _calculateMedian(recentReadings.map((r) => r.scores.energy.toDouble()).toList()).round(),
      lastUpdated: DateTime.now(),
      readingCount: recentReadings.length,
      daysCovered: days,
      age: age,
      gender: gender,
    );
  }

  /// Get 7-day rolling baseline
  Future<HrvBaseline> getSevenDayBaseline({
    int? age,
    String? gender,
  }) async {
    final repository = await sl.getAsync<HrvRepositoryInterface>();
    final readings = await repository.getTrendReadings(days: 7, realDataOnly: false);
    
    return calculateBaseline(
      readings: readings,
      age: age,
      gender: gender,
      days: 7,
    );
  }

  /// Get 14-day rolling baseline (default)
  Future<HrvBaseline> getFourteenDayBaseline({
    int? age,
    String? gender,
  }) async {
    final repository = await sl.getAsync<HrvRepositoryInterface>();
    final readings = await repository.getTrendReadings(days: 14, realDataOnly: false);
    
    return calculateBaseline(
      readings: readings,
      age: age,
      gender: gender,
      days: 14,
    );
  }

  /// Compare current metrics to baseline
  BaselineComparison compareToBaseline(
    HrvMetrics current,
    HrvBaseline baseline,
  ) {
    return BaselineComparison(
      rmssdPercentage: (current.rmssd / baseline.rmssdMedian) * 100,
      sdnnPercentage: (current.sdnn / baseline.sdnnMedian) * 100,
      meanRrPercentage: (current.meanRr / baseline.meanRrMedian) * 100,
      pnn50Percentage: (current.pnn50 / baseline.pnn50Median) * 100,
      lfPercentage: (current.lowFrequency / baseline.lowFrequencyMedian) * 100,
      hfPercentage: (current.highFrequency / baseline.highFrequencyMedian) * 100,
      totalPowerPercentage: (current.totalPower / baseline.totalPowerMedian) * 100,
      lfHfRatioPercentage: (current.lfHfRatio / baseline.lfHfRatioMedian) * 100,
      overallTrend: _calculateOverallTrend(current, baseline),
    );
  }

  /// Calculate median of a list of values
  double _calculateMedian(List<double> values) {
    if (values.isEmpty) return 0.0;
    
    final sorted = List<double>.from(values)..sort();
    final middle = sorted.length ~/ 2;
    
    if (sorted.length % 2 == 0) {
      return (sorted[middle - 1] + sorted[middle]) / 2;
    }
    return sorted[middle];
  }

  /// Calculate overall trend based on key metrics
  TrendType _calculateOverallTrend(HrvMetrics current, HrvBaseline baseline) {
    // Key metrics for trend analysis
    final rmssdRatio = current.rmssd / baseline.rmssdMedian;
    final sdnnRatio = current.sdnn / baseline.sdnnMedian;
    final totalPowerRatio = current.totalPower / baseline.totalPowerMedian;
    
    // Average of key ratios
    final avgRatio = (rmssdRatio + sdnnRatio + totalPowerRatio) / 3;
    
    if (avgRatio >= 1.15) return TrendType.significantlyBetter;
    if (avgRatio >= 1.05) return TrendType.better;
    if (avgRatio >= 0.95) return TrendType.stable;
    if (avgRatio >= 0.85) return TrendType.worse;
    return TrendType.significantlyWorse;
  }

  /// Get age-adjusted normal ranges
  NormalRanges getAgeAdjustedRanges(int? age, String? gender) {
    const baseAge = 30;
    final actualAge = age ?? baseAge;
    final ageAdjustment = 1 - ((actualAge - baseAge) * 0.01); // 1% decline per year
    
    // Base values for 30-year-old
    final baseRmssd = gender == 'female' ? 32.0 : 28.0;
    final baseSdnn = gender == 'female' ? 45.0 : 42.0;
    final baseMeanRr = gender == 'female' ? 900.0 : 950.0;
    
    return NormalRanges(
      rmssdRange: Range(
        min: (baseRmssd * 0.6 * ageAdjustment).roundToDouble(),
        max: (baseRmssd * 1.5 * ageAdjustment).roundToDouble(),
      ),
      sdnnRange: Range(
        min: (baseSdnn * 0.6 * ageAdjustment).roundToDouble(),
        max: (baseSdnn * 1.5 * ageAdjustment).roundToDouble(),
      ),
      meanRrRange: Range(
        min: (baseMeanRr * 0.8).roundToDouble(),
        max: (baseMeanRr * 1.2).roundToDouble(),
      ),
      pnn50Range: const Range(min: 5, max: 50),
      lfHfRatioRange: const Range(min: 0.5, max: 2.0),
      totalPowerRange: const Range(min: 300, max: 4000),
    );
  }
}

/// Personal HRV baseline data
class HrvBaseline {
  final double rmssdMedian;
  final double sdnnMedian;
  final double meanRrMedian;
  final double pnn50Median;
  final double lowFrequencyMedian;
  final double highFrequencyMedian;
  final double totalPowerMedian;
  final double lfHfRatioMedian;
  final int stressMedian;
  final int recoveryMedian;
  final int energyMedian;
  final DateTime lastUpdated;
  final int readingCount;
  final int daysCovered;
  final int? age;
  final String? gender;

  const HrvBaseline({
    required this.rmssdMedian,
    required this.sdnnMedian,
    required this.meanRrMedian,
    required this.pnn50Median,
    required this.lowFrequencyMedian,
    required this.highFrequencyMedian,
    required this.totalPowerMedian,
    required this.lfHfRatioMedian,
    required this.stressMedian,
    required this.recoveryMedian,
    required this.energyMedian,
    required this.lastUpdated,
    required this.readingCount,
    required this.daysCovered,
    this.age,
    this.gender,
  });

  /// Create default baseline based on age and gender
  factory HrvBaseline.defaultBaseline({
    int? age,
    String? gender,
  }) {
    final actualAge = age ?? 30;
    final ageAdjustment = 1 - ((actualAge - 30) * 0.01);
    
    // Default values based on normative data
    final baseRmssd = gender == 'female' ? 32.0 : 28.0;
    final baseSdnn = gender == 'female' ? 45.0 : 42.0;
    
    return HrvBaseline(
      rmssdMedian: baseRmssd * ageAdjustment,
      sdnnMedian: baseSdnn * ageAdjustment,
      meanRrMedian: gender == 'female' ? 900.0 : 950.0,
      pnn50Median: 15.0,
      lowFrequencyMedian: 200.0,
      highFrequencyMedian: 150.0,
      totalPowerMedian: 1500.0,
      lfHfRatioMedian: 1.3,
      stressMedian: 40,
      recoveryMedian: 60,
      energyMedian: 65,
      lastUpdated: DateTime.now(),
      readingCount: 0,
      daysCovered: 0,
      age: age,
      gender: gender,
    );
  }

  bool get hasEnoughData => readingCount >= 3;
}

/// Comparison of current metrics to baseline
class BaselineComparison {
  final double rmssdPercentage;
  final double sdnnPercentage;
  final double meanRrPercentage;
  final double pnn50Percentage;
  final double lfPercentage;
  final double hfPercentage;
  final double totalPowerPercentage;
  final double lfHfRatioPercentage;
  final TrendType overallTrend;

  const BaselineComparison({
    required this.rmssdPercentage,
    required this.sdnnPercentage,
    required this.meanRrPercentage,
    required this.pnn50Percentage,
    required this.lfPercentage,
    required this.hfPercentage,
    required this.totalPowerPercentage,
    required this.lfHfRatioPercentage,
    required this.overallTrend,
  });

  bool get isAboveBaseline => rmssdPercentage >= 100;
  bool get isSignificantlyAbove => rmssdPercentage >= 120;
  bool get isSignificantlyBelow => rmssdPercentage <= 80;
}

/// Normal ranges for HRV metrics
class NormalRanges {
  final Range rmssdRange;
  final Range sdnnRange;
  final Range meanRrRange;
  final Range pnn50Range;
  final Range lfHfRatioRange;
  final Range totalPowerRange;

  const NormalRanges({
    required this.rmssdRange,
    required this.sdnnRange,
    required this.meanRrRange,
    required this.pnn50Range,
    required this.lfHfRatioRange,
    required this.totalPowerRange,
  });
}

/// Simple range class
class Range {
  final double min;
  final double max;

  const Range({required this.min, required this.max});

  bool contains(double value) => value >= min && value <= max;
}

/// Trend types for baseline comparison
enum TrendType {
  significantlyBetter,
  better,
  stable,
  worse,
  significantlyWorse,
}

extension TrendTypeExtension on TrendType {
  String get displayName {
    switch (this) {
      case TrendType.significantlyBetter:
        return 'Significantly Better';
      case TrendType.better:
        return 'Better';
      case TrendType.stable:
        return 'Stable';
      case TrendType.worse:
        return 'Worse';
      case TrendType.significantlyWorse:
        return 'Significantly Worse';
    }
  }

  String get emoji {
    switch (this) {
      case TrendType.significantlyBetter:
        return '🚀';
      case TrendType.better:
        return '📈';
      case TrendType.stable:
        return '➡️';
      case TrendType.worse:
        return '📉';
      case TrendType.significantlyWorse:
        return '⚠️';
    }
  }
}