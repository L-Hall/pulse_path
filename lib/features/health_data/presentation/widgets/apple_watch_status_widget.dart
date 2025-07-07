import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/apple_watch_providers.dart';
import '../../models/apple_watch_data.dart';
import '../../services/watch_connectivity_service.dart';
import '../../../../core/theme/liquid_glass_theme.dart';

/// Compact Apple Watch status widget for dashboard
class AppleWatchStatusWidget extends ConsumerWidget {
  final bool isCompact;
  final VoidCallback? onTap;

  const AppleWatchStatusWidget({
    super.key,
    this.isCompact = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchStatusAsync = ref.watch(appleWatchStatusProvider);
    final connectivityStatusAsync = ref.watch(watchConnectivityStatusProvider);
    final theme = Theme.of(context);

    return watchStatusAsync.when(
      data: (watchStatus) => connectivityStatusAsync.when(
        data: (connectivityStatus) => _buildStatusWidget(
          context,
          theme,
          watchStatus,
          connectivityStatus,
        ),
        loading: () => _buildLoadingWidget(context, theme),
        error: (_, __) => _buildErrorWidget(context, theme),
      ),
      loading: () => _buildLoadingWidget(context, theme),
      error: (_, __) => _buildErrorWidget(context, theme),
    );
  }

  Widget _buildStatusWidget(
    BuildContext context,
    ThemeData theme,
    AppleWatchStatus watchStatus,
    WatchConnectivityStatus connectivityStatus,
  ) {
    final isFullyConnected = watchStatus.isConnected && 
                            watchStatus.isReachable && 
                            connectivityStatus.isFullyConnected;

    if (isCompact) {
      return _buildCompactWidget(
        context,
        theme,
        isFullyConnected,
        watchStatus,
      );
    } else {
      return _buildExpandedWidget(
        context,
        theme,
        isFullyConnected,
        watchStatus,
        connectivityStatus,
      );
    }
  }

  Widget _buildCompactWidget(
    BuildContext context,
    ThemeData theme,
    bool isConnected,
    AppleWatchStatus watchStatus,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _getStatusColor(isConnected).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _getStatusColor(isConnected),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getStatusIcon(isConnected),
              size: 16,
              color: _getStatusColor(isConnected),
            ),
            const SizedBox(width: 4),
            Text(
              _getStatusText(isConnected),
              style: theme.textTheme.bodySmall?.copyWith(
                color: _getStatusColor(isConnected),
                fontWeight: FontWeight.w500,
              ),
            ),
            if (watchStatus.batteryLevel != null) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.battery_std,
                size: 12,
                color: _getBatteryColor(watchStatus.batteryLevel!),
              ),
              Text(
                '${watchStatus.batteryLevel!.round()}%',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _getBatteryColor(watchStatus.batteryLevel!),
                  fontSize: 10,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedWidget(
    BuildContext context,
    ThemeData theme,
    bool isConnected,
    AppleWatchStatus watchStatus,
    WatchConnectivityStatus connectivityStatus,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.watch,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Apple Watch',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(isConnected).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(isConnected),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(isConnected),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            if (watchStatus.deviceModel != null) ...[
              _buildInfoRow(
                context,
                Icons.devices,
                'Model',
                watchStatus.deviceModel!,
              ),
              const SizedBox(height: 8),
            ],
            
            if (watchStatus.watchOSVersion != null) ...[
              _buildInfoRow(
                context,
                Icons.system_update,
                'watchOS',
                watchStatus.watchOSVersion!,
              ),
              const SizedBox(height: 8),
            ],
            
            if (watchStatus.batteryLevel != null) ...[
              _buildBatteryRow(context, watchStatus.batteryLevel!),
              const SizedBox(height: 8),
            ],
            
            if (watchStatus.lastDataSync != null) ...[
              _buildInfoRow(
                context,
                Icons.sync,
                'Last Sync',
                _formatRelativeTime(watchStatus.lastDataSync!),
              ),
              const SizedBox(height: 8),
            ],
            
            _buildCapabilitiesRow(context, watchStatus.supportedCapabilities),
            
            if (isConnected) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _triggerManualSync(context),
                      icon: const Icon(Icons.sync),
                      label: const Text('Sync Now'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBatteryRow(BuildContext context, double batteryLevel) {
    final theme = Theme.of(context);
    final batteryColor = _getBatteryColor(batteryLevel);
    
    return Row(
      children: [
        Icon(
          _getBatteryIcon(batteryLevel),
          size: 16,
          color: batteryColor,
        ),
        const SizedBox(width: 8),
        Text(
          'Battery:',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: batteryLevel / 100.0,
            backgroundColor: batteryColor.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(batteryColor),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${batteryLevel.round()}%',
          style: theme.textTheme.bodySmall?.copyWith(
            color: batteryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCapabilitiesRow(
    BuildContext context, 
    List<WatchCapability> capabilities,
  ) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.settings,
              size: 16,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              'Capabilities:',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: capabilities.map((capability) => Chip(
            label: Text(
              capability.displayName,
              style: theme.textTheme.bodySmall,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide.none,
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildLoadingWidget(BuildContext context, ThemeData theme) {
    if (isCompact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Checking...',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    } else {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }

  Widget _buildErrorWidget(BuildContext context, ThemeData theme) {
    if (isCompact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 16,
              color: theme.colorScheme.error,
            ),
            const SizedBox(width: 4),
            Text(
              'Error',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
      );
    } else {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 8),
                Text(
                  'Unable to check Apple Watch status',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void _triggerManualSync(BuildContext context) {
    // This would trigger a manual sync
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Manual sync triggered'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Color _getStatusColor(bool isConnected) {
    return isConnected ? Colors.green : Colors.grey;
  }

  IconData _getStatusIcon(bool isConnected) {
    return isConnected ? Icons.check_circle : Icons.watch_off;
  }

  String _getStatusText(bool isConnected) {
    return isConnected ? 'Connected' : 'Disconnected';
  }

  Color _getBatteryColor(double batteryLevel) {
    if (batteryLevel > 50) return Colors.green;
    if (batteryLevel > 20) return Colors.orange;
    return Colors.red;
  }

  IconData _getBatteryIcon(double batteryLevel) {
    if (batteryLevel > 75) return Icons.battery_full;
    if (batteryLevel > 50) return Icons.battery_5_bar;
    if (batteryLevel > 25) return Icons.battery_3_bar;
    if (batteryLevel > 10) return Icons.battery_2_bar;
    return Icons.battery_1_bar;
  }

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}