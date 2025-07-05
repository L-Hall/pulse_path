import '../../../../shared/models/adaptive_pacing_data.dart';
import '../../../../shared/models/daily_health_metrics.dart';
import '../../../settings/domain/models/user_preferences.dart' show PemRiskLevel;

/// Simple in-memory repository for adaptive pacing (for development/testing)
class AdaptivePacingRepository {
  final Map<String, AdaptivePacingAssessment> _assessments = {};
  final Map<String, DailyHealthMetrics> _healthMetrics = {};

  /// Save an adaptive pacing assessment
  Future<void> saveAssessment(AdaptivePacingAssessment assessment) async {
    _assessments[assessment.id] = assessment;
  }

  /// Get assessment for a specific date
  Future<AdaptivePacingAssessment?> getAssessmentForDate(DateTime date) async {
    final dateKey = '${date.year}-${date.month}-${date.day}';
    return _assessments.values
        .where((a) => '${a.date.year}-${a.date.month}-${a.date.day}' == dateKey)
        .lastOrNull;
  }

  /// Get recent assessments
  Future<List<AdaptivePacingAssessment>> getRecentAssessments(int days) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    return _assessments.values
        .where((a) => a.date.isAfter(cutoffDate))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Save daily health metrics
  Future<void> saveHealthMetrics(DailyHealthMetrics metrics) async {
    _healthMetrics[metrics.id] = metrics;
  }

  /// Get health metrics for a specific date
  Future<DailyHealthMetrics?> getHealthMetricsForDate(DateTime date) async {
    final dateKey = '${date.year}-${date.month}-${date.day}';
    return _healthMetrics.values
        .where((m) => '${m.date.year}-${m.date.month}-${m.date.day}' == dateKey)
        .lastOrNull;
  }

  /// Get health metrics for a date range
  Future<List<DailyHealthMetrics>> getHealthMetricsRange(DateTime startDate, DateTime endDate) async {
    return _healthMetrics.values
        .where((m) => m.date.isAfter(startDate.subtract(Duration(days: 1))) && 
                      m.date.isBefore(endDate.add(Duration(days: 1))))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Delete old assessments beyond retention period
  Future<void> cleanupOldAssessments(Duration retentionPeriod) async {
    final cutoffDate = DateTime.now().subtract(retentionPeriod);
    _assessments.removeWhere((key, assessment) => assessment.date.isBefore(cutoffDate));
  }

  /// Delete old health metrics beyond retention period
  Future<void> cleanupOldHealthMetrics(Duration retentionPeriod) async {
    final cutoffDate = DateTime.now().subtract(retentionPeriod);
    _healthMetrics.removeWhere((key, metrics) => metrics.date.isBefore(cutoffDate));
  }
}

extension<T> on Iterable<T> {
  T? get lastOrNull => isEmpty ? null : last;
}