import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

part 'subscription_product.freezed.dart';
part 'subscription_product.g.dart';

/// Represents a subscription product with its configuration and state
@freezed
class SubscriptionProduct with _$SubscriptionProduct {
  const factory SubscriptionProduct({
    required String id,
    required String title,
    required String description,
    required String price,
    required String currencyCode,
    required double rawPrice,
    required SubscriptionType type,
    required SubscriptionDuration duration,
    required List<String> features,
    @Default(false) bool isActive,
    @Default(false) bool isPopular,
    @Default(null) String? originalPrice,
    @Default(null) String? discountPercentage,
    @JsonKey(includeFromJson: false, includeToJson: false) 
    @Default(null) ProductDetails? productDetails,
  }) = _SubscriptionProduct;

  factory SubscriptionProduct.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionProductFromJson(json);
}

/// Subscription type enum
enum SubscriptionType {
  monthly,
  annual,
  lifetime,
  free,
}

/// Subscription duration enum
enum SubscriptionDuration {
  month,
  year,
  lifetime,
  free,
}

/// Subscription status model
@freezed
class SubscriptionStatus with _$SubscriptionStatus {
  const factory SubscriptionStatus({
    required bool isActive,
    required SubscriptionType currentType,
    @Default(null) DateTime? expiryDate,
    @Default(null) DateTime? purchaseDate,
    @Default(null) String? transactionId,
    @Default(false) bool isInTrialPeriod,
    @Default(false) bool isInIntroductoryPeriod,
    @Default(false) bool autoRenewEnabled,
  }) = _SubscriptionStatus;

  factory SubscriptionStatus.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionStatusFromJson(json);
}

/// Purchase result model
@freezed
class PurchaseResult with _$PurchaseResult {
  const factory PurchaseResult.success({
    required String productId,
    required String transactionId,
    required DateTime purchaseDate,
    required SubscriptionStatus subscriptionStatus,
  }) = _PurchaseSuccess;

  const factory PurchaseResult.error({
    required String message,
    required PurchaseErrorType errorType,
    @Default(null) String? productId,
  }) = _PurchaseError;

  const factory PurchaseResult.cancelled({
    required String productId,
  }) = _PurchaseCancelled;
}

/// Purchase error types
enum PurchaseErrorType {
  networkError,
  userCancelled,
  paymentInvalid,
  productNotFound,
  alreadyPurchased,
  insufficientFunds,
  unknown,
}

/// Feature access model
@freezed
class FeatureAccess with _$FeatureAccess {
  const factory FeatureAccess({
    required bool advancedAnalytics,
    required bool dataExport,
    required bool cloudSync,
    required bool premiumSupport,
    required bool adaptivePacing,
    required bool unlimitedReadings,
    required bool customMetrics,
    required bool trendPredictions,
  }) = _FeatureAccess;

  factory FeatureAccess.fromJson(Map<String, dynamic> json) =>
      _$FeatureAccessFromJson(json);
}

/// Constants for subscription configuration
class SubscriptionConfig {
  // Product IDs - these must match App Store Connect and Google Play Console
  static const String monthlyProductId = 'pulsepath_monthly_subscription';
  static const String annualProductId = 'pulsepath_annual_subscription';
  static const String lifetimeProductId = 'pulsepath_lifetime_purchase';
  
  // Product IDs list for easy iteration
  static const List<String> allProductIds = [
    monthlyProductId,
    annualProductId,
    lifetimeProductId,
  ];
  
  // Pricing (for display purposes - actual prices come from stores)
  static const double monthlyPrice = 5.99;
  static const double annualPrice = 39.99;
  static const double lifetimePrice = 99.0;
  
  // Feature configurations
  static const int freeReadingsLimit = 10;
  static const int premiumReadingsLimit = -1; // Unlimited
  
  // Default feature access configurations
  static const FeatureAccess freeFeatures = FeatureAccess(
    advancedAnalytics: false,
    dataExport: false,
    cloudSync: true, // Cloud sync is free but limited
    premiumSupport: false,
    adaptivePacing: true, // Core feature - always available
    unlimitedReadings: false,
    customMetrics: false,
    trendPredictions: false,
  );
  
  static const FeatureAccess premiumFeatures = FeatureAccess(
    advancedAnalytics: true,
    dataExport: true,
    cloudSync: true,
    premiumSupport: true,
    adaptivePacing: true,
    unlimitedReadings: true,
    customMetrics: true,
    trendPredictions: true,
  );
}