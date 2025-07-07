import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_providers.dart';
import '../../data/repositories/hrv_repository_interface.dart';

/// Widget that displays whether the dashboard shows real user data or sample data
class DataSourceIndicator extends ConsumerWidget {
  final bool isCompact;
  final VoidCallback? onTap;

  const DataSourceIndicator({
    super.key,
    this.isCompact = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dataSourceAsync = ref.watch(dataSourceBreakdownProvider);

    return dataSourceAsync.when(
      data: (breakdown) => _buildIndicator(context, breakdown),
      loading: () => _buildLoadingIndicator(context),
      error: (error, stack) => _buildErrorIndicator(context),
    );
  }

  Widget _buildIndicator(BuildContext context, DataSourceBreakdown breakdown) {
    final theme = Theme.of(context);
    
    if (isCompact) {
      return _buildCompactIndicator(context, breakdown, theme);
    } else {
      return _buildFullIndicator(context, breakdown, theme);
    }
  }

  Widget _buildCompactIndicator(BuildContext context, DataSourceBreakdown breakdown, ThemeData theme) {
    final isRealData = breakdown.hasAnyRealData;
    final icon = isRealData ? Icons.verified_user : Icons.science;
    final color = isRealData ? Colors.green : Colors.orange;
    final label = isRealData ? 'Your Data' : 'Sample Data';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullIndicator(BuildContext context, DataSourceBreakdown breakdown, ThemeData theme) {
    final hasAnyReal = breakdown.hasAnyRealData;
    final hasMixed = hasAnyReal && breakdown.sampleDataCount > 0;
    final onlyReal = hasAnyReal && breakdown.sampleDataCount == 0;
    final onlySample = !hasAnyReal && breakdown.sampleDataCount > 0;

    Color primaryColor;
    IconData primaryIcon;
    String title;
    String subtitle;

    if (onlyReal) {
      primaryColor = Colors.green;
      primaryIcon = Icons.verified_user;
      title = 'Your Data Only';
      subtitle = '${breakdown.realDataCount} real readings captured';
    } else if (onlySample) {
      primaryColor = Colors.orange;
      primaryIcon = Icons.science;
      title = 'Sample Data';
      subtitle = 'Take your first reading to see real data';
    } else if (hasMixed) {
      primaryColor = Colors.blue;
      primaryIcon = Icons.analytics;
      title = 'Mixed Data';
      subtitle = '${breakdown.realDataCount} real + ${breakdown.sampleDataCount} sample readings';
    } else {
      primaryColor = Colors.grey;
      primaryIcon = Icons.help_outline;
      title = 'No Data';
      subtitle = 'Start by capturing your first reading';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(primaryIcon, color: primaryColor, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasMixed) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${breakdown.realDataPercentage.toStringAsFixed(0)}% real',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (hasMixed) ...[
              const SizedBox(height: 12),
              _buildDataBreakdownBar(context, breakdown, theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDataBreakdownBar(BuildContext context, DataSourceBreakdown breakdown, ThemeData theme) {
    final realPercentage = breakdown.realDataPercentage / 100;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data composition:',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.grey.withOpacity(0.2),
          ),
          child: Row(
            children: [
              if (realPercentage > 0)
                Expanded(
                  flex: (realPercentage * 100).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(3),
                        bottomLeft: const Radius.circular(3),
                        topRight: realPercentage == 1.0 ? const Radius.circular(3) : Radius.zero,
                        bottomRight: realPercentage == 1.0 ? const Radius.circular(3) : Radius.zero,
                      ),
                    ),
                  ),
                ),
              if (realPercentage < 1.0)
                Expanded(
                  flex: ((1.0 - realPercentage) * 100).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(3),
                        bottomRight: const Radius.circular(3),
                        topLeft: realPercentage == 0.0 ? const Radius.circular(3) : Radius.zero,
                        bottomLeft: realPercentage == 0.0 ? const Radius.circular(3) : Radius.zero,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Real (${breakdown.realDataCount})',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Sample (${breakdown.sampleDataCount})',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
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

  Widget _buildErrorIndicator(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 16,
            color: theme.colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 8),
          Text(
            'Unknown',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onErrorContainer,
            ),
          ),
        ],
      ),
    );
  }
}