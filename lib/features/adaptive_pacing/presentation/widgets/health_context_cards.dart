import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/adaptive_pacing_providers.dart';
import '../../../dashboard/presentation/widgets/score_card.dart';

/// Widget displaying health context information on the dashboard
class HealthContextCards extends ConsumerWidget {
  const HealthContextCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthSummary = ref.watch(healthDataSummaryProvider);
    final hasPermissions = ref.watch(healthPermissionsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Health Context',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!healthSummary['hasData'])
              TextButton.icon(
                onPressed: () => _requestHealthPermissions(ref),
                icon: const Icon(Icons.health_and_safety, size: 16),
                label: const Text('Enable'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        hasPermissions.when(
          data: (hasPerms) => hasPerms
              ? _buildHealthCards(context, healthSummary)
              : _buildPermissionPrompt(context, ref),
          loading: () => _buildLoadingCards(context),
          error: (_, __) => _buildErrorCards(context),
        ),
      ],
    );
  }

  Widget _buildHealthCards(BuildContext context, Map<String, dynamic> healthSummary) {
    if (!healthSummary['hasData']) {
      return _buildNoDataCards(context);
    }

    return Row(
      children: [
        Expanded(
          child: ScoreCard(
            title: 'Steps',
            score: healthSummary['stepCount'] ?? 0,
            maxScore: 10000,
            color: _getStepsColor(healthSummary['stepCount'] ?? 0),
            icon: Icons.directions_walk,
            subtitle: _getStepsDescription(healthSummary['stepCount'] ?? 0),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ScoreCard(
            title: 'Activity',
            score: healthSummary['activeMinutes'] ?? 0,
            maxScore: 60,
            color: _getActivityColor(healthSummary['activeMinutes'] ?? 0),
            icon: Icons.fitness_center,
            subtitle: _getActivityDescription(healthSummary['activeMinutes'] ?? 0),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ScoreCard(
            title: 'Sleep',
            score: ((healthSummary['sleepHours'] ?? 0.0) * 10).round(),
            maxScore: 100,
            color: _getSleepColor(healthSummary['sleepHours'] ?? 0.0),
            icon: Icons.bedtime,
            subtitle: _getSleepDescription(healthSummary['sleepHours'] ?? 0.0),
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionPrompt(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.health_and_safety,
            size: 48,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Enable Health Data',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Connect your health data to get personalized pacing recommendations based on your activity, sleep, and daily patterns.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _requestHealthPermissions(ref),
            icon: const Icon(Icons.link),
            label: const Text('Connect Health Data'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCards(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildLoadingCard(context)),
        const SizedBox(width: 12),
        Expanded(child: _buildLoadingCard(context)),
        const SizedBox(width: 12),
        Expanded(child: _buildLoadingCard(context)),
      ],
    );
  }

  Widget _buildLoadingCard(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Loading...',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCards(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Data Error',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Unable to load health data. Check permissions.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataCards(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No Health Data',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Health data will appear here once available.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _requestHealthPermissions(WidgetRef ref) {
    ref.read(requestHealthPermissionsProvider(null));
  }

  // Color and description helpers
  
  Color _getStepsColor(int steps) {
    if (steps >= 8000) return Colors.green;
    if (steps >= 5000) return Colors.orange;
    return Colors.red;
  }

  String _getStepsDescription(int steps) {
    if (steps >= 10000) return 'Excellent';
    if (steps >= 8000) return 'Great';
    if (steps >= 5000) return 'Good';
    if (steps >= 2000) return 'Light';
    return 'Low';
  }

  Color _getActivityColor(int activeMinutes) {
    if (activeMinutes >= 30) return Colors.green;
    if (activeMinutes >= 15) return Colors.orange;
    return Colors.red;
  }

  String _getActivityDescription(int activeMinutes) {
    if (activeMinutes >= 60) return 'Very Active';
    if (activeMinutes >= 30) return 'Active';
    if (activeMinutes >= 15) return 'Moderate';
    if (activeMinutes > 0) return 'Light';
    return 'Sedentary';
  }

  Color _getSleepColor(double sleepHours) {
    if (sleepHours >= 7.5) return Colors.green;
    if (sleepHours >= 6.5) return Colors.orange;
    return Colors.red;
  }

  String _getSleepDescription(double sleepHours) {
    if (sleepHours >= 8.5) return 'Excellent';
    if (sleepHours >= 7.5) return 'Good';
    if (sleepHours >= 6.5) return 'Fair';
    if (sleepHours >= 5.0) return 'Poor';
    if (sleepHours > 0) return 'Very Poor';
    return 'No Data';
  }
}