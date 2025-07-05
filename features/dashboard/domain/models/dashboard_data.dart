import '../../data/repositories/simple_hrv_repository.dart';
import '../../../../shared/models/hrv_reading.dart';

/// Dashboard data model containing all information needed for the main dashboard
class DashboardData {
  final HrvReading? latestReading;
  final DashboardStatistics statistics;
  final List<HrvReading> trendReadings;
  final DateTime lastUpdated;

  const DashboardData({
    required this.latestReading,
    required this.statistics,
    required this.trendReadings,
    required this.lastUpdated,
  });

  /// Create empty dashboard data for fallback scenarios
  factory DashboardData.empty() {
    return DashboardData(
      latestReading: null,
      statistics: DashboardStatistics.empty(),
      trendReadings: const [],
      lastUpdated: DateTime.now(),
    );
  }

  /// Get current scores from the latest reading, or default values
  DashboardScores get currentScores {
    if (latestReading != null) {
      return DashboardScores(
        stress: latestReading!.scores.stress,
        recovery: latestReading!.scores.recovery,
        energy: latestReading!.scores.energy,
        confidence: latestReading!.scores.confidence,
        timestamp: latestReading!.timestamp,
      );
    }
    
    return const DashboardScores(
      stress: 0,
      recovery: 0,
      energy: 0,
      confidence: 0.0,
      timestamp: null,
    );
  }

  /// Check if we have recent data (within last 24 hours)
  bool get hasRecentData {
    if (latestReading == null) return false;
    
    final now = DateTime.now();
    final timeDifference = now.difference(latestReading!.timestamp);
    return timeDifference.inHours < 24;
  }

  /// Get trend data for chart display
  List<TrendPoint> getTrendPoints() {
    return trendReadings.map((reading) => TrendPoint(
      timestamp: reading.timestamp,
      stress: reading.scores.stress.toDouble(),
      recovery: reading.scores.recovery.toDouble(),
      energy: reading.scores.energy.toDouble(),
      rmssd: reading.metrics.rmssd,
    )).toList();
  }

  /// Copy with updated data
  DashboardData copyWith({
    HrvReading? latestReading,
    DashboardStatistics? statistics,
    List<HrvReading>? trendReadings,
    DateTime? lastUpdated,
  }) {
    return DashboardData(
      latestReading: latestReading ?? this.latestReading,
      statistics: statistics ?? this.statistics,
      trendReadings: trendReadings ?? this.trendReadings,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

/// Current dashboard scores with metadata
class DashboardScores {
  final int stress;
  final int recovery;
  final int energy;
  final double confidence;
  final DateTime? timestamp;

  const DashboardScores({
    required this.stress,
    required this.recovery,
    required this.energy,
    required this.confidence,
    required this.timestamp,
  });

  /// Get the primary score category based on the highest value
  ScoreCategory get primaryCategory {
    if (recovery >= stress && recovery >= energy) {
      return ScoreCategory.recovery;
    } else if (energy >= stress) {
      return ScoreCategory.energy;
    } else {
      return ScoreCategory.stress;
    }
  }

  /// Check if the scores indicate good wellbeing
  bool get isGoodWellbeing => recovery >= 70 && stress <= 30 && energy >= 60;
}

/// Trend point for chart visualization
class TrendPoint {
  final DateTime timestamp;
  final double stress;
  final double recovery;
  final double energy;
  final double rmssd;

  const TrendPoint({
    required this.timestamp,
    required this.stress,
    required this.recovery,
    required this.energy,
    required this.rmssd,
  });
}

/// Score categories for dashboard display
enum ScoreCategory {
  stress,
  recovery,
  energy,
}

extension ScoreCategoryExtension on ScoreCategory {
  String get label {
    switch (this) {
      case ScoreCategory.stress:
        return 'Stress';
      case ScoreCategory.recovery:
        return 'Recovery';
      case ScoreCategory.energy:
        return 'Energy';
    }
  }

  String get description {
    switch (this) {
      case ScoreCategory.stress:
        return 'Mental and physical stress level';
      case ScoreCategory.recovery:
        return 'Recovery and restoration capacity';
      case ScoreCategory.energy:
        return 'Available energy and vitality';
    }
  }
}