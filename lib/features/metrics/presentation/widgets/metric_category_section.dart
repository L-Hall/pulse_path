import 'package:flutter/material.dart';
import '../../domain/models/metric_info.dart';
import 'metric_tile.dart';

/// Widget displaying a category of HRV metrics
class MetricCategorySection extends StatelessWidget {
  final MetricCategory category;
  final List<MapEntry<String, MetricInfo>> metrics;
  final void Function(String metricKey) onMetricTap;

  const MetricCategorySection({
    super.key,
    required this.category,
    required this.metrics,
    required this.onMetricTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getCategoryColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCategoryIcon(),
                    color: _getCategoryColor(),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        HrvMetricData.getCategoryName(category),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        HrvMetricData.getCategoryDescription(category),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Metrics Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: metrics.length,
              itemBuilder: (context, index) {
                final entry = metrics[index];
                return MetricTile(
                  metricKey: entry.key,
                  metricInfo: entry.value,
                  currentValue: _getCurrentValue(entry.key), // Mock value for now
                  onTap: () => onMetricTap(entry.key),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (category) {
      case MetricCategory.timeDomain:
        return Colors.blue;
      case MetricCategory.frequencyDomain:
        return Colors.purple;
      case MetricCategory.nonLinear:
        return Colors.teal;
      case MetricCategory.geometric:
        return Colors.orange;
      case MetricCategory.stress:
        return Colors.red;
    }
  }

  IconData _getCategoryIcon() {
    switch (category) {
      case MetricCategory.timeDomain:
        return Icons.timeline;
      case MetricCategory.frequencyDomain:
        return Icons.equalizer;
      case MetricCategory.nonLinear:
        return Icons.insights;
      case MetricCategory.geometric:
        return Icons.show_chart;
      case MetricCategory.stress:
        return Icons.psychology;
    }
  }

  double _getCurrentValue(String metricKey) {
    // TODO: Get actual current value from data provider
    // For now, return mock values based on metric type
    switch (metricKey) {
      case 'rmssd':
        return 35.2;
      case 'meanRr':
        return 892.0;
      case 'sdnn':
        return 45.3;
      case 'lowFrequency':
        return 245.0;
      case 'highFrequency':
        return 187.0;
      case 'lfHfRatio':
        return 1.31;
      case 'baevsky':
        return 89.0;
      case 'coefficientOfVariance':
        return 5.1;
      case 'mxdmn':
        return 234.0;
      case 'moda':
        return 885.0;
      case 'amo50':
        return 32.0;
      case 'pnn50':
        return 18.5;
      case 'pnn20':
        return 45.2;
      case 'totalPower':
        return 1876.0;
      case 'dfaAlpha1':
        return 1.12;
      default:
        return 0.0;
    }
  }
}