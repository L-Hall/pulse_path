import 'package:flutter/foundation.dart';
import '../../../../shared/models/hrv_reading.dart';
import 'advanced_statistics_service.dart';
import 'pattern_recognition_service.dart';

/// Comprehensive insights engine that combines statistical analysis with pattern recognition
/// to provide actionable insights and recommendations
class InsightsEngine {
  final AdvancedStatisticsService _statisticsService;
  final PatternRecognitionService _patternService;

  const InsightsEngine({
    AdvancedStatisticsService? statisticsService,
    PatternRecognitionService? patternService,
  })  : _statisticsService = statisticsService ?? const AdvancedStatisticsService(),
        _patternService = patternService ?? const PatternRecognitionService();

  /// Generate comprehensive insights for a user's HRV data
  ComprehensiveInsights generateInsights(List<HrvReading> readings) {
    if (readings.isEmpty) {
      return const ComprehensiveInsights(
        summary: 'No data available for analysis',
        statisticalInsights: [],
        patternInsights: [],
        recommendations: [],
        highlights: [],
      );
    }

    // Sort readings by timestamp
    final sortedReadings = List<HrvReading>.from(readings)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    // Generate statistical insights
    final statisticalInsights = _generateStatisticalInsights(sortedReadings);
    
    // Generate pattern insights
    final patternInsights = _generatePatternInsights(sortedReadings);
    
    // Generate recommendations based on findings
    final recommendations = _generateRecommendations(
      sortedReadings,
      statisticalInsights,
      patternInsights,
    );
    
    // Extract key highlights
    final highlights = _extractHighlights(
      statisticalInsights,
      patternInsights,
    );

    // Generate summary
    final summary = _generateSummary(sortedReadings, highlights);

    return ComprehensiveInsights(
      summary: summary,
      statisticalInsights: statisticalInsights,
      patternInsights: patternInsights,
      recommendations: recommendations,
      highlights: highlights,
    );
  }

  List<StatisticalInsight> _generateStatisticalInsights(List<HrvReading> readings) {
    final insights = <StatisticalInsight>[];

    // Extract RMSSD values for analysis
    final rmssdValues = readings.map((r) => r.metrics.rmssd).toList();
    final recoveryScores = readings.map((r) => r.scores.recovery.toDouble()).toList();
    
    // 1. Percentile analysis
    final rmssdPercentiles = _statisticsService.calculatePercentiles(rmssdValues);
    if (rmssdPercentiles.isNotEmpty) {
      insights.add(StatisticalInsight(
        type: InsightType.percentiles,
        title: 'HRV Distribution',
        description: 'Your typical HRV (RMSSD) ranges from ${rmssdPercentiles[25]?.toStringAsFixed(1)} '
            'to ${rmssdPercentiles[75]?.toStringAsFixed(1)}ms, with a median of ${rmssdPercentiles[50]?.toStringAsFixed(1)}ms.',
        importance: ImportanceLevel.medium,
        metrics: rmssdPercentiles.map((k, v) => MapEntry(k.toString(), v.toDouble())),
      ));
    }

    // 2. Variability analysis
    final varianceStats = _statisticsService.calculateVariance(rmssdValues);
    final coefficientOfVariation = varianceStats.mean > 0 
        ? (varianceStats.stdDev / varianceStats.mean) * 100 
        : 0;
    
    insights.add(StatisticalInsight(
      type: InsightType.variability,
      title: 'HRV Consistency',
      description: coefficientOfVariation < 20
          ? 'Your HRV is very consistent (${coefficientOfVariation.toStringAsFixed(1)}% variation), indicating stable autonomic function.'
          : coefficientOfVariation < 40
              ? 'Your HRV shows moderate variation (${coefficientOfVariation.toStringAsFixed(1)}%), which is normal.'
              : 'Your HRV is highly variable (${coefficientOfVariation.toStringAsFixed(1)}%), suggesting fluctuating stress or recovery states.',
      importance: coefficientOfVariation > 40 ? ImportanceLevel.high : ImportanceLevel.medium,
      metrics: {
        'mean': varianceStats.mean,
        'stdDev': varianceStats.stdDev,
        'cv': coefficientOfVariation.toDouble(),
      },
    ));

    // 3. Distribution shape analysis
    final distribution = _statisticsService.analyzeDistribution(rmssdValues);
    if (distribution.skewness.abs() > 1.0) {
      insights.add(StatisticalInsight(
        type: InsightType.distribution,
        title: 'Distribution Pattern',
        description: distribution.interpretation,
        importance: ImportanceLevel.low,
        metrics: {
          'skewness': distribution.skewness,
          'kurtosis': distribution.kurtosis,
        },
      ));
    }

    // 4. Outlier detection
    final outliers = _statisticsService.calculateZScores(recoveryScores);
    final outlierCount = outliers.where((z) => z.isOutlier).length;
    if (outlierCount > 0) {
      final outlierPercentage = (outlierCount / recoveryScores.length) * 100;
      insights.add(StatisticalInsight(
        type: InsightType.outliers,
        title: 'Unusual Readings',
        description: 'You had $outlierCount unusual readings (${outlierPercentage.toStringAsFixed(1)}% of total). '
            'These might indicate particularly stressful or restful periods.',
        importance: outlierPercentage > 10 ? ImportanceLevel.high : ImportanceLevel.low,
        metrics: {
          'outlierCount': outlierCount.toDouble(),
          'percentage': outlierPercentage,
        },
      ));
    }

    return insights;
  }

  List<PatternInsight> _generatePatternInsights(List<HrvReading> readings) {
    final insights = <PatternInsight>[];

    // 1. Weekly pattern analysis
    final weeklyPattern = _patternService.analyzeWeeklyPattern(readings);
    if (weeklyPattern.hasSignificantPattern) {
      insights.add(PatternInsight(
        type: PatternType.weekly,
        title: 'Weekly Recovery Pattern',
        description: weeklyPattern.interpretation,
        importance: ImportanceLevel.high,
        confidence: 0.85,
        data: {
          'weekdayRecovery': weeklyPattern.weekdayAverage['recoveryScore'] ?? 0,
          'weekendRecovery': weeklyPattern.weekendAverage['recoveryScore'] ?? 0,
        },
      ));
    }

    // 2. Time of day analysis
    final timePattern = _patternService.analyzeTimeOfDayPattern(readings);
    insights.add(PatternInsight(
      type: PatternType.timeOfDay,
      title: 'Best Time for Activities',
      description: timePattern.interpretation,
      importance: ImportanceLevel.medium,
      confidence: 0.75,
      data: {
        'morningRMSSD': timePattern.morningAverage['rmssd'] ?? 0,
        'afternoonRMSSD': timePattern.afternoonAverage['rmssd'] ?? 0,
        'eveningRMSSD': timePattern.eveningAverage['rmssd'] ?? 0,
      },
    ));

    // 3. Trend analysis
    final trend = _patternService.identifyTrend(readings, days: 7);
    if (trend.trend != Trend.insufficient) {
      insights.add(PatternInsight(
        type: PatternType.trend,
        title: '7-Day Trend',
        description: trend.interpretation,
        importance: trend.trend == Trend.declining ? ImportanceLevel.high : ImportanceLevel.medium,
        confidence: trend.confidence,
        data: {'trend': trend.trend.toString()},
      ));
    }

    // 4. Recovery patterns
    final recoveryPatterns = _patternService.detectRecoveryPatterns(readings);
    if (recoveryPatterns.isNotEmpty) {
      final avgRecoveryTime = recoveryPatterns
          .map((p) => p.recoveryTimeHours)
          .reduce((a, b) => a + b) / recoveryPatterns.length;
      
      insights.add(PatternInsight(
        type: PatternType.recovery,
        title: 'Recovery After Stress',
        description: 'After high-stress events, you typically recover within '
            '${avgRecoveryTime.toStringAsFixed(0)} hours. '
            '${avgRecoveryTime < 24 ? "This is excellent recovery!" : avgRecoveryTime < 36 ? "This is normal recovery." : "Consider stress management techniques to improve recovery time."}',
        importance: avgRecoveryTime > 36 ? ImportanceLevel.high : ImportanceLevel.medium,
        confidence: 0.8,
        data: {
          'avgRecoveryHours': avgRecoveryTime,
          'patternCount': recoveryPatterns.length.toDouble(),
        },
      ));
    }

    // 5. Anomaly detection
    final anomalies = _patternService.detectAnomalies(readings);
    if (anomalies.isNotEmpty) {
      final highSeverityCount = anomalies.where((a) => a.severity == AnomalySeverity.high).length;
      insights.add(PatternInsight(
        type: PatternType.anomaly,
        title: 'Unusual Patterns Detected',
        description: 'Found ${anomalies.length} unusual readings. '
            '${highSeverityCount > 0 ? "$highSeverityCount were significant deviations." : "Most were minor variations."}',
        importance: highSeverityCount > 0 ? ImportanceLevel.high : ImportanceLevel.low,
        confidence: 0.9,
        data: {
          'totalAnomalies': anomalies.length.toDouble(),
          'highSeverity': highSeverityCount.toDouble(),
        },
      ));
    }

    return insights;
  }

  List<String> _generateRecommendations(
    List<HrvReading> readings,
    List<StatisticalInsight> statisticalInsights,
    List<PatternInsight> patternInsights,
  ) {
    final recommendations = <String>[];

    // Check for high variability
    final variabilityInsight = statisticalInsights.firstWhere(
      (i) => i.type == InsightType.variability,
      orElse: () => StatisticalInsight(
        type: InsightType.variability,
        title: '',
        description: '',
        importance: ImportanceLevel.low,
        metrics: {},
      ),
    );
    
    if (variabilityInsight.metrics['cv'] != null && 
        variabilityInsight.metrics['cv']! > 40) {
      recommendations.add(
        '🎯 Your HRV shows high variability. Consider maintaining more consistent sleep and meal times to stabilize your autonomic nervous system.',
      );
    }

    // Check weekly patterns
    final weeklyInsight = patternInsights.firstWhere(
      (i) => i.type == PatternType.weekly,
      orElse: () => PatternInsight(
        type: PatternType.weekly,
        title: '',
        description: '',
        importance: ImportanceLevel.low,
        confidence: 0,
        data: {},
      ),
    );
    
    if (weeklyInsight.importance == ImportanceLevel.high) {
      final weekdayRecovery = weeklyInsight.data['weekdayRecovery'] ?? 0;
      final weekendRecovery = weeklyInsight.data['weekendRecovery'] ?? 0;
      
      if ((weekdayRecovery as double) < (weekendRecovery as double) * 0.9) {
        recommendations.add(
          '📅 Your weekday recovery is notably lower than weekends. Try incorporating short recovery breaks during your work day.',
        );
      }
    }

    // Check trends
    final trendInsight = patternInsights.firstWhere(
      (i) => i.type == PatternType.trend,
      orElse: () => PatternInsight(
        type: PatternType.trend,
        title: '',
        description: '',
        importance: ImportanceLevel.low,
        confidence: 0,
        data: {},
      ),
    );
    
    if (trendInsight.data['trend'] == Trend.declining.toString()) {
      recommendations.add(
        '📉 Your HRV shows a declining trend. Focus on recovery activities: quality sleep, gentle exercise, and stress reduction.',
      );
    } else if (trendInsight.data['trend'] == Trend.improving.toString()) {
      recommendations.add(
        '📈 Great work! Your HRV is improving. Continue with your current wellness practices.',
      );
    }

    // Check recovery time
    final recoveryInsight = patternInsights.firstWhere(
      (i) => i.type == PatternType.recovery,
      orElse: () => PatternInsight(
        type: PatternType.recovery,
        title: '',
        description: '',
        importance: ImportanceLevel.low,
        confidence: 0,
        data: {},
      ),
    );
    
    final avgRecoveryHours = recoveryInsight.data['avgRecoveryHours'] as double?;
    if (avgRecoveryHours != null && avgRecoveryHours > 36) {
      recommendations.add(
        '⏱️ Your recovery from stress takes longer than optimal. Consider adding meditation, breathwork, or other relaxation techniques.',
      );
    }

    // Time of day recommendations
    final timeInsight = patternInsights.firstWhere(
      (i) => i.type == PatternType.timeOfDay,
      orElse: () => PatternInsight(
        type: PatternType.timeOfDay,
        title: '',
        description: '',
        importance: ImportanceLevel.low,
        confidence: 0,
        data: {},
      ),
    );
    
    if (timeInsight.confidence > 0.7) {
      recommendations.add(
        '🕐 ${timeInsight.description} Schedule important tasks accordingly.',
      );
    }

    // Ensure we have at least one recommendation
    if (recommendations.isEmpty) {
      recommendations.add(
        '✨ Keep monitoring your HRV regularly to identify patterns and optimize your wellness routine.',
      );
    }

    return recommendations;
  }

  List<String> _extractHighlights(
    List<StatisticalInsight> statisticalInsights,
    List<PatternInsight> patternInsights,
  ) {
    final highlights = <String>[];
    
    // Get highest importance insights
    final importantStats = statisticalInsights
        .where((i) => i.importance == ImportanceLevel.high)
        .take(2);
    
    final importantPatterns = patternInsights
        .where((i) => i.importance == ImportanceLevel.high)
        .take(2);
    
    for (final insight in importantStats) {
      highlights.add('📊 ${insight.title}: ${insight.description}');
    }
    
    for (final insight in importantPatterns) {
      highlights.add('🔍 ${insight.title}: ${insight.description}');
    }
    
    return highlights;
  }

  String _generateSummary(List<HrvReading> readings, List<String> highlights) {
    final recentReadings = readings.where((r) => 
      r.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 7))),
    ).toList();
    
    final avgRecovery = recentReadings.isEmpty ? 0 : recentReadings
        .map((r) => r.scores.recovery)
        .reduce((a, b) => a + b) / recentReadings.length;
    
    String summary = 'Based on ${readings.length} readings, ';
    
    if (avgRecovery >= 80) {
      summary += 'you\'re showing excellent recovery and resilience. ';
    } else if (avgRecovery >= 60) {
      summary += 'your recovery is in a healthy range. ';
    } else if (avgRecovery >= 40) {
      summary += 'there\'s room to improve your recovery. ';
    } else {
      summary += 'your recovery needs attention. ';
    }
    
    if (highlights.isNotEmpty) {
      summary += 'Key findings include ${highlights.length} important patterns. ';
    }
    
    summary += 'Review the detailed insights below for personalized recommendations.';
    
    return summary;
  }
}

// Data models for insights

@immutable
class ComprehensiveInsights {
  final String summary;
  final List<StatisticalInsight> statisticalInsights;
  final List<PatternInsight> patternInsights;
  final List<String> recommendations;
  final List<String> highlights;

  const ComprehensiveInsights({
    required this.summary,
    required this.statisticalInsights,
    required this.patternInsights,
    required this.recommendations,
    required this.highlights,
  });
}

@immutable
class StatisticalInsight {
  final InsightType type;
  final String title;
  final String description;
  final ImportanceLevel importance;
  final Map<String, double> metrics;

  const StatisticalInsight({
    required this.type,
    required this.title,
    required this.description,
    required this.importance,
    required this.metrics,
  });
}

@immutable
class PatternInsight {
  final PatternType type;
  final String title;
  final String description;
  final ImportanceLevel importance;
  final double confidence;
  final Map<String, dynamic> data;

  const PatternInsight({
    required this.type,
    required this.title,
    required this.description,
    required this.importance,
    required this.confidence,
    required this.data,
  });
}

// Enums

enum InsightType {
  percentiles,
  variability,
  distribution,
  outliers,
  confidence,
}

enum PatternType {
  weekly,
  timeOfDay,
  trend,
  recovery,
  anomaly,
}

enum ImportanceLevel {
  high,
  medium,
  low,
}