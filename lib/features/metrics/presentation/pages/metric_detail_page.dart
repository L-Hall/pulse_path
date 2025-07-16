import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import '../../domain/models/metric_info.dart';
import '../../../../shared/models/hrv_reading.dart';

/// Detailed page for individual HRV metrics with comprehensive educational content
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
    final statistics = _calculateStatistics(historicalValues);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(metricInfo.shortName),
        backgroundColor: metricInfo.color.withValues(alpha: 0.1),
        foregroundColor: metricInfo.color,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showEducationalDialog(context, metricInfo),
            tooltip: 'Learn more',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Value Card with enhanced interpretation
            _buildCurrentValueCard(context, metricInfo, currentValue),
            
            const SizedBox(height: 24),
            
            // Enhanced Trend Chart with reference lines
            _buildTrendChart(context, metricInfo, historicalValues),
            
            const SizedBox(height: 24),
            
            // Statistics Summary Card
            _buildStatisticsCard(context, metricInfo, statistics),
            
            const SizedBox(height: 24),
            
            // Metric Information with calculation formula
            _buildMetricInformation(context, metricInfo),
            
            const SizedBox(height: 24),
            
            // Ranges and Interpretation with visual gauge
            _buildRangesCard(context, metricInfo, currentValue),
            
            const SizedBox(height: 24),
            
            // Key Points with icons
            _buildKeyPointsCard(context, metricInfo),
            
            const SizedBox(height: 24),
            
            // Clinical Context Card
            _buildClinicalContextCard(context, metricInfo),
            
            const SizedBox(height: 24),
            
            // Related Metrics with navigation
            if (metricInfo.relatedMetrics.isNotEmpty)
              _buildRelatedMetricsCard(context, metricInfo),
              
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentValueCard(BuildContext context, MetricInfo metricInfo, double currentValue) {
    final interpretation = _getValueInterpretation(metricInfo, currentValue);
    final percentileRank = _calculatePercentileRank(currentValue, metricInfo);
    
    return Card(
      elevation: 2,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Top $percentileRank%',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildValueGauge(context, metricInfo, currentValue),
            const SizedBox(height: 16),
            Text(
              _getDetailedInterpretation(metricInfo, currentValue),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
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
    
    final minY = values.reduce((a, b) => a < b ? a : b) * 0.9;
    final maxY = values.reduce((a, b) => a > b ? a : b) * 1.1;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '7-Day Trend',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTrendIndicator(context, values),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  minY: minY,
                  maxY: maxY,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: (maxY - minY) / 5,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                        strokeWidth: 1,
                      );
                    },
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
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: metricInfo.color,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: metricInfo.color,
                            strokeWidth: 2,
                            strokeColor: Theme.of(context).colorScheme.surface,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: metricInfo.color.withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      if (metricInfo.optimalRange.min != null)
                        HorizontalLine(
                          y: metricInfo.optimalRange.min!,
                          color: Colors.green.withValues(alpha: 0.5),
                          strokeWidth: 2,
                          dashArray: [5, 5],
                          label: HorizontalLineLabel(
                            show: true,
                            labelResolver: (line) => 'Optimal',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      if (metricInfo.optimalRange.max != null)
                        HorizontalLine(
                          y: metricInfo.optimalRange.max!,
                          color: Colors.green.withValues(alpha: 0.5),
                          strokeWidth: 2,
                          dashArray: [5, 5],
                        ),
                    ],
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final daysAgo = values.length - 1 - spot.x.toInt();
                          final dateText = daysAgo == 0 ? 'Today' : '$daysAgo days ago';
                          return LineTooltipItem(
                            '$dateText\n${spot.y.toStringAsFixed(1)} ${metricInfo.unit}',
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

  // New methods for enhanced metric detail page
  
  MetricStatistics _calculateStatistics(List<double> values) {
    if (values.isEmpty) {
      return const MetricStatistics(
        mean: 0,
        min: 0,
        max: 0,
        stdDev: 0,
        trend: 0,
      );
    }
    
    final mean = values.reduce((a, b) => a + b) / values.length;
    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    
    double stdDev = 0;
    if (values.length > 1) {
      final variance = values.map((v) => math.pow(v - mean, 2)).reduce((a, b) => a + b) / values.length;
      stdDev = math.sqrt(variance);
    }
    
    // Calculate trend using simple linear regression
    double trend = 0;
    if (values.length > 2) {
      double sumX = 0, sumY = 0, sumXY = 0, sumX2 = 0;
      for (int i = 0; i < values.length; i++) {
        sumX += i;
        sumY += values[i];
        sumXY += i * values[i];
        sumX2 += i * i;
      }
      final n = values.length.toDouble();
      trend = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
    }
    
    return MetricStatistics(
      mean: mean,
      min: min,
      max: max,
      stdDev: stdDev,
      trend: trend,
    );
  }

  int _calculatePercentileRank(double value, MetricInfo metricInfo) {
    // Simple percentile calculation based on normal ranges
    final min = metricInfo.normalRange.min ?? 0;
    final max = metricInfo.normalRange.max ?? 100;
    final optimalMin = metricInfo.optimalRange.min ?? min;
    final optimalMax = metricInfo.optimalRange.max ?? max;
    
    if (value >= optimalMin && value <= optimalMax) {
      // In optimal range: 70-95th percentile
      return 70 + ((value - optimalMin) / (optimalMax - optimalMin) * 25).round();
    } else if (value >= min && value <= max) {
      // In normal range: 30-70th percentile
      if (value < optimalMin) {
        return 30 + ((value - min) / (optimalMin - min) * 40).round();
      } else {
        return 70 - ((value - optimalMax) / (max - optimalMax) * 40).round();
      }
    } else {
      // Outside normal range: 0-30th percentile
      if (value < min) {
        return math.max(5, 30 - ((min - value) / min * 25).round());
      } else {
        return math.max(5, 30 - ((value - max) / max * 25).round());
      }
    }
  }

  Widget _buildValueGauge(BuildContext context, MetricInfo metricInfo, double value) {
    final theme = Theme.of(context);
    final min = metricInfo.normalRange.min ?? 0;
    final max = metricInfo.normalRange.max ?? 100;
    final percentage = ((value - min) / (max - min)).clamp(0.0, 1.0);
    
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              if (metricInfo.optimalRange.min != null && metricInfo.optimalRange.max != null)
                Positioned(
                  left: ((metricInfo.optimalRange.min! - min) / (max - min) * 300).clamp(0.0, 300.0),
                  width: (((metricInfo.optimalRange.max! - metricInfo.optimalRange.min!) / (max - min)) * 300).clamp(0.0, 300.0),
                  top: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              Positioned(
                left: percentage * 280 + 10,
                top: 2,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: metricInfo.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: metricInfo.color.withValues(alpha: 0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              min.toStringAsFixed(0),
              style: theme.textTheme.bodySmall,
            ),
            Text(
              'Optimal Range',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              max.toStringAsFixed(0),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  String _getDetailedInterpretation(MetricInfo metricInfo, double value) {
    final interpretation = _getValueInterpretation(metricInfo, value);
    
    if (interpretation.label == 'Optimal') {
      return 'Your ${metricInfo.shortName} is in the optimal range, indicating ${_getPositiveOutcome(metricInfo)}.';
    } else if (interpretation.label == 'Normal') {
      return 'Your ${metricInfo.shortName} is within normal limits. ${_getImprovementSuggestion(metricInfo)}.';
    } else if (interpretation.label == 'Below Normal') {
      return 'Your ${metricInfo.shortName} is below typical values. ${_getLowValueImplication(metricInfo)}.';
    } else {
      return 'Your ${metricInfo.shortName} is above typical values. ${_getHighValueImplication(metricInfo)}.';
    }
  }

  String _getPositiveOutcome(MetricInfo metricInfo) {
    switch (metricInfo.shortName) {
      case 'RMSSD':
        return 'excellent parasympathetic function and recovery capacity';
      case 'HF':
        return 'strong vagal tone and stress resilience';
      case 'SDNN':
        return 'good overall autonomic balance';
      default:
        return 'healthy autonomic function';
    }
  }

  String _getImprovementSuggestion(MetricInfo metricInfo) {
    switch (metricInfo.category) {
      case MetricCategory.timeDomain:
        return 'Consider stress reduction and recovery practices to optimize this metric';
      case MetricCategory.frequencyDomain:
        return 'Breathing exercises may help improve frequency domain metrics';
      default:
        return 'Continue monitoring for trends';
    }
  }

  String _getLowValueImplication(MetricInfo metricInfo) {
    switch (metricInfo.shortName) {
      case 'RMSSD':
        return 'This may indicate reduced recovery capacity or high stress';
      case 'HF':
        return 'This suggests reduced parasympathetic activity';
      case 'SI':
        return 'Low stress index values are generally positive';
      default:
        return 'Consider lifestyle factors that may be affecting this metric';
    }
  }

  String _getHighValueImplication(MetricInfo metricInfo) {
    switch (metricInfo.shortName) {
      case 'SI':
        return 'This indicates elevated physiological stress';
      case 'LF/HF':
        return 'This may suggest sympathetic dominance';
      default:
        return 'Monitor for consistency and consult if concerned';
    }
  }

  Widget _buildTrendIndicator(BuildContext context, List<double> values) {
    if (values.length < 3) return const SizedBox.shrink();
    
    final recent = values.take(3).reduce((a, b) => a + b) / 3;
    final older = values.skip(values.length - 3).reduce((a, b) => a + b) / 3;
    final change = ((recent - older) / older * 100).abs();
    
    IconData icon;
    Color color;
    String text;
    
    if (recent > older * 1.05) {
      icon = Icons.trending_up;
      color = Colors.green;
      text = '+${change.toStringAsFixed(0)}%';
    } else if (recent < older * 0.95) {
      icon = Icons.trending_down;
      color = Colors.red;
      text = '-${change.toStringAsFixed(0)}%';
    } else {
      icon = Icons.trending_flat;
      color = Colors.grey;
      text = 'Stable';
    }
    
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _showEducationalDialog(BuildContext context, MetricInfo metricInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Understanding ${metricInfo.shortName}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Clinical Background',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(metricInfo.significance),
              const SizedBox(height: 16),
              Text(
                'How It\'s Calculated',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  metricInfo.calculation,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Clinical Research',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This metric has been validated in numerous clinical studies as an important marker of autonomic function and cardiovascular health.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
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

  Widget _buildStatisticsCard(BuildContext context, MetricInfo metricInfo, MetricStatistics stats) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Statistics Summary',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  context,
                  'Average',
                  '${stats.mean.toStringAsFixed(1)} ${metricInfo.unit}',
                  Icons.calculate,
                ),
                _buildStatItem(
                  context,
                  'Range',
                  '${stats.min.toStringAsFixed(0)}-${stats.max.toStringAsFixed(0)}',
                  Icons.straighten,
                ),
                _buildStatItem(
                  context,
                  'Std Dev',
                  stats.stdDev.toStringAsFixed(1),
                  Icons.scatter_plot,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Icon(
          icon,
          color: theme.colorScheme.primary.withValues(alpha: 0.7),
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildClinicalContextCard(BuildContext context, MetricInfo metricInfo) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.medical_information,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Clinical Context',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'What affects this metric?',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ..._getFactorsAffectingMetric(metricInfo).map((factor) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      factor,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tips_and_updates,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getImprovementTip(metricInfo),
                      style: theme.textTheme.bodySmall,
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

  List<String> _getFactorsAffectingMetric(MetricInfo metricInfo) {
    switch (metricInfo.category) {
      case MetricCategory.timeDomain:
        return [
          'Physical fitness and training status',
          'Sleep quality and duration',
          'Stress levels and mental state',
          'Hydration and nutrition',
          'Time of day and circadian rhythm',
        ];
      case MetricCategory.frequencyDomain:
        return [
          'Breathing patterns and rate',
          'Autonomic balance',
          'Physical activity level',
          'Emotional state',
          'Environmental factors',
        ];
      case MetricCategory.stress:
        return [
          'Psychological stress',
          'Physical fatigue',
          'Recovery status',
          'Training load',
          'Sleep deprivation',
        ];
      default:
        return [
          'Overall health status',
          'Lifestyle factors',
          'Environmental conditions',
          'Measurement conditions',
        ];
    }
  }

  String _getImprovementTip(MetricInfo metricInfo) {
    switch (metricInfo.shortName) {
      case 'RMSSD':
        return 'Regular meditation, quality sleep, and aerobic exercise can improve RMSSD over time.';
      case 'SI':
        return 'Stress management techniques and adequate recovery between training sessions help optimize the stress index.';
      case 'HF':
        return 'Deep breathing exercises and parasympathetic activation techniques can enhance HF power.';
      default:
        return 'Consistent healthy lifestyle habits typically improve HRV metrics over weeks to months.';
    }
  }
}

class ValueInterpretation {
  final String label;
  final Color color;

  const ValueInterpretation(this.label, this.color);
}

// Statistics helper class
class MetricStatistics {
  final double mean;
  final double min;
  final double max;
  final double stdDev;
  final double trend;
  
  const MetricStatistics({
    required this.mean,
    required this.min,
    required this.max,
    required this.stdDev,
    required this.trend,
  });
}