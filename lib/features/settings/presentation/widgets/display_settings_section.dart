import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter/material.dart' as material show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_preferences.dart';
import '../providers/settings_providers.dart';
import 'settings_section_card.dart';

/// Display settings section widget
class DisplaySettingsSection extends ConsumerWidget {
  final UserPreferences preferences;
  
  const DisplaySettingsSection({
    super.key,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsSectionCard(
      title: 'Display',
      icon: Icons.display_settings,
      subtitle: 'Customize app appearance and units',
      children: [
        // Theme mode
        ListTile(
          leading: const Icon(Icons.palette),
          title: const Text('Theme'),
          subtitle: Text(preferences.themeMode.displayName),
          onTap: () => _showThemeDialog(context, ref),
        ),
        
        // Chart time range
        ListTile(
          leading: const Icon(Icons.timeline),
          title: const Text('Default Chart Range'),
          subtitle: Text(preferences.defaultChartRange.displayName),
          onTap: () => _showChartRangeDialog(context, ref),
        ),
        
        const Divider(height: 1),
        
        // 24-hour format
        SwitchListTile(
          secondary: const Icon(Icons.access_time),
          title: const Text('24-Hour Format'),
          value: preferences.use24HourFormat,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updateDisplayPreferences(
              use24HourFormat: value,
            );
          },
        ),
        
        // Show advanced metrics
        SwitchListTile(
          secondary: const Icon(Icons.analytics),
          title: const Text('Advanced Metrics'),
          subtitle: const Text('Show all 14 HRV metrics'),
          value: preferences.showAdvancedMetrics,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updateDisplayPreferences(
              showAdvancedMetrics: value,
            );
          },
        ),
        
        // Show confidence scores
        SwitchListTile(
          secondary: const Icon(Icons.verified),
          title: const Text('Confidence Scores'),
          subtitle: const Text('Display measurement confidence'),
          value: preferences.showConfidenceScores,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updateDisplayPreferences(
              showConfidenceScores: value,
            );
          },
        ),
      ],
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeMode.values.map((theme) => 
            RadioListTile<ThemeMode>(
              title: Text(theme.displayName),
              value: theme,
              groupValue: preferences.themeMode,
              onChanged: (value) {
                Navigator.of(context).pop();
                if (value != null) {
                  ref.read(userPreferencesNotifierProvider.notifier).updateDisplayPreferences(
                    themeMode: value,
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

  void _showChartRangeDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Default Chart Range'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ChartTimeRange.values.map((range) => 
            RadioListTile<ChartTimeRange>(
              title: Text(range.displayName),
              value: range,
              groupValue: preferences.defaultChartRange,
              onChanged: (value) {
                Navigator.of(context).pop();
                if (value != null) {
                  ref.read(userPreferencesNotifierProvider.notifier).updateDisplayPreferences(
                    defaultChartRange: value,
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
}