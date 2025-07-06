import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../settings/presentation/providers/settings_providers.dart';
import '../../../settings/domain/models/user_preferences.dart';
import '../../../dashboard/presentation/providers/dashboard_providers.dart';

import '../providers/cloud_sync_providers.dart';
import 'sync_status_widget.dart';

/// Widget for managing cloud sync settings
class CloudSettingsWidget extends ConsumerWidget {
  const CloudSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

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
              data: (user) => user != null && !(user.isAnonymous ?? false)

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
    AsyncValue<UserPreferences> userPreferences,

  ) {
    return userPreferences.when(
      data: (prefs) => SwitchListTile(
        title: const Text('Enable Cloud Sync'),
        subtitle: const Text('Sync your HRV data across all devices'),
        value: prefs.enableCloudSync,
        onChanged: (value) async {
          await ref.read(userPreferencesNotifierProvider.notifier).updatePreference('enableCloudSync', value);

          
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

  void _exportData(BuildContext context, WidgetRef ref) async {
    try {
      // Show loading dialog
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertDialog(
            title: Text('Exporting Data'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Preparing your HRV data for export...'),
              ],
            ),
          ),
        );
      }

      // Get HRV repository from dashboard providers
      final repository = ref.read(simpleHrvRepositoryProvider);
      
      // Get all HRV readings
      final readings = await repository.getTrendReadings(days: 365); // Get last year
      final statistics = await repository.getStatistics(days: 365);
      
      // Create export data structure
      final exportData = {
        'export_info': {
          'app_name': 'PulsePath',
          'version': '1.0.0',
          'export_date': DateTime.now().toIso8601String(),
          'format_version': '1.0',
        },
        'user_profile': {
          'readings_count': readings.length,
          'date_range': {
            'start': readings.isNotEmpty ? readings.last.timestamp.toIso8601String() : null,
            'end': readings.isNotEmpty ? readings.first.timestamp.toIso8601String() : null,
          },
        },
        'statistics': {
          'avg_stress_score': statistics.averageStress,
          'avg_recovery_score': statistics.averageRecovery,
          'avg_energy_score': statistics.averageEnergy,
          'total_readings': statistics.totalReadings,
          'avg_rmssd': statistics.averageRmssd,
          'avg_heart_rate': statistics.averageHeartRate,
          'streak_days': statistics.streakDays,
        },
        'hrv_readings': readings.map((reading) => {
          'id': reading.id,
          'timestamp': reading.timestamp.toIso8601String(),
          'duration_seconds': reading.durationSeconds,
          'rr_intervals': reading.rrIntervals,
          'metrics': reading.metrics.toJson(),
          'scores': reading.scores.toJson(),
          'notes': reading.notes,
          'tags': reading.tags,
          'is_synced': reading.isSynced,
        }).toList(),
      };

      // Convert to JSON
      final jsonString = const JsonEncoder.withIndent('  ').convert(exportData);
      
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show export options dialog
      if (context.mounted) {
        _showExportOptionsDialog(context, jsonString);
      }
    } catch (error) {
      // Close loading dialog if still open
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      
      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _showExportOptionsDialog(BuildContext context, String jsonData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Options'),
        content: const Text('Choose how to export your HRV data:'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _copyToClipboard(context, jsonData);
            },
            child: const Text('Copy to Clipboard'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _saveToFile(context, jsonData);
            },
            child: const Text('Save to File'),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String data) {
    Clipboard.setData(ClipboardData(text: data));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('HRV data copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _saveToFile(BuildContext context, String data) {
    // For web and mobile platforms, this would typically use a file picker
    // For simplicity, we'll show instructions for now
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Export File'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your data has been prepared for export.'),
            const SizedBox(height: 16),
            const Text('File name suggestion:'),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'pulsepath_export_${DateTime.now().toIso8601String().split('T')[0]}.json',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('The data is available in your clipboard. Paste it into a text file and save with .json extension.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _copyToClipboard(context, data);
            },
            child: const Text('Copy & Close'),
          ),
        ],
      ),
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
              _deleteCloudData(context, ref);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteCloudData(BuildContext context, WidgetRef ref) async {
    try {
      // Show loading dialog
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertDialog(
            title: Text('Deleting Cloud Data'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Removing all data from cloud storage...'),
              ],
            ),
          ),
        );
      }

      // Get the cloud sync service
      final cloudSyncService = ref.read(cloudSyncServiceProvider);
      if (cloudSyncService == null) {
        throw Exception('Cloud sync not available');
      }

      // Get current user
      final authState = ref.read(authStateChangesProvider);
      final user = authState.value;
      if (user == null || user.isAnonymous) {
        throw Exception('User not authenticated');
      }

      // Delete all cloud data by clearing the user's Firestore collections
      final firestore = FirebaseFirestore.instance;
      
      // Delete HRV readings collection
      final hrvCollection = firestore
          .collection('users')
          .doc(user.uid)
          .collection('hrv_readings');
      
      final hrvBatch = firestore.batch();
      final hrvSnapshot = await hrvCollection.get();
      for (final doc in hrvSnapshot.docs) {
        hrvBatch.delete(doc.reference);
      }
      await hrvBatch.commit();

      // Delete preferences collection
      final prefsCollection = firestore
          .collection('users')
          .doc(user.uid)
          .collection('preferences');
          
      final prefsBatch = firestore.batch();
      final prefsSnapshot = await prefsCollection.get();
      for (final doc in prefsSnapshot.docs) {
        prefsBatch.delete(doc.reference);
      }
      await prefsBatch.commit();

      // Delete user document
      await firestore.collection('users').doc(user.uid).delete();

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cloud data deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      // Close loading dialog if still open
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      
      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete cloud data: $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}