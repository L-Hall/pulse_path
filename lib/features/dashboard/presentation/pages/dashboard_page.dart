import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/score_card.dart';
import '../widgets/hrv_trend_chart.dart';
import '../widgets/enhanced_hrv_chart.dart';
import '../../../hrv/presentation/pages/hrv_capture_page.dart';
import '../../../ble/presentation/pages/ble_device_discovery_page.dart';
import '../../../metrics/presentation/pages/metrics_overview_page.dart';
import '../../domain/models/dashboard_data.dart';
import '../../data/repositories/simple_hrv_repository.dart';
import '../../data/services/data_export_service.dart';
import '../../../../core/di/injection_container.dart';

/// Main dashboard page displaying HRV scores and trends
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardDataProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('PulsePath'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => ref.refresh(dashboardDataProvider),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh data',
          ),
          IconButton(
            onPressed: () => _showSettingsMenu(context),
            icon: const Icon(Icons.more_vert),
            tooltip: 'More options',
          ),
        ],
      ),
      body: SafeArea(
        child: dashboardState.when(
          data: (data) => _buildDashboardContent(context, ref, data),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => _buildErrorState(context, ref, error),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToCapture(context),
        icon: const Icon(Icons.favorite),
        label: const Text('New Reading'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, WidgetRef ref, DashboardData data) {
    final theme = Theme.of(context);
    final scores = data.currentScores;

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(dashboardDataProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            _buildWelcomeSection(context, data),
            const SizedBox(height: 24),

            // Score cards
            _buildScoreCards(context, scores),
            const SizedBox(height: 32),

            // Trend chart section
            _buildTrendSection(context, data),
            
            const SizedBox(height: 24),
            
            // Enhanced chart section
            _buildEnhancedChartSection(context, data),
            const SizedBox(height: 32),

            // Quick stats
            _buildQuickStats(context, data.statistics),
            const SizedBox(height: 100), // Extra space for FAB
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, DashboardData data) {
    final theme = Theme.of(context);
    final timeOfDay = _getTimeOfDayGreeting();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.primaryContainer.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$timeOfDay!',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.hasRecentData 
                ? 'Your latest HRV reading shows ${_getWellbeingMessage(data.currentScores)}'
                : 'Ready for your next HRV reading?',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
            ),
          ),
          if (!data.hasRecentData) ...[
            const SizedBox(height: 12),
            Text(
              'Take a 3-minute reading to see your stress, recovery, and energy scores.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScoreCards(BuildContext context, DashboardScores scores) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Scores',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ScoreCard(
                title: 'Stress',
                score: scores.stress,
                maxScore: 100,
                color: _getStressColor(scores.stress),
                icon: Icons.psychology,
                subtitle: _getScoreDescription(scores.stress, ScoreCategory.stress),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ScoreCard(
                title: 'Recovery',
                score: scores.recovery,
                maxScore: 100,
                color: _getRecoveryColor(scores.recovery),
                icon: Icons.spa,
                subtitle: _getScoreDescription(scores.recovery, ScoreCategory.recovery),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ScoreCard(
                title: 'Energy',
                score: scores.energy,
                maxScore: 100,
                color: _getEnergyColor(scores.energy),
                icon: Icons.bolt,
                subtitle: _getScoreDescription(scores.energy, ScoreCategory.energy),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendSection(BuildContext context, DashboardData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '7-Day Trend',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => _showDetailedTrends(context),
              child: const Text('View Details'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: data.trendReadings.isNotEmpty
              ? HrvTrendChart(
                  trendPoints: data.getTrendPoints(),
                  days: 7,
                )
              : _buildEmptyTrendState(context),
        ),
      ],
    );
  }

  Widget _buildEnhancedChartSection(BuildContext context, DashboardData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.auto_graph,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Advanced Analytics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Interactive charts with multiple visualization modes',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 16),
        data.trendReadings.isNotEmpty
            ? EnhancedHrvChart(
                trendPoints: data.getTrendPoints(),
                readings: data.trendReadings,
                days: 7,
              )
            : _buildEmptyTrendState(context),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context, DashboardStatistics stats) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Stats',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                'Total Readings',
                '${stats.totalReadings}',
                Icons.timeline,
              ),
              _buildStatItem(
                context,
                'Current Streak',
                '${stats.streakDays} days',
                Icons.local_fire_department,
              ),
              _buildStatItem(
                context,
                'Avg Heart Rate',
                '${stats.averageHeartRate.round()} BPM',
                Icons.favorite,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmptyTrendState(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
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
              'No trend data yet',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Take a few readings to see your trend',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load dashboard',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.refresh(dashboardDataProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  String _getTimeOfDayGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String _getWellbeingMessage(DashboardScores scores) {
    if (scores.isGoodWellbeing) {
      return 'excellent wellbeing!';
    } else if (scores.recovery >= 50) {
      return 'balanced wellbeing.';
    } else {
      return 'room for improvement.';
    }
  }

  Color _getStressColor(int score) {
    if (score <= 30) return Colors.green;
    if (score <= 60) return Colors.orange;
    return Colors.red;
  }

  Color _getRecoveryColor(int score) {
    if (score >= 70) return Colors.green;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }

  Color _getEnergyColor(int score) {
    if (score >= 70) return Colors.green;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }

  String _getScoreDescription(int score, ScoreCategory category) {
    switch (category) {
      case ScoreCategory.stress:
        if (score <= 30) return 'Low';
        if (score <= 60) return 'Moderate';
        return 'High';
      case ScoreCategory.recovery:
        if (score >= 70) return 'Excellent';
        if (score >= 40) return 'Good';
        return 'Poor';
      case ScoreCategory.energy:
        if (score >= 70) return 'High';
        if (score >= 40) return 'Moderate';
        return 'Low';
    }
  }

  void _navigateToCapture(BuildContext context) {
    // Show capture method selection dialog
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Capture Method',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Select how you\'d like to capture your HRV reading',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.camera_alt, size: 28),
              title: const Text('Camera (PPG)'),
              subtitle: const Text('Use phone camera for 3-minute capture'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const HrvCapturePage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.bluetooth, size: 28),
              title: const Text('Heart Rate Monitor'),
              subtitle: const Text('Connect to BLE chest strap or watch'),
              onTap: () {
                Navigator.pop(context);
                _navigateToBleDiscovery(context);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _navigateToBleDiscovery(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const BleDeviceDiscoveryPage(),
      ),
    );
  }

  void _navigateToMetricsOverview(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const MetricsOverviewPage(),
      ),
    );
  }

  void _showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.file_download),
              title: const Text('Export Data'),
              onTap: () {
                Navigator.pop(context);
                _exportData(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('All HRV Metrics'),
              subtitle: const Text('View detailed metric analysis'),
              onTap: () {
                Navigator.pop(context);
                _navigateToMetricsOverview(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bluetooth),
              title: const Text('Heart Rate Monitor'),
              subtitle: const Text('Connect to BLE device'),
              onTap: () {
                Navigator.pop(context);
                _navigateToBleDiscovery(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Show about dialog
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailedTrends(BuildContext context) {
    // TODO: Navigate to detailed trends page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Detailed trends coming soon!')),
    );
  }

  void _exportData(BuildContext context) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Exporting data...'),
            ],
          ),
        ),
      );

      // Import the export service here to avoid circular imports
      final repository = sl<SimpleHrvRepository>();
      final exportService = DataExportService(repository);
      
      // Export to JSON by default
      final filePath = await exportService.saveToFile(asJson: true);
      
      // Close loading dialog
      Navigator.of(context).pop();
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Export Complete'),
          content: Text('Data exported successfully to:\n$filePath'),
          actions: [
            TextButton(
              onPressed: () async {
                await exportService.copyToClipboard(asJson: true);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data copied to clipboard!')),
                );
              },
              child: const Text('Copy to Clipboard'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Close loading dialog if open
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    }
  }
}