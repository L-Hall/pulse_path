import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../shared/models/hrv_reading.dart';
import '../../domain/services/insights_engine.dart';
import '../../../dashboard/data/repositories/hrv_repository_interface.dart';

/// Provider for accessing the HRV repository
final hrvRepositoryProvider = FutureProvider<HrvRepositoryInterface>((ref) async {
  if (kIsWeb) {
    return sl<HrvRepositoryInterface>();
  } else {
    return await sl.getAsync<HrvRepositoryInterface>();
  }
});

/// Provider for accessing the insights engine service
final insightsEngineProvider = Provider<InsightsEngine>((ref) {
  return sl<InsightsEngine>();
});

/// Provider for comprehensive insights based on current HRV data
final comprehensiveInsightsProvider = FutureProvider<ComprehensiveInsights>((ref) async {
  final insightsEngine = ref.watch(insightsEngineProvider);
  final repository = await ref.watch(hrvRepositoryProvider.future);
  final hrvData = await repository.getTrendReadings(days: 365);
  
  if (hrvData.isEmpty) {
    return const ComprehensiveInsights(
      summary: 'No HRV data available for analysis. Complete your first reading to see insights.',
      statisticalInsights: [],
      patternInsights: [],
      recommendations: [],
      highlights: [],
    );
  }
  
  return insightsEngine.generateInsights(hrvData);
});

/// Provider for weekly insights (last 7 days)
final weeklyInsightsProvider = FutureProvider<ComprehensiveInsights>((ref) async {
  final insightsEngine = ref.watch(insightsEngineProvider);
  final repository = await ref.watch(hrvRepositoryProvider.future);
  final weeklyData = await repository.getTrendReadings(days: 7);
  
  if (weeklyData.isEmpty) {
    return const ComprehensiveInsights(
      summary: 'No HRV data from the past week. Take readings regularly for weekly insights.',
      statisticalInsights: [],
      patternInsights: [],
      recommendations: [],
      highlights: [],
    );
  }
  
  return insightsEngine.generateInsights(weeklyData);
});

/// Provider for monthly insights (last 30 days)
final monthlyInsightsProvider = FutureProvider<ComprehensiveInsights>((ref) async {
  final insightsEngine = ref.watch(insightsEngineProvider);
  final repository = await ref.watch(hrvRepositoryProvider.future);
  final monthlyData = await repository.getTrendReadings(days: 30);
  
  if (monthlyData.isEmpty) {
    return const ComprehensiveInsights(
      summary: 'No HRV data from the past month. Build a consistent measurement routine for monthly trends.',
      statisticalInsights: [],
      patternInsights: [],
      recommendations: [],
      highlights: [],
    );
  }
  
  return insightsEngine.generateInsights(monthlyData);
});

/// Provider for filtering insights by importance level
final filteredInsightsProvider = Provider.family<ComprehensiveInsights, ImportanceLevel>((ref, minImportance) {
  final insights = ref.watch(comprehensiveInsightsProvider).valueOrNull;
  
  if (insights == null) {
    return const ComprehensiveInsights(
      summary: 'Loading insights...',
      statisticalInsights: [],
      patternInsights: [],
      recommendations: [],
      highlights: [],
    );
  }
  
  // Filter insights by importance level
  final importanceLevels = [ImportanceLevel.high, ImportanceLevel.medium, ImportanceLevel.low];
  final minIndex = importanceLevels.indexOf(minImportance);
  final allowedLevels = importanceLevels.sublist(0, minIndex + 1);
  
  return ComprehensiveInsights(
    summary: insights.summary,
    statisticalInsights: insights.statisticalInsights
        .where((i) => allowedLevels.contains(i.importance))
        .toList(),
    patternInsights: insights.patternInsights
        .where((i) => allowedLevels.contains(i.importance))
        .toList(),
    recommendations: insights.recommendations,
    highlights: insights.highlights,
  );
});

/// Provider for real-time insight notifications
final insightNotificationProvider = StreamProvider<InsightNotification>((ref) async* {
  // Poll for changes every 30 seconds
  while (true) {
    try {
      final repository = await ref.read(hrvRepositoryProvider.future);
      final latestReading = await repository.getLatestReading();
      
      if (latestReading != null) {
        final recentReadings = await repository.getTrendReadings(days: 1);
        final previousReadings = recentReadings
            .where((r) => r.timestamp.isBefore(latestReading.timestamp))
            .toList();
        
        // Check for significant changes
        if (previousReadings.isNotEmpty) {
          final avgPreviousRecovery = previousReadings
              .map((r) => r.scores.recovery)
              .reduce((a, b) => a + b) / previousReadings.length;
          
          final recoveryChange = latestReading.scores.recovery - avgPreviousRecovery;
          
          if (recoveryChange.abs() > 20) {
            yield InsightNotification(
              type: recoveryChange > 0 ? NotificationType.positive : NotificationType.negative,
              title: recoveryChange > 0 ? 'Recovery Improving!' : 'Recovery Declining',
              message: 'Your recovery score changed by ${recoveryChange.abs().toStringAsFixed(0)} points',
              timestamp: DateTime.now(),
            );
          }
        }
        
        // Check for stress spikes
        if (latestReading.scores.stress > 80) {
          yield InsightNotification(
            type: NotificationType.alert,
            title: 'High Stress Detected',
            message: 'Consider taking a break or practicing relaxation techniques',
            timestamp: DateTime.now(),
          );
        }
      }
    } catch (e) {
      debugPrint('Error in insight notification provider: $e');
    }
    
    await Future.delayed(const Duration(seconds: 30));
  }
});

// Data models for notifications

class InsightNotification {
  final NotificationType type;
  final String title;
  final String message;
  final DateTime timestamp;

  InsightNotification({
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
  });
}

enum NotificationType { positive, negative, alert, info }