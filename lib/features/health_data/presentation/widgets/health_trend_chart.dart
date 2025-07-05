import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/health_data_provider.dart';
import '../../models/health_data_point.dart';

/// Chart widget that displays health data trends over time
class HealthTrendChart extends ConsumerWidget {
  final HealthMetricType metricType;
  final int days;

  const HealthTrendChart({
    super.key,
    required this.metricType,
    this.days = 7,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = DateTime.now().subtract(Duration(days: days - 1));
    final weeklyDataAsync = ref.watch(weeklyHealthDataProvider(startDate));

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: weeklyDataAsync.when(
                data: (weeklyData) => _buildChart(context, weeklyData),
                loading: () => _buildLoadingState(context),
                error: (error, stackTrace) => _buildErrorState(context, error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Icon(
          _getMetricIcon(),
          color: theme.colorScheme.primary,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          '${_getMetricTitle()} Trend ($days days)',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context, List<HealthDataSummary> weeklyData) {
    final spots = _generateSpots(weeklyData);
    final theme = Theme.of(context);

    if (spots.isEmpty) {
      return _buildEmptyState(context);
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _getGridInterval(),
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) => _buildBottomTitle(context, value.toInt()),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: _getLeftTitleInterval(),
              reservedSize: 50,
              getTitlesWidget: (value, meta) => _buildLeftTitle(context, value),
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: 0.3),
              width: 1,
            ),
            left: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
        minX: 0,
        maxX: (days - 1).toDouble(),
        minY: _getMinY(spots),
        maxY: _getMaxY(spots),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                _getMetricColor().withValues(alpha: 0.8),
                _getMetricColor(),
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                radius: 4,
                color: _getMetricColor(),
                strokeWidth: 2,
                strokeColor: theme.colorScheme.surface,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  _getMetricColor().withValues(alpha: 0.2),
                  _getMetricColor().withValues(alpha: 0.05),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                final value = touchedSpot.y;
                return LineTooltipItem(
                  _formatTooltipValue(value),
                  TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Unable to load trend data',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timeline,
            color: theme.colorScheme.outline,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'No ${_getMetricTitle().toLowerCase()} data',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Data will appear as you record ${_getMetricTitle().toLowerCase()}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomTitle(BuildContext context, int dayIndex) {
    final theme = Theme.of(context);
    final date = DateTime.now().subtract(Duration(days: days - 1 - dayIndex));
    final dayName = _getDayName(date.weekday);
    
    return Text(
      dayName,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildLeftTitle(BuildContext context, double value) {
    final theme = Theme.of(context);
    
    return Text(
      _formatLeftTitleValue(value),
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  List<FlSpot> _generateSpots(List<HealthDataSummary> weeklyData) {
    final spots = <FlSpot>[];
    
    for (int i = 0; i < weeklyData.length && i < days; i++) {
      final summary = weeklyData[i];
      final value = _getMetricValue(summary);
      if (value > 0) {
        spots.add(FlSpot(i.toDouble(), value));
      }
    }
    
    return spots;
  }

  double _getMetricValue(HealthDataSummary summary) {
    switch (metricType) {
      case HealthMetricType.steps:
        return summary.steps.toDouble();
      case HealthMetricType.sleep:
        return summary.sleepHours;
      case HealthMetricType.heartRate:
        return summary.averageHeartRate;
      case HealthMetricType.activeEnergy:
        return summary.activeEnergyBurned;
      case HealthMetricType.workouts:
        return summary.workouts.length.toDouble();
    }
  }

  String _getMetricTitle() {
    switch (metricType) {
      case HealthMetricType.steps:
        return 'Steps';
      case HealthMetricType.sleep:
        return 'Sleep';
      case HealthMetricType.heartRate:
        return 'Heart Rate';
      case HealthMetricType.activeEnergy:
        return 'Active Energy';
      case HealthMetricType.workouts:
        return 'Workouts';
    }
  }

  IconData _getMetricIcon() {
    switch (metricType) {
      case HealthMetricType.steps:
        return Icons.directions_walk;
      case HealthMetricType.sleep:
        return Icons.bedtime;
      case HealthMetricType.heartRate:
        return Icons.favorite;
      case HealthMetricType.activeEnergy:
        return Icons.local_fire_department;
      case HealthMetricType.workouts:
        return Icons.fitness_center;
    }
  }

  Color _getMetricColor() {
    switch (metricType) {
      case HealthMetricType.steps:
        return Colors.blue;
      case HealthMetricType.sleep:
        return Colors.indigo;
      case HealthMetricType.heartRate:
        return Colors.red;
      case HealthMetricType.activeEnergy:
        return Colors.orange;
      case HealthMetricType.workouts:
        return Colors.green;
    }
  }

  double _getGridInterval() {
    switch (metricType) {
      case HealthMetricType.steps:
        return 2000;
      case HealthMetricType.sleep:
        return 1;
      case HealthMetricType.heartRate:
        return 10;
      case HealthMetricType.activeEnergy:
        return 100;
      case HealthMetricType.workouts:
        return 1;
    }
  }

  double _getLeftTitleInterval() {
    switch (metricType) {
      case HealthMetricType.steps:
        return 5000;
      case HealthMetricType.sleep:
        return 2;
      case HealthMetricType.heartRate:
        return 20;
      case HealthMetricType.activeEnergy:
        return 200;
      case HealthMetricType.workouts:
        return 1;
    }
  }

  double _getMinY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0;
    final minValue = spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    
    switch (metricType) {
      case HealthMetricType.steps:
        return (minValue - 1000).clamp(0, double.infinity);
      case HealthMetricType.sleep:
        return (minValue - 1).clamp(0, double.infinity);
      case HealthMetricType.heartRate:
        return (minValue - 10).clamp(0, double.infinity);
      case HealthMetricType.activeEnergy:
        return (minValue - 50).clamp(0, double.infinity);
      case HealthMetricType.workouts:
        return 0;
    }
  }

  double _getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 100;
    final maxValue = spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    
    switch (metricType) {
      case HealthMetricType.steps:
        return maxValue + 1000;
      case HealthMetricType.sleep:
        return maxValue + 1;
      case HealthMetricType.heartRate:
        return maxValue + 10;
      case HealthMetricType.activeEnergy:
        return maxValue + 50;
      case HealthMetricType.workouts:
        return maxValue + 1;
    }
  }

  String _formatLeftTitleValue(double value) {
    switch (metricType) {
      case HealthMetricType.steps:
        return '${(value / 1000).toStringAsFixed(0)}k';
      case HealthMetricType.sleep:
        return '${value.toStringAsFixed(0)}h';
      case HealthMetricType.heartRate:
        return '${value.toStringAsFixed(0)}';
      case HealthMetricType.activeEnergy:
        return '${value.toStringAsFixed(0)}';
      case HealthMetricType.workouts:
        return '${value.toStringAsFixed(0)}';
    }
  }

  String _formatTooltipValue(double value) {
    switch (metricType) {
      case HealthMetricType.steps:
        return '${value.toStringAsFixed(0)} steps';
      case HealthMetricType.sleep:
        return '${value.toStringAsFixed(1)} hours';
      case HealthMetricType.heartRate:
        return '${value.toStringAsFixed(0)} BPM';
      case HealthMetricType.activeEnergy:
        return '${value.toStringAsFixed(0)} cal';
      case HealthMetricType.workouts:
        return '${value.toStringAsFixed(0)} workouts';
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}

/// Enum for different health metric types
enum HealthMetricType {
  steps,
  sleep,
  heartRate,
  activeEnergy,
  workouts,
}

/// Compact health trend chart for dashboard overview
class CompactHealthTrendChart extends ConsumerWidget {
  final HealthMetricType metricType;

  const CompactHealthTrendChart({
    super.key,
    required this.metricType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = DateTime.now().subtract(const Duration(days: 6));
    final weeklyDataAsync = ref.watch(weeklyHealthDataProvider(startDate));

    return SizedBox(
      height: 100,
      child: weeklyDataAsync.when(
        data: (weeklyData) => _buildCompactChart(context, weeklyData),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildCompactChart(BuildContext context, List<HealthDataSummary> weeklyData) {
    final spots = _generateSpots(weeklyData);
    final theme = Theme.of(context);

    if (spots.isEmpty) {
      return const SizedBox.shrink();
    }

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 6,
        minY: spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b) * 0.9,
        maxY: spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) * 1.1,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: _getMetricColor(),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: _getMetricColor().withValues(alpha: 0.1),
            ),
          ),
        ],
        lineTouchData: const LineTouchData(enabled: false),
      ),
    );
  }

  List<FlSpot> _generateSpots(List<HealthDataSummary> weeklyData) {
    final spots = <FlSpot>[];
    
    for (int i = 0; i < weeklyData.length && i < 7; i++) {
      final summary = weeklyData[i];
      final value = _getMetricValue(summary);
      if (value > 0) {
        spots.add(FlSpot(i.toDouble(), value));
      }
    }
    
    return spots;
  }

  double _getMetricValue(HealthDataSummary summary) {
    switch (metricType) {
      case HealthMetricType.steps:
        return summary.steps.toDouble();
      case HealthMetricType.sleep:
        return summary.sleepHours;
      case HealthMetricType.heartRate:
        return summary.averageHeartRate;
      case HealthMetricType.activeEnergy:
        return summary.activeEnergyBurned;
      case HealthMetricType.workouts:
        return summary.workouts.length.toDouble();
    }
  }

  Color _getMetricColor() {
    switch (metricType) {
      case HealthMetricType.steps:
        return Colors.blue;
      case HealthMetricType.sleep:
        return Colors.indigo;
      case HealthMetricType.heartRate:
        return Colors.red;
      case HealthMetricType.activeEnergy:
        return Colors.orange;
      case HealthMetricType.workouts:
        return Colors.green;
    }
  }
}