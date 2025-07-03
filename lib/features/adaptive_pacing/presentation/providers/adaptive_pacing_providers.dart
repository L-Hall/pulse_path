import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/adaptive_pacing_service.dart';
import '../../../settings/domain/models/user_preferences.dart';
import '../../../settings/presentation/providers/settings_providers.dart';
import '../../../../shared/models/adaptive_pacing_data.dart';
import '../../../../shared/models/daily_health_metrics.dart';
import '../../../../shared/models/hrv_reading.dart';
import '../../../../shared/services/health_data_service.dart';
import '../../data/repositories/adaptive_pacing_repository_simple.dart';
import '../../../dashboard/presentation/providers/dashboard_providers.dart';

/// Provider for the adaptive pacing service
final adaptivePacingServiceProvider = Provider<AdaptivePacingService>((ref) {
  return AdaptivePacingService();
});

/// Provider for the health data service
final healthDataServiceProvider = Provider<HealthDataService>((ref) {
  return HealthDataService();
});

/// Provider for the adaptive pacing repository
final adaptivePacingRepositoryProvider = Provider<AdaptivePacingRepository>((ref) {
  return AdaptivePacingRepository();
});

/// Provider for health data permissions status
final healthPermissionsProvider = FutureProvider<bool>((ref) async {
  final healthService = ref.watch(healthDataServiceProvider);
  await healthService.initialize();
  return healthService.hasPermissions();
});

/// Provider for today's health metrics
final todayHealthMetricsProvider = FutureProvider<DailyHealthMetrics?>((ref) async {
  final healthService = ref.watch(healthDataServiceProvider);
  final hasPermissions = await ref.watch(healthPermissionsProvider.future);
  
  if (!hasPermissions) return null;
  
  final today = DateTime.now();
  return healthService.getDailyHealthMetrics(today);
});

/// Provider for recent health metrics (last 30 days)
final recentHealthMetricsProvider = FutureProvider<List<DailyHealthMetrics>>((ref) async {
  final healthService = ref.watch(healthDataServiceProvider);
  final hasPermissions = await ref.watch(healthPermissionsProvider.future);
  
  if (!hasPermissions) return [];
  
  final endDate = DateTime.now();
  final startDate = endDate.subtract(const Duration(days: 30));
  
  return healthService.getHealthMetricsRange(startDate, endDate);
});

/// Provider for recent HRV readings (from dashboard)
final recentHrvReadingsProvider = FutureProvider<List<HrvReading>>((ref) async {
  final dashboardData = await ref.watch(dashboardDataProvider.future);
  
  // Get recent readings from dashboard data
  final readings = <HrvReading>[];
  
  // Add current reading if available
  if (dashboardData.hasRecentData) {
    // For now, create a mock reading from dashboard scores
    // In a real implementation, this would come from the HRV repository
    final mockReading = HrvReading(
      id: 'current_${DateTime.now().millisecondsSinceEpoch}',
      timestamp: DateTime.now(),
      durationSeconds: 180,
      rrIntervals: [], // Empty for mock
      metrics: HrvMetrics(
        rmssd: 45.0,
        meanRr: 800.0,
        sdnn: 40.0,
        lowFrequency: 800.0,
        highFrequency: 600.0,
        lfHfRatio: 1.33,
        baevsky: 50.0,
        coefficientOfVariance: 5.0,
        mxdmn: 400.0,
        moda: 800.0,
        amo50: 30.0,
        pnn50: 25.0,
        pnn20: 40.0,
        totalPower: 2000.0,
        dfaAlpha1: 1.2,
      ),
      scores: HrvScores(
        stress: dashboardData.currentScores.stress,
        recovery: dashboardData.currentScores.recovery,
        energy: dashboardData.currentScores.energy,
        confidence: 85.0,
      ),
      notes: '',
      tags: [],
    );
    readings.add(mockReading);
  }
  
  // Add trend readings (convert from dashboard trend data)
  for (final trendReading in dashboardData.trendReadings) {
    readings.add(trendReading);
  }
  
  return readings;
});

/// Provider for today's adaptive pacing assessment
final todayPacingAssessmentProvider = FutureProvider<AdaptivePacingAssessment?>((ref) async {
  final pacingService = ref.watch(adaptivePacingServiceProvider);
  final userPreferences = await ref.watch(userPreferencesProvider.future);
  final todayHealth = await ref.watch(todayHealthMetricsProvider.future);
  final recentHealth = await ref.watch(recentHealthMetricsProvider.future);
  final recentHrv = await ref.watch(recentHrvReadingsProvider.future);
  
  if (recentHrv.isEmpty) return null;
  
  final today = DateTime.now();
  final todayHrv = recentHrv.isNotEmpty ? recentHrv.first : null;
  
  try {
    return await pacingService.generateAssessment(
      date: today,
      userPreferences: userPreferences,
      todayHrv: todayHrv,
      todayHealth: todayHealth,
      recentHrvReadings: recentHrv,
      recentHealthMetrics: recentHealth,
    );
  } catch (e) {
    // Return null if assessment generation fails
    return null;
  }
});

/// Provider for the current pacing state
final currentPacingStateProvider = Provider<PacingState?>((ref) {
  final assessmentAsync = ref.watch(todayPacingAssessmentProvider);
  
  return assessmentAsync.when(
    data: (assessment) => assessment?.currentState,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Provider for current PEM risk level
final currentPemRiskProvider = Provider<PemRiskLevel?>((ref) {
  final assessmentAsync = ref.watch(todayPacingAssessmentProvider);
  
  return assessmentAsync.when(
    data: (assessment) => assessment?.pemRisk,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Provider for current energy envelope percentage
final currentEnergyEnvelopeProvider = Provider<int?>((ref) {
  final assessmentAsync = ref.watch(todayPacingAssessmentProvider);
  
  return assessmentAsync.when(
    data: (assessment) => assessment?.energyEnvelopePercentage,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Provider for current activity guidance
final currentActivityGuidanceProvider = Provider<ActivityGuidance?>((ref) {
  final assessmentAsync = ref.watch(todayPacingAssessmentProvider);
  
  return assessmentAsync.when(
    data: (assessment) => assessment?.activityGuidance,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Provider for current pacing recommendations
final currentRecommendationsProvider = Provider<List<PacingRecommendation>>((ref) {
  final assessmentAsync = ref.watch(todayPacingAssessmentProvider);
  
  return assessmentAsync.when(
    data: (assessment) => assessment?.recommendations ?? [],
    loading: () => [],
    error: (_, __) => [],
  );
});

/// Provider for trend warnings
final trendWarningsProvider = Provider<List<String>>((ref) {
  final assessmentAsync = ref.watch(todayPacingAssessmentProvider);
  
  return assessmentAsync.when(
    data: (assessment) => assessment?.trendWarnings ?? [],
    loading: () => [],
    error: (_, __) => [],
  );
});

/// Provider for consecutive high-risk days
final consecutiveHighRiskDaysProvider = Provider<int>((ref) {
  final assessmentAsync = ref.watch(todayPacingAssessmentProvider);
  
  return assessmentAsync.when(
    data: (assessment) => assessment?.consecutiveHighRiskDays ?? 0,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

/// Provider to request health permissions
final requestHealthPermissionsProvider = FutureProvider.family<bool, void>((ref, _) async {
  final healthService = ref.watch(healthDataServiceProvider);
  final granted = await healthService.requestPermissions();
  
  // Refresh permissions status after request
  ref.invalidate(healthPermissionsProvider);
  
  return granted;
});

/// Provider to refresh health data
final refreshHealthDataProvider = FutureProvider.family<void, void>((ref, _) async {
  // Invalidate all health-related providers to trigger refresh
  ref.invalidate(todayHealthMetricsProvider);
  ref.invalidate(recentHealthMetricsProvider);
  ref.invalidate(todayPacingAssessmentProvider);
});

/// Provider for health data summary (for dashboard display)
final healthDataSummaryProvider = Provider<Map<String, dynamic>>((ref) {
  final todayHealthAsync = ref.watch(todayHealthMetricsProvider);
  
  return todayHealthAsync.when(
    data: (healthData) {
      if (healthData == null) {
        return {
          'hasData': false,
          'stepCount': 0,
          'workoutCount': 0,
          'sleepHours': 0.0,
          'dataSource': 'none',
        };
      }
      
      return {
        'hasData': true,
        'stepCount': healthData.stepCount,
        'workoutCount': healthData.workouts.length,
        'sleepHours': healthData.sleepData?.totalSleepTime.inMinutes ?? 0 / 60.0,
        'dataSource': healthData.dataSources.isNotEmpty ? healthData.dataSources.first : 'unknown',
        'activeMinutes': healthData.activeMinutes,
        'distanceKm': healthData.distanceKm,
        'energyLevel': healthData.energyLevel,
        'stressLevel': healthData.stressLevel,
      };
    },
    loading: () => {
      'hasData': false,
      'loading': true,
    },
    error: (_, __) => {
      'hasData': false,
      'error': true,
    },
  );
});

/// Provider for adaptive pacing status summary (for dashboard display)
final pacingStatusSummaryProvider = Provider<Map<String, dynamic>>((ref) {
  final pacingState = ref.watch(currentPacingStateProvider);
  final pemRisk = ref.watch(currentPemRiskProvider);
  final energyEnvelope = ref.watch(currentEnergyEnvelopeProvider);
  final warnings = ref.watch(trendWarningsProvider);
  final consecutiveHighRiskDays = ref.watch(consecutiveHighRiskDaysProvider);
  
  return {
    'hasAssessment': pacingState != null,
    'pacingState': pacingState,
    'pemRisk': pemRisk,
    'energyEnvelope': energyEnvelope,
    'hasWarnings': warnings.isNotEmpty,
    'warningCount': warnings.length,
    'consecutiveHighRiskDays': consecutiveHighRiskDays,
    'needsAttention': pemRisk == PemRiskLevel.high || 
                     pemRisk == PemRiskLevel.critical ||
                     consecutiveHighRiskDays >= 2,
  };
});