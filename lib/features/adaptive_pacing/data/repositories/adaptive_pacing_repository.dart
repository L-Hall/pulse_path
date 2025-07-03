import '../../../../shared/models/adaptive_pacing_data.dart';
import '../../../../shared/models/daily_health_metrics.dart';
import '../../../../shared/repositories/database/app_database.dart';
import '../../../../core/di/injection_container.dart';
import '../../../settings/domain/models/user_preferences.dart' show PemRiskLevel;

/// Repository for managing adaptive pacing assessments and health data
class AdaptivePacingRepository {
  final AppDatabase _database = sl<AppDatabase>();

  /// Save an adaptive pacing assessment
  Future<void> saveAssessment(AdaptivePacingAssessment assessment) async {
    await _database.into(_database.adaptivePacingAssessmentsTable).insert(
      AdaptivePacingAssessmentsTableCompanion.insert(
        id: assessment.id,
        date: assessment.date,
        currentStateJson: _encodeJson(assessment.currentState.toJson()),
        pemRisk: assessment.pemRisk.name,
        energyEnvelopePercentage: assessment.energyEnvelopePercentage,
        hrvContributionJson: _encodeJson(assessment.hrvContribution.toJson()),
        activityContributionJson: _encodeJson(assessment.activityContribution.toJson()),
        sleepContributionJson: _encodeJson(assessment.sleepContribution.toJson()),
        menstrualContributionJson: assessment.menstrualContribution != null 
            ? _encodeJson(assessment.menstrualContribution!.toJson()) 
            : null,
        recommendationsJson: _encodeJson(assessment.recommendations.map((r) => r.toJson()).toList()),
        activityGuidanceJson: _encodeJson(assessment.activityGuidance.toJson()),
        trendWarningsJson: _encodeJson(assessment.trendWarnings),
        consecutiveHighRiskDays: assessment.consecutiveHighRiskDays,
        sevenDayEnergyTrend: assessment.sevenDayEnergyTrend,
        conditionProfileJson: _encodeJson(assessment.conditionProfile.toJson()),
        personalSensitivity: assessment.personalSensitivity,
        createdAt: assessment.createdAt,
      ),
    );
  }

  /// Get assessment for a specific date
  Future<AdaptivePacingAssessment?> getAssessmentForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = _database.select(_database.adaptivePacingAssessmentsTable)
      ..where((tbl) => tbl.date.isBetweenValues(startOfDay, endOfDay))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])
      ..limit(1);

    final result = await query.getSingleOrNull();
    if (result == null) return null;

    return _mapToAssessment(result);
  }

  /// Get recent assessments
  Future<List<AdaptivePacingAssessment>> getRecentAssessments(int days) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));

    final query = _database.select(_database.adaptivePacingAssessmentsTable)
      ..where((tbl) => tbl.date.isAfterValue(cutoffDate))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]);

    final results = await query.get();
    return results.map(_mapToAssessment).toList();
  }

  /// Save daily health metrics
  Future<void> saveHealthMetrics(DailyHealthMetrics metrics) async {
    await _database.into(_database.dailyHealthMetricsTable).insertOnConflictUpdate(
      DailyHealthMetricsTableCompanion.insert(
        id: metrics.id,
        date: metrics.date,
        stepCount: metrics.stepCount,
        distanceKm: metrics.distanceKm,
        activeMinutes: metrics.activeMinutes,
        flightsClimbed: metrics.flightsClimbed,
        sleepDataJson: metrics.sleepData != null 
            ? _encodeJson(metrics.sleepData!.toJson()) 
            : null,
        workoutsJson: _encodeJson(metrics.workouts.map((w) => w.toJson()).toList()),
        menstrualDataJson: metrics.menstrualData != null 
            ? _encodeJson(metrics.menstrualData!.toJson()) 
            : null,
        energyLevel: metrics.energyLevel,
        stressLevel: metrics.stressLevel,
        symptomsJson: _encodeJson(metrics.symptoms),
        notes: metrics.notes,
        isComplete: metrics.isComplete,
        dataSourcesJson: _encodeJson(metrics.dataSources),
        createdAt: metrics.createdAt,
        updatedAt: metrics.updatedAt,
      ),
    );
  }

  /// Get health metrics for a specific date
  Future<DailyHealthMetrics?> getHealthMetricsForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = _database.select(_database.dailyHealthMetricsTable)
      ..where((tbl) => tbl.date.isBetweenValues(startOfDay, endOfDay))
      ..limit(1);

    final result = await query.getSingleOrNull();
    if (result == null) return null;

    return _mapToHealthMetrics(result);
  }

  /// Get health metrics for a date range
  Future<List<DailyHealthMetrics>> getHealthMetricsRange(DateTime startDate, DateTime endDate) async {
    final query = _database.select(_database.dailyHealthMetricsTable)
      ..where((tbl) => tbl.date.isBetweenValues(startDate, endDate))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]);

    final results = await query.get();
    return results.map(_mapToHealthMetrics).toList();
  }

  /// Delete old assessments beyond retention period
  Future<void> cleanupOldAssessments(Duration retentionPeriod) async {
    final cutoffDate = DateTime.now().subtract(retentionPeriod);
    
    await (_database.delete(_database.adaptivePacingAssessmentsTable)
      ..where((tbl) => tbl.date.isBeforeValue(cutoffDate))).go();
  }

  /// Delete old health metrics beyond retention period
  Future<void> cleanupOldHealthMetrics(Duration retentionPeriod) async {
    final cutoffDate = DateTime.now().subtract(retentionPeriod);
    
    await (_database.delete(_database.dailyHealthMetricsTable)
      ..where((tbl) => tbl.date.isBeforeValue(cutoffDate))).go();
  }

  // Helper methods

  String _encodeJson(dynamic data) {
    return data.toString(); // Simplified - in real implementation, use proper JSON encoding
  }

  dynamic _decodeJson(String json) {
    return json; // Simplified - in real implementation, use proper JSON decoding
  }

  AdaptivePacingAssessment _mapToAssessment(AdaptivePacingAssessmentsTableData data) {
    // This is a simplified mapping - in a real implementation, you would properly 
    // deserialize JSON fields back to their original objects
    return AdaptivePacingAssessment(
      id: data.id,
      date: data.date,
      currentState: PacingState(
        type: PacingStateType.moderate, // Simplified
        overallScore: 50,
        description: 'Loaded from database',
      ),
      pemRisk: PemRiskLevel.values.firstWhere(
        (e) => e.name == data.pemRisk,
        orElse: () => PemRiskLevel.moderate,
      ),
      energyEnvelopePercentage: data.energyEnvelopePercentage,
      hrvContribution: HrvContribution(
        currentHrvScore: 50.0,
        sevenDayAverage: 50.0,
        personalBaseline: 50.0,
        percentageOfBaseline: 100.0,
        trend: TrendDirection.stable,
      ),
      activityContribution: ActivityContribution(
        yesterdaySteps: 0,
        sevenDayAverageSteps: 0,
        recentWorkouts: [],
        cumulativeIntensityScore: 0,
        loadLevel: ActivityLoadLevel.moderate,
      ),
      sleepContribution: SleepContribution(
        sevenDayAverageSleep: Duration(hours: 8),
        sleepDebt: SleepDebtLevel.wellRested,
      ),
      recommendations: [],
      activityGuidance: ActivityGuidance(
        mainRecommendation: ActivityRecommendation.moderateActivity,
      ),
      consecutiveHighRiskDays: data.consecutiveHighRiskDays,
      sevenDayEnergyTrend: data.sevenDayEnergyTrend,
      conditionProfile: ChronicConditionProfile(),
      personalSensitivity: data.personalSensitivity,
      createdAt: data.createdAt,
    );
  }

  DailyHealthMetrics _mapToHealthMetrics(DailyHealthMetricsTableData data) {
    return DailyHealthMetrics(
      id: data.id,
      date: data.date,
      stepCount: data.stepCount,
      distanceKm: data.distanceKm,
      activeMinutes: data.activeMinutes,
      flightsClimbed: data.flightsClimbed,
      energyLevel: data.energyLevel,
      stressLevel: data.stressLevel,
      symptoms: [], // Simplified - would deserialize from JSON
      notes: data.notes,
      isComplete: data.isComplete,
      dataSources: [], // Simplified - would deserialize from JSON
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}