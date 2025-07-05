import 'package:flutter/material.dart';
import '../../domain/models/metric_info.dart';

/// Individual metric tile showing key information
class MetricTile extends StatelessWidget {
  final String metricKey;
  final MetricInfo metricInfo;
  final double currentValue;
  final VoidCallback onTap;

  const MetricTile({
    super.key,
    required this.metricKey,
    required this.metricInfo,
    required this.currentValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final interpretation = _getValueInterpretation();
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: metricInfo.color.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and interpretation
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: metricInfo.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      metricInfo.icon,
                      size: 16,
                      color: metricInfo.color,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: interpretation.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      interpretation.label,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: interpretation.color,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Metric name
              Text(
                metricInfo.shortName,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 4),
              
              // Current value
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Flexible(
                    child: Text(
                      currentValue.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: metricInfo.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    metricInfo.unit,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Tap indicator
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Tap for details',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ValueInterpretation _getValueInterpretation() {
    // Check if value is in optimal range
    if (_isInRange(currentValue, metricInfo.optimalRange)) {
      return const ValueInterpretation('Optimal', Colors.green);
    }
    
    // Check if value is in normal range
    if (_isInRange(currentValue, metricInfo.normalRange)) {
      return const ValueInterpretation('Normal', Colors.blue);
    }
    
    // Determine if below or above normal
    final normalMin = metricInfo.normalRange.min;
    if (normalMin != null && currentValue < normalMin) {
      return const ValueInterpretation('Low', Colors.orange);
    }
    
    return const ValueInterpretation('High', Colors.red);
  }

  bool _isInRange(double value, MetricRange range) {
    final min = range.min;
    final max = range.max;
    
    if (min != null && value < min) return false;
    if (max != null && value > max) return false;
    
    return true;
  }
}

class ValueInterpretation {
  final String label;
  final Color color;

  const ValueInterpretation(this.label, this.color);
}