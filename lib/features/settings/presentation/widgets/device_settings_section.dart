import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_preferences.dart';
import '../../../health_data/presentation/widgets/device_selection_widget.dart';
import '../../../health_data/presentation/widgets/apple_watch_status_widget.dart';
import '../../../health_data/presentation/providers/apple_watch_providers.dart';

/// Settings section for device selection and Apple Watch configuration
class DeviceSettingsSection extends ConsumerWidget {
  final UserPreferences preferences;

  const DeviceSettingsSection({
    super.key,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Device Settings',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Device Selection Widget
        const DeviceSelectionWidget(),
        
        const SizedBox(height: 16),
        
        // Apple Watch Settings Card
        _buildAppleWatchCard(context, ref),
        
        const SizedBox(height: 16),
        
        // Real-time Monitoring Settings
        _buildRealtimeMonitoringCard(context, ref),
      ],
    );
  }

  Widget _buildAppleWatchCard(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isWatchConnected = ref.watch(isAppleWatchConnectedProvider);
    
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
                  'Apple Watch Integration',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Apple Watch Status
            const AppleWatchStatusWidget(isCompact: false),
            
            if (!isWatchConnected) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Setup Instructions',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '1. Make sure your Apple Watch is paired and nearby\n'
                      '2. Open the Apple Watch app on your iPhone\n'
                      '3. Ensure Health data sharing is enabled\n'
                      '4. Grant HealthKit permissions when prompted',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRealtimeMonitoringCard(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isMonitoring = ref.watch(realTimeHrvMonitoringProvider);
    final isWatchConnected = ref.watch(isAppleWatchConnectedProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.monitor_heart,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Real-time Monitoring',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            SwitchListTile(
              title: const Text('Enable Real-time HRV Monitoring'),
              subtitle: const Text(
                'Continuously monitor HRV from Apple Watch in the background',
              ),
              value: isMonitoring,
              onChanged: isWatchConnected 
                  ? (value) {
                      ref.read(realTimeHrvMonitoringProvider.notifier).state = value;
                      
                      if (value) {
                        _showRealtimeMonitoringDialog(context);
                      }
                    }
                  : null,
            ),
            
            if (!isWatchConnected)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Apple Watch must be connected to enable real-time monitoring',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            
            if (isMonitoring && isWatchConnected) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 12,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Real-time monitoring active',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showRealtimeMonitoringDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Real-time Monitoring'),
        content: const Text(
          'Real-time HRV monitoring will continuously track your heart rate '
          'variability using your Apple Watch. This feature may impact battery '
          'life on both your Watch and iPhone.\n\n'
          'Data will be processed in real-time to provide immediate insights '
          'about your stress and recovery status.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}