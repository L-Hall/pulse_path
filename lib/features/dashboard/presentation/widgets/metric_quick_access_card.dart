import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/liquid_glass_container.dart';
import '../../../metrics/domain/models/metric_info.dart';
import '../../../metrics/presentation/pages/metric_detail_page.dart';
import '../../../../shared/models/hrv_reading.dart';
import '../providers/dashboard_providers.dart';

/// Quick access card for individual HRV metrics with navigation to detail page
class MetricQuickAccessCard extends ConsumerWidget {
  const MetricQuickAccessCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardData = ref.watch(smartDashboardDataProvider);
    
    return dashboardData.when(
      data: (data) => _buildMetricCards(context, data.trendReadings),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildMetricCards(BuildContext context, List<HrvReading> readings) {
    if (readings.isEmpty) return const SizedBox.shrink();
    
    final theme = Theme.of(context);
    final latestReading = readings.last;
    
    // Select key metrics to display
    final keyMetrics = ['rmssd', 'sdnn', 'lfHfRatio', 'baevsky'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Key Metrics',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => _navigateToAllMetrics(context, readings),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: keyMetrics.length,
          itemBuilder: (context, index) {
            final metricKey = keyMetrics[index];
            final metricInfo = HrvMetricData.getMetricInfo(metricKey);
            if (metricInfo == null) return const SizedBox.shrink();
            
            final value = _getMetricValue(latestReading, metricKey);
            
            return _buildMetricTile(
              context,
              metricInfo,
              value,
              readings,
            );
          },
        ),
      ],
    );
  }

  Widget _buildMetricTile(
    BuildContext context,
    MetricInfo metricInfo,
    double value,
    List<HrvReading> readings,
  ) {
    final theme = Theme.of(context);
    final interpretation = _getSimpleInterpretation(metricInfo, value);
    
    return GestureDetector(
      onTap: () => _navigateToMetricDetail(context, metricInfo, readings),
      child: LiquidGlassContainer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    metricInfo.icon,
                    color: metricInfo.color,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      metricInfo.shortName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value.toStringAsFixed(1),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: metricInfo.color,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    metricInfo.unit,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: interpretation.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    interpretation.label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getMetricValue(HrvReading reading, String metricKey) {
    switch (metricKey) {
      case 'rmssd':
        return reading.metrics.rmssd;
      case 'meanRr':
        return reading.metrics.meanRr;
      case 'sdnn':
        return reading.metrics.sdnn;
      case 'lowFrequency':
        return reading.metrics.lowFrequency;
      case 'highFrequency':
        return reading.metrics.highFrequency;
      case 'lfHfRatio':
        return reading.metrics.lfHfRatio;
      case 'baevsky':
        return reading.metrics.baevsky;
      case 'coefficientOfVariance':
        return reading.metrics.coefficientOfVariance;
      case 'mxdmn':
        return reading.metrics.mxdmn;
      case 'moda':
        return reading.metrics.moda;
      case 'amo50':
        return reading.metrics.amo50;
      case 'pnn50':
        return reading.metrics.pnn50;
      case 'pnn20':
        return reading.metrics.pnn20;
      case 'totalPower':
        return reading.metrics.totalPower;
      case 'dfaAlpha1':
        return reading.metrics.dfaAlpha1;
      default:
        return 0.0;
    }
  }

  _SimpleInterpretation _getSimpleInterpretation(MetricInfo metricInfo, double value) {
    if (metricInfo.optimalRange.min != null && 
        metricInfo.optimalRange.max != null &&
        value >= metricInfo.optimalRange.min! && 
        value <= metricInfo.optimalRange.max!) {
      return const _SimpleInterpretation('Optimal', Colors.green);
    } else if (metricInfo.normalRange.min != null && 
               metricInfo.normalRange.max != null &&
               value >= metricInfo.normalRange.min! && 
               value <= metricInfo.normalRange.max!) {
      return const _SimpleInterpretation('Normal', Colors.blue);
    } else {
      return const _SimpleInterpretation('Check', Colors.orange);
    }
  }

  void _navigateToMetricDetail(
    BuildContext context,
    MetricInfo metricInfo,
    List<HrvReading> readings,
  ) {
    final metricKey = HrvMetricData.metrics.entries
        .firstWhere((entry) => entry.value == metricInfo)
        .key;
    
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => MetricDetailPage(
          metricKey: metricKey,
          readings: readings,
        ),
      ),
    );
  }

  void _navigateToAllMetrics(BuildContext context, List<HrvReading> readings) {
    Navigator.of(context).pushNamed('/metrics');
  }
}

class _SimpleInterpretation {
  final String label;
  final Color color;
  
  const _SimpleInterpretation(this.label, this.color);
}