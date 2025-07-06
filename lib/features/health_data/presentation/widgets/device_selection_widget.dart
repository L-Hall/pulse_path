import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/apple_watch_providers.dart';

/// Widget for selecting preferred HRV data source
class DeviceSelectionWidget extends ConsumerWidget {
  const DeviceSelectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicePriority = ref.watch(devicePriorityProvider);
    final preferredSource = ref.watch(preferredHrvDataSourceProvider);
    final isWatchConnected = ref.watch(isAppleWatchConnectedProvider);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.devices,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'HRV Data Source',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Current selection indicator
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    _getSourceIcon(preferredSource),
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Source',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        preferredSource.displayName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        preferredSource.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            Text(
              'Device Priority',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            
            // Device priority options
            ...DevicePriority.values.map((priority) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildPriorityOption(
                context,
                ref,
                priority,
                devicePriority,
                isWatchConnected,
              ),
            )),
            
            const SizedBox(height: 16),
            
            // Device status indicators
            _buildDeviceStatusSection(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityOption(
    BuildContext context,
    WidgetRef ref,
    DevicePriority priority,
    DevicePriority currentPriority,
    bool isWatchConnected,
  ) {
    final theme = Theme.of(context);
    final isSelected = priority == currentPriority;
    final isEnabled = _isPriorityEnabled(priority, isWatchConnected);

    return InkWell(
      onTap: isEnabled 
          ? () => ref.read(devicePriorityProvider.notifier).state = priority
          : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected 
                ? theme.colorScheme.primary 
                : theme.colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected 
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : null,
        ),
        child: Row(
          children: [
            Radio<DevicePriority>(
              value: priority,
              groupValue: currentPriority,
              onChanged: isEnabled 
                  ? (value) => ref.read(devicePriorityProvider.notifier).state = value!
                  : null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        priority.displayName,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isEnabled 
                              ? null 
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (!isEnabled) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.block,
                          size: 16,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    priority.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isEnabled 
                          ? theme.colorScheme.onSurfaceVariant
                          : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                    ),
                  ),
                  if (!isEnabled && priority == DevicePriority.appleWatchOnly)
                    Text(
                      'Apple Watch not connected',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceStatusSection(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Device Status',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        
        // Apple Watch status
        _buildDeviceStatus(
          context,
          ref,
          HrvDataSource.appleWatch,
          Icons.watch,
          ref.watch(isAppleWatchConnectedProvider),
        ),
        
        const SizedBox(height: 8),
        
        // BLE device status (placeholder)
        _buildDeviceStatus(
          context,
          ref,
          HrvDataSource.ble,
          Icons.bluetooth,
          false, // TODO: Add BLE connection status
        ),
        
        const SizedBox(height: 8),
        
        // Camera PPG status
        _buildDeviceStatus(
          context,
          ref,
          HrvDataSource.camera,
          Icons.camera_alt,
          true, // Camera is always available
        ),
      ],
    );
  }

  Widget _buildDeviceStatus(
    BuildContext context,
    WidgetRef ref,
    HrvDataSource source,
    IconData icon,
    bool isAvailable,
  ) {
    final theme = Theme.of(context);
    final statusColor = isAvailable ? Colors.green : Colors.grey;
    
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: statusColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            source.displayName,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isAvailable ? 'Available' : 'Unavailable',
            style: theme.textTheme.bodySmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  bool _isPriorityEnabled(DevicePriority priority, bool isWatchConnected) {
    switch (priority) {
      case DevicePriority.appleWatchOnly:
        return isWatchConnected;
      case DevicePriority.auto:
      case DevicePriority.bleOnly:
      case DevicePriority.cameraOnly:
        return true;
    }
  }

  IconData _getSourceIcon(HrvDataSource source) {
    switch (source) {
      case HrvDataSource.appleWatch:
        return Icons.watch;
      case HrvDataSource.ble:
        return Icons.bluetooth;
      case HrvDataSource.camera:
        return Icons.camera_alt;
      case HrvDataSource.none:
        return Icons.device_unknown;
    }
  }
}