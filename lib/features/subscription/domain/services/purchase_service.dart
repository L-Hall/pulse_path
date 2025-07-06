import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/subscription_product.dart';

/// Comprehensive purchase service handling StoreKit 2 and Play Billing v6
class PurchaseService {
  final InAppPurchase _inAppPurchase;
  final FlutterSecureStorage _secureStorage;
  
  // Stream controllers for purchase events
  final StreamController<List<SubscriptionProduct>> _productsController =
      StreamController<List<SubscriptionProduct>>.broadcast();
  final StreamController<PurchaseResult> _purchaseResultController =
      StreamController<PurchaseResult>.broadcast();
  final StreamController<SubscriptionStatus> _subscriptionStatusController =
      StreamController<SubscriptionStatus>.broadcast();
  
  // Internal state
  List<SubscriptionProduct> _availableProducts = [];
  SubscriptionStatus _currentStatus = const SubscriptionStatus(
    isActive: false,
    currentType: SubscriptionType.free,
  );
  
  StreamSubscription<List<PurchaseDetails>>? _purchaseStreamSubscription;
  bool _isInitialized = false;
  
  PurchaseService({
    InAppPurchase? inAppPurchase,
    FlutterSecureStorage? secureStorage,
  }) : _inAppPurchase = inAppPurchase ?? InAppPurchase.instance,
       _secureStorage = secureStorage ?? const FlutterSecureStorage();
  
  // Public streams
  Stream<List<SubscriptionProduct>> get productsStream => _productsController.stream;
  Stream<PurchaseResult> get purchaseResultStream => _purchaseResultController.stream;
  Stream<SubscriptionStatus> get subscriptionStatusStream => _subscriptionStatusController.stream;
  
  // Public getters
  List<SubscriptionProduct> get availableProducts => List.unmodifiable(_availableProducts);
  SubscriptionStatus get currentStatus => _currentStatus;
  bool get isInitialized => _isInitialized;
  bool get isPremiumActive => _currentStatus.isActive && _currentStatus.currentType != SubscriptionType.free;
  
  /// Initialize the purchase service
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      debugPrint('🔄 Initializing PurchaseService...');
      
      // Check if in-app purchase is available
      final bool available = await _inAppPurchase.isAvailable();
      if (!available) {
        debugPrint('❌ In-app purchase not available');
        if (!kIsWeb) {
          throw Exception('In-app purchase not available on this device');
        }
        return;
      }
      
      // Listen to purchase updates
      _purchaseStreamSubscription = _inAppPurchase.purchaseStream.listen(
        _handlePurchaseUpdate,
        onError: (error) {
          debugPrint('❌ Purchase stream error: $error');
          _purchaseResultController.add(PurchaseResult.error(
            message: 'Purchase stream error: $error',
            errorType: PurchaseErrorType.unknown,
          ));
        },
      );
      
      // Load products
      await _loadProducts();
      
      // Restore existing purchases
      await _restorePurchases();
      
      _isInitialized = true;
      debugPrint('✅ PurchaseService initialized successfully');
      
    } catch (e, stackTrace) {
      debugPrint('❌ PurchaseService initialization failed: $e');
      debugPrint('Stack trace: $stackTrace');
      _purchaseResultController.add(PurchaseResult.error(
        message: 'Failed to initialize purchase service: $e',
        errorType: PurchaseErrorType.unknown,
      ));
    }
  }
  
  /// Load available products from the store
  Future<void> _loadProducts() async {
    try {
      debugPrint('🔄 Loading subscription products...');
      
      // Query products from store
      final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(
        SubscriptionConfig.allProductIds.toSet(),
      );
      
      if (response.error != null) {
        debugPrint('❌ Failed to load products: ${response.error}');
        throw Exception('Failed to load products: ${response.error}');
      }
      
      // Convert to our subscription product model
      _availableProducts = response.productDetails.map((productDetails) {
        return _createSubscriptionProduct(productDetails);
      }).toList();
      
      // Sort by price (monthly, annual, lifetime)
      _availableProducts.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
      
      debugPrint('✅ Loaded ${_availableProducts.length} products');
      _productsController.add(_availableProducts);
      
    } catch (e) {
      debugPrint('❌ Error loading products: $e');
      rethrow;
    }
  }
  
  /// Create subscription product from store product details
  SubscriptionProduct _createSubscriptionProduct(ProductDetails productDetails) {
    final productId = productDetails.id;
    SubscriptionType type;
    SubscriptionDuration duration;
    List<String> features;
    bool isPopular = false;
    
    // Configure based on product ID
    switch (productId) {
      case SubscriptionConfig.monthlyProductId:
        type = SubscriptionType.monthly;
        duration = SubscriptionDuration.month;
        features = _getMonthlyFeatures();
        break;
      case SubscriptionConfig.annualProductId:
        type = SubscriptionType.annual;
        duration = SubscriptionDuration.year;
        features = _getAnnualFeatures();
        isPopular = true; // Most popular option
        break;
      case SubscriptionConfig.lifetimeProductId:
        type = SubscriptionType.lifetime;
        duration = SubscriptionDuration.lifetime;
        features = _getLifetimeFeatures();
        break;
      default:
        type = SubscriptionType.free;
        duration = SubscriptionDuration.free;
        features = _getFreeFeatures();
    }
    
    return SubscriptionProduct(
      id: productId,
      title: productDetails.title,
      description: productDetails.description,
      price: productDetails.price,
      currencyCode: productDetails.currencyCode,
      rawPrice: productDetails.rawPrice,
      type: type,
      duration: duration,
      features: features,
      isPopular: isPopular,
      productDetails: productDetails,
    );
  }
  
  /// Get features for monthly subscription
  List<String> _getMonthlyFeatures() {
    return [
      'Advanced HRV Analytics',
      'Data Export (CSV, PDF)',
      'Cloud Sync',
      'Premium Support',
      'Unlimited Readings',
      'Custom Metrics',
    ];
  }
  
  /// Get features for annual subscription
  List<String> _getAnnualFeatures() {
    return [
      'Advanced HRV Analytics',
      'Data Export (CSV, PDF)',
      'Cloud Sync',
      'Premium Support',
      'Unlimited Readings',
      'Custom Metrics',
      'Trend Predictions',
      'Save 33% vs Monthly',
    ];
  }
  
  /// Get features for lifetime subscription
  List<String> _getLifetimeFeatures() {
    return [
      'Advanced HRV Analytics',
      'Data Export (CSV, PDF)',
      'Cloud Sync',
      'Premium Support',
      'Unlimited Readings',
      'Custom Metrics',
      'Trend Predictions',
      'One-time Payment',
      'All Future Features',
    ];
  }
  
  /// Get features for free tier
  List<String> _getFreeFeatures() {
    return [
      'Basic HRV Readings',
      'Adaptive Pacing',
      'Limited Cloud Sync',
      'Community Support',
      '10 Readings/Month',
    ];
  }
  
  /// Purchase a subscription product
  Future<void> purchaseProduct(SubscriptionProduct product) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    try {
      debugPrint('🔄 Purchasing product: ${product.id}');
      
      if (product.productDetails == null) {
        throw Exception('Product details not available');
      }
      
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: product.productDetails!,
      );
      
      // Determine purchase type
      bool success;
      if (product.type == SubscriptionType.lifetime) {
        success = await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
      } else {
        success = await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
      }
      
      if (!success) {
        debugPrint('❌ Failed to initiate purchase');
        _purchaseResultController.add(PurchaseResult.error(
          message: 'Failed to initiate purchase',
          errorType: PurchaseErrorType.unknown,
          productId: product.id,
        ));
      }
      
    } catch (e) {
      debugPrint('❌ Purchase error: $e');
      _purchaseResultController.add(PurchaseResult.error(
        message: 'Purchase failed: $e',
        errorType: _mapErrorType(e),
        productId: product.id,
      ));
    }
  }
  
  /// Restore previous purchases
  Future<void> restorePurchases() async {
    if (!_isInitialized) {
      await initialize();
    }
    
    await _restorePurchases();
  }
  
  /// Internal restore purchases implementation
  Future<void> _restorePurchases() async {
    try {
      debugPrint('🔄 Restoring purchases...');
      
      await _inAppPurchase.restorePurchases();
      
      // The restored purchases will be handled in _handlePurchaseUpdate
      debugPrint('✅ Restore purchases completed');
      
    } catch (e) {
      debugPrint('❌ Restore purchases failed: $e');
      _purchaseResultController.add(PurchaseResult.error(
        message: 'Failed to restore purchases: $e',
        errorType: PurchaseErrorType.unknown,
      ));
    }
  }
  
  /// Handle purchase updates from the store
  void _handlePurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      debugPrint('🔄 Processing purchase: ${purchaseDetails.productID}');
      
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          debugPrint('⏳ Purchase pending: ${purchaseDetails.productID}');
          break;
          
        case PurchaseStatus.purchased:
          debugPrint('✅ Purchase completed: ${purchaseDetails.productID}');
          _processPurchaseSuccess(purchaseDetails);
          break;
          
        case PurchaseStatus.error:
          debugPrint('❌ Purchase error: ${purchaseDetails.error}');
          _processPurchaseError(purchaseDetails);
          break;
          
        case PurchaseStatus.restored:
          debugPrint('🔄 Purchase restored: ${purchaseDetails.productID}');
          _processPurchaseSuccess(purchaseDetails);
          break;
          
        case PurchaseStatus.canceled:
          debugPrint('⏹️ Purchase cancelled: ${purchaseDetails.productID}');
          _processPurchaseCancelled(purchaseDetails);
          break;
      }
      
      // Complete the purchase
      if (purchaseDetails.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }
  
  /// Process successful purchase
  void _processPurchaseSuccess(PurchaseDetails purchaseDetails) {
    final product = _availableProducts.firstWhere(
      (p) => p.id == purchaseDetails.productID,
      orElse: () => SubscriptionProduct(
        id: purchaseDetails.productID,
        title: 'Unknown Product',
        description: '',
        price: '',
        currencyCode: '',
        rawPrice: 0.0,
        type: SubscriptionType.free,
        duration: SubscriptionDuration.free,
        features: [],
      ),
    );
    
    // Update subscription status
    _currentStatus = SubscriptionStatus(
      isActive: true,
      currentType: product.type,
      purchaseDate: DateTime.fromMillisecondsSinceEpoch(
        int.parse(purchaseDetails.transactionDate ?? '0'),
      ),
      transactionId: purchaseDetails.purchaseID,
      autoRenewEnabled: true,
    );
    
    // Save to secure storage
    _saveSubscriptionStatus();
    
    // Emit events
    _subscriptionStatusController.add(_currentStatus);
    _purchaseResultController.add(PurchaseResult.success(
      productId: purchaseDetails.productID,
      transactionId: purchaseDetails.purchaseID ?? '',
      purchaseDate: DateTime.fromMillisecondsSinceEpoch(
        int.parse(purchaseDetails.transactionDate ?? '0'),
      ),
      subscriptionStatus: _currentStatus,
    ));
  }
  
  /// Process purchase error
  void _processPurchaseError(PurchaseDetails purchaseDetails) {
    final error = purchaseDetails.error;
    _purchaseResultController.add(PurchaseResult.error(
      message: error?.message ?? 'Unknown purchase error',
      errorType: _mapStoreErrorType(error),
      productId: purchaseDetails.productID,
    ));
  }
  
  /// Process purchase cancellation
  void _processPurchaseCancelled(PurchaseDetails purchaseDetails) {
    _purchaseResultController.add(PurchaseResult.cancelled(
      productId: purchaseDetails.productID,
    ));
  }
  
  /// Map generic errors to our error types
  PurchaseErrorType _mapErrorType(dynamic error) {
    if (error is PlatformException) {
      return _mapPlatformErrorType(error);
    }
    return PurchaseErrorType.unknown;
  }
  
  /// Map platform errors to our error types
  PurchaseErrorType _mapPlatformErrorType(PlatformException error) {
    switch (error.code) {
      case 'storekit_duplicate_product_object':
      case 'already_owned':
        return PurchaseErrorType.alreadyPurchased;
      case 'user_cancelled':
        return PurchaseErrorType.userCancelled;
      case 'payment_invalid':
        return PurchaseErrorType.paymentInvalid;
      case 'product_not_found':
        return PurchaseErrorType.productNotFound;
      case 'network_error':
        return PurchaseErrorType.networkError;
      default:
        return PurchaseErrorType.unknown;
    }
  }
  
  /// Map store errors to our error types
  PurchaseErrorType _mapStoreErrorType(IAPError? error) {
    if (error == null) return PurchaseErrorType.unknown;
    
    switch (error.code) {
      case 'purchase_error':
        return PurchaseErrorType.paymentInvalid;
      case 'user_cancelled':
        return PurchaseErrorType.userCancelled;
      case 'network_error':
        return PurchaseErrorType.networkError;
      case 'product_not_found':
        return PurchaseErrorType.productNotFound;
      case 'already_owned':
        return PurchaseErrorType.alreadyPurchased;
      default:
        return PurchaseErrorType.unknown;
    }
  }
  
  /// Save subscription status to secure storage
  Future<void> _saveSubscriptionStatus() async {
    try {
      final json = _currentStatus.toJson();
      await _secureStorage.write(
        key: 'subscription_status',
        value: json.toString(),
      );
    } catch (e) {
      debugPrint('❌ Failed to save subscription status: $e');
    }
  }
  
  /// Load subscription status from secure storage
  Future<void> _loadSubscriptionStatus() async {
    try {
      final jsonString = await _secureStorage.read(key: 'subscription_status');
      if (jsonString != null) {
        final json = Map<String, dynamic>.from(jsonString as Map);
        _currentStatus = SubscriptionStatus.fromJson(json);
        _subscriptionStatusController.add(_currentStatus);
      }
    } catch (e) {
      debugPrint('❌ Failed to load subscription status: $e');
    }
  }
  
  /// Get feature access based on current subscription
  FeatureAccess getFeatureAccess() {
    if (_currentStatus.isActive && _currentStatus.currentType != SubscriptionType.free) {
      return SubscriptionConfig.premiumFeatures;
    }
    return SubscriptionConfig.freeFeatures;
  }
  
  /// Check if a specific feature is accessible
  bool hasFeatureAccess(String featureName) {
    final access = getFeatureAccess();
    switch (featureName.toLowerCase()) {
      case 'advanced_analytics':
        return access.advancedAnalytics;
      case 'data_export':
        return access.dataExport;
      case 'cloud_sync':
        return access.cloudSync;
      case 'premium_support':
        return access.premiumSupport;
      case 'adaptive_pacing':
        return access.adaptivePacing;
      case 'unlimited_readings':
        return access.unlimitedReadings;
      case 'custom_metrics':
        return access.customMetrics;
      case 'trend_predictions':
        return access.trendPredictions;
      default:
        return false;
    }
  }
  
  /// Dispose of resources
  void dispose() {
    _purchaseStreamSubscription?.cancel();
    _productsController.close();
    _purchaseResultController.close();
    _subscriptionStatusController.close();
  }
}