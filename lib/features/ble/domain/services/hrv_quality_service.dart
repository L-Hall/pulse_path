import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Service for validating HRV data quality and detecting artifacts
/// 
/// Provides comprehensive quality assessment including:
/// - RR interval validation and artifact detection
/// - Signal quality scoring
/// - Data sufficiency checks
/// - Physiological plausibility validation
class HrvQualityService {
  static const double _minValidRr = 300.0; // 200 BPM
  static const double _maxValidRr = 2000.0; // 30 BPM
  static const double _maxRrChange = 200.0; // Max 200ms change between intervals
  static const double _artifactThreshold = 0.20; // 20% max change for artifact detection
  static const int _minIntervalsForAnalysis = 30;
  static const int _recommendedIntervalsForAnalysis = 150;

  /// Validate and clean RR intervals, removing artifacts
  HrvQualityResult validateAndCleanRrIntervals(List<double> rrIntervals) {
    if (rrIntervals.isEmpty) {
      return HrvQualityResult(
        originalCount: 0,
        cleanedIntervals: [],
        artifactsRemoved: 0,
        qualityScore: 0.0,
        qualityRating: HrvQualityRating.poor,
        issues: ['No RR intervals provided'],
        recommendations: ['Ensure heart rate monitor is properly connected'],
      );
    }

    final List<double> cleanedIntervals = [];
    final List<HrvArtifact> artifacts = [];
    final List<String> issues = [];
    final List<String> recommendations = [];

    // Step 1: Basic physiological range validation
    for (int i = 0; i < rrIntervals.length; i++) {
      final rr = rrIntervals[i];
      
      if (rr < _minValidRr || rr > _maxValidRr) {
        artifacts.add(HrvArtifact(
          index: i,
          value: rr,
          type: HrvArtifactType.physiologicallyImplausible,
          reason: 'RR interval ${rr.toStringAsFixed(1)}ms outside valid range (${_minValidRr.toInt()}-${_maxValidRr.toInt()}ms)',
        ));
        continue;
      }
      
      cleanedIntervals.add(rr);
    }

    // Step 2: Consecutive interval change validation
    final List<double> furtherCleaned = [];
    if (cleanedIntervals.isNotEmpty) {
      furtherCleaned.add(cleanedIntervals.first);
      
      for (int i = 1; i < cleanedIntervals.length; i++) {
        final current = cleanedIntervals[i];
        final previous = cleanedIntervals[i - 1];
        final change = (current - previous).abs();
        final percentChange = change / previous;
        
        // Check for sudden large changes (artifacts)
        if (change > _maxRrChange || percentChange > _artifactThreshold) {
          artifacts.add(HrvArtifact(
            index: i,
            value: current,
            type: HrvArtifactType.suddenChange,
            reason: 'Sudden change of ${change.toStringAsFixed(1)}ms (${(percentChange * 100).toStringAsFixed(1)}%) from previous interval',
          ));
          continue;
        }
        
        furtherCleaned.add(current);
      }
    }

    // Step 3: Statistical outlier detection using modified z-score
    final List<double> finalCleaned = _removeStatisticalOutliers(furtherCleaned, artifacts);

    // Step 4: Calculate quality metrics
    final qualityScore = _calculateQualityScore(finalCleaned, rrIntervals.length);
    final qualityRating = _determineQualityRating(qualityScore, finalCleaned.length);

    // Step 5: Generate issues and recommendations
    _analyzeQualityIssues(finalCleaned, artifacts, issues, recommendations);

    return HrvQualityResult(
      originalCount: rrIntervals.length,
      cleanedIntervals: finalCleaned,
      artifactsRemoved: artifacts.length,
      qualityScore: qualityScore,
      qualityRating: qualityRating,
      issues: issues,
      recommendations: recommendations,
      artifacts: artifacts,
    );
  }

  /// Remove statistical outliers using modified z-score method
  List<double> _removeStatisticalOutliers(List<double> intervals, List<HrvArtifact> artifacts) {
    if (intervals.length < 10) return intervals; // Too few data points for statistical analysis
    
    // Calculate median and median absolute deviation (MAD)
    final sortedIntervals = List<double>.from(intervals)..sort();
    final median = _calculateMedian(sortedIntervals);
    
    final deviations = intervals.map((x) => (x - median).abs()).toList();
    final mad = _calculateMedian(deviations..sort());
    
    // Modified z-score threshold (3.5 is commonly used)
    const threshold = 3.5;
    
    final List<double> cleaned = [];
    for (int i = 0; i < intervals.length; i++) {
      final modifiedZScore = 0.6745 * (intervals[i] - median) / mad;
      
      if (modifiedZScore.abs() > threshold) {
        artifacts.add(HrvArtifact(
          index: i,
          value: intervals[i],
          type: HrvArtifactType.statisticalOutlier,
          reason: 'Statistical outlier (modified z-score: ${modifiedZScore.toStringAsFixed(2)})',
        ));
      } else {
        cleaned.add(intervals[i]);
      }
    }
    
    return cleaned;
  }

  /// Calculate median of a sorted list
  double _calculateMedian(List<double> sortedValues) {
    final n = sortedValues.length;
    if (n == 0) return 0.0;
    
    if (n.isOdd) {
      return sortedValues[n ~/ 2];
    } else {
      return (sortedValues[n ~/ 2 - 1] + sortedValues[n ~/ 2]) / 2;
    }
  }

  /// Calculate overall quality score (0.0 to 1.0)
  double _calculateQualityScore(List<double> cleanedIntervals, int originalCount) {
    if (originalCount == 0) return 0.0;
    
    // Factor 1: Data retention rate (how much data survived cleaning)
    final retentionRate = cleanedIntervals.length / originalCount;
    
    // Factor 2: Data sufficiency (do we have enough intervals)
    final sufficiencyScore = (cleanedIntervals.length / _recommendedIntervalsForAnalysis).clamp(0.0, 1.0);
    
    // Factor 3: Data consistency (coefficient of variation)
    double consistencyScore = 1.0;
    if (cleanedIntervals.length > 1) {
      final mean = cleanedIntervals.reduce((a, b) => a + b) / cleanedIntervals.length;
      final variance = cleanedIntervals.map((x) => math.pow(x - mean, 2)).reduce((a, b) => a + b) / cleanedIntervals.length;
      final cv = math.sqrt(variance) / mean;
      
      // Lower CV is better for baseline stability
      consistencyScore = (1.0 - (cv - 0.05).clamp(0.0, 0.5) / 0.5).clamp(0.0, 1.0);
    }
    
    // Weighted combination of factors
    return (retentionRate * 0.4 + sufficiencyScore * 0.4 + consistencyScore * 0.2).clamp(0.0, 1.0);
  }

  /// Determine quality rating based on score and data count
  HrvQualityRating _determineQualityRating(double score, int dataCount) {
    if (dataCount < _minIntervalsForAnalysis) {
      return HrvQualityRating.insufficient;
    }
    
    if (score >= 0.8) {
      return HrvQualityRating.excellent;
    } else if (score >= 0.6) {
      return HrvQualityRating.good;
    } else if (score >= 0.4) {
      return HrvQualityRating.fair;
    } else {
      return HrvQualityRating.poor;
    }
  }

  /// Analyze quality issues and generate recommendations
  void _analyzeQualityIssues(
    List<double> cleanedIntervals,
    List<HrvArtifact> artifacts,
    List<String> issues,
    List<String> recommendations,
  ) {
    // Check data sufficiency
    if (cleanedIntervals.length < _minIntervalsForAnalysis) {
      issues.add('Insufficient data for reliable HRV analysis (${cleanedIntervals.length} intervals, minimum ${_minIntervalsForAnalysis} required)');
      recommendations.add('Extend measurement duration to collect more data');
    } else if (cleanedIntervals.length < _recommendedIntervalsForAnalysis) {
      issues.add('Limited data for optimal HRV analysis (${cleanedIntervals.length} intervals, ${_recommendedIntervalsForAnalysis} recommended)');
      recommendations.add('Consider longer measurement periods for more reliable results');
    }

    // Check artifact levels
    final artifactRate = artifacts.length / (artifacts.length + cleanedIntervals.length);
    if (artifactRate > 0.3) {
      issues.add('High artifact rate (${(artifactRate * 100).toStringAsFixed(1)}% of data removed)');
      recommendations.add('Check heart rate monitor placement and ensure minimal movement during measurement');
    } else if (artifactRate > 0.1) {
      issues.add('Moderate artifact rate (${(artifactRate * 100).toStringAsFixed(1)}% of data removed)');
      recommendations.add('Try to remain still and breathe normally during measurement');
    }

    // Analyze artifact types
    final physiologicalArtifacts = artifacts.where((a) => a.type == HrvArtifactType.physiologicallyImplausible).length;
    if (physiologicalArtifacts > 0) {
      issues.add('$physiologicalArtifacts physiologically implausible intervals detected');
      recommendations.add('Ensure heart rate monitor is properly fitted and functioning');
    }

    final suddenChangeArtifacts = artifacts.where((a) => a.type == HrvArtifactType.suddenChange).length;
    if (suddenChangeArtifacts > 0) {
      issues.add('$suddenChangeArtifacts sudden interval changes detected');
      recommendations.add('Minimize movement and ensure stable heart rate monitor contact');
    }

    // Check for very low variability (potential monitoring issue)
    if (cleanedIntervals.length >= 10) {
      final mean = cleanedIntervals.reduce((a, b) => a + b) / cleanedIntervals.length;
      final variance = cleanedIntervals.map((x) => math.pow(x - mean, 2)).reduce((a, b) => a + b) / cleanedIntervals.length;
      final rmssd = math.sqrt(variance);
      
      if (rmssd < 5.0) {
        issues.add('Very low heart rate variability detected (RMSSD: ${rmssd.toStringAsFixed(1)}ms)');
        recommendations.add('This may indicate measurement issues or extremely low natural variability');
      }
    }

    // Add general recommendations if issues found
    if (issues.isNotEmpty && recommendations.isEmpty) {
      recommendations.add('Ensure proper heart rate monitor placement and minimize movement during measurement');
    }
  }

  /// Get real-time quality assessment during data collection
  HrvRealTimeQuality getRealTimeQuality(List<double> currentIntervals) {
    if (currentIntervals.isEmpty) {
      return HrvRealTimeQuality(
        signalQuality: 0.0,
        intervalCount: 0,
        artifactRate: 0.0,
        isMinimumDataReached: false,
        isRecommendedDataReached: false,
        lastIntervalValid: false,
        estimatedTimeToCompletion: null,
      );
    }

    // Quick validation of recent intervals
    int validIntervals = 0;
    int recentArtifacts = 0;
    final recentCount = math.min(currentIntervals.length, 30); // Check last 30 intervals
    
    for (int i = currentIntervals.length - recentCount; i < currentIntervals.length; i++) {
      final rr = currentIntervals[i];
      
      if (rr >= _minValidRr && rr <= _maxValidRr) {
        if (i > 0) {
          final previous = currentIntervals[i - 1];
          final change = (rr - previous).abs();
          final percentChange = change / previous;
          
          if (change <= _maxRrChange && percentChange <= _artifactThreshold) {
            validIntervals++;
          } else {
            recentArtifacts++;
          }
        } else {
          validIntervals++;
        }
      } else {
        recentArtifacts++;
      }
    }

    final signalQuality = validIntervals / recentCount;
    final artifactRate = recentArtifacts / recentCount;
    final lastIntervalValid = currentIntervals.isNotEmpty && 
        currentIntervals.last >= _minValidRr && 
        currentIntervals.last <= _maxValidRr;

    // Estimate time to completion based on current rate
    Duration? estimatedTime;
    if (currentIntervals.length >= 10) {
      final avgHeartRate = 60000 / (currentIntervals.reduce((a, b) => a + b) / currentIntervals.length);
      final intervalsPerMinute = avgHeartRate;
      final remainingIntervals = _recommendedIntervalsForAnalysis - currentIntervals.length;
      
      if (remainingIntervals > 0) {
        estimatedTime = Duration(seconds: (remainingIntervals / intervalsPerMinute * 60).round());
      }
    }

    return HrvRealTimeQuality(
      signalQuality: signalQuality,
      intervalCount: currentIntervals.length,
      artifactRate: artifactRate,
      isMinimumDataReached: currentIntervals.length >= _minIntervalsForAnalysis,
      isRecommendedDataReached: currentIntervals.length >= _recommendedIntervalsForAnalysis,
      lastIntervalValid: lastIntervalValid,
      estimatedTimeToCompletion: estimatedTime,
    );
  }
}

/// Result of HRV quality validation
class HrvQualityResult {
  final int originalCount;
  final List<double> cleanedIntervals;
  final int artifactsRemoved;
  final double qualityScore; // 0.0 to 1.0
  final HrvQualityRating qualityRating;
  final List<String> issues;
  final List<String> recommendations;
  final List<HrvArtifact> artifacts;

  const HrvQualityResult({
    required this.originalCount,
    required this.cleanedIntervals,
    required this.artifactsRemoved,
    required this.qualityScore,
    required this.qualityRating,
    required this.issues,
    required this.recommendations,
    this.artifacts = const [],
  });

  double get dataRetentionRate => originalCount > 0 ? cleanedIntervals.length / originalCount : 0.0;
  bool get hasSufficientData => cleanedIntervals.length >= HrvQualityService._minIntervalsForAnalysis;
  bool get hasOptimalData => cleanedIntervals.length >= HrvQualityService._recommendedIntervalsForAnalysis;

  @override
  String toString() => 'HrvQualityResult(score: ${(qualityScore * 100).toStringAsFixed(1)}%, '
      'rating: $qualityRating, '
      'intervals: ${cleanedIntervals.length}/${originalCount})';
}

/// Real-time quality assessment during data collection
class HrvRealTimeQuality {
  final double signalQuality; // 0.0 to 1.0
  final int intervalCount;
  final double artifactRate;
  final bool isMinimumDataReached;
  final bool isRecommendedDataReached;
  final bool lastIntervalValid;
  final Duration? estimatedTimeToCompletion;

  const HrvRealTimeQuality({
    required this.signalQuality,
    required this.intervalCount,
    required this.artifactRate,
    required this.isMinimumDataReached,
    required this.isRecommendedDataReached,
    required this.lastIntervalValid,
    this.estimatedTimeToCompletion,
  });

  HrvQualityRating get qualityRating {
    if (signalQuality >= 0.9) return HrvQualityRating.excellent;
    if (signalQuality >= 0.7) return HrvQualityRating.good;
    if (signalQuality >= 0.5) return HrvQualityRating.fair;
    return HrvQualityRating.poor;
  }

  @override
  String toString() => 'HrvRealTimeQuality(signal: ${(signalQuality * 100).toStringAsFixed(1)}%, '
      'intervals: $intervalCount, artifacts: ${(artifactRate * 100).toStringAsFixed(1)}%)';
}

/// Individual artifact detected in HRV data
class HrvArtifact {
  final int index;
  final double value;
  final HrvArtifactType type;
  final String reason;

  const HrvArtifact({
    required this.index,
    required this.value,
    required this.type,
    required this.reason,
  });

  @override
  String toString() => 'HrvArtifact(index: $index, value: ${value.toStringAsFixed(1)}ms, type: $type)';
}

/// Types of artifacts that can be detected
enum HrvArtifactType {
  physiologicallyImplausible,
  suddenChange,
  statisticalOutlier,
}

/// Quality rating for HRV data
enum HrvQualityRating {
  excellent,
  good,
  fair,
  poor,
  insufficient,
}

/// Extension methods for quality rating
extension HrvQualityRatingExtension on HrvQualityRating {
  String get displayName {
    switch (this) {
      case HrvQualityRating.excellent:
        return 'Excellent';
      case HrvQualityRating.good:
        return 'Good';
      case HrvQualityRating.fair:
        return 'Fair';
      case HrvQualityRating.poor:
        return 'Poor';
      case HrvQualityRating.insufficient:
        return 'Insufficient Data';
    }
  }

  String get description {
    switch (this) {
      case HrvQualityRating.excellent:
        return 'High quality data with minimal artifacts';
      case HrvQualityRating.good:
        return 'Good quality data suitable for analysis';
      case HrvQualityRating.fair:
        return 'Acceptable quality with some limitations';
      case HrvQualityRating.poor:
        return 'Poor quality data with significant artifacts';
      case HrvQualityRating.insufficient:
        return 'Not enough data for reliable analysis';
    }
  }
}