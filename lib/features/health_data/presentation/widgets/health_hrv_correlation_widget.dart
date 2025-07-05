import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/health_data_provider.dart';
import '../../../dashboard/presentation/providers/dashboard_providers.dart';
import '../../../dashboard/domain/models/dashboard_data.dart';

/// Widget that shows correlations between health data and HRV metrics
class HealthHrvCorrelationWidget extends ConsumerWidget {
  const HealthHrvCorrelationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthDataAsync = ref.watch(weeklyHealthMetricsProvider);
    final dashboardDataAsync = ref.watch(dashboardDataProvider);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: healthDataAsync.when(
                data: (healthMetrics) => dashboardDataAsync.when(
                  data: (dashboardData) => _buildCorrelationContent(
                    context,
                    healthMetrics,
                    dashboardData,
                  ),
                  loading: () => _buildLoadingState(context),
                  error: (error, stackTrace) => _buildErrorState(context, error),
                ),
                loading: () => _buildLoadingState(context),
                error: (error, stackTrace) => _buildErrorState(context, error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Icon(
          Icons.analytics,
          color: theme.colorScheme.primary,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          'Health & HRV Insights',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCorrelationContent(
    BuildContext context,
    WeeklyHealthMetrics healthMetrics,
    DashboardData dashboardData,
  ) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        // Correlation insights
        _buildInsightsSection(context, healthMetrics, dashboardData),
        const SizedBox(height: 16),
        
        // Recommendations
        _buildRecommendationsSection(context, healthMetrics, dashboardData),
      ],
    );
  }

  Widget _buildInsightsSection(
    BuildContext context,
    WeeklyHealthMetrics healthMetrics,
    DashboardData dashboardData,
  ) {
    final theme = Theme.of(context);
    final currentScores = dashboardData.currentScores;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Insights',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Steps vs Recovery correlation
          _buildInsightRow(
            context,
            'Activity Level',
            _getActivityInsight(healthMetrics.totalSteps, currentScores.recovery),
            Icons.directions_walk,
            Colors.blue,
          ),
          const SizedBox(height: 8),
          
          // Sleep vs Recovery correlation
          _buildInsightRow(
            context,
            'Sleep Quality',
            _getSleepInsight(healthMetrics.averageSleepHours, healthMetrics.averageSleepEfficiency, currentScores.recovery),
            Icons.bedtime,
            Colors.indigo,
          ),
          const SizedBox(height: 8),
          
          // Workout vs Stress correlation
          _buildInsightRow(
            context,
            'Exercise Impact',
            _getWorkoutInsight(healthMetrics.totalWorkouts, healthMetrics.totalWorkoutDuration, currentScores.stress),
            Icons.fitness_center,
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightRow(
    BuildContext context,
    String title,
    String insight,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: color,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                insight,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationsSection(
    BuildContext context,
    WeeklyHealthMetrics healthMetrics,
    DashboardData dashboardData,
  ) {
    final theme = Theme.of(context);
    final currentScores = dashboardData.currentScores;
    final recommendations = _generateRecommendations(healthMetrics, currentScores);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Personalized Recommendations',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Display recommendations
          ...recommendations.map((recommendation) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_right,
                  color: theme.colorScheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    recommendation,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Unable to load insights',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  String _getActivityInsight(int totalSteps, int recoveryScore) {
    if (totalSteps >= 70000) { // ~10k steps/day
      if (recoveryScore >= 70) {
        return 'Excellent activity level supporting great recovery';
      } else {
        return 'High activity may need more recovery time';
      }
    } else if (totalSteps >= 35000) { // ~5k steps/day
      if (recoveryScore >= 50) {
        return 'Moderate activity level with good recovery balance';
      } else {
        return 'Consider light movement to boost recovery';
      }
    } else {
      return 'Increasing daily movement could improve HRV recovery';
    }
  }

  String _getSleepInsight(double avgSleepHours, double avgSleepEfficiency, int recoveryScore) {
    if (avgSleepHours >= 7 && avgSleepEfficiency >= 85) {
      return 'Excellent sleep quality supporting optimal recovery';
    } else if (avgSleepHours >= 6 && avgSleepEfficiency >= 75) {
      return 'Good sleep foundation with room for improvement';
    } else if (avgSleepHours < 6) {
      return 'Insufficient sleep duration may be limiting recovery';
    } else {
      return 'Sleep quality could be impacting HRV recovery';
    }
  }

  String _getWorkoutInsight(int totalWorkouts, double totalDuration, int stressScore) {
    if (totalWorkouts >= 4 && totalDuration > 240) { // 4+ workouts, 4+ hours
      if (stressScore <= 30) {
        return 'Well-balanced training load with low stress impact';
      } else {
        return 'High training volume may be increasing stress levels';
      }
    } else if (totalWorkouts >= 2) {
      return 'Moderate exercise routine supporting stress management';
    } else {
      return 'Adding structured exercise could help reduce stress';
    }
  }

  List<String> _generateRecommendations(
    WeeklyHealthMetrics healthMetrics,
    DashboardScores currentScores,
  ) {
    final recommendations = <String>[];
    
    // Sleep recommendations
    if (healthMetrics.averageSleepHours < 7) {
      recommendations.add('Aim for 7-9 hours of sleep to optimize HRV recovery');
    }
    if (healthMetrics.averageSleepEfficiency < 80) {
      recommendations.add('Improve sleep quality with consistent bedtime routine');
    }
    
    // Activity recommendations
    if (healthMetrics.totalSteps < 35000) {
      recommendations.add('Increase daily steps to 7,000-10,000 for better cardiovascular health');
    }
    
    // Workout recommendations
    if (healthMetrics.totalWorkouts < 3) {
      recommendations.add('Consider 3-4 moderate workouts per week for optimal stress resilience');
    } else if (healthMetrics.totalWorkouts > 6) {
      recommendations.add('Ensure adequate rest days to prevent overtraining stress');
    }
    
    // Stress-specific recommendations
    if (currentScores.stress > 60) {
      recommendations.add('Focus on stress-reducing activities like meditation or gentle yoga');
    }
    
    // Recovery-specific recommendations
    if (currentScores.recovery < 50) {
      recommendations.add('Prioritize recovery with quality sleep and reduced training intensity');
    }
    
    // Energy-specific recommendations
    if (currentScores.energy < 50) {
      recommendations.add('Balance activity with rest to maintain sustainable energy levels');
    }
    
    // Default recommendation if list is empty
    if (recommendations.isEmpty) {
      recommendations.add('Maintain your current healthy lifestyle patterns');
    }
    
    return recommendations.take(3).toList(); // Limit to top 3 recommendations
  }
}

/// Compact version for smaller dashboard spaces
class CompactHealthHrvCorrelationWidget extends ConsumerWidget {
  const CompactHealthHrvCorrelationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthDataAsync = ref.watch(weeklyHealthMetricsProvider);
    final dashboardDataAsync = ref.watch(dashboardDataProvider);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  'Health Insights',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            healthDataAsync.when(
              data: (healthMetrics) => dashboardDataAsync.when(
                data: (dashboardData) => _buildCompactInsight(
                  context,
                  healthMetrics,
                  dashboardData,
                ),
                loading: () => const Text('Loading...'),
                error: (error, stackTrace) => const Text('Insights unavailable'),
              ),
              loading: () => const Text('Loading...'),
              error: (error, stackTrace) => const Text('Insights unavailable'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactInsight(
    BuildContext context,
    WeeklyHealthMetrics healthMetrics,
    DashboardData dashboardData,
  ) {
    final theme = Theme.of(context);
    final insight = _getTopInsight(healthMetrics, dashboardData.currentScores);
    
    return Text(
      insight,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  String _getTopInsight(WeeklyHealthMetrics healthMetrics, DashboardScores currentScores) {
    // Prioritize the most important insight
    if (healthMetrics.averageSleepHours < 6) {
      return 'Sleep more to improve HRV recovery';
    }
    if (healthMetrics.totalSteps < 21000) { // Less than 3k steps/day
      return 'More daily movement could boost energy';
    }
    if (currentScores.stress > 70) {
      return 'High stress - consider recovery activities';
    }
    if (currentScores.recovery < 40) {
      return 'Focus on sleep and recovery this week';
    }
    return 'Health metrics support good HRV balance';
  }
}