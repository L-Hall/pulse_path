import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_preferences.dart';
import '../providers/settings_providers.dart';
import 'settings_section_card.dart';

/// Privacy settings section widget
class PrivacySettingsSection extends ConsumerWidget {
  final UserPreferences preferences;
  
  const PrivacySettingsSection({
    super.key,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsSectionCard(
      title: 'Privacy & Data',
      icon: Icons.privacy_tip,
      subtitle: 'Control your data and privacy settings',
      children: [
        // Cloud sync
        SwitchListTile(
          secondary: const Icon(Icons.cloud),
          title: const Text('Cloud Sync'),
          subtitle: const Text('Backup data to the cloud'),
          value: preferences.enableCloudSync,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updatePrivacyPreferences(
              enableCloudSync: value,
            );
          },
        ),
        
        // Data export
        SwitchListTile(
          secondary: const Icon(Icons.download),
          title: const Text('Data Export'),
          subtitle: const Text('Allow exporting your data'),
          value: preferences.enableDataExport,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updatePrivacyPreferences(
              enableDataExport: value,
            );
          },
        ),
        
        // Anonymous data sharing
        SwitchListTile(
          secondary: const Icon(Icons.analytics),
          title: const Text('Anonymous Analytics'),
          subtitle: const Text('Help improve the app'),
          value: preferences.shareAnonymousData,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updatePrivacyPreferences(
              shareAnonymousData: value,
            );
          },
        ),
        
        // Crash reporting
        SwitchListTile(
          secondary: const Icon(Icons.bug_report),
          title: const Text('Crash Reports'),
          subtitle: const Text('Send crash reports for bug fixes'),
          value: preferences.enableCrashReporting,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updatePrivacyPreferences(
              enableCrashReporting: value,
            );
          },
        ),
      ],
    );
  }
}