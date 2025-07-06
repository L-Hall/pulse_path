import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_providers.dart';
import '../../domain/models/user_preferences.dart';
import '../widgets/profile_section.dart';
import '../widgets/capture_settings_section.dart';
import '../widgets/privacy_settings_section.dart';
import '../widgets/display_settings_section.dart';
import '../widgets/adaptive_pacing_section.dart';
import '../widgets/data_management_section.dart';
import '../widgets/about_section.dart';
import '../widgets/device_settings_section.dart';

/// Main settings page with all user preferences
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferencesAsync = ref.watch(userPreferencesNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        actions: [
          IconButton(
            onPressed: () => _showResetDialog(context, ref),
            icon: const Icon(Icons.restore),
            tooltip: 'Reset to defaults',
          ),
        ],
      ),
      body: preferencesAsync.when(
        data: (preferences) => _buildSettingsContent(context, ref, preferences),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(context, ref, error),
      ),
    );
  }

  Widget _buildSettingsContent(BuildContext context, WidgetRef ref, UserPreferences preferences) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          ProfileSection(preferences: preferences),
          
          const SizedBox(height: 24),
          
          // Capture Settings
          CaptureSettingsSection(preferences: preferences),
          
          const SizedBox(height: 24),
          
          // Device Settings
          DeviceSettingsSection(preferences: preferences),
          
          const SizedBox(height: 24),
          
          // Display Settings
          DisplaySettingsSection(preferences: preferences),
          
          const SizedBox(height: 24),
          
          // Adaptive Pacing (if enabled)
          if (preferences.hasChronicConditions || preferences.enableAdaptivePacing) ...[
            AdaptivePacingSection(preferences: preferences),
            const SizedBox(height: 24),
          ],
          
          // Privacy & Data
          PrivacySettingsSection(preferences: preferences),
          
          const SizedBox(height: 24),
          
          // Data Management
          DataManagementSection(preferences: preferences),
          
          const SizedBox(height: 24),
          
          // About & Support
          AboutSection(preferences: preferences),
          
          const SizedBox(height: 100), // Extra space for FAB
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load settings',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(userPreferencesNotifierProvider);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'Are you sure you want to reset all settings to their default values? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(userPreferencesNotifierProvider.notifier).resetToDefaults();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings reset to defaults'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}