import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/score_card.dart';
import '../widgets/hrv_trend_chart.dart';
import '../widgets/enhanced_hrv_chart.dart';
import '../widgets/data_source_indicator.dart';
import '../widgets/first_launch_dialog.dart';
import '../../../adaptive_pacing/presentation/widgets/health_context_cards.dart';
import '../../../adaptive_pacing/presentation/widgets/pem_risk_indicator.dart';
import '../../../hrv/presentation/pages/hrv_capture_page.dart';
import '../../../ble/presentation/pages/ble_device_discovery_page.dart';
import '../../../ble/presentation/widgets/ble_status_widget.dart';
import '../../../ble/presentation/providers/ble_providers.dart';
import '../../../metrics/presentation/pages/metrics_overview_page.dart';
import '../../../liquid_glass/presentation/pages/liquid_glass_demo_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../auth/presentation/widgets/user_profile_widget.dart';
import '../../../health_data/presentation/widgets/health_summary_widget.dart';
import '../../../health_data/presentation/widgets/health_metrics_card.dart';
import '../../../health_data/presentation/widgets/health_trend_chart.dart';
import '../../../health_data/presentation/widgets/apple_watch_status_widget.dart';
import '../../domain/models/dashboard_data.dart';
import '../../data/repositories/simple_hrv_repository.dart';
import '../../data/repositories/hrv_repository_interface.dart';
import '../../data/services/data_export_service.dart';
import '../../../../core/di/injection_container.dart';
import '../../../analytics/presentation/widgets/insights_card.dart';

/// Main dashboard page displaying HRV scores and trends
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(smartDashboardDataProvider);
    
    // Show first launch dialog if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showFirstLaunchDialogIfNeeded(context, ref);
    });
    
    // Initialize BLE connection manager for auto-reconnect functionality
    ref.listen(bleConnectionManagerProvider, (previous, next) {
      if (previous == null) {
        try {
          next.initialize();
        } catch (e) {
          // BLE initialization failure is not critical for dashboard
          debugPrint('BLE connection manager initialization failed: $e');
        }
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('PulsePath'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ref.refresh(smartDashboardDataProvider);
              ref.refresh(dataSourceBreakdownProvider);
            },
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
          loading: () => _buildLoadingState(context),
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
        ref.refresh(smartDashboardDataProvider);
        ref.refresh(dataSourceBreakdownProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User profile section
            const UserProfileWidget(),
            const SizedBox(height: 16),
            
            // Welcome section
            _buildWelcomeSection(context, data),
            const SizedBox(height: 16),

            // Data source indicator
            DataSourceIndicator(
              onTap: () => _showDataSourceDetails(context),
            ),
            const SizedBox(height: 24),

            // Score cards
            _buildScoreCards(context, scores),
            const SizedBox(height: 32),

            // Adaptive Pacing Section
            const PemRiskIndicator(),
            const SizedBox(height: 32),

            // Health Context Section
            const HealthContextCards(),
            const SizedBox(height: 32),


            // Health Data Section
            _buildHealthDataSection(context),
            const SizedBox(height: 16),
            
            // BLE Device Status Section
            _buildBleStatusSection(context),
            const SizedBox(height: 16),
            
            // Apple Watch Status Section
            _buildAppleWatchStatusSection(context),
            const SizedBox(height: 32),

            // Trend chart section
            _buildTrendSection(context, data),
            
            const SizedBox(height: 24),
            
            // Enhanced chart section
            _buildEnhancedChartSection(context, data),
            const SizedBox(height: 32),

            // Quick stats
            _buildQuickStats(context, data.statistics),
            const SizedBox(height: 32),
            
            // Weekly insights
            const InsightsCard(),
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

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(
              'Loading PulsePath Dashboard',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Initializing HRV data and dependencies...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'This may take a few moments on first launch',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  Widget _buildHealthDataSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.health_and_safety,
              color: theme.colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Health Data',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Health Summary Widget
        const HealthSummaryWidget(),
        const SizedBox(height: 16),
        
        // Health Metrics Cards Row
        const Row(
          children: [
            Expanded(
              child: StepsMetricCard(),
            ),
            SizedBox(width: 8),
            Expanded(
              child: SleepMetricCard(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Expanded(
              child: HeartRateMetricCard(),
            ),
            SizedBox(width: 8),
            Expanded(
              child: WorkoutMetricCard(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Health Trend Chart
        const HealthTrendChart(
          metricType: HealthMetricType.steps,
          days: 7,
        ),
      ],
    );
  }

  Widget _buildBleStatusSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.bluetooth,
              color: theme.colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Heart Rate Monitor',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            CompactBleStatusWidget(
              onTap: () => _navigateToBleDiscovery(context),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        GestureDetector(
          onTap: () => _navigateToBleDiscovery(context),
          child: const BleStatusWidget(),
        ),
      ],
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
              leading: const Icon(Icons.auto_awesome),
              title: const Text('Liquid Glass Demo'),
              subtitle: const Text('Experience iOS 26+ UI effects'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LiquidGlassDemoPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                _showAboutDialog(context);
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

  void _showAboutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AboutDialog(
        applicationName: 'PulsePath',
        applicationVersion: '1.0.0 (Alpha)',
        applicationIcon: const Icon(Icons.favorite, size: 48, color: Colors.red),
        applicationLegalese: '© 2024 PulsePath. All rights reserved.\n\nHRV-based wellbeing tracking with privacy-first design.',
        children: const [
          SizedBox(height: 16),
          Text('Features:'),
          Text('• 3-minute HRV capture via camera PPG or BLE'),
          Text('• Stress, Recovery, and Energy scores'),
          Text('• Adaptive Pacing for chronic illness support'),
          Text('• End-to-end encrypted cloud sync'),
          Text('• Liquid Glass UI for iOS 26+'),
        ],
      ),
    );
  }

  Widget _buildAppleWatchStatusSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.watch,
              color: theme.colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Apple Watch',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            AppleWatchStatusWidget(
              isCompact: true,
              onTap: () => _showAppleWatchDetails(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const AppleWatchStatusWidget(isCompact: false),
      ],
    );
  }

  void _showAppleWatchDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apple Watch Integration'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppleWatchStatusWidget(isCompact: false),
              SizedBox(height: 16),
              Text(
                'Apple Watch provides real-time heart rate and HRV data '
                'for continuous health monitoring. When connected, your '
                'Watch data will be automatically synchronized with the app.',
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

  void _showDataSourceDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Consumer(
        builder: (context, ref, child) {
          final dataSourceAsync = ref.watch(dataSourceBreakdownProvider);
          
          return AlertDialog(
            title: const Text('Data Sources'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dataSourceAsync.when(
                    data: (breakdown) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataSourceIndicator(isCompact: false),
                        const SizedBox(height: 16),
                        const Text(
                          'Understanding Your Data:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        _buildDataExplanation(breakdown),
                        const SizedBox(height: 16),
                        if (breakdown.sampleDataCount > 0) ...[
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _showClearSampleDataDialog(context, ref);
                            },
                            icon: const Icon(Icons.clear_all),
                            label: const Text('Clear Sample Data'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ],
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text('Error loading data sources: $error'),
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
          );
        },
      ),
    );
  }

  Widget _buildDataExplanation(DataSourceBreakdown breakdown) {
    if (breakdown.hasOnlySampleData) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• Sample Data: Pre-loaded realistic HRV readings for demonstration'),
          Text('• Take your first reading to see real data from your body'),
          Text('• Sample data helps you understand the app\'s features'),
        ],
      );
    } else if (breakdown.hasAnyRealData && breakdown.sampleDataCount > 0) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• Your Data: Real HRV readings captured from your device'),
          Text('• Sample Data: Demo readings showing app capabilities'),
          Text('• Consider clearing sample data to see only your readings'),
        ],
      );
    } else {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• Your Data: Real HRV readings captured from your device'),
          Text('• All dashboard data reflects your actual physiological state'),
          Text('• Great job building your HRV history!'),
        ],
      );
    }
  }

  void _showClearSampleDataDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Sample Data'),
        content: const Text(
          'This will remove all sample/demo data from your dashboard, '
          'showing only your real HRV readings. This action cannot be undone.\n\n'
          'Are you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _clearSampleData(context, ref);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear Sample Data'),
          ),
        ],
      ),
    );
  }

  Future<void> _clearSampleData(BuildContext context, WidgetRef ref) async {
    try {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Clearing sample data...'),
            ],
          ),
        ),
      );

      // Get repository and clear sample data
      final repository = kIsWeb ? sl<SimpleHrvRepository>() : await sl.getAsync<HrvRepositoryInterface>();
      await repository.clearSampleData();
      
      // Refresh providers
      ref.invalidate(smartDashboardDataProvider);
      ref.invalidate(dataSourceBreakdownProvider);
      
      // Close loading dialog
      Navigator.of(context).pop();
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sample data cleared successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Close loading dialog if open
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to clear sample data: $e')),
      );
    }
  }
}