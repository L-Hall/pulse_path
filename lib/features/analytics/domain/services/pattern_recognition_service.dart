import 'package:flutter/foundation.dart';
import '../../../../shared/models/hrv_reading.dart';

/// Pattern recognition service for identifying trends and patterns in HRV data
class PatternRecognitionService {
  const PatternRecognitionService();

  /// Analyze weekly patterns (weekday vs weekend differences)
  WeeklyPattern analyzeWeeklyPattern(List<HrvReading> readings) {
    if (readings.isEmpty) {
      return const WeeklyPattern(
        hasSignificantPattern: false,
        weekdayAverage: {},
        weekendAverage: {},
        interpretation: 'Insufficient data',
      );
    }

    final weekdayReadings = <HrvReading>[];
    final weekendReadings = <HrvReading>[];

    for (final reading in readings) {
      final dayOfWeek = reading.timestamp.weekday;
      if (dayOfWeek >= DateTime.monday && dayOfWeek <= DateTime.friday) {
        weekdayReadings.add(reading);
      } else {
        weekendReadings.add(reading);
      }
    }

    final weekdayAvg = _calculateAverages(weekdayReadings);
    final weekendAvg = _calculateAverages(weekendReadings);

    // Determine if there's a significant pattern
    final hasSignificantPattern = _isSignificantDifference(
      weekdayAvg['recoveryScore'] ?? 0,
      weekendAvg['recoveryScore'] ?? 0,
    );

    String interpretation = '';
    if (hasSignificantPattern) {
      final weekdayRecovery = weekdayAvg['recoveryScore'] ?? 0;
      final weekendRecovery = weekendAvg['recoveryScore'] ?? 0;
      
      if (weekendRecovery > weekdayRecovery * 1.1) {
        interpretation = 'You recover significantly better on weekends. Consider incorporating weekend recovery strategies into weekdays.';
      } else if (weekdayRecovery > weekendRecovery * 1.1) {
        interpretation = 'Your weekday routine appears more conducive to recovery. Weekend activities may be impacting your recovery.';
      }
    } else {
      interpretation = 'Your recovery patterns are consistent throughout the week.';
    }

    return WeeklyPattern(
      hasSignificantPattern: hasSignificantPattern,
      weekdayAverage: weekdayAvg,
      weekendAverage: weekendAvg,
      interpretation: interpretation,
    );
  }

  /// Analyze time-of-day patterns
  TimeOfDayPattern analyzeTimeOfDayPattern(List<HrvReading> readings) {
    if (readings.isEmpty) {
      return const TimeOfDayPattern(
        morningAverage: {},
        afternoonAverage: {},
        eveningAverage: {},
        bestTimeOfDay: '',
        interpretation: 'Insufficient data',
      );
    }

    final morningReadings = <HrvReading>[];
    final afternoonReadings = <HrvReading>[];
    final eveningReadings = <HrvReading>[];

    for (final reading in readings) {
      final hour = reading.timestamp.hour;
      if (hour >= 5 && hour < 12) {
        morningReadings.add(reading);
      } else if (hour >= 12 && hour < 17) {
        afternoonReadings.add(reading);
      } else if (hour >= 17 && hour < 22) {
        eveningReadings.add(reading);
      }
    }

    final morningAvg = _calculateAverages(morningReadings);
    final afternoonAvg = _calculateAverages(afternoonReadings);
    final eveningAvg = _calculateAverages(eveningReadings);

    // Determine best time of day
    final times = {
      'Morning': morningAvg['rmssd'] ?? 0,
      'Afternoon': afternoonAvg['rmssd'] ?? 0,
      'Evening': eveningAvg['rmssd'] ?? 0,
    };

    final bestTime = times.entries.reduce((a, b) => a.value > b.value ? a : b);
    
    final interpretation = 'Your HRV is typically highest in the ${bestTime.key.toLowerCase()}, '
        'suggesting this may be your optimal time for important activities or decision-making.';

    return TimeOfDayPattern(
      morningAverage: morningAvg,
      afternoonAverage: afternoonAvg,
      eveningAverage: eveningAvg,
      bestTimeOfDay: bestTime.key,
      interpretation: interpretation,
    );
  }

  /// Detect recovery patterns after stress events
  List<RecoveryPattern> detectRecoveryPatterns(List<HrvReading> readings) {
    if (readings.length < 3) return [];

    final patterns = <RecoveryPattern>[];
    final sortedReadings = List<HrvReading>.from(readings)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    for (int i = 0; i < sortedReadings.length - 2; i++) {
      final current = sortedReadings[i];
      
      // Look for high stress events (stress score > 70)
      if (current.scores.stress > 70) {
        final recoveryReadings = <HrvReading>[];
        var j = i + 1;
        
        // Track recovery over next 48 hours
        while (j < sortedReadings.length &&
            sortedReadings[j].timestamp.difference(current.timestamp).inHours < 48) {
          recoveryReadings.add(sortedReadings[j]);
          j++;
        }

        if (recoveryReadings.isNotEmpty) {
          final recoveryTime = _calculateRecoveryTime(current, recoveryReadings);
          final recoveryQuality = _assessRecoveryQuality(current, recoveryReadings);
          
          patterns.add(RecoveryPattern(
            stressEvent: current,
            recoveryReadings: recoveryReadings,
            recoveryTimeHours: recoveryTime,
            recoveryQuality: recoveryQuality,
          ),);
        }
      }
    }

    return patterns;
  }

  /// Identify trending patterns (improving, declining, stable)
  TrendPattern identifyTrend(
    List<HrvReading> readings, {
    int days = 7,
  }) {
    if (readings.length < 3) {
      return const TrendPattern(
        trend: Trend.insufficient,
        confidence: 0,
        interpretation: 'Need at least 3 readings to identify trends',
      );
    }

    final cutoff = DateTime.now().subtract(Duration(days: days));
    final recentReadings = readings
        .where((r) => r.timestamp.isAfter(cutoff))
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    if (recentReadings.length < 3) {
      return const TrendPattern(
        trend: Trend.insufficient,
        confidence: 0,
        interpretation: 'Need more recent readings to identify trends',
      );
    }

    // Calculate linear regression for recovery scores
    final xValues = List.generate(recentReadings.length, (i) => i.toDouble());
    final yValues = recentReadings.map((r) => r.scores.recovery.toDouble()).toList();
    
    final regression = _calculateLinearRegression(xValues, yValues);
    final slope = regression.slope;
    final rSquared = regression.rSquared;

    Trend trend;
    String interpretation;
    
    if (slope.abs() < 0.5) {
      trend = Trend.stable;
      interpretation = 'Your recovery scores have been stable over the past $days days.';
    } else if (slope > 0) {
      trend = Trend.improving;
      final improvement = slope * days;
      interpretation = 'Your recovery is trending upward! You\'ve improved by approximately ${improvement.toStringAsFixed(0)} points over $days days.';
    } else {
      trend = Trend.declining;
      final decline = slope.abs() * days;
      interpretation = 'Your recovery shows a declining trend. Consider reviewing your lifestyle factors. You\'ve declined by approximately ${decline.toStringAsFixed(0)} points over $days days.';
    }

    return TrendPattern(
      trend: trend,
      confidence: rSquared,
      interpretation: interpretation,
    );
  }

  /// Detect anomalies in HRV patterns
  List<AnomalyPattern> detectAnomalies(List<HrvReading> readings) {
    if (readings.length < 7) return [];

    final anomalies = <AnomalyPattern>[];
    final sortedReadings = List<HrvReading>.from(readings)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    // Calculate baseline statistics
    final rmssdValues = sortedReadings.map((r) => r.metrics.rmssd).toList();
    final mean = rmssdValues.reduce((a, b) => a + b) / rmssdValues.length;
    final variance = rmssdValues
        .map((v) => (v - mean) * (v - mean))
        .reduce((a, b) => a + b) / rmssdValues.length;
    final stdDev = variance > 0 ? variance : 1;

    for (final reading in sortedReadings) {
      final zScore = (reading.metrics.rmssd - mean) / stdDev;
      
      // Detect significant deviations (|z| > 2)
      if (zScore.abs() > 2) {
        final type = zScore > 0 
            ? AnomalyType.unusuallyHigh 
            : AnomalyType.unusuallyLow;
            
        final severity = zScore.abs() > 3 
            ? AnomalySeverity.high 
            : AnomalySeverity.medium;
            
        anomalies.add(AnomalyPattern(
          reading: reading,
          anomalyType: type,
          severity: severity,
          zScore: zScore,
          interpretation: _interpretAnomaly(type, severity, reading),
        ));
      }
    }

    return anomalies;
  }

  // Helper methods

  Map<String, double> _calculateAverages(List<HrvReading> readings) {
    if (readings.isEmpty) return {};

    return {
      'stressScore': readings.map((r) => r.scores.stress).reduce((a, b) => a + b) / readings.length.toDouble(),
      'recoveryScore': readings.map((r) => r.scores.recovery).reduce((a, b) => a + b) / readings.length.toDouble(),
      'energyScore': readings.map((r) => r.scores.energy).reduce((a, b) => a + b) / readings.length.toDouble(),
      'rmssd': readings.map((r) => r.metrics.rmssd).reduce((a, b) => a + b) / readings.length,
      'heartRate': readings.map((r) => r.metrics.meanRr > 0 ? 60000 / r.metrics.meanRr : 0).reduce((a, b) => a + b) / readings.length.toDouble(),
    };
  }

  bool _isSignificantDifference(double value1, double value2) {
    final difference = (value1 - value2).abs();
    final average = (value1 + value2) / 2;
    return average > 0 && (difference / average) > 0.1; // 10% difference
  }

  double _calculateRecoveryTime(HrvReading stressEvent, List<HrvReading> recoveryReadings) {
    final baselineRecovery = stressEvent.scores.recovery;
    
    for (final reading in recoveryReadings) {
      if (reading.scores.recovery >= baselineRecovery * 0.9) {
        return reading.timestamp.difference(stressEvent.timestamp).inHours.toDouble();
      }
    }
    
    return 48.0; // Max observation period
  }

  RecoveryQuality _assessRecoveryQuality(HrvReading stressEvent, List<HrvReading> recoveryReadings) {
    if (recoveryReadings.isEmpty) return RecoveryQuality.poor;
    
    final finalRecovery = recoveryReadings.last.scores.recovery;
    final initialRecovery = stressEvent.scores.recovery;
    
    if (finalRecovery >= initialRecovery) {
      return RecoveryQuality.excellent;
    } else if (finalRecovery >= initialRecovery * 0.9) {
      return RecoveryQuality.good;
    } else if (finalRecovery >= initialRecovery * 0.75) {
      return RecoveryQuality.moderate;
    } else {
      return RecoveryQuality.poor;
    }
  }

  ({double slope, double intercept, double rSquared}) _calculateLinearRegression(
    List<double> x,
    List<double> y,
  ) {
    final n = x.length;
    final sumX = x.reduce((a, b) => a + b);
    final sumY = y.reduce((a, b) => a + b);
    final sumXY = List.generate(n, (i) => x[i] * y[i]).reduce((a, b) => a + b);
    final sumX2 = x.map((v) => v * v).reduce((a, b) => a + b);
    
    final slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
    final intercept = (sumY - slope * sumX) / n;
    
    // Calculate R-squared
    final yMean = sumY / n;
    final totalSS = y.map((v) => (v - yMean) * (v - yMean)).reduce((a, b) => a + b);
    final residualSS = List.generate(n, (i) {
      final predicted = slope * x[i] + intercept;
      return (y[i] - predicted) * (y[i] - predicted);
    }).reduce((a, b) => a + b);
    
    final rSquared = totalSS > 0 ? 1 - (residualSS / totalSS) : 0;
    
    return (slope: slope, intercept: intercept, rSquared: rSquared.toDouble());
  }

  String _interpretAnomaly(AnomalyType type, AnomalySeverity severity, HrvReading reading) {
    final severityText = severity == AnomalySeverity.high ? 'significantly' : 'notably';
    
    if (type == AnomalyType.unusuallyHigh) {
      return 'Your HRV was $severityText higher than usual at ${reading.timestamp.hour}:${reading.timestamp.minute.toString().padLeft(2, '0')}. '
          'This could indicate exceptional recovery or relaxation.';
    } else {
      return 'Your HRV was $severityText lower than usual at ${reading.timestamp.hour}:${reading.timestamp.minute.toString().padLeft(2, '0')}. '
          'This might indicate stress, fatigue, or other factors affecting your recovery.';
    }
  }
}

// Data models for pattern recognition results

@immutable
class WeeklyPattern {
  final bool hasSignificantPattern;
  final Map<String, double> weekdayAverage;
  final Map<String, double> weekendAverage;
  final String interpretation;

  const WeeklyPattern({
    required this.hasSignificantPattern,
    required this.weekdayAverage,
    required this.weekendAverage,
    required this.interpretation,
  });
}

@immutable
class TimeOfDayPattern {
  final Map<String, double> morningAverage;
  final Map<String, double> afternoonAverage;
  final Map<String, double> eveningAverage;
  final String bestTimeOfDay;
  final String interpretation;

  const TimeOfDayPattern({
    required this.morningAverage,
    required this.afternoonAverage,
    required this.eveningAverage,
    required this.bestTimeOfDay,
    required this.interpretation,
  });
}

@immutable
class RecoveryPattern {
  final HrvReading stressEvent;
  final List<HrvReading> recoveryReadings;
  final double recoveryTimeHours;
  final RecoveryQuality recoveryQuality;

  const RecoveryPattern({
    required this.stressEvent,
    required this.recoveryReadings,
    required this.recoveryTimeHours,
    required this.recoveryQuality,
  });
}

@immutable
class TrendPattern {
  final Trend trend;
  final double confidence;
  final String interpretation;

  const TrendPattern({
    required this.trend,
    required this.confidence,
    required this.interpretation,
  });
}

@immutable
class AnomalyPattern {
  final HrvReading reading;
  final AnomalyType anomalyType;
  final AnomalySeverity severity;
  final double zScore;
  final String interpretation;

  const AnomalyPattern({
    required this.reading,
    required this.anomalyType,
    required this.severity,
    required this.zScore,
    required this.interpretation,
  });
}

// Enums

enum Trend { improving, stable, declining, insufficient }

enum RecoveryQuality { excellent, good, moderate, poor }

enum AnomalyType { unusuallyHigh, unusuallyLow }

enum AnomalySeverity { high, medium, low }