import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../settings/presentation/providers/settings_providers.dart';
import '../providers/cloud_sync_providers.dart';
import 'sync_status_widget.dart';

/// Widget for managing cloud sync settings
class CloudSettingsWidget extends ConsumerWidget {
  const CloudSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final userPreferences = ref.watch(userPreferencesProvider);
    final cloudSyncAvailable = ref.watch(cloudSyncAvailableProvider);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cloud,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Cloud Sync',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Show sync status if available
            if (cloudSyncAvailable) ...[
              const SyncStatusWidget(compact: false),
              const SizedBox(height: 16),
            ],
            
            // Cloud sync toggle
            authState.when(
              data: (user) => user != null && !user.isAnonymous
                  ? _buildCloudSyncToggle(context, ref, userPreferences)
                  : _buildSignInPrompt(context, ref),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _buildErrorMessage(context, error.toString()),
            ),
            
            const SizedBox(height: 16),
            
            // Cloud sync options
            if (cloudSyncAvailable) ...[
              _buildSyncOptions(context, ref),
              const SizedBox(height: 16),
            ],
            
            // Data management
            _buildDataManagement(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildCloudSyncToggle(
    BuildContext context, 
    WidgetRef ref, 
    AsyncValue userPreferences,
  ) {
    return userPreferences.when(
      data: (prefs) => SwitchListTile(
        title: const Text('Enable Cloud Sync'),
        subtitle: const Text('Sync your HRV data across all devices'),
        value: prefs.enableCloudSync,
        onChanged: (value) async {
          await ref.read(userPreferencesProvider.notifier).updateCloudSyncEnabled(value);
          
          if (value) {
            // Trigger initial sync when enabled
            final syncTrigger = ref.read(syncTriggerProvider);
            await syncTrigger();
          }
        },
      ),
      loading: () => const ListTile(
        title: Text('Enable Cloud Sync'),
        trailing: CircularProgressIndicator(),
      ),
      error: (error, _) => ListTile(
        title: const Text('Enable Cloud Sync'),
        subtitle: Text('Error: $error'),
      ),
    );
  }

  Widget _buildSignInPrompt(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Sign in to enable cloud sync',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Create an account to sync your HRV data across all your devices.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _navigateToAuth(context),
            icon: const Icon(Icons.login),
            label: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncOptions(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sync Options',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        ListTile(
          title: const Text('Manual Sync'),
          subtitle: const Text('Sync now'),
          trailing: IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () async {
              final syncTrigger = ref.read(syncTriggerProvider);
              await syncTrigger();
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sync triggered')),
                );
              }
            },
          ),
        ),
        ListTile(
          title: const Text('Sync Statistics'),
          subtitle: const Text('View sync details'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showSyncStatistics(context, ref),
        ),
      ],
    );
  }

  Widget _buildDataManagement(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data Management',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        ListTile(
          title: const Text('Export Data'),
          subtitle: const Text('Download your HRV data'),
          trailing: const Icon(Icons.download),
          onTap: () => _exportData(context, ref),
        ),
        ListTile(
          title: const Text('Delete Cloud Data'),
          subtitle: const Text('Remove all data from cloud'),
          trailing: const Icon(Icons.delete_outline),
          onTap: () => _showDeleteCloudDataDialog(context, ref),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(BuildContext context, String error) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Error loading cloud sync settings: $error',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAuth(BuildContext context) {
    Navigator.of(context).pushNamed('/auth');
  }

  void _showSyncStatistics(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sync Statistics'),
        content: Consumer(
          builder: (context, ref, child) {
            final statistics = ref.watch(syncStatisticsProvider);
            return statistics.when(
              data: (stats) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Operations: ${stats.totalOperations}'),
                  Text('Successful: ${stats.successfulOperations}'),
                  Text('Failed: ${stats.failedOperations}'),
                  Text('Conflicts: ${stats.conflictOperations}'),
                  if (stats.lastSyncAt != null)
                    Text('Last Sync: ${stats.lastSyncAt}'),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('Error: $error'),
            );
          },
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

  void _exportData(BuildContext context, WidgetRef ref) {
    // TODO: Implement data export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data export coming soon')),
    );
  }

  void _showDeleteCloudDataDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Cloud Data'),
        content: const Text(
          'This will permanently delete all your HRV data from the cloud. '
          'Local data will remain unchanged. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement cloud data deletion
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cloud data deletion coming soon')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}