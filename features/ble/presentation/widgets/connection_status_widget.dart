import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/ble_heart_rate_service.dart';

/// Widget to display BLE connection status
class ConnectionStatusWidget extends StatelessWidget {
  final AsyncValue<BleConnectionState> connectionState;

  const ConnectionStatusWidget({
    super.key,
    required this.connectionState,
  });

  @override
  Widget build(BuildContext context) {
    return connectionState.when(
      data: (state) => _buildStatusCard(context, state),
      loading: () => _buildStatusCard(context, BleConnectionState.disconnected),
      error: (error, stack) => _buildErrorCard(context, error.toString()),
    );
  }

  Widget _buildStatusCard(BuildContext context, BleConnectionState state) {
    IconData icon;
    String text;
    Color color;

    switch (state) {
      case BleConnectionState.disconnected:
        icon = Icons.bluetooth_disabled;
        text = 'Disconnected';
        color = Colors.grey;
        break;
      case BleConnectionState.scanning:
        icon = Icons.bluetooth_searching;
        text = 'Scanning for devices...';
        color = Colors.blue;
        break;
      case BleConnectionState.connecting:
        icon = Icons.bluetooth_connected;
        text = 'Connecting...';
        color = Colors.orange;
        break;
      case BleConnectionState.connected:
        icon = Icons.bluetooth_connected;
        text = 'Connected';
        color = Colors.green;
        break;
      case BleConnectionState.error:
        icon = Icons.error;
        text = 'Connection error';
        color = Colors.red;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: color.withValues(alpha: 0.1),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (state == BleConnectionState.scanning || 
              state == BleConnectionState.connecting) ...[
            const Spacer(),
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context, String error) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.red.withValues(alpha: 0.1),
      child: Row(
        children: [
          const Icon(Icons.error, color: Colors.red, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Error: $error',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}