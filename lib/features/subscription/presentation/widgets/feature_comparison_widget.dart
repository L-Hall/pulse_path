import 'package:flutter/material.dart';

/// Widget that displays a comparison of free vs premium features
class FeatureComparisonWidget extends StatelessWidget {
  const FeatureComparisonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What\'s Included in Premium',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Feature comparison table
          _buildFeatureTable(context),
        ],
      ),
    );
  }

  Widget _buildFeatureTable(BuildContext context) {
    final features = [
      FeatureComparison(
        name: 'HRV Readings per Month',
        free: '10',
        premium: 'Unlimited',
        isHighlight: true,
      ),
      FeatureComparison(
        name: 'Basic HRV Metrics',
        free: true,
        premium: true,
      ),
      FeatureComparison(
        name: 'Advanced Analytics',
        free: false,
        premium: true,
        isHighlight: true,
      ),
      FeatureComparison(
        name: 'Data Export (CSV, PDF)',
        free: false,
        premium: true,
        isHighlight: true,
      ),
      FeatureComparison(
        name: 'Cloud Sync',
        free: 'Limited',
        premium: 'Full',
      ),
      FeatureComparison(
        name: 'Adaptive Pacing',
        free: true,
        premium: true,
      ),
      FeatureComparison(
        name: 'Custom Metrics',
        free: false,
        premium: true,
        isHighlight: true,
      ),
      FeatureComparison(
        name: 'Trend Predictions',
        free: false,
        premium: true,
        isHighlight: true,
      ),
      FeatureComparison(
        name: 'Premium Support',
        free: false,
        premium: true,
      ),
    ];

    return Column(
      children: [
        // Header row
        _buildTableHeader(context),
        const SizedBox(height: 8),
        
        // Feature rows
        ...features.map((feature) => _buildFeatureRow(context, feature)),
      ],
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
        Expanded(
          child: Text(
            'Free',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            'Premium',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureRow(BuildContext context, FeatureComparison feature) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: feature.isHighlight ? BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ) : null,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                feature.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: feature.isHighlight ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildFeatureValue(
              context,
              feature.free,
              isHighlight: feature.isHighlight,
            ),
          ),
          Expanded(
            child: _buildFeatureValue(
              context,
              feature.premium,
              isPremium: true,
              isHighlight: feature.isHighlight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureValue(
    BuildContext context,
    dynamic value, {
    bool isPremium = false,
    bool isHighlight = false,
  }) {
    Widget child;
    Color? color;

    if (value is bool) {
      child = Icon(
        value ? Icons.check : Icons.close,
        size: 18,
        color: value 
            ? (isPremium ? Theme.of(context).colorScheme.primary : Colors.green)
            : Colors.grey,
      );
    } else {
      color = isPremium && isHighlight
          ? Theme.of(context).colorScheme.primary
          : null;
      child = Text(
        value.toString(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: isPremium && isHighlight ? FontWeight.bold : null,
        ),
        textAlign: TextAlign.center,
      );
    }

    return Container(
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// Data class for feature comparison
class FeatureComparison {
  final String name;
  final dynamic free;
  final dynamic premium;
  final bool isHighlight;

  const FeatureComparison({
    required this.name,
    required this.free,
    required this.premium,
    this.isHighlight = false,
  });
}