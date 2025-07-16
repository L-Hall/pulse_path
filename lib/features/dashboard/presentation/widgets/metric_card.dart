import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../hrv/domain/services/hrv_baseline_service.dart';

/// Reusable metric card widget for displaying HRV metrics with baseline comparison
class MetricCard extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final double? baseline;
  final Range? normalRange;
  final List<double>? sparklineData;
  final String? description;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;
  final bool showTrend;
  final bool showBaseline;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.unit = '',
    this.baseline,
    this.normalRange,
    this.sparklineData,
    this.description,
    this.icon,
    this.color,
    this.onTap,
    this.showTrend = true,
    this.showBaseline = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayColor = color ?? theme.colorScheme.primary;
    final percentageOfBaseline = baseline != null ? (value / baseline!) * 100 : null;
    final isInNormalRange = normalRange?.contains(value) ?? true;

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
              // Header row
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: displayColor, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (onTap != null)
                    Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // Value and baseline
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value.toStringAsFixed(1),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: displayColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (unit.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Text(
                      unit,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const Spacer(),
                  if (percentageOfBaseline != null && showBaseline) ...[
                    _buildPercentageChip(context, percentageOfBaseline),
                  ],
                ],
              ),

              // Baseline comparison
              if (baseline != null && showBaseline) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Baseline: ${baseline!.toStringAsFixed(1)}$unit',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildTrendIcon(percentageOfBaseline!),
                  ],
                ),
              ],

              // Normal range indicator
              if (normalRange != null) ...[
                const SizedBox(height: 8),
                _buildNormalRangeIndicator(context, isInNormalRange),
              ],

              // Sparkline chart
              if (sparklineData != null && sparklineData!.isNotEmpty && showTrend) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: _buildSparkline(context),
                ),
              ],

              // Description
              if (description != null) ...[
                const SizedBox(height: 12),
                Text(
                  description!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPercentageChip(BuildContext context, double percentage) {
    final theme = Theme.of(context);
    final color = _getPercentageColor(percentage);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        '${percentage.toStringAsFixed(0)}%',
        style: theme.textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTrendIcon(double percentage) {
    if (percentage >= 110) {
      return const Icon(Icons.trending_up, color: Colors.green, size: 16);
    } else if (percentage >= 90) {
      return const Icon(Icons.trending_flat, color: Colors.orange, size: 16);
    } else {
      return const Icon(Icons.trending_down, color: Colors.red, size: 16);
    }
  }

  Widget _buildNormalRangeIndicator(BuildContext context, bool isInRange) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Icon(
          isInRange ? Icons.check_circle : Icons.warning,
          color: isInRange ? Colors.green : Colors.orange,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          isInRange ? 'Normal range' : 'Outside normal range',
          style: theme.textTheme.bodySmall?.copyWith(
            color: isInRange ? Colors.green : Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildSparkline(BuildContext context) {
    final theme = Theme.of(context);
    final displayColor = color ?? theme.colorScheme.primary;
    
    // Calculate baseline Y value for dashed line
    final minValue = sparklineData!.reduce((a, b) => a < b ? a : b);
    final maxValue = sparklineData!.reduce((a, b) => a > b ? a : b);
    final range = maxValue - minValue;
    final baselineY = baseline != null && range > 0
        ? ((baseline! - minValue) / range).clamp(0.0, 1.0)
        : null;

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: sparklineData!
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value))
                .toList(),
            isCurved: true,
            color: displayColor,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: displayColor.withValues(alpha: 0.1),
            ),
          ),
        ],
        extraLinesData: baselineY != null && showBaseline
            ? ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: baseline!,
                    color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                    label: HorizontalLineLabel(
                      show: false,
                    ),
                  ),
                ],
              )
            : null,
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        lineTouchData: const LineTouchData(enabled: false),
      ),
    );
  }

  Color _getPercentageColor(double percentage) {
    if (percentage >= 110) return Colors.green;
    if (percentage >= 90) return Colors.orange;
    return Colors.red;
  }
}

/// Compact metric card for secondary metrics
class CompactMetricCard extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;

  const CompactMetricCard({
    super.key,
    required this.title,
    required this.value,
    this.unit = '',
    this.icon,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayColor = color ?? theme.colorScheme.primary;

    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: displayColor, size: 16),
                    const SizedBox(width: 4),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value.toStringAsFixed(1),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: displayColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (unit.isNotEmpty) ...[
                    const SizedBox(width: 2),
                    Text(
                      unit,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}