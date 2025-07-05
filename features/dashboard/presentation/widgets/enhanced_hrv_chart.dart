import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/models/dashboard_data.dart';
import '../../../../shared/models/hrv_reading.dart';
import 'dart:math' as math;

/// Enhanced HRV chart with multiple visualization options
class EnhancedHrvChart extends StatefulWidget {
  final List<TrendPoint> trendPoints;
  final List<HrvReading> readings;
  final int days;

  const EnhancedHrvChart({
    super.key,
    required this.trendPoints,
    required this.readings,
    this.days = 7,
  });

  @override
  State<EnhancedHrvChart> createState() => _EnhancedHrvChartState();
}

class _EnhancedHrvChartState extends State<EnhancedHrvChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  ChartViewType _viewType = ChartViewType.scores;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with controls
            _buildChartHeader(context),
            
            const SizedBox(height: 16),
            
            // Chart content
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return SizedBox(
                  height: 280,
                  child: _buildChart(context),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Legend and insights
            _buildChartLegend(context),
          ],
        ),
      ),
    );
  }

  Widget _buildChartHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HRV Analysis',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _getViewTypeDescription(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        
        // View type selector
        SegmentedButton<ChartViewType>(
          segments: const [
            ButtonSegment(
              value: ChartViewType.scores,
              label: Text('Scores', style: TextStyle(fontSize: 12)),
              icon: Icon(Icons.assessment, size: 16),
            ),
            ButtonSegment(
              value: ChartViewType.metrics,
              label: Text('Metrics', style: TextStyle(fontSize: 12)),
              icon: Icon(Icons.analytics, size: 16),
            ),
            ButtonSegment(
              value: ChartViewType.comparison,
              label: Text('Compare', style: TextStyle(fontSize: 12)),
              icon: Icon(Icons.compare_arrows, size: 16),
            ),
          ],
          selected: {_viewType},
          onSelectionChanged: (Set<ChartViewType> selection) {
            setState(() {
              _viewType = selection.first;
              _animationController.reset();
              _animationController.forward();
            });
          },
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context) {
    switch (_viewType) {
      case ChartViewType.scores:
        return _buildScoresChart(context);
      case ChartViewType.metrics:
        return _buildMetricsChart(context);
      case ChartViewType.comparison:
        return _buildComparisonChart(context);
    }
  }

  Widget _buildScoresChart(BuildContext context) {
    if (widget.trendPoints.isEmpty) {
      return _buildEmptyChart('No score data available');
    }

    final recoverySpots = widget.trendPoints.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.recovery * _animation.value);
    }).toList();

    final stressSpots = widget.trendPoints.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.stress * _animation.value);
    }).toList();

    final energySpots = widget.trendPoints.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.energy * _animation.value);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: _buildGridData(),
        titlesData: _buildTitlesData(),
        borderData: _buildBorderData(),
        lineBarsData: [
          _buildLineBarData(recoverySpots, Colors.green, 'Recovery'),
          _buildLineBarData(stressSpots, Colors.red, 'Stress'),
          _buildLineBarData(energySpots, Colors.blue, 'Energy'),
        ],
        minY: 0,
        maxY: 100,
        lineTouchData: _buildLineTouchData(),
      ),
    );
  }

  Widget _buildMetricsChart(BuildContext context) {
    if (widget.readings.isEmpty) {
      return _buildEmptyChart('No metric data available');
    }

    final rmssdSpots = widget.readings.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.metrics.rmssd * _animation.value);
    }).toList();

    final sdnnSpots = widget.readings.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.metrics.sdnn * _animation.value);
    }).toList();

    final maxRmssd = widget.readings.map((r) => r.metrics.rmssd).reduce(math.max);
    final maxSdnn = widget.readings.map((r) => r.metrics.sdnn).reduce(math.max);
    final maxY = math.max(maxRmssd, maxSdnn) * 1.1;

    return LineChart(
      LineChartData(
        gridData: _buildGridData(),
        titlesData: _buildTitlesData(),
        borderData: _buildBorderData(),
        lineBarsData: [
          _buildLineBarData(rmssdSpots, Colors.purple, 'RMSSD'),
          _buildLineBarData(sdnnSpots, Colors.orange, 'SDNN'),
        ],
        minY: 0,
        maxY: maxY,
        lineTouchData: _buildLineTouchData(),
      ),
    );
  }

  Widget _buildComparisonChart(BuildContext context) {
    if (widget.readings.length < 2) {
      return _buildEmptyChart('Need at least 2 readings for comparison');
    }

    // Show recovery score vs RMSSD correlation
    final spots = widget.readings.asMap().entries.map((entry) {
      final reading = entry.value;
      return FlSpot(
        reading.metrics.rmssd * _animation.value,
        reading.scores.recovery.toDouble() * _animation.value,
      );
    }).toList();

    final maxRmssd = widget.readings.map((r) => r.metrics.rmssd).reduce(math.max);

    return ScatterChart(
      ScatterChartData(
        scatterSpots: spots.map((spot) => ScatterSpot(
          spot.x,
          spot.y,
        ),).toList(),
        minX: 0,
        maxX: maxRmssd * 1.1,
        minY: 0,
        maxY: 100,
        gridData: _buildGridData(),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) => Text(
                '${value.toInt()}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            axisNameWidget: Text(
              'Recovery Score',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) => Text(
                '${value.toInt()}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            axisNameWidget: Text(
              'RMSSD (ms)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: _buildBorderData(),
      ),
    );
  }

  Widget _buildEmptyChart(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart,
            size: 48,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(BuildContext context) {
    switch (_viewType) {
      case ChartViewType.scores:
        return _buildScoresLegend(context);
      case ChartViewType.metrics:
        return _buildMetricsLegend(context);
      case ChartViewType.comparison:
        return _buildComparisonLegend(context);
    }
  }

  Widget _buildScoresLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildLegendItem(context, Colors.green, 'Recovery', 'Rest & digest'),
        _buildLegendItem(context, Colors.red, 'Stress', 'Fight or flight'),
        _buildLegendItem(context, Colors.blue, 'Energy', 'Available reserves'),
      ],
    );
  }

  Widget _buildMetricsLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildLegendItem(context, Colors.purple, 'RMSSD', 'Parasympathetic activity'),
        _buildLegendItem(context, Colors.orange, 'SDNN', 'Overall variability'),
      ],
    );
  }

  Widget _buildComparisonLegend(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recovery Score vs RMSSD Correlation',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Each dot represents a reading. Strong correlation indicates consistent HRV patterns.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String title, String subtitle) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Helper methods for chart styling
  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      getDrawingHorizontalLine: (value) => FlLine(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        strokeWidth: 1,
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (value, meta) => Text(
            '${value.toInt()}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
            final dayIndex = value.toInt();
            if (dayIndex >= 0 && dayIndex < widget.trendPoints.length) {
              final timestamp = widget.trendPoints[dayIndex].timestamp;
              return Text(
                '${timestamp.day}/${timestamp.month}',
                style: Theme.of(context).textTheme.bodySmall,
              );
            }
            return const Text('');
          },
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  FlBorderData _buildBorderData() {
    return FlBorderData(
      show: true,
      border: Border.all(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
      ),
    );
  }

  LineChartBarData _buildLineBarData(List<FlSpot> spots, Color color, String label) {
    return LineChartBarData(
      spots: spots,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4,
            color: color,
            strokeWidth: 2,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.3),
            color.withValues(alpha: 0.05),
          ],
        ),
      ),
    );
  }

  LineTouchData _buildLineTouchData() {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            return LineTooltipItem(
              spot.y.toStringAsFixed(1),
              TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            );
          }).toList();
        },
      ),
    );
  }


  String _getViewTypeDescription() {
    switch (_viewType) {
      case ChartViewType.scores:
        return 'Recovery, stress, and energy trends over time';
      case ChartViewType.metrics:
        return 'Raw HRV metrics (RMSSD, SDNN) analysis';
      case ChartViewType.comparison:
        return 'Correlation between recovery scores and RMSSD';
    }
  }
}

enum ChartViewType {
  scores,
  metrics,
  comparison,
}