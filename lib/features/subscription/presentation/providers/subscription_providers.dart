import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/services/purchase_service.dart';
import '../../domain/models/subscription_product.dart' as models;

part 'subscription_providers.g.dart';

/// Provider for the purchase service
@riverpod
PurchaseService purchaseService(PurchaseServiceRef ref) {
  return sl<PurchaseService>();
}

/// Provider for subscription products
@riverpod
class SubscriptionProducts extends _$SubscriptionProducts {
  @override
  List<models.SubscriptionProduct> build() {
    final purchaseService = ref.watch(purchaseServiceProvider);
    return purchaseService.availableProducts;
  }

  /// Load products from the store
  Future<void> loadProducts() async {
    final purchaseService = ref.read(purchaseServiceProvider);
    await purchaseService.initialize();
    state = purchaseService.availableProducts;
  }
}

/// Provider for current subscription status
@riverpod
class CurrentSubscriptionStatus extends _$CurrentSubscriptionStatus {
  @override
  models.SubscriptionStatus build() {
    final purchaseService = ref.watch(purchaseServiceProvider);
    return purchaseService.currentStatus;
  }

  /// Check if premium features are active
  bool get isPremiumActive {
    final purchaseService = ref.read(purchaseServiceProvider);
    return purchaseService.isPremiumActive;
  }

  /// Get current feature access
  models.FeatureAccess getFeatureAccess() {
    final purchaseService = ref.read(purchaseServiceProvider);
    return purchaseService.getFeatureAccess();
  }

  /// Check if a specific feature is accessible
  bool hasFeatureAccess(String featureName) {
    final purchaseService = ref.read(purchaseServiceProvider);
    return purchaseService.hasFeatureAccess(featureName);
  }
}

/// Provider for purchase results stream
@riverpod
Stream<models.PurchaseResult> purchaseResultStream(PurchaseResultStreamRef ref) {
  final purchaseService = ref.watch(purchaseServiceProvider);
  return purchaseService.purchaseResultStream;
}

/// Provider for subscription status stream
@riverpod
Stream<models.SubscriptionStatus> subscriptionStatusStream(SubscriptionStatusStreamRef ref) {
  final purchaseService = ref.watch(purchaseServiceProvider);
  return purchaseService.subscriptionStatusStream;
}

/// Provider for products stream
@riverpod
Stream<List<models.SubscriptionProduct>> productsStream(ProductsStreamRef ref) {
  final purchaseService = ref.watch(purchaseServiceProvider);
  return purchaseService.productsStream;
}

/// Provider to purchase a product
@riverpod
class ProductPurchaser extends _$ProductPurchaser {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  /// Purchase a subscription product
  Future<void> purchaseProduct(models.SubscriptionProduct product) async {
    state = const AsyncValue.loading();
    
    try {
      final purchaseService = ref.read(purchaseServiceProvider);
      await purchaseService.purchaseProduct(product);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Restore previous purchases
  Future<void> restorePurchases() async {
    state = const AsyncValue.loading();
    
    try {
      final purchaseService = ref.read(purchaseServiceProvider);
      await purchaseService.restorePurchases();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

/// Provider for feature gating
@riverpod
class FeatureGating extends _$FeatureGating {
  @override
  models.FeatureAccess build() {
    final purchaseService = ref.watch(purchaseServiceProvider);
    return purchaseService.getFeatureAccess();
  }

  /// Check if advanced analytics is available
  bool get hasAdvancedAnalytics => state.advancedAnalytics;

  /// Check if data export is available
  bool get hasDataExport => state.dataExport;

  /// Check if cloud sync is available
  bool get hasCloudSync => state.cloudSync;

  /// Check if premium support is available
  bool get hasPremiumSupport => state.premiumSupport;

  /// Check if adaptive pacing is available
  bool get hasAdaptivePacing => state.adaptivePacing;

  /// Check if unlimited readings are available
  bool get hasUnlimitedReadings => state.unlimitedReadings;

  /// Check if custom metrics are available
  bool get hasCustomMetrics => state.customMetrics;

  /// Check if trend predictions are available
  bool get hasTrendPredictions => state.trendPredictions;

  /// Get upgrade message for a specific feature
  String getUpgradeMessage(String featureName) {
    switch (featureName.toLowerCase()) {
      case 'advanced_analytics':
        return 'Unlock advanced HRV analytics with detailed insights and correlations. Upgrade to Premium to access this feature.';
      case 'data_export':
        return 'Export your HRV data in CSV and PDF formats. Upgrade to Premium to access data export.';
      case 'cloud_sync':
        return 'Sync your data across all devices with unlimited cloud storage. Upgrade to Premium for enhanced cloud sync.';
      case 'premium_support':
        return 'Get priority support from our HRV experts. Upgrade to Premium for premium support.';
      case 'unlimited_readings':
        return 'Take unlimited HRV readings per month. Free users are limited to 10 readings. Upgrade to Premium for unlimited access.';
      case 'custom_metrics':
        return 'Create and track custom HRV metrics tailored to your needs. Upgrade to Premium for custom metrics.';
      case 'trend_predictions':
        return 'Get AI-powered predictions of your HRV trends and recovery patterns. Upgrade to Premium for trend predictions.';
      default:
        return 'This feature requires a Premium subscription. Upgrade to unlock all features.';
    }
  }
}

/// Provider for subscription initialization
@riverpod
class SubscriptionInitializer extends _$SubscriptionInitializer {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.loading();
  }

  /// Initialize the subscription service
  Future<void> initialize() async {
    try {
      final purchaseService = ref.read(purchaseServiceProvider);
      await purchaseService.initialize();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

/// Helper provider to get the most popular subscription
@riverpod
models.SubscriptionProduct? popularSubscription(PopularSubscriptionRef ref) {
  final products = ref.watch(subscriptionProductsProvider);
  try {
    return products.firstWhere((models.SubscriptionProduct product) => product.isPopular);
  } catch (e) {
    return null;
  }
}

/// Helper provider to get subscription by type
@riverpod
models.SubscriptionProduct? subscriptionByType(SubscriptionByTypeRef ref, models.SubscriptionType type) {
  final products = ref.watch(subscriptionProductsProvider);
  try {
    return products.firstWhere((models.SubscriptionProduct product) => product.type == type);
  } catch (e) {
    return null;
  }
}