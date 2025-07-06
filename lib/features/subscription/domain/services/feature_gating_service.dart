import 'package:flutter/material.dart';
import 'purchase_service.dart';
import '../models/subscription_product.dart';

/// Service for managing feature access and gating
class FeatureGatingService {
  final PurchaseService _purchaseService;

  FeatureGatingService(this._purchaseService);

  /// Check if a feature is accessible
  bool hasAccess(String featureName) {
    return _purchaseService.hasFeatureAccess(featureName);
  }

  /// Get current feature access configuration
  FeatureAccess getFeatureAccess() {
    return _purchaseService.getFeatureAccess();
  }

  /// Check if user has premium subscription
  bool get isPremium => _purchaseService.isPremiumActive;

  /// Show upgrade prompt for a specific feature
  void showUpgradePrompt(BuildContext context, String featureName) {
    final message = _getUpgradeMessage(featureName);
    
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Premium Feature'),
        content: Text(message),
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

  /// Navigate to subscription page
  void _navigateToSubscription(BuildContext context) {
    // Navigate to subscription paywall
    Navigator.of(context).pushNamed('/subscription');
  }

  /// Get upgrade message for a specific feature
  String _getUpgradeMessage(String featureName) {
    switch (featureName.toLowerCase()) {
      case 'advanced_analytics':
        return 'Unlock advanced HRV analytics with detailed insights, correlations, and trend analysis. Upgrade to Premium to access this feature.';
      case 'data_export':
        return 'Export your HRV data in CSV and PDF formats for external analysis. Upgrade to Premium for data export capabilities.';
      case 'unlimited_readings':
        return 'Take unlimited HRV readings per month. Free users are limited to 10 readings. Upgrade to Premium for unlimited access.';
      case 'custom_metrics':
        return 'Create and track custom HRV metrics tailored to your specific needs. Upgrade to Premium for custom metrics.';
      case 'trend_predictions':
        return 'Get AI-powered predictions of your HRV trends and recovery patterns. Upgrade to Premium for trend predictions.';
      case 'premium_support':
        return 'Get priority support from our HRV experts with faster response times. Upgrade to Premium for premium support.';
      default:
        return 'This feature requires a Premium subscription. Upgrade to unlock all premium features and enhance your HRV tracking experience.';
    }
  }

  /// Check if readings limit is reached
  bool isReadingsLimitReached(int currentReadings) {
    if (isPremium) {
      return false; // No limit for premium users
    }
    return currentReadings >= SubscriptionConfig.freeReadingsLimit;
  }

  /// Get readings limit for current subscription
  int getReadingsLimit() {
    if (isPremium) {
      return SubscriptionConfig.premiumReadingsLimit; // Unlimited (-1)
    }
    return SubscriptionConfig.freeReadingsLimit;
  }

  /// Get remaining readings for free users
  int getRemainingReadings(int currentReadings) {
    if (isPremium) {
      return -1; // Unlimited
    }
    final remaining = SubscriptionConfig.freeReadingsLimit - currentReadings;
    return remaining.clamp(0, SubscriptionConfig.freeReadingsLimit);
  }

  /// Show readings limit warning
  void showReadingsLimitWarning(BuildContext context, int remainingReadings) {
    String message;
    if (remainingReadings <= 0) {
      message = 'You\'ve reached your monthly limit of ${SubscriptionConfig.freeReadingsLimit} HRV readings. Upgrade to Premium for unlimited readings.';
    } else if (remainingReadings <= 2) {
      message = 'You have $remainingReadings HRV readings remaining this month. Upgrade to Premium for unlimited readings.';
    } else {
      return; // Don't show warning if more than 2 readings remaining
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reading Limit'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
          if (remainingReadings <= 0)
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

  /// Check if export is allowed
  bool canExportData() {
    return hasAccess('data_export');
  }

  /// Check if advanced analytics are available
  bool canAccessAdvancedAnalytics() {
    return hasAccess('advanced_analytics');
  }

  /// Check if custom metrics are available
  bool canUseCustomMetrics() {
    return hasAccess('custom_metrics');
  }

  /// Check if trend predictions are available
  bool canAccessTrendPredictions() {
    return hasAccess('trend_predictions');
  }

  /// Check if premium support is available
  bool hasPremiumSupport() {
    return hasAccess('premium_support');
  }

  /// Get feature badge text for UI
  String? getFeatureBadge(String featureName) {
    if (hasAccess(featureName)) {
      return null; // No badge needed for accessible features
    }
    
    switch (featureName.toLowerCase()) {
      case 'advanced_analytics':
      case 'data_export':
      case 'custom_metrics':
      case 'trend_predictions':
      case 'premium_support':
        return 'PREMIUM';
      case 'unlimited_readings':
        return 'PREMIUM';
      default:
        return 'PREMIUM';
    }
  }
}