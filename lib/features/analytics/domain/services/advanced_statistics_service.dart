import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import '../../../../shared/models/hrv_reading.dart';

/// Advanced statistical analysis service for HRV data
/// Provides comprehensive statistical calculations beyond simple averages
class AdvancedStatisticsService {
  const AdvancedStatisticsService();

  /// Calculate percentiles for a list of values
  Map<int, double> calculatePercentiles(
    List<double> values, {
    List<int> percentiles = const [5, 25, 50, 75, 95],
  }) {
    if (values.isEmpty) return {};

    final sorted = List<double>.from(values)..sort();
    final result = <int, double>{};

    for (final p in percentiles) {
      final index = (p / 100) * (sorted.length - 1);
      final lower = index.floor();
      final upper = index.ceil();
      
      if (lower == upper) {
        result[p] = sorted[lower];
      } else {
        final fraction = index - lower;
        result[p] = sorted[lower] + (sorted[upper] - sorted[lower]) * fraction;
      }
    }

    return result;
  }

  /// Calculate standard deviation and variance
  ({double mean, double variance, double stdDev}) calculateVariance(
    List<double> values,
  ) {
    if (values.isEmpty) {
      return (mean: 0, variance: 0, stdDev: 0);
    }

    final mean = values.reduce((a, b) => a + b) / values.length;
    final squaredDiffs = values.map((v) => math.pow(v - mean, 2));
    final variance = squaredDiffs.reduce((a, b) => a + b) / values.length;
    final stdDev = math.sqrt(variance);

    return (mean: mean, variance: variance, stdDev: stdDev);
  }

  /// Calculate skewness (measure of distribution asymmetry)
  double calculateSkewness(List<double> values) {
    if (values.length < 3) return 0;

    final stats = calculateVariance(values);
    if (stats.stdDev == 0) return 0;

    final n = values.length.toDouble();
    final sumCubedDiffs = values
        .map((v) => math.pow((v - stats.mean) / stats.stdDev, 3))
        .reduce((a, b) => a + b);

    return (n / ((n - 1) * (n - 2))) * sumCubedDiffs;
  }

  /// Calculate kurtosis (measure of distribution "tailedness")
  double calculateKurtosis(List<double> values) {
    if (values.length < 4) return 0;

    final stats = calculateVariance(values);
    if (stats.stdDev == 0) return 0;

    final n = values.length.toDouble();
    final sumQuarticDiffs = values
        .map((v) => math.pow((v - stats.mean) / stats.stdDev, 4))
        .reduce((a, b) => a + b);

    final factor1 = (n * (n + 1)) / ((n - 1) * (n - 2) * (n - 3));
    final factor2 = (3 * math.pow(n - 1, 2)) / ((n - 2) * (n - 3));

    return factor1 * sumQuarticDiffs - factor2;
  }

  /// Calculate z-scores for outlier detection
  List<({double value, double zScore, bool isOutlier})> calculateZScores(
    List<double> values, {
    double threshold = 2.5,
  }) {
    if (values.isEmpty) return [];

    final stats = calculateVariance(values);
    if (stats.stdDev == 0) {
      return values
          .map((v) => (value: v, zScore: 0.0, isOutlier: false))
          .toList();
    }

    return values.map((value) {
      final zScore = (value - stats.mean) / stats.stdDev;
      final isOutlier = zScore.abs() > threshold;
      return (value: value, zScore: zScore, isOutlier: isOutlier);
    }).toList();
  }

  /// Calculate rolling statistics with configurable window
  List<RollingStatistic> calculateRollingStatistics(
    List<HrvReading> readings, {
    required int windowSize,
    required String metric,
  }) {
    if (readings.length < windowSize) return [];

    final results = <RollingStatistic>[];
    final sortedReadings = List<HrvReading>.from(readings)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    for (int i = windowSize - 1; i < sortedReadings.length; i++) {
      final window = sortedReadings.sublist(i - windowSize + 1, i + 1);
      final values = _extractMetricValues(window, metric);
      
      if (values.isNotEmpty) {
        final stats = calculateVariance(values);
        final percentiles = calculatePercentiles(values);
        
        results.add(RollingStatistic(
          timestamp: sortedReadings[i].timestamp,
          windowSize: windowSize,
          metric: metric,
          mean: stats.mean,
          stdDev: stats.stdDev,
          median: percentiles[50] ?? 0,
          min: values.reduce(math.min),
          max: values.reduce(math.max),
        ),);
      }
    }

    return results;
  }

  /// Calculate confidence intervals
  ({double lower, double upper}) calculateConfidenceInterval(
    List<double> values, {
    double confidenceLevel = 0.95,
  }) {
    if (values.isEmpty) return (lower: 0, upper: 0);

    final stats = calculateVariance(values);
    final n = values.length;
    final standardError = stats.stdDev / math.sqrt(n);
    
    // Using z-score for 95% confidence (1.96)
    // For more accurate results with small samples, use t-distribution
    final zScore = _getZScoreForConfidence(confidenceLevel);
    final marginOfError = zScore * standardError;

    return (
      lower: stats.mean - marginOfError,
      upper: stats.mean + marginOfError,
    );
  }

  /// Analyze distribution characteristics
  DistributionAnalysis analyzeDistribution(List<double> values) {
    if (values.isEmpty) {
      return const DistributionAnalysis(
        isNormal: false,
        skewness: 0,
        kurtosis: 0,
        interpretation: 'Insufficient data',
      );
    }

    final skewness = calculateSkewness(values);
    final kurtosis = calculateKurtosis(values);
    
    // Simplified normality test based on skewness and kurtosis
    final isNormal = skewness.abs() < 0.5 && kurtosis.abs() < 3;
    
    String interpretation;
    if (skewness > 0.5) {
      interpretation = 'Right-skewed distribution (tail extends right)';
    } else if (skewness < -0.5) {
      interpretation = 'Left-skewed distribution (tail extends left)';
    } else {
      interpretation = 'Approximately symmetric distribution';
    }

    if (kurtosis > 3) {
      interpretation += ' with heavy tails';
    } else if (kurtosis < -3) {
      interpretation += ' with light tails';
    }

    return DistributionAnalysis(
      isNormal: isNormal,
      skewness: skewness,
      kurtosis: kurtosis,
      interpretation: interpretation,
    );
  }

  /// Extract metric values from HRV readings
  List<double> _extractMetricValues(List<HrvReading> readings, String metric) {
    return readings.map((r) {
      switch (metric) {
        case 'stressScore':
          return r.scores.stress.toDouble();
        case 'recoveryScore':
          return r.scores.recovery.toDouble();
        case 'energyScore':
          return r.scores.energy.toDouble();
        case 'rmssd':
          return r.metrics.rmssd;
        case 'meanRr':
          return r.metrics.meanRr;
        case 'sdnn':
          return r.metrics.sdnn;
        case 'heartRate':
          // Calculate heart rate from mean RR interval
          return r.metrics.meanRr > 0 ? 60000 / r.metrics.meanRr : 0.0;
        default:
          return 0.0;
      }
    }).where((v) => v > 0).toList();
  }

  /// Get z-score for confidence level
  double _getZScoreForConfidence(double confidence) {
    // Common confidence levels
    switch (confidence) {
      case 0.90:
        return 1.645;
      case 0.95:
        return 1.96;
      case 0.99:
        return 2.576;
      default:
        return 1.96; // Default to 95%
    }
  }
}

/// Rolling statistic data point
@immutable
class RollingStatistic {
  final DateTime timestamp;
  final int windowSize;
  final String metric;
  final double mean;
  final double stdDev;
  final double median;
  final double min;
  final double max;

  const RollingStatistic({
    required this.timestamp,
    required this.windowSize,
    required this.metric,
    required this.mean,
    required this.stdDev,
    required this.median,
    required this.min,
    required this.max,
  });
}

/// Distribution analysis result
@immutable
class DistributionAnalysis {
  final bool isNormal;
  final double skewness;
  final double kurtosis;
  final String interpretation;

  const DistributionAnalysis({
    required this.isNormal,
    required this.skewness,
    required this.kurtosis,
    required this.interpretation,
  });
}