import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/health_data_provider.dart';
import '../../models/health_data_point.dart';

/// Individual health metric card that displays a specific health data point
class HealthMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const HealthMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Steps metric card with today's step count
class StepsMetricCard extends ConsumerWidget {
  const StepsMetricCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthDataAsync = ref.watch(todayHealthDataProvider);
    final theme = Theme.of(context);

    return healthDataAsync.when(
      data: (summary) => HealthMetricCard(
        title: 'Steps',
        value: _formatSteps(summary.steps),
        subtitle: _getStepsSubtitle(summary.steps),
        icon: Icons.directions_walk,
        color: theme.colorScheme.primary,
        onTap: () => _showStepsDetail(context, summary.steps),
      ),
      loading: () => _buildLoadingCard(context, 'Steps', Icons.directions_walk),
      error: (error, stackTrace) => _buildErrorCard(context, 'Steps', Icons.directions_walk),
    );
  }

  String _formatSteps(int steps) {
    if (steps < 1000) return steps.toString();
    if (steps < 10000) {
      return '${(steps / 1000).toStringAsFixed(1)}k';
    }
    return '${(steps / 1000).toStringAsFixed(0)}k';
  }

  String _getStepsSubtitle(int steps) {
    if (steps >= 10000) return 'Great job! Goal achieved';
    if (steps >= 7500) return 'Almost there!';
    if (steps >= 5000) return 'Good progress';
    if (steps >= 2500) return 'Keep moving';
    return 'Let\'s get started';
  }

  void _showStepsDetail(BuildContext context, int steps) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Steps Detail'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Steps: $steps'),
            const SizedBox(height: 8),
            Text('Goal Progress: ${(steps / 10000 * 100).clamp(0, 100).round()}%'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (steps / 10000).clamp(0, 1),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    
    return HealthMetricCard(
      title: title,
      value: '...',
      subtitle: 'Loading...',
      icon: icon,
      color: theme.colorScheme.outline,
    );
  }

  Widget _buildErrorCard(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    
    return HealthMetricCard(
      title: title,
      value: '--',
      subtitle: 'Data unavailable',
      icon: icon,
      color: theme.colorScheme.error,
    );
  }
}

/// Sleep metric card with today's sleep hours
class SleepMetricCard extends ConsumerWidget {
  const SleepMetricCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthDataAsync = ref.watch(todayHealthDataProvider);

    return healthDataAsync.when(
      data: (summary) => HealthMetricCard(
        title: 'Sleep',
        value: '${summary.sleepHours.toStringAsFixed(1)}h',
        subtitle: _getSleepSubtitle(summary.sleepHours, summary.sleepEfficiency),
        icon: Icons.bedtime,
        color: Colors.indigo,
        onTap: () => _showSleepDetail(context, summary),
      ),
      loading: () => _buildLoadingCard(context, 'Sleep', Icons.bedtime),
      error: (error, stackTrace) => _buildErrorCard(context, 'Sleep', Icons.bedtime),
    );
  }

  String _getSleepSubtitle(double hours, double efficiency) {
    if (hours >= 7 && efficiency >= 85) return 'Excellent sleep';
    if (hours >= 6 && efficiency >= 75) return 'Good sleep';
    if (hours >= 5) return 'Could be better';
    return 'Need more sleep';
  }

  void _showSleepDetail(BuildContext context, HealthDataSummary summary) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sleep Detail'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sleep Duration: ${summary.sleepHours.toStringAsFixed(1)} hours'),
            const SizedBox(height: 8),
            Text('Sleep Efficiency: ${summary.sleepEfficiency.round()}%'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (summary.sleepEfficiency / 100).clamp(0, 1),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    
    return HealthMetricCard(
      title: title,
      value: '...',
      subtitle: 'Loading...',
      icon: icon,
      color: theme.colorScheme.outline,
    );
  }

  Widget _buildErrorCard(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    
    return HealthMetricCard(
      title: title,
      value: '--',
      subtitle: 'Data unavailable',
      icon: icon,
      color: theme.colorScheme.error,
    );
  }
}

/// Heart rate metric card with average heart rate
class HeartRateMetricCard extends ConsumerWidget {
  const HeartRateMetricCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthDataAsync = ref.watch(todayHealthDataProvider);

    return healthDataAsync.when(
      data: (summary) => HealthMetricCard(
        title: 'Heart Rate',
        value: '${summary.averageHeartRate.round()} BPM',
        subtitle: _getHeartRateSubtitle(summary.averageHeartRate, summary.restingHeartRate),
        icon: Icons.favorite,
        color: Colors.red,
        onTap: () => _showHeartRateDetail(context, summary),
      ),
      loading: () => _buildLoadingCard(context, 'Heart Rate', Icons.favorite),
      error: (error, stackTrace) => _buildErrorCard(context, 'Heart Rate', Icons.favorite),
    );
  }

  String _getHeartRateSubtitle(double average, double resting) {
    if (resting > 0) {
      return 'Resting: ${resting.round()} BPM';
    }
    return 'Average for today';
  }

  void _showHeartRateDetail(BuildContext context, HealthDataSummary summary) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Heart Rate Detail'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Average: ${summary.averageHeartRate.round()} BPM'),
            const SizedBox(height: 8),
            if (summary.restingHeartRate > 0) ...[
              Text('Resting: ${summary.restingHeartRate.round()} BPM'),
              const SizedBox(height: 8),
            ],
            Text('Heart rate data helps track cardiovascular health and recovery'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    
    return HealthMetricCard(
      title: title,
      value: '...',
      subtitle: 'Loading...',
      icon: icon,
      color: theme.colorScheme.outline,
    );
  }

  Widget _buildErrorCard(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    
    return HealthMetricCard(
      title: title,
      value: '--',
      subtitle: 'Data unavailable',
      icon: icon,
      color: theme.colorScheme.error,
    );
  }
}

/// Workout metric card with today's workout summary
class WorkoutMetricCard extends ConsumerWidget {
  const WorkoutMetricCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthDataAsync = ref.watch(todayHealthDataProvider);

    return healthDataAsync.when(
      data: (summary) => HealthMetricCard(
        title: 'Workouts',
        value: '${summary.workouts.length}',
        subtitle: _getWorkoutSubtitle(summary.workouts),
        icon: Icons.fitness_center,
        color: Colors.green,
        onTap: () => _showWorkoutDetail(context, summary.workouts),
      ),
      loading: () => _buildLoadingCard(context, 'Workouts', Icons.fitness_center),
      error: (error, stackTrace) => _buildErrorCard(context, 'Workouts', Icons.fitness_center),
    );
  }

  String _getWorkoutSubtitle(List<WorkoutSession> workouts) {
    if (workouts.isEmpty) return 'No workouts today';
    final totalDuration = workouts.fold<double>(0, (sum, workout) => sum + workout.duration);
    final hours = totalDuration ~/ 60;
    final minutes = (totalDuration % 60).round();
    
    if (hours > 0) {
      return '${hours}h ${minutes}m total';
    }
    return '${minutes}m total';
  }

  void _showWorkoutDetail(BuildContext context, List<WorkoutSession> workouts) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Workout Detail'),
        content: SizedBox(
          width: double.maxFinite,
          child: workouts.isEmpty
              ? const Text('No workouts recorded today')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: workouts.length,
                  itemBuilder: (context, index) {
                    final workout = workouts[index];
                    return ListTile(
                      title: Text(workout.type.displayName),
                      subtitle: Text('${workout.duration.round()} minutes'),
                      trailing: Text('${workout.caloriesBurned.round()} cal'),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    
    return HealthMetricCard(
      title: title,
      value: '...',
      subtitle: 'Loading...',
      icon: icon,
      color: theme.colorScheme.outline,
    );
  }

  Widget _buildErrorCard(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    
    return HealthMetricCard(
      title: title,
      value: '--',
      subtitle: 'Data unavailable',
      icon: icon,
      color: theme.colorScheme.error,
    );
  }
}