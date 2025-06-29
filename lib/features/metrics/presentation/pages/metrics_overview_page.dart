import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/metric_info.dart';
import '../../../dashboard/presentation/providers/dashboard_providers.dart';
import '../widgets/metric_category_section.dart';
import 'metric_detail_page.dart';
import '../../../../shared/models/hrv_reading.dart';

/// Overview page showing all HRV metrics organized by category
class MetricsOverviewPage extends ConsumerWidget {
  const MetricsOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardData = ref.watch(dashboardDataProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('HRV Metrics'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      body: dashboardData.when(
        data: (data) => _buildMetricsContent(context, data.trendReadings),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'Error loading metrics data',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricsContent(BuildContext context, List<dynamic> trendReadings) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.analytics,
                        size: 32,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Heart Rate Variability Metrics',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Comprehensive analysis of your autonomic nervous system',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Tap any metric to view detailed analysis, trends, and clinical explanations',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Metric Categories
          ...MetricCategory.values.map((category) => 
            _buildCategorySection(context, category, trendReadings),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, MetricCategory category, List<dynamic> trendReadings) {
    final metrics = HrvMetricData.getMetricsByCategory(category);
    
    if (metrics.isEmpty) return const SizedBox.shrink();
    
    return Column(
      children: [
        MetricCategorySection(
          category: category,
          metrics: metrics,
          onMetricTap: (metricKey) => _navigateToMetricDetail(context, metricKey, trendReadings),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _navigateToMetricDetail(BuildContext context, String metricKey, List<dynamic> trendReadings) {
    // Cast the dynamic list to the proper type
    final readings = trendReadings.cast<HrvReading>();
    
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => MetricDetailPage(
          metricKey: metricKey,
          readings: readings,
        ),
      ),
    );
  }
}