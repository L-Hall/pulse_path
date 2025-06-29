import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_preferences.dart';
import '../providers/settings_providers.dart';
import 'settings_section_card.dart';

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