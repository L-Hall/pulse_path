import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_preferences.dart';
import '../providers/settings_providers.dart';
import 'settings_section_card.dart';

/// Adaptive pacing settings for chronic illness management
class AdaptivePacingSection extends ConsumerWidget {
  final UserPreferences preferences;
  
  const AdaptivePacingSection({
    super.key,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsSectionCard(
      title: 'Adaptive Pacing',
      icon: Icons.accessibility,
      subtitle: 'Settings for chronic illness and PEM prevention',
      children: [
        // Enable adaptive pacing
        SwitchListTile(
          secondary: const Icon(Icons.accessibility),
          title: const Text('Enable Adaptive Pacing'),
          subtitle: const Text('Get guidance for chronic conditions'),
          value: preferences.enableAdaptivePacing,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updateAdaptivePacingPreferences(
              enableAdaptivePacing: value,
            );
          },
        ),
        
        if (preferences.enableAdaptivePacing) ...[
          // PEM risk threshold
          ListTile(
            leading: const Icon(Icons.warning),
            title: const Text('PEM Risk Level'),
            subtitle: Text(preferences.pemRiskThreshold.displayName),
            onTap: () => _showRiskLevelDialog(context, ref),
          ),
          
          // Show PEM warnings
          SwitchListTile(
            secondary: const Icon(Icons.notification_important),
            title: const Text('PEM Warnings'),
            subtitle: const Text('Show alerts for potential overexertion'),
            value: preferences.showPemWarnings,
            onChanged: (value) {
              ref.read(userPreferencesNotifierProvider.notifier).updateAdaptivePacingPreferences(
                showPemWarnings: value,
              );
            },
          ),
          
          // Rest day threshold
          ListTile(
            leading: const Icon(Icons.bed),
            title: const Text('Rest Day Threshold'),
            subtitle: Text('${preferences.restDayThresholdScore} recovery score'),
            onTap: () => _showThresholdDialog(context, ref),
          ),
        ],
      ],
    );
  }

  void _showRiskLevelDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('PEM Risk Level'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: PemRiskLevel.values.map((level) => 
            RadioListTile<PemRiskLevel>(
              title: Text(level.displayName),
              subtitle: Text(level.description),
              value: level,
              groupValue: preferences.pemRiskThreshold,
              onChanged: (value) {
                Navigator.of(context).pop();
                if (value != null) {
                  ref.read(userPreferencesNotifierProvider.notifier).updateAdaptivePacingPreferences(
                    pemRiskThreshold: value,
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

  void _showThresholdDialog(BuildContext context, WidgetRef ref) {
    int selectedThreshold = preferences.restDayThresholdScore;
    
    showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Rest Day Threshold'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Recovery Score: $selectedThreshold',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'Suggest rest when recovery score is below this level',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Slider(
                value: selectedThreshold.toDouble(),
                min: 30,
                max: 80,
                divisions: 50,
                onChanged: (value) {
                  setState(() {
                    selectedThreshold = value.round();
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(userPreferencesNotifierProvider.notifier).updateAdaptivePacingPreferences(
                  restDayThresholdScore: selectedThreshold,
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}