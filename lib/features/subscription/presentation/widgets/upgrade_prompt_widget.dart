import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/subscription_paywall_page.dart';

/// Widget that shows an upgrade prompt for premium features
class UpgradePromptWidget extends ConsumerWidget {
  final String featureName;
  final String? customMessage;
  final Widget? child;

  const UpgradePromptWidget({
    super.key,
    required this.featureName,
    this.customMessage,
    this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showUpgradeDialog(context),
      child: child ?? _buildDefaultPrompt(context),
    );
  }

  Widget _buildDefaultPrompt(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Premium Feature',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            customMessage ?? _getDefaultMessage(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _navigateToSubscription(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Text('Upgrade to Premium'),
          ),
        ],
      ),
    );
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.star,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('Premium Feature'),
          ],
        ),
        content: Text(customMessage ?? _getDefaultMessage()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _navigateToSubscription(context);
            },
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );
  }

  void _navigateToSubscription(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const SubscriptionPaywallPage(),
      ),
    );
  }

  String _getDefaultMessage() {
    switch (featureName.toLowerCase()) {
      case 'advanced_analytics':
        return 'Unlock advanced HRV analytics with detailed insights and correlations.';
      case 'data_export':
        return 'Export your HRV data in CSV and PDF formats for external analysis.';
      case 'unlimited_readings':
        return 'Take unlimited HRV readings per month. Free users are limited to 10 readings.';
      case 'custom_metrics':
        return 'Create and track custom HRV metrics tailored to your needs.';
      case 'trend_predictions':
        return 'Get AI-powered predictions of your HRV trends and recovery patterns.';
      case 'premium_support':
        return 'Get priority support from our HRV experts with faster response times.';
      default:
        return 'This feature requires a Premium subscription. Upgrade to unlock all premium features.';
    }
  }
}

/// A banner widget that shows upgrade prompts
class UpgradeBannerWidget extends ConsumerWidget {
  final String message;
  final VoidCallback? onTap;
  final bool isDismissible;

  const UpgradeBannerWidget({
    super.key,
    required this.message,
    this.onTap,
    this.isDismissible = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: onTap ?? () => _navigateToSubscription(context),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              side: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            child: const Text('Upgrade'),
          ),
          if (isDismissible) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                // TODO: Implement banner dismissal logic
              },
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _navigateToSubscription(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const SubscriptionPaywallPage(),
      ),
    );
  }
}

/// A floating action button that promotes premium features
class PremiumFabWidget extends ConsumerWidget {
  final VoidCallback? onPressed;

  const PremiumFabWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: onPressed ?? () => _navigateToSubscription(context),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      icon: const Icon(Icons.star),
      label: const Text('Go Premium'),
    );
  }

  void _navigateToSubscription(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const SubscriptionPaywallPage(),
      ),
    );
  }
}