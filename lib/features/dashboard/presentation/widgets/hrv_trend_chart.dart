import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/models/dashboard_data.dart';
import 'dart:math' as math;

/// Chart widget displaying HRV trend data over time
class HrvTrendChart extends StatefulWidget {
  final List<TrendPoint> trendPoints;
  final int days;
  final bool showAllScores;

  const HrvTrendChart({
    super.key,
    required this.trendPoints,
    this.days = 7,
    this.showAllScores = true,
  });

  @override
  State<HrvTrendChart> createState() => _HrvTrendChartState();
}

class _HrvTrendChartState extends State<HrvTrendChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _selectedMetric = 0; // 0: Recovery, 1: Stress, 2: Energy
  
  final List<String> _metricNames = ['Recovery', 'Stress', 'Energy'];
  final List<Color> _metricColors = [
    Colors.green,
    Colors.red,
    Colors.blue,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
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
    final theme = Theme.of(context);
    
    if (widget.trendPoints.isEmpty) {
      return _buildEmptyChart(context);
    }

    return Column(
      children: [
        // Metric selector
        if (widget.showAllScores) _buildMetricSelector(theme),
        
        // Chart
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.1),
              ),
            ),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LineChart(
                  _buildLineChartData(),
                  duration: const Duration(milliseconds: 250),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricSelector(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _metricNames.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedMetric = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _selectedMetric == index
                    ? _metricColors[index]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _metricColors[index],
                  width: 2,
                ),
              ),
              child: Text(
                _metricNames[index],
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: _selectedMetric == index
                      ? Colors.white
                      : _metricColors[index],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyChart(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timeline,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No data to display',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Take more readings to see trends',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _buildLineChartData() {
    final spots = _buildFlSpots();
    final theme = Theme.of(context);
    
    return LineChartData(
      gridData: FlGridData(
        drawVerticalLine: false,
        horizontalInterval: 25,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) => _buildBottomTitle(value, meta),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 25,
            reservedSize: 40,
            getTitlesWidget: (value, meta) => _buildLeftTitle(value, meta),
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: math.max(widget.days - 1, spots.length - 1).toDouble(),
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              _metricColors[_selectedMetric].withValues(alpha: 0.8),
              _metricColors[_selectedMetric],
            ],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
              radius: 4,
              color: _metricColors[_selectedMetric],
              strokeWidth: 2,
              strokeColor: theme.colorScheme.surface,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _metricColors[_selectedMetric].withValues(alpha: 0.2),
                _metricColors[_selectedMetric].withValues(alpha: 0.05),
              ],
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              final date = _getDateForSpot(spot.spotIndex);
              return LineTooltipItem(
                '${_metricNames[_selectedMetric]}: ${spot.y.round()}\n$date',
                TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  List<FlSpot> _buildFlSpots() {
    final sortedPoints = List<TrendPoint>.from(widget.trendPoints)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    final spots = <FlSpot>[];
    
    for (int i = 0; i < sortedPoints.length; i++) {
      final point = sortedPoints[i];
      double yValue;
      
      switch (_selectedMetric) {
        case 0: // Recovery
          yValue = point.recovery;
          break;
        case 1: // Stress
          yValue = point.stress;
          break;
        case 2: // Energy
          yValue = point.energy;
          break;
        default:
          yValue = point.recovery;
      }
      
      spots.add(FlSpot(i.toDouble(), yValue * _animation.value));
    }
    
    return spots;
  }

  Widget _buildBottomTitle(double value, TitleMeta meta) {
    final theme = Theme.of(context);
    final index = value.toInt();
    
    if (index < 0 || index >= widget.trendPoints.length) {
      return const SizedBox.shrink();
    }
    
    final date = widget.trendPoints[index].timestamp;
    final dayName = _getDayName(date.weekday);
    
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        dayName,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildLeftTitle(double value, TitleMeta meta) {
    final theme = Theme.of(context);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '${value.toInt()}',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getDateForSpot(int spotIndex) {
    if (spotIndex < 0 || spotIndex >= widget.trendPoints.length) {
      return '';
    }
    
    final date = widget.trendPoints[spotIndex].timestamp;
    return '${date.month}/${date.day}';
  }
}