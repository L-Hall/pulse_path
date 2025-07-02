import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_preferences.dart';
import '../providers/settings_providers.dart';
import 'settings_section_card.dart';

/// Capture settings section widget
class CaptureSettingsSection extends ConsumerWidget {
  final UserPreferences preferences;
  
  const CaptureSettingsSection({
    super.key,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsSectionCard(
      title: 'HRV Capture',
      icon: Icons.favorite,
      subtitle: 'Configure how you capture HRV readings',
      children: [
        // Preferred capture method
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Default Capture Method'),
          subtitle: Text(preferences.preferredCaptureMethod.displayName),
          onTap: () => _showCaptureMethodDialog(context, ref),
        ),
        
        // Capture duration
        ListTile(
          leading: const Icon(Icons.timer),
          title: const Text('Capture Duration'),
          subtitle: Text('${(preferences.captureTimeSeconds / 60).toStringAsFixed(1)} minutes'),
          onTap: () => _showDurationDialog(context, ref),
        ),
        
        const Divider(height: 1),
        
        // Enable capture sound
        SwitchListTile(
          secondary: const Icon(Icons.volume_up),
          title: const Text('Capture Sounds'),
          subtitle: const Text('Play audio cues during capture'),
          value: preferences.enableCaptureSound,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updateCapturePreferences(
              enableCaptureSound: value,
            );
          },
        ),
        
        // Enable haptic feedback
        SwitchListTile(
          secondary: const Icon(Icons.vibration),
          title: const Text('Haptic Feedback'),
          subtitle: const Text('Vibration during capture'),
          value: preferences.enableHapticFeedback,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updateCapturePreferences(
              enableHapticFeedback: value,
            );
          },
        ),
        
        // Enable flashlight (for camera capture)
        if (preferences.preferredCaptureMethod == CaptureMethod.camera ||
            preferences.preferredCaptureMethod == CaptureMethod.auto)
          SwitchListTile(
            secondary: const Icon(Icons.flashlight_on),
            title: const Text('Camera Flash'),
            subtitle: const Text('Use flashlight for better PPG signal'),
            value: preferences.enableFlashlight,
            onChanged: (value) {
              ref.read(userPreferencesNotifierProvider.notifier).updateCapturePreferences(
                enableFlashlight: value,
              );
            },
          ),
        
        // Auto-start capture
        SwitchListTile(
          secondary: const Icon(Icons.play_arrow),
          title: const Text('Auto-Start Capture'),
          subtitle: const Text('Start capture immediately when opening'),
          value: preferences.autoStartCapture,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updateCapturePreferences(
              autoStartCapture: value,
            );
          },
        ),
      ],
    );
  }

  void _showCaptureMethodDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Default Capture Method'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: CaptureMethod.values.map((method) => 
            RadioListTile<CaptureMethod>(
              title: Text(method.displayName.split(' (')[0]),
              subtitle: method == CaptureMethod.auto 
                  ? const Text('Use BLE if available, fallback to camera')
                  : null,
              value: method,
              groupValue: preferences.preferredCaptureMethod,
              onChanged: (value) {
                Navigator.of(context).pop();
                if (value != null) {
                  ref.read(userPreferencesNotifierProvider.notifier).updateCapturePreferences(
                    preferredCaptureMethod: value,
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

  void _showDurationDialog(BuildContext context, WidgetRef ref) {
    final durations = [120, 180, 240, 300]; // 2, 3, 4, 5 minutes
    
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Capture Duration'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: durations.map((seconds) => 
            RadioListTile<int>(
              title: Text('${(seconds / 60).toStringAsFixed(0)} minutes'),
              subtitle: seconds == 180 
                  ? const Text('Recommended for most users')
                  : seconds == 300
                      ? const Text('For detailed analysis')
                      : null,
              value: seconds,
              groupValue: preferences.captureTimeSeconds,
              onChanged: (value) {
                Navigator.of(context).pop();
                if (value != null) {
                  ref.read(userPreferencesNotifierProvider.notifier).updateCapturePreferences(
                    captureTimeSeconds: value,
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