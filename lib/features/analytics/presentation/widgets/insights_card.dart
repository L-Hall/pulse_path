import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/liquid_glass_container.dart';
import '../../domain/services/insights_engine.dart';
import '../providers/insights_provider.dart';

/// A card that displays personalized insights based on HRV analytics
class InsightsCard extends ConsumerWidget {
  const InsightsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightsAsync = ref.watch(weeklyInsightsProvider);
    
    return insightsAsync.when(
      data: (insights) => _buildInsightsCard(context, insights),
      loading: () => _buildLoadingCard(context),
      error: (error, stack) => _buildErrorCard(context, error),
    );
  }

  Widget _buildInsightsCard(BuildContext context, ComprehensiveInsights insights) {
    final theme = Theme.of(context);
    
    // Filter to show only high importance insights
    final importantStatistical = insights.statisticalInsights
        .where((i) => i.importance == ImportanceLevel.high)
        .take(2)
        .toList();
    
    final importantPatterns = insights.patternInsights
        .where((i) => i.importance == ImportanceLevel.high)
        .take(2)
        .toList();
    
    final hasInsights = importantStatistical.isNotEmpty || importantPatterns.isNotEmpty;
    
    return LiquidGlassContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.insights,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Weekly Insights',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              insights.summary,
              style: theme.textTheme.bodyMedium,
            ),
            if (hasInsights) ...[
              const SizedBox(height: 16),
              if (importantStatistical.isNotEmpty) ...[
                _buildInsightSection(
                  context,
                  'Key Findings',
                  importantStatistical
                      .map((i) => _buildInsightItem(context, i.title, i.description))
                      .toList(),
                ),
                const SizedBox(height: 12),
              ],
              if (importantPatterns.isNotEmpty) ...[
                _buildInsightSection(
                  context,
                  'Patterns Detected',
                  importantPatterns
                      .map((i) => _buildPatternItem(context, i))
                      .toList(),
                ),
                const SizedBox(height: 12),
              ],
            ],
            if (insights.recommendations.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildRecommendations(context, insights.recommendations.take(2).toList()),
            ],
            const SizedBox(height: 12),
            _buildViewDetailsButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightSection(BuildContext context, String title, List<Widget> items) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        ...items,
      ],
    );
  }

  Widget _buildInsightItem(BuildContext context, String title, String description) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            size: 8,
            color: theme.colorScheme.primary.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
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

  Widget _buildPatternItem(BuildContext context, PatternInsight pattern) {
    final theme = Theme.of(context);
    final confidence = (pattern.confidence * 100).toInt();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _getPatternIcon(pattern.type),
            size: 16,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        pattern.title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      '$confidence% confidence',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  pattern.description,
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

  Widget _buildRecommendations(BuildContext context, List<String> recommendations) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
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
                Icons.lightbulb_outline,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Recommendations',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...recommendations.map((rec) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  rec,
                  style: theme.textTheme.bodySmall,
                ),
              ),),
        ],
      ),
    );
  }

  Widget _buildViewDetailsButton(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: TextButton(
        onPressed: () {
          // TODO: Navigate to full insights page
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'View All Insights',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_forward,
              size: 16,
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context) {
    return const LiquidGlassContainer(
      child: Padding(
        padding: EdgeInsets.all(48.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context, Object error) {
    final theme = Theme.of(context);
    
    return LiquidGlassContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 8),
            Text(
              'Unable to load insights',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Please try again later',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPatternIcon(PatternType type) {
    switch (type) {
      case PatternType.weekly:
        return Icons.calendar_month;
      case PatternType.timeOfDay:
        return Icons.schedule;
      case PatternType.trend:
        return Icons.trending_up;
      case PatternType.recovery:
        return Icons.favorite;
      case PatternType.anomaly:
        return Icons.warning_amber;
    }
  }
}