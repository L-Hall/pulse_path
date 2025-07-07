// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$purchaseServiceHash() => r'fe406d02903d8f053bf2d64fb5dcfc5193a8666e';

/// Provider for the purchase service
///
/// Copied from [purchaseService].
@ProviderFor(purchaseService)
final purchaseServiceProvider = AutoDisposeProvider<PurchaseService>.internal(
  purchaseService,
  name: r'purchaseServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$purchaseServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PurchaseServiceRef = AutoDisposeProviderRef<PurchaseService>;
String _$purchaseResultStreamHash() =>
    r'9bf6c75820159029a2e821d92bd6f0c9cd7a930a';

/// Provider for purchase results stream
///
/// Copied from [purchaseResultStream].
@ProviderFor(purchaseResultStream)
final purchaseResultStreamProvider =
    AutoDisposeStreamProvider<models.PurchaseResult>.internal(
  purchaseResultStream,
  name: r'purchaseResultStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$purchaseResultStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PurchaseResultStreamRef
    = AutoDisposeStreamProviderRef<models.PurchaseResult>;
String _$subscriptionStatusStreamHash() =>
    r'022cfc416f43fb77887840345506b1e499ff1997';

/// Provider for subscription status stream
///
/// Copied from [subscriptionStatusStream].
@ProviderFor(subscriptionStatusStream)
final subscriptionStatusStreamProvider =
    AutoDisposeStreamProvider<models.SubscriptionStatus>.internal(
  subscriptionStatusStream,
  name: r'subscriptionStatusStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$subscriptionStatusStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubscriptionStatusStreamRef
    = AutoDisposeStreamProviderRef<models.SubscriptionStatus>;
String _$productsStreamHash() => r'c0185f075faa2a47c35d983ed1188cce4499f8ce';

/// Provider for products stream
///
/// Copied from [productsStream].
@ProviderFor(productsStream)
final productsStreamProvider =
    AutoDisposeStreamProvider<List<models.SubscriptionProduct>>.internal(
  productsStream,
  name: r'productsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsStreamRef
    = AutoDisposeStreamProviderRef<List<models.SubscriptionProduct>>;
String _$popularSubscriptionHash() =>
    r'742ccf05d110deb4a462a26b9c47c8ba7c85e31b';

/// Helper provider to get the most popular subscription
///
/// Copied from [popularSubscription].
@ProviderFor(popularSubscription)
final popularSubscriptionProvider =
    AutoDisposeProvider<models.SubscriptionProduct?>.internal(
  popularSubscription,
  name: r'popularSubscriptionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$popularSubscriptionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PopularSubscriptionRef
    = AutoDisposeProviderRef<models.SubscriptionProduct?>;
String _$subscriptionByTypeHash() =>
    r'896ba34a32d9323660ec230e44e2a0a989c942f9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Helper provider to get subscription by type
///
/// Copied from [subscriptionByType].
@ProviderFor(subscriptionByType)
const subscriptionByTypeProvider = SubscriptionByTypeFamily();

/// Helper provider to get subscription by type
///
/// Copied from [subscriptionByType].
class SubscriptionByTypeFamily extends Family<models.SubscriptionProduct?> {
  /// Helper provider to get subscription by type
  ///
  /// Copied from [subscriptionByType].
  const SubscriptionByTypeFamily();

  /// Helper provider to get subscription by type
  ///
  /// Copied from [subscriptionByType].
  SubscriptionByTypeProvider call(
    SubscriptionType type,
  ) {
    return SubscriptionByTypeProvider(
      type,
    );
  }

  @override
  SubscriptionByTypeProvider getProviderOverride(
    covariant SubscriptionByTypeProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'subscriptionByTypeProvider';
}

/// Helper provider to get subscription by type
///
/// Copied from [subscriptionByType].
class SubscriptionByTypeProvider
    extends AutoDisposeProvider<models.SubscriptionProduct?> {
  /// Helper provider to get subscription by type
  ///
  /// Copied from [subscriptionByType].
  SubscriptionByTypeProvider(
    SubscriptionType type,
  ) : this._internal(
          (ref) => subscriptionByType(
            ref as SubscriptionByTypeRef,
            type,
          ),
          from: subscriptionByTypeProvider,
          name: r'subscriptionByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$subscriptionByTypeHash,
          dependencies: SubscriptionByTypeFamily._dependencies,
          allTransitiveDependencies:
              SubscriptionByTypeFamily._allTransitiveDependencies,
          type: type,
        );

  SubscriptionByTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final SubscriptionType type;

  @override
  Override overrideWith(
    models.SubscriptionProduct? Function(SubscriptionByTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubscriptionByTypeProvider._internal(
        (ref) => create(ref as SubscriptionByTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<models.SubscriptionProduct?> createElement() {
    return _SubscriptionByTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubscriptionByTypeProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubscriptionByTypeRef
    on AutoDisposeProviderRef<models.SubscriptionProduct?> {
  /// The parameter `type` of this provider.
  SubscriptionType get type;
}

class _SubscriptionByTypeProviderElement
    extends AutoDisposeProviderElement<models.SubscriptionProduct?>
    with SubscriptionByTypeRef {
  _SubscriptionByTypeProviderElement(super.provider);

  @override
  SubscriptionType get type => (origin as SubscriptionByTypeProvider).type;
}

String _$subscriptionProductsHash() =>
    r'9065f00179cd8420411c1a0d89f03aaf5751a1b3';

/// Provider for subscription products
///
/// Copied from [SubscriptionProducts].
@ProviderFor(SubscriptionProducts)
final subscriptionProductsProvider = AutoDisposeNotifierProvider<
    SubscriptionProducts, List<models.SubscriptionProduct>>.internal(
  SubscriptionProducts.new,
  name: r'subscriptionProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$subscriptionProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SubscriptionProducts
    = AutoDisposeNotifier<List<models.SubscriptionProduct>>;
String _$currentSubscriptionStatusHash() =>
    r'534e27047404ecd2be96a936b37e4d3ce7c9767d';

/// Provider for current subscription status
///
/// Copied from [CurrentSubscriptionStatus].
@ProviderFor(CurrentSubscriptionStatus)
final currentSubscriptionStatusProvider = AutoDisposeNotifierProvider<
    CurrentSubscriptionStatus, models.SubscriptionStatus>.internal(
  CurrentSubscriptionStatus.new,
  name: r'currentSubscriptionStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSubscriptionStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSubscriptionStatus
    = AutoDisposeNotifier<models.SubscriptionStatus>;
String _$productPurchaserHash() => r'2df2f61cb8f45ed6a2a4fa78d8e5ccf20ee783c8';

/// Provider to purchase a product
///
/// Copied from [ProductPurchaser].
@ProviderFor(ProductPurchaser)
final productPurchaserProvider =
    AutoDisposeNotifierProvider<ProductPurchaser, AsyncValue<void>>.internal(
  ProductPurchaser.new,
  name: r'productPurchaserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productPurchaserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductPurchaser = AutoDisposeNotifier<AsyncValue<void>>;
String _$featureGatingHash() => r'37622b4cd9b6bbd5f2431bd7d1bbe7d40276ba0b';

/// Provider for feature gating
///
/// Copied from [FeatureGating].
@ProviderFor(FeatureGating)
final featureGatingProvider =
    AutoDisposeNotifierProvider<FeatureGating, models.FeatureAccess>.internal(
  FeatureGating.new,
  name: r'featureGatingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featureGatingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FeatureGating = AutoDisposeNotifier<models.FeatureAccess>;
String _$subscriptionInitializerHash() =>
    r'e4715675e05d9587d1a1fffff746b072710879b5';

/// Provider for subscription initialization
///
/// Copied from [SubscriptionInitializer].
@ProviderFor(SubscriptionInitializer)
final subscriptionInitializerProvider = AutoDisposeNotifierProvider<
    SubscriptionInitializer, AsyncValue<void>>.internal(
  SubscriptionInitializer.new,
  name: r'subscriptionInitializerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$subscriptionInitializerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SubscriptionInitializer = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
