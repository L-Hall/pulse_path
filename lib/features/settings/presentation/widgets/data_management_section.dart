import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_preferences.dart';
import '../providers/settings_providers.dart';
import 'settings_section_card.dart';
import '../../../dashboard/data/repositories/hrv_repository_interface.dart';
import '../../../dashboard/data/repositories/simple_hrv_repository.dart';
import '../../../dashboard/presentation/providers/dashboard_providers.dart';
import '../../../../core/di/injection_container.dart';

/// Data management section widget
class DataManagementSection extends ConsumerWidget {
  final UserPreferences preferences;
  
  const DataManagementSection({
    super.key,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsSectionCard(
      title: 'Data Management',
      icon: Icons.storage,
      subtitle: 'Manage your HRV data and backups',
      children: [
        // Export data
        ListTile(
          leading: const Icon(Icons.download),
          title: const Text('Export Data'),
          subtitle: const Text('Download all your HRV data'),
          onTap: () => _exportData(context, ref),
        ),
        
        // Import data
        ListTile(
          leading: const Icon(Icons.upload),
          title: const Text('Import Data'),
          subtitle: const Text('Restore from backup file'),
          onTap: () => _importData(context, ref),
        ),
        
        const Divider(height: 1),
        
        // Data retention
        ListTile(
          leading: const Icon(Icons.schedule),
          title: const Text('Data Retention'),
          subtitle: Text('Keep data for ${preferences.dataRetention.displayName}'),
          onTap: () => _showDataRetentionDialog(context, ref),
        ),
        
        // Backup frequency
        ListTile(
          leading: const Icon(Icons.backup),
          title: const Text('Auto Backup'),
          subtitle: Text(preferences.autoBackupFrequency.name.toUpperCase()),
          trailing: Switch(
            value: preferences.enableAutomaticBackup,
            onChanged: (value) {
              // TODO: Update backup preferences
            },
          ),
          onTap: () => _showBackupFrequencyDialog(context, ref),
        ),
        
        // Last backup
        if (preferences.lastBackupDate != null)
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Last Backup'),
            subtitle: Text(_formatBackupDate(preferences.lastBackupDate!)),
          ),
        
        const Divider(height: 1),
        
        // Clear sample data
        ListTile(
          leading: const Icon(Icons.science, color: Colors.orange),
          title: const Text('Clear Sample Data', style: TextStyle(color: Colors.orange)),
          subtitle: const Text('Remove demo data, keep your real readings'),
          onTap: () => _showClearSampleDataDialog(context, ref),
        ),
        
        // Clear all data
        ListTile(
          leading: const Icon(Icons.delete_forever, color: Colors.red),
          title: const Text('Clear All Data', style: TextStyle(color: Colors.red)),
          subtitle: const Text('Permanently delete all HRV data'),
          onTap: () => _showClearDataDialog(context, ref),
        ),
      ],
    );
  }

  void _exportData(BuildContext context, WidgetRef ref) async {
    try {
      final data = await ref.read(userPreferencesNotifierProvider.notifier).exportPreferences();
      // TODO: Save to file or share
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data exported successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _importData(BuildContext context, WidgetRef ref) {
    // TODO: Show file picker and import data
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Import feature coming soon'),
      ),
    );
  }

  void _showDataRetentionDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Retention'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: DataRetentionPeriod.values.map((period) => 
            RadioListTile<DataRetentionPeriod>(
              title: Text(period.displayName),
              value: period,
              groupValue: preferences.dataRetention,
              onChanged: (value) {
                Navigator.of(context).pop();
                if (value != null) {
                  ref.read(userPreferencesNotifierProvider.notifier).updatePrivacyPreferences(
                    dataRetention: value,
                  );
                }
              },
            ),
          ).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showBackupFrequencyDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Backup Frequency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: BackupFrequency.values.map((frequency) => 
            RadioListTile<BackupFrequency>(
              title: Text(frequency.name.toUpperCase()),
              value: frequency,
              groupValue: preferences.autoBackupFrequency,
              onChanged: (value) {
                Navigator.of(context).pop();
                // TODO: Update backup frequency
              },
            ),
          ).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showClearSampleDataDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Sample Data'),
        content: const Text(
          'This will remove all demo/sample data from your dashboard, '
          'keeping only your real HRV readings. This action cannot be undone.\n\n'
          'Are you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _clearSampleData(context, ref);
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

  void _showClearDataDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all your HRV readings, preferences, and settings. This action cannot be undone.\n\nAre you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Clear all data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data cleared'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear Data'),
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
      final repository = kIsWeb 
          ? sl<SimpleHrvRepository>() 
          : await sl.getAsync<HrvRepositoryInterface>();
      await repository.clearSampleData();
      
      // Refresh dashboard providers
      ref.invalidate(dashboardDataProvider);
      ref.invalidate(dataSourceBreakdownProvider);
      
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      
      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sample data cleared successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if open
      if (context.mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to clear sample data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _formatBackupDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}