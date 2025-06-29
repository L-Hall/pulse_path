import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// List tile for displaying a BLE device
class DeviceListTile extends StatelessWidget {
  final BluetoothDevice device;
  final VoidCallback onTap;
  final bool isConnecting;

  const DeviceListTile({
    super.key,
    required this.device,
    required this.onTap,
    this.isConnecting = false,
  });

  @override
  Widget build(BuildContext context) {
    final deviceName = device.platformName.isNotEmpty 
        ? device.platformName 
        : 'Unknown Device';
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(
            _getDeviceIcon(),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          deviceName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${device.remoteId}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            if (_getDeviceType() != null)
              Text(
                _getDeviceType()!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        trailing: isConnecting
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                Icons.bluetooth,
                color: Theme.of(context).colorScheme.primary,
              ),
        onTap: isConnecting ? null : onTap,
      ),
    );
  }

  IconData _getDeviceIcon() {
    final deviceName = device.platformName.toLowerCase();
    
    if (deviceName.contains('polar')) {
      return Icons.favorite;
    } else if (deviceName.contains('garmin')) {
      return Icons.watch;
    } else if (deviceName.contains('wahoo')) {
      return Icons.sensors;
    } else if (deviceName.contains('apple')) {
      return Icons.watch;
    } else if (deviceName.contains('suunto')) {
      return Icons.fitness_center;
    }
    
    return Icons.monitor_heart;
  }

  String? _getDeviceType() {
    final deviceName = device.platformName.toLowerCase();
    
    if (deviceName.contains('polar h10')) {
      return 'Polar H10 Chest Strap';
    } else if (deviceName.contains('polar h9')) {
      return 'Polar H9 Chest Strap';
    } else if (deviceName.contains('polar h7')) {
      return 'Polar H7 Chest Strap';
    } else if (deviceName.contains('garmin hrm-pro')) {
      return 'Garmin HRM-Pro';
    } else if (deviceName.contains('garmin hrm-dual')) {
      return 'Garmin HRM-Dual';
    } else if (deviceName.contains('wahoo tickr')) {
      return 'Wahoo TICKR';
    } else if (deviceName.contains('apple watch')) {
      return 'Apple Watch';
    } else if (deviceName.contains('suunto')) {
      return 'Suunto Heart Rate Monitor';
    } else if (deviceName.contains('heart rate') || deviceName.contains('hrm')) {
      return 'Heart Rate Monitor';
    }
    
    return null;
  }
}