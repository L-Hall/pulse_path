import 'package:flutter/material.dart';
import '../../domain/services/ble_hrv_integration_service.dart';

/// Widget showing BLE device connection status and information
class BleDeviceStatusWidget extends StatelessWidget {
  final BleHrvCaptureStats stats;

  const BleDeviceStatusWidget({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getStatusIcon(),
                  color: _getStatusColor(),
                ),
                const SizedBox(width: 8),
                Text(
                  'Device Status',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(),
                    style: TextStyle(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            if (stats.deviceInfo != null) ...[
              _buildDeviceInfo(context),
              const SizedBox(height: 12),
            ],
            
            if (stats.isCapturing) ...[
              _buildCaptureInfo(context),
            ] else ...[
              _buildReadyInfo(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfo(BuildContext context) {
    final device = stats.deviceInfo!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.bluetooth_connected, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                device.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Address: ${device.address}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildCaptureInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.favorite, size: 16, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              'Capturing HRV Data',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                'Duration',
                _formatDuration(stats.elapsedDuration),
              ),
            ),
            Expanded(
              child: _buildInfoItem(
                context,
                'RR Intervals',
                '${stats.currentRrCount}',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReadyInfo(BuildContext context) {
    if (!stats.isConnected) {
      return Row(
        children: [
          Icon(
            Icons.warning_amber,
            size: 16,
            color: Colors.orange,
          ),
          const SizedBox(width: 8),
          Text(
            'No heart rate monitor connected',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.orange,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Icon(
          Icons.check_circle,
          size: 16,
          color: Colors.green,
        ),
        const SizedBox(width: 8),
        Text(
          'Ready for HRV capture',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  IconData _getStatusIcon() {
    if (stats.isCapturing) {
      return Icons.favorite;
    } else if (stats.isConnected) {
      return Icons.bluetooth_connected;
    } else {
      return Icons.bluetooth_disabled;
    }
  }

  Color _getStatusColor() {
    if (stats.isCapturing) {
      return Colors.red;
    } else if (stats.isConnected) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  String _getStatusText() {
    if (stats.isCapturing) {
      return 'Capturing';
    } else if (stats.isConnected) {
      return 'Connected';
    } else {
      return 'Disconnected';
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}