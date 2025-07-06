import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ble_providers.dart';
import '../../domain/services/ble_heart_rate_service.dart';

/// Widget that shows the current BLE device connection status on the dashboard
class BleStatusWidget extends ConsumerWidget {
  const BleStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionState = ref.watch(bleConnectionStateProvider);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusColor(connectionState.valueOrNull, theme),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getStatusIcon(connectionState.valueOrNull),
            color: _getStatusColor(connectionState.valueOrNull, theme),
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Heart Rate Monitor',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  _getStatusText(connectionState.valueOrNull),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(connectionState.valueOrNull, theme),
                  ),
                ),
              ],
            ),
          ),
          if (connectionState.valueOrNull == BleConnectionState.connected)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(BleConnectionState? state) {
    switch (state) {
      case BleConnectionState.connected:
        return Icons.bluetooth_connected;
      case BleConnectionState.connecting:
        return Icons.bluetooth_searching;
      case BleConnectionState.scanning:
        return Icons.bluetooth_searching;
      case BleConnectionState.error:
        return Icons.bluetooth_disabled;
      case BleConnectionState.disconnected:
      case null:
        return Icons.bluetooth;
    }
  }

  Color _getStatusColor(BleConnectionState? state, ThemeData theme) {
    switch (state) {
      case BleConnectionState.connected:
        return Colors.green;
      case BleConnectionState.connecting:
      case BleConnectionState.scanning:
        return theme.colorScheme.primary;
      case BleConnectionState.error:
        return Colors.red;
      case BleConnectionState.disconnected:
      case null:
        return theme.colorScheme.onSurface.withValues(alpha: 0.6);
    }
  }

  String _getStatusText(BleConnectionState? state) {
    switch (state) {
      case BleConnectionState.connected:
        return 'Connected';
      case BleConnectionState.connecting:
        return 'Connecting...';
      case BleConnectionState.scanning:
        return 'Scanning...';
      case BleConnectionState.error:
        return 'Error';
      case BleConnectionState.disconnected:
      case null:
        return 'Not connected';
    }
  }
}

/// Compact version for use in floating actions or quick status displays
class CompactBleStatusWidget extends ConsumerWidget {
  final VoidCallback? onTap;

  const CompactBleStatusWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionState = ref.watch(bleConnectionStateProvider);
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _getStatusColor(connectionState.valueOrNull, theme).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _getStatusColor(connectionState.valueOrNull, theme),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getStatusIcon(connectionState.valueOrNull),
              color: _getStatusColor(connectionState.valueOrNull, theme),
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              _getCompactStatusText(connectionState.valueOrNull),
              style: theme.textTheme.bodySmall?.copyWith(
                color: _getStatusColor(connectionState.valueOrNull, theme),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(BleConnectionState? state) {
    switch (state) {
      case BleConnectionState.connected:
        return Icons.bluetooth_connected;
      case BleConnectionState.connecting:
        return Icons.bluetooth_searching;
      case BleConnectionState.scanning:
        return Icons.bluetooth_searching;
      case BleConnectionState.error:
        return Icons.bluetooth_disabled;
      case BleConnectionState.disconnected:
      case null:
        return Icons.bluetooth;
    }
  }

  Color _getStatusColor(BleConnectionState? state, ThemeData theme) {
    switch (state) {
      case BleConnectionState.connected:
        return Colors.green;
      case BleConnectionState.connecting:
      case BleConnectionState.scanning:
        return theme.colorScheme.primary;
      case BleConnectionState.error:
        return Colors.red;
      case BleConnectionState.disconnected:
      case null:
        return theme.colorScheme.onSurface.withValues(alpha: 0.6);
    }
  }

  String _getCompactStatusText(BleConnectionState? state) {
    switch (state) {
      case BleConnectionState.connected:
        return 'Connected';
      case BleConnectionState.connecting:
        return 'Connecting';
      case BleConnectionState.scanning:
        return 'Scanning';
      case BleConnectionState.error:
        return 'Error';
      case BleConnectionState.disconnected:
      case null:
        return 'BLE';
    }
  }
}