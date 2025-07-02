import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_preferences.dart';
import 'settings_section_card.dart';

/// About section widget with app information and links
class AboutSection extends ConsumerWidget {
  final UserPreferences preferences;
  
  const AboutSection({
    super.key,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsSectionCard(
      title: 'About',
      icon: Icons.info,
      subtitle: 'App information and support',
      children: [
        // App version
        ListTile(
          leading: const Icon(Icons.apps),
          title: const Text('PulsePath'),
          subtitle: const Text('Version 1.0.0 (Alpha)\nHRV-based wellbeing tracking'),
          isThreeLine: true,
        ),
        
        const Divider(height: 1),
        
        // Privacy policy
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy Policy'),
          subtitle: const Text('How we protect your data'),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => _launchUrl(context, 'https://pulsepath.app/privacy'),
        ),
        
        // Terms of service
        ListTile(
          leading: const Icon(Icons.article),
          title: const Text('Terms of Service'),
          subtitle: const Text('Usage terms and conditions'),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => _launchUrl(context, 'https://pulsepath.app/terms'),
        ),
        
        // Support
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help & Support'),
          subtitle: const Text('Get help using the app'),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => _launchUrl(context, 'https://pulsepath.app/support'),
        ),
        
        // Rate app
        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('Rate PulsePath'),
          subtitle: const Text('Share your feedback'),
          onTap: () => _showRatingDialog(context),
        ),
        
        const Divider(height: 1),
        
        // Open source licenses
        ListTile(
          leading: const Icon(Icons.code),
          title: const Text('Open Source Licenses'),
          subtitle: const Text('Third-party software acknowledgments'),
          onTap: () => _showLicensePage(context),
        ),
        
        // Debug info (only in debug mode)
        if (_isDebugMode()) ...[
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: const Text('Debug Information'),
            subtitle: const Text('Technical details for troubleshooting'),
            onTap: () => _showDebugInfo(context),
          ),
        ],
      ],
    );
  }

  void _launchUrl(BuildContext context, String url) {
    // TODO: Implement URL launching when url_launcher is added
    // For now, just show a message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Visit: $url'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rate PulsePath'),
        content: const Text(
          'Enjoying PulsePath? Your feedback helps us improve the app for everyone. Would you like to rate us on the App Store?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Maybe Later'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Open app store rating page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Thank you for your feedback!'),
                ),
              );
            },
            child: const Text('Rate App'),
          ),
        ],
      ),
    );
  }

  void _showLicensePage(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: 'PulsePath',
      applicationVersion: '1.0.0 (Alpha)',
      applicationLegalese: '© 2024 PulsePath. All rights reserved.\n\nPulsePath is committed to privacy-first HRV tracking with transparent algorithms and secure data handling.',
    );
  }

  void _showDebugInfo(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Debug Information'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('App Version: 1.0.0 (Alpha)', style: Theme.of(context).textTheme.bodyMedium),
              Text('Build Mode: ${_isDebugMode() ? 'Debug' : 'Release'}', style: Theme.of(context).textTheme.bodyMedium),
              Text('Platform: ${Theme.of(context).platform.name}', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text('User Preferences:', style: Theme.of(context).textTheme.titleMedium),
              Text('Theme: ${preferences.themeMode.displayName}', style: Theme.of(context).textTheme.bodySmall),
              Text('Capture Method: ${preferences.preferredCaptureMethod.displayName}', style: Theme.of(context).textTheme.bodySmall),
              Text('Cloud Sync: ${preferences.enableCloudSync ? 'Enabled' : 'Disabled'}', style: Theme.of(context).textTheme.bodySmall),
              Text('Adaptive Pacing: ${preferences.enableAdaptivePacing ? 'Enabled' : 'Disabled'}', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Copy debug info to clipboard
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Debug info copied to clipboard'),
                ),
              );
            },
            child: const Text('Copy'),
          ),
        ],
      ),
    );
  }

  bool _isDebugMode() {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }
}