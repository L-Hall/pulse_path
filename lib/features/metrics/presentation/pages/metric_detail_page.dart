import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/models/metric_info.dart';
import '../../../../shared/models/hrv_reading.dart';

/// Detailed page for individual HRV metrics
class MetricDetailPage extends StatelessWidget {
  final String metricKey;
  final List<HrvReading> readings;

  const MetricDetailPage({
    super.key,
    required this.metricKey,
    required this.readings,
  });

  @override
  Widget build(BuildContext context) {
    final metricInfo = HrvMetricData.getMetricInfo(metricKey);
    
    if (metricInfo == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Unknown Metric')),
        body: const Center(child: Text('Metric information not found')),
      );
    }

    final currentValue = _getCurrentValue(metricInfo);
    final historicalValues = _getHistoricalValues(metricInfo);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(metricInfo.shortName),
        backgroundColor: metricInfo.color.withValues(alpha: 0.1),
        foregroundColor: metricInfo.color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Value Card
            _buildCurrentValueCard(context, metricInfo, currentValue),
            
            const SizedBox(height: 24),
            
            // Trend Chart
            _buildTrendChart(context, metricInfo, historicalValues),
            
            const SizedBox(height: 24),
            
            // Metric Information
            _buildMetricInformation(context, metricInfo),
            
            const SizedBox(height: 24),
            
            // Ranges and Interpretation
            _buildRangesCard(context, metricInfo, currentValue),
            
            const SizedBox(height: 24),
            
            // Key Points
            _buildKeyPointsCard(context, metricInfo),
            
            const SizedBox(height: 24),
            
            // Related Metrics
            if (metricInfo.relatedMetrics.isNotEmpty)
              _buildRelatedMetricsCard(context, metricInfo),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentValueCard(BuildContext context, MetricInfo metricInfo, double currentValue) {
    final interpretation = _getValueInterpretation(metricInfo, currentValue);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: metricInfo.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    metricInfo.icon,
                    size: 32,
                    color: metricInfo.color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        metricInfo.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        HrvMetricData.getCategoryName(metricInfo.category),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  currentValue.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: metricInfo.color,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  metricInfo.unit,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: interpretation.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                interpretation.label,
                style: TextStyle(
                  color: interpretation.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendChart(BuildContext context, MetricInfo metricInfo, List<double> values) {
    if (values.length < 2) {
      return Card(
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(20),
          child: const Center(
            child: Text('Not enough data for trend analysis'),
          ),
        ),
      );
    }

    final spots = values.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '7-Day Trend',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    horizontalInterval: (values.reduce((a, b) => a > b ? a : b) - 
                        values.reduce((a, b) => a < b ? a : b)) / 4,
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(0),
                            style: Theme.of(context).textTheme.bodySmall,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          final daysAgo = values.length - 1 - value.toInt();
                          return Text(
                            daysAgo == 0 ? 'Today' : '${daysAgo}d ago',
                            style: Theme.of(context).textTheme.bodySmall,
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: metricInfo.color,
                      barWidth: 3,
                      dotData: FlDotData(
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: metricInfo.color,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: metricInfo.color.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            '${spot.y.toStringAsFixed(1)} ${metricInfo.unit}',
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricInformation(BuildContext context, MetricInfo metricInfo) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About This Metric',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              metricInfo.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Clinical Significance',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              metricInfo.significance,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Interpretation',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              metricInfo.interpretation,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRangesCard(BuildContext context, MetricInfo metricInfo, double currentValue) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reference Ranges',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Normal Range
            _buildRangeRow(
              context,
              'Normal Range',
              metricInfo.normalRange,
              Colors.blue,
              _isInRange(currentValue, metricInfo.normalRange),
            ),
            
            const SizedBox(height: 12),
            
            // Optimal Range
            _buildRangeRow(
              context,
              'Optimal Range',
              metricInfo.optimalRange,
              Colors.green,
              _isInRange(currentValue, metricInfo.optimalRange),
            ),
            
            const SizedBox(height: 16),
            
            // Current value indicator
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.my_location,
                    color: metricInfo.color,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Your current value: ${currentValue.toStringAsFixed(1)} ${metricInfo.unit}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRangeRow(BuildContext context, String title, MetricRange range, Color color, bool isInRange) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: isInRange
              ? Icon(Icons.check, size: 10, color: color)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _formatRange(range),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              if (range.description.isNotEmpty)
                Text(
                  range.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKeyPointsCard(BuildContext context, MetricInfo metricInfo) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Points',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...metricInfo.keyPoints.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: metricInfo.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      point,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedMetricsCard(BuildContext context, MetricInfo metricInfo) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Related Metrics',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: metricInfo.relatedMetrics.map((relatedKey) {
                final relatedInfo = HrvMetricData.getMetricInfo(relatedKey);
                if (relatedInfo == null) return const SizedBox.shrink();
                
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: relatedInfo.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    relatedInfo.shortName,
                    style: TextStyle(
                      color: relatedInfo.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  double _getCurrentValue(MetricInfo metricInfo) {
    if (readings.isEmpty) return 0.0;
    
    final latest = readings.last;
    switch (metricKey) {
      case 'rmssd':
        return latest.metrics.rmssd;
      case 'meanRr':
        return latest.metrics.meanRr;
      case 'sdnn':
        return latest.metrics.sdnn;
      case 'lowFrequency':
        return latest.metrics.lowFrequency;
      case 'highFrequency':
        return latest.metrics.highFrequency;
      case 'lfHfRatio':
        return latest.metrics.lfHfRatio;
      case 'baevsky':
        return latest.metrics.baevsky;
      case 'coefficientOfVariance':
        return latest.metrics.coefficientOfVariance;
      case 'mxdmn':
        return latest.metrics.mxdmn;
      case 'moda':
        return latest.metrics.moda;
      case 'amo50':
        return latest.metrics.amo50;
      case 'pnn50':
        return latest.metrics.pnn50;
      case 'pnn20':
        return latest.metrics.pnn20;
      case 'totalPower':
        return latest.metrics.totalPower;
      case 'dfaAlpha1':
        return latest.metrics.dfaAlpha1;
      default:
        return 0.0;
    }
  }

  List<double> _getHistoricalValues(MetricInfo metricInfo) {
    return readings.map((reading) {
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
    }).toList();
  }

  ValueInterpretation _getValueInterpretation(MetricInfo metricInfo, double value) {
    if (_isInRange(value, metricInfo.optimalRange)) {
      return const ValueInterpretation('Optimal', Colors.green);
    } else if (_isInRange(value, metricInfo.normalRange)) {
      return const ValueInterpretation('Normal', Colors.blue);
    } else if (value < (metricInfo.normalRange.min ?? 0)) {
      return const ValueInterpretation('Below Normal', Colors.orange);
    } else {
      return const ValueInterpretation('Above Normal', Colors.red);
    }
  }

  bool _isInRange(double value, MetricRange range) {
    final min = range.min;
    final max = range.max;
    
    if (min != null && value < min) return false;
    if (max != null && value > max) return false;
    
    return true;
  }

  String _formatRange(MetricRange range) {
    if (range.min != null && range.max != null) {
      return '${range.min!.toStringAsFixed(1)} - ${range.max!.toStringAsFixed(1)}';
    } else if (range.min != null) {
      return '> ${range.min!.toStringAsFixed(1)}';
    } else if (range.max != null) {
      return '< ${range.max!.toStringAsFixed(1)}';
    } else {
      return 'No specific range';
    }
  }
}

class ValueInterpretation {
  final String label;
  final Color color;

  const ValueInterpretation(this.label, this.color);
}