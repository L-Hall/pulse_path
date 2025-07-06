import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/health_data_provider.dart';
import '../../models/health_data_point.dart';

/// Widget that displays a comprehensive health data summary for today
class HealthSummaryWidget extends ConsumerWidget {
  const HealthSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthDataAsync = ref.watch(todayHealthDataProvider);
    final permissionsAsync = ref.watch(healthPermissionsProvider);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            permissionsAsync.when(
              data: (hasPermissions) => hasPermissions
                  ? _buildHealthData(context, ref, healthDataAsync)
                  : _buildPermissionRequest(context),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => _buildErrorState(context, error),
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
          Icons.health_and_safety,
          color: theme.colorScheme.primary,
          size: 28,
        ),
        const SizedBox(width: 12),
        Text(
          'Today\'s Health Summary',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildHealthData(BuildContext context, WidgetRef ref, AsyncValue<HealthDataSummary> healthDataAsync) {
    return healthDataAsync.when(
      data: (summary) => _buildHealthSummary(context, summary),
      loading: () => _buildLoadingState(context),
      error: (error, stackTrace) => _buildErrorState(context, error),
    );
  }

  Widget _buildHealthSummary(BuildContext context, HealthDataSummary summary) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        // Primary metrics row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMetricItem(
              context,
              icon: Icons.directions_walk,
              label: 'Steps',
              value: _formatSteps(summary.steps),
              color: theme.colorScheme.primary,
            ),
            _buildMetricItem(
              context,
              icon: Icons.bedtime,
              label: 'Sleep',
              value: '${summary.sleepHours.toStringAsFixed(1)}h',
              color: theme.colorScheme.secondary,
            ),
            _buildMetricItem(
              context,
              icon: Icons.favorite,
              label: 'Heart Rate',
              value: '${summary.averageHeartRate.round()} BPM',
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Secondary metrics row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMetricItem(
              context,
              icon: Icons.local_fire_department,
              label: 'Active Energy',
              value: '${summary.activeEnergyBurned.round()} cal',
              color: Colors.orange,
            ),
            _buildMetricItem(
              context,
              icon: Icons.fitness_center,
              label: 'Workouts',
              value: '${summary.workouts.length}',
              color: theme.colorScheme.tertiary,
            ),
            _buildMetricItem(
              context,
              icon: Icons.nights_stay,
              label: 'Sleep Quality',
              value: '${summary.sleepEfficiency.round()}%',
              color: Colors.indigo,
            ),
          ],
        ),
        if (summary.workouts.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildWorkoutSummary(context, summary.workouts),
        ],
      ],
    );
  }

  Widget _buildMetricItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutSummary(BuildContext context, List<WorkoutSession> workouts) {
    final theme = Theme.of(context);
    final totalDuration = workouts.fold<double>(0, (sum, workout) => sum + workout.duration);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Workout Summary',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Duration: ${_formatDuration(totalDuration)}',
                style: theme.textTheme.bodyMedium,
              ),
              Text(
                'Types: ${_getWorkoutTypes(workouts)}',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: theme.colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Unable to load health data',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check your health permissions and try again',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionRequest(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              Icons.health_and_safety_outlined,
              color: theme.colorScheme.primary,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Health Data Permission Required',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Grant access to display your health and fitness data alongside HRV metrics',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _requestPermissions(context),
              child: const Text('Grant Permission'),
            ),
          ],
        ),
      ),
    );
  }

  void _requestPermissions(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please grant health permissions in Settings'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  String _formatSteps(int steps) {
    if (steps < 1000) return steps.toString();
    final thousands = steps / 1000;
    return '${thousands.toStringAsFixed(1)}k';
  }

  String _formatDuration(double minutes) {
    final hours = minutes ~/ 60;
    final mins = (minutes % 60).round();
    if (hours > 0) {
      return '${hours}h ${mins}m';
    }
    return '${mins}m';
  }

  String _getWorkoutTypes(List<WorkoutSession> workouts) {
    final types = workouts.map((w) => w.type.displayName).toSet().toList();
    if (types.length <= 2) {
      return types.join(', ');
    }
    return '${types.take(2).join(', ')} +${types.length - 2}';
  }
}

/// Compact version of the health summary widget for smaller spaces
class CompactHealthSummaryWidget extends ConsumerWidget {
  const CompactHealthSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthDataAsync = ref.watch(todayHealthDataProvider);
    final theme = Theme.of(context);

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
                  Icons.health_and_safety,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Health Summary',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            healthDataAsync.when(
              data: (summary) => _buildCompactSummary(context, summary),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Text(
                'Health data unavailable',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactSummary(BuildContext context, HealthDataSummary summary) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCompactMetric(
          context,
          icon: Icons.directions_walk,
          value: _formatSteps(summary.steps),
          color: theme.colorScheme.primary,
        ),
        _buildCompactMetric(
          context,
          icon: Icons.bedtime,
          value: '${summary.sleepHours.toStringAsFixed(1)}h',
          color: theme.colorScheme.secondary,
        ),
        _buildCompactMetric(
          context,
          icon: Icons.favorite,
          value: '${summary.averageHeartRate.round()}',
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildCompactMetric(
    BuildContext context, {
    required IconData icon,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 18,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _formatSteps(int steps) {
    if (steps < 1000) return steps.toString();
    final thousands = steps / 1000;
    return '${thousands.toStringAsFixed(1)}k';
  }
}