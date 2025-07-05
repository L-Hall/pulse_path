// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubscriptionProduct _$SubscriptionProductFromJson(Map<String, dynamic> json) {
  return _SubscriptionProduct.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionProduct {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String get currencyCode => throw _privateConstructorUsedError;
  double get rawPrice => throw _privateConstructorUsedError;
  SubscriptionType get type => throw _privateConstructorUsedError;
  SubscriptionDuration get duration => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isPopular => throw _privateConstructorUsedError;
  String? get originalPrice => throw _privateConstructorUsedError;
  String? get discountPercentage => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ProductDetails? get productDetails => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionProductCopyWith<SubscriptionProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionProductCopyWith<$Res> {
  factory $SubscriptionProductCopyWith(
          SubscriptionProduct value, $Res Function(SubscriptionProduct) then) =
      _$SubscriptionProductCopyWithImpl<$Res, SubscriptionProduct>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String price,
      String currencyCode,
      double rawPrice,
      SubscriptionType type,
      SubscriptionDuration duration,
      List<String> features,
      bool isActive,
      bool isPopular,
      String? originalPrice,
      String? discountPercentage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ProductDetails? productDetails});
}

/// @nodoc
class _$SubscriptionProductCopyWithImpl<$Res, $Val extends SubscriptionProduct>
    implements $SubscriptionProductCopyWith<$Res> {
  _$SubscriptionProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? price = null,
    Object? currencyCode = null,
    Object? rawPrice = null,
    Object? type = null,
    Object? duration = null,
    Object? features = null,
    Object? isActive = null,
    Object? isPopular = null,
    Object? originalPrice = freezed,
    Object? discountPercentage = freezed,
    Object? productDetails = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      rawPrice: null == rawPrice
          ? _value.rawPrice
          : rawPrice // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SubscriptionType,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as SubscriptionDuration,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPopular: null == isPopular
          ? _value.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      originalPrice: freezed == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      discountPercentage: freezed == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as String?,
      productDetails: freezed == productDetails
          ? _value.productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
              as ProductDetails?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionProductImplCopyWith<$Res>
    implements $SubscriptionProductCopyWith<$Res> {
  factory _$$SubscriptionProductImplCopyWith(_$SubscriptionProductImpl value,
          $Res Function(_$SubscriptionProductImpl) then) =
      __$$SubscriptionProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String price,
      String currencyCode,
      double rawPrice,
      SubscriptionType type,
      SubscriptionDuration duration,
      List<String> features,
      bool isActive,
      bool isPopular,
      String? originalPrice,
      String? discountPercentage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ProductDetails? productDetails});
}

/// @nodoc
class __$$SubscriptionProductImplCopyWithImpl<$Res>
    extends _$SubscriptionProductCopyWithImpl<$Res, _$SubscriptionProductImpl>
    implements _$$SubscriptionProductImplCopyWith<$Res> {
  __$$SubscriptionProductImplCopyWithImpl(_$SubscriptionProductImpl _value,
      $Res Function(_$SubscriptionProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? price = null,
    Object? currencyCode = null,
    Object? rawPrice = null,
    Object? type = null,
    Object? duration = null,
    Object? features = null,
    Object? isActive = null,
    Object? isPopular = null,
    Object? originalPrice = freezed,
    Object? discountPercentage = freezed,
    Object? productDetails = freezed,
  }) {
    return _then(_$SubscriptionProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      rawPrice: null == rawPrice
          ? _value.rawPrice
          : rawPrice // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SubscriptionType,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as SubscriptionDuration,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPopular: null == isPopular
          ? _value.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      originalPrice: freezed == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      discountPercentage: freezed == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as String?,
      productDetails: freezed == productDetails
          ? _value.productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
              as ProductDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionProductImpl implements _SubscriptionProduct {
  const _$SubscriptionProductImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.currencyCode,
      required this.rawPrice,
      required this.type,
      required this.duration,
      required final List<String> features,
      this.isActive = false,
      this.isPopular = false,
      this.originalPrice = null,
      this.discountPercentage = null,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.productDetails = null})
      : _features = features;

  factory _$SubscriptionProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionProductImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String price;
  @override
  final String currencyCode;
  @override
  final double rawPrice;
  @override
  final SubscriptionType type;
  @override
  final SubscriptionDuration duration;
  final List<String> _features;
  @override
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isPopular;
  @override
  @JsonKey()
  final String? originalPrice;
  @override
  @JsonKey()
  final String? discountPercentage;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ProductDetails? productDetails;

  @override
  String toString() {
    return 'SubscriptionProduct(id: $id, title: $title, description: $description, price: $price, currencyCode: $currencyCode, rawPrice: $rawPrice, type: $type, duration: $duration, features: $features, isActive: $isActive, isPopular: $isPopular, originalPrice: $originalPrice, discountPercentage: $discountPercentage, productDetails: $productDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.rawPrice, rawPrice) ||
                other.rawPrice == rawPrice) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isPopular, isPopular) ||
                other.isPopular == isPopular) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            (identical(other.productDetails, productDetails) ||
                other.productDetails == productDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      price,
      currencyCode,
      rawPrice,
      type,
      duration,
      const DeepCollectionEquality().hash(_features),
      isActive,
      isPopular,
      originalPrice,
      discountPercentage,
      productDetails);

  /// Create a copy of SubscriptionProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionProductImplCopyWith<_$SubscriptionProductImpl> get copyWith =>
      __$$SubscriptionProductImplCopyWithImpl<_$SubscriptionProductImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionProductImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionProduct implements SubscriptionProduct {
  const factory _SubscriptionProduct(
      {required final String id,
      required final String title,
      required final String description,
      required final String price,
      required final String currencyCode,
      required final double rawPrice,
      required final SubscriptionType type,
      required final SubscriptionDuration duration,
      required final List<String> features,
      final bool isActive,
      final bool isPopular,
      final String? originalPrice,
      final String? discountPercentage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final ProductDetails? productDetails}) = _$SubscriptionProductImpl;

  factory _SubscriptionProduct.fromJson(Map<String, dynamic> json) =
      _$SubscriptionProductImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get price;
  @override
  String get currencyCode;
  @override
  double get rawPrice;
  @override
  SubscriptionType get type;
  @override
  SubscriptionDuration get duration;
  @override
  List<String> get features;
  @override
  bool get isActive;
  @override
  bool get isPopular;
  @override
  String? get originalPrice;
  @override
  String? get discountPercentage;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ProductDetails? get productDetails;

  /// Create a copy of SubscriptionProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionProductImplCopyWith<_$SubscriptionProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionStatus _$SubscriptionStatusFromJson(Map<String, dynamic> json) {
  return _SubscriptionStatus.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionStatus {
  bool get isActive => throw _privateConstructorUsedError;
  SubscriptionType get currentType => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  DateTime? get purchaseDate => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  bool get isInTrialPeriod => throw _privateConstructorUsedError;
  bool get isInIntroductoryPeriod => throw _privateConstructorUsedError;
  bool get autoRenewEnabled => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionStatusCopyWith<SubscriptionStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionStatusCopyWith<$Res> {
  factory $SubscriptionStatusCopyWith(
          SubscriptionStatus value, $Res Function(SubscriptionStatus) then) =
      _$SubscriptionStatusCopyWithImpl<$Res, SubscriptionStatus>;
  @useResult
  $Res call(
      {bool isActive,
      SubscriptionType currentType,
      DateTime? expiryDate,
      DateTime? purchaseDate,
      String? transactionId,
      bool isInTrialPeriod,
      bool isInIntroductoryPeriod,
      bool autoRenewEnabled});
}

/// @nodoc
class _$SubscriptionStatusCopyWithImpl<$Res, $Val extends SubscriptionStatus>
    implements $SubscriptionStatusCopyWith<$Res> {
  _$SubscriptionStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActive = null,
    Object? currentType = null,
    Object? expiryDate = freezed,
    Object? purchaseDate = freezed,
    Object? transactionId = freezed,
    Object? isInTrialPeriod = null,
    Object? isInIntroductoryPeriod = null,
    Object? autoRenewEnabled = null,
  }) {
    return _then(_value.copyWith(
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      currentType: null == currentType
          ? _value.currentType
          : currentType // ignore: cast_nullable_to_non_nullable
              as SubscriptionType,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      purchaseDate: freezed == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isInTrialPeriod: null == isInTrialPeriod
          ? _value.isInTrialPeriod
          : isInTrialPeriod // ignore: cast_nullable_to_non_nullable
              as bool,
      isInIntroductoryPeriod: null == isInIntroductoryPeriod
          ? _value.isInIntroductoryPeriod
          : isInIntroductoryPeriod // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRenewEnabled: null == autoRenewEnabled
          ? _value.autoRenewEnabled
          : autoRenewEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionStatusImplCopyWith<$Res>
    implements $SubscriptionStatusCopyWith<$Res> {
  factory _$$SubscriptionStatusImplCopyWith(_$SubscriptionStatusImpl value,
          $Res Function(_$SubscriptionStatusImpl) then) =
      __$$SubscriptionStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isActive,
      SubscriptionType currentType,
      DateTime? expiryDate,
      DateTime? purchaseDate,
      String? transactionId,
      bool isInTrialPeriod,
      bool isInIntroductoryPeriod,
      bool autoRenewEnabled});
}

/// @nodoc
class __$$SubscriptionStatusImplCopyWithImpl<$Res>
    extends _$SubscriptionStatusCopyWithImpl<$Res, _$SubscriptionStatusImpl>
    implements _$$SubscriptionStatusImplCopyWith<$Res> {
  __$$SubscriptionStatusImplCopyWithImpl(_$SubscriptionStatusImpl _value,
      $Res Function(_$SubscriptionStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActive = null,
    Object? currentType = null,
    Object? expiryDate = freezed,
    Object? purchaseDate = freezed,
    Object? transactionId = freezed,
    Object? isInTrialPeriod = null,
    Object? isInIntroductoryPeriod = null,
    Object? autoRenewEnabled = null,
  }) {
    return _then(_$SubscriptionStatusImpl(
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      currentType: null == currentType
          ? _value.currentType
          : currentType // ignore: cast_nullable_to_non_nullable
              as SubscriptionType,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      purchaseDate: freezed == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isInTrialPeriod: null == isInTrialPeriod
          ? _value.isInTrialPeriod
          : isInTrialPeriod // ignore: cast_nullable_to_non_nullable
              as bool,
      isInIntroductoryPeriod: null == isInIntroductoryPeriod
          ? _value.isInIntroductoryPeriod
          : isInIntroductoryPeriod // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRenewEnabled: null == autoRenewEnabled
          ? _value.autoRenewEnabled
          : autoRenewEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionStatusImpl implements _SubscriptionStatus {
  const _$SubscriptionStatusImpl(
      {required this.isActive,
      required this.currentType,
      this.expiryDate = null,
      this.purchaseDate = null,
      this.transactionId = null,
      this.isInTrialPeriod = false,
      this.isInIntroductoryPeriod = false,
      this.autoRenewEnabled = false});

  factory _$SubscriptionStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionStatusImplFromJson(json);

  @override
  final bool isActive;
  @override
  final SubscriptionType currentType;
  @override
  @JsonKey()
  final DateTime? expiryDate;
  @override
  @JsonKey()
  final DateTime? purchaseDate;
  @override
  @JsonKey()
  final String? transactionId;
  @override
  @JsonKey()
  final bool isInTrialPeriod;
  @override
  @JsonKey()
  final bool isInIntroductoryPeriod;
  @override
  @JsonKey()
  final bool autoRenewEnabled;

  @override
  String toString() {
    return 'SubscriptionStatus(isActive: $isActive, currentType: $currentType, expiryDate: $expiryDate, purchaseDate: $purchaseDate, transactionId: $transactionId, isInTrialPeriod: $isInTrialPeriod, isInIntroductoryPeriod: $isInIntroductoryPeriod, autoRenewEnabled: $autoRenewEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionStatusImpl &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.currentType, currentType) ||
                other.currentType == currentType) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.isInTrialPeriod, isInTrialPeriod) ||
                other.isInTrialPeriod == isInTrialPeriod) &&
            (identical(other.isInIntroductoryPeriod, isInIntroductoryPeriod) ||
                other.isInIntroductoryPeriod == isInIntroductoryPeriod) &&
            (identical(other.autoRenewEnabled, autoRenewEnabled) ||
                other.autoRenewEnabled == autoRenewEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isActive,
      currentType,
      expiryDate,
      purchaseDate,
      transactionId,
      isInTrialPeriod,
      isInIntroductoryPeriod,
      autoRenewEnabled);

  /// Create a copy of SubscriptionStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionStatusImplCopyWith<_$SubscriptionStatusImpl> get copyWith =>
      __$$SubscriptionStatusImplCopyWithImpl<_$SubscriptionStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionStatusImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionStatus implements SubscriptionStatus {
  const factory _SubscriptionStatus(
      {required final bool isActive,
      required final SubscriptionType currentType,
      final DateTime? expiryDate,
      final DateTime? purchaseDate,
      final String? transactionId,
      final bool isInTrialPeriod,
      final bool isInIntroductoryPeriod,
      final bool autoRenewEnabled}) = _$SubscriptionStatusImpl;

  factory _SubscriptionStatus.fromJson(Map<String, dynamic> json) =
      _$SubscriptionStatusImpl.fromJson;

  @override
  bool get isActive;
  @override
  SubscriptionType get currentType;
  @override
  DateTime? get expiryDate;
  @override
  DateTime? get purchaseDate;
  @override
  String? get transactionId;
  @override
  bool get isInTrialPeriod;
  @override
  bool get isInIntroductoryPeriod;
  @override
  bool get autoRenewEnabled;

  /// Create a copy of SubscriptionStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionStatusImplCopyWith<_$SubscriptionStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PurchaseResult {
  String? get productId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)
        success,
    required TResult Function(
            String message, PurchaseErrorType errorType, String? productId)
        error,
    required TResult Function(String productId) cancelled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)?
        success,
    TResult? Function(
            String message, PurchaseErrorType errorType, String? productId)?
        error,
    TResult? Function(String productId)? cancelled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)?
        success,
    TResult Function(
            String message, PurchaseErrorType errorType, String? productId)?
        error,
    TResult Function(String productId)? cancelled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PurchaseSuccess value) success,
    required TResult Function(_PurchaseError value) error,
    required TResult Function(_PurchaseCancelled value) cancelled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PurchaseSuccess value)? success,
    TResult? Function(_PurchaseError value)? error,
    TResult? Function(_PurchaseCancelled value)? cancelled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PurchaseSuccess value)? success,
    TResult Function(_PurchaseError value)? error,
    TResult Function(_PurchaseCancelled value)? cancelled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseResultCopyWith<PurchaseResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseResultCopyWith<$Res> {
  factory $PurchaseResultCopyWith(
          PurchaseResult value, $Res Function(PurchaseResult) then) =
      _$PurchaseResultCopyWithImpl<$Res, PurchaseResult>;
  @useResult
  $Res call({String productId});
}

/// @nodoc
class _$PurchaseResultCopyWithImpl<$Res, $Val extends PurchaseResult>
    implements $PurchaseResultCopyWith<$Res> {
  _$PurchaseResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId!
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseSuccessImplCopyWith<$Res>
    implements $PurchaseResultCopyWith<$Res> {
  factory _$$PurchaseSuccessImplCopyWith(_$PurchaseSuccessImpl value,
          $Res Function(_$PurchaseSuccessImpl) then) =
      __$$PurchaseSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productId,
      String transactionId,
      DateTime purchaseDate,
      SubscriptionStatus subscriptionStatus});

  $SubscriptionStatusCopyWith<$Res> get subscriptionStatus;
}

/// @nodoc
class __$$PurchaseSuccessImplCopyWithImpl<$Res>
    extends _$PurchaseResultCopyWithImpl<$Res, _$PurchaseSuccessImpl>
    implements _$$PurchaseSuccessImplCopyWith<$Res> {
  __$$PurchaseSuccessImplCopyWithImpl(
      _$PurchaseSuccessImpl _value, $Res Function(_$PurchaseSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? transactionId = null,
    Object? purchaseDate = null,
    Object? subscriptionStatus = null,
  }) {
    return _then(_$PurchaseSuccessImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subscriptionStatus: null == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as SubscriptionStatus,
    ));
  }

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionStatusCopyWith<$Res> get subscriptionStatus {
    return $SubscriptionStatusCopyWith<$Res>(_value.subscriptionStatus,
        (value) {
      return _then(_value.copyWith(subscriptionStatus: value));
    });
  }
}

/// @nodoc

class _$PurchaseSuccessImpl implements _PurchaseSuccess {
  const _$PurchaseSuccessImpl(
      {required this.productId,
      required this.transactionId,
      required this.purchaseDate,
      required this.subscriptionStatus});

  @override
  final String productId;
  @override
  final String transactionId;
  @override
  final DateTime purchaseDate;
  @override
  final SubscriptionStatus subscriptionStatus;

  @override
  String toString() {
    return 'PurchaseResult.success(productId: $productId, transactionId: $transactionId, purchaseDate: $purchaseDate, subscriptionStatus: $subscriptionStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseSuccessImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.subscriptionStatus, subscriptionStatus) ||
                other.subscriptionStatus == subscriptionStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, productId, transactionId, purchaseDate, subscriptionStatus);

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseSuccessImplCopyWith<_$PurchaseSuccessImpl> get copyWith =>
      __$$PurchaseSuccessImplCopyWithImpl<_$PurchaseSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)
        success,
    required TResult Function(
            String message, PurchaseErrorType errorType, String? productId)
        error,
    required TResult Function(String productId) cancelled,
  }) {
    return success(productId, transactionId, purchaseDate, subscriptionStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)?
        success,
    TResult? Function(
            String message, PurchaseErrorType errorType, String? productId)?
        error,
    TResult? Function(String productId)? cancelled,
  }) {
    return success?.call(
        productId, transactionId, purchaseDate, subscriptionStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)?
        success,
    TResult Function(
            String message, PurchaseErrorType errorType, String? productId)?
        error,
    TResult Function(String productId)? cancelled,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(
          productId, transactionId, purchaseDate, subscriptionStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PurchaseSuccess value) success,
    required TResult Function(_PurchaseError value) error,
    required TResult Function(_PurchaseCancelled value) cancelled,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PurchaseSuccess value)? success,
    TResult? Function(_PurchaseError value)? error,
    TResult? Function(_PurchaseCancelled value)? cancelled,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PurchaseSuccess value)? success,
    TResult Function(_PurchaseError value)? error,
    TResult Function(_PurchaseCancelled value)? cancelled,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _PurchaseSuccess implements PurchaseResult {
  const factory _PurchaseSuccess(
          {required final String productId,
          required final String transactionId,
          required final DateTime purchaseDate,
          required final SubscriptionStatus subscriptionStatus}) =
      _$PurchaseSuccessImpl;

  @override
  String get productId;
  String get transactionId;
  DateTime get purchaseDate;
  SubscriptionStatus get subscriptionStatus;

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseSuccessImplCopyWith<_$PurchaseSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PurchaseErrorImplCopyWith<$Res>
    implements $PurchaseResultCopyWith<$Res> {
  factory _$$PurchaseErrorImplCopyWith(
          _$PurchaseErrorImpl value, $Res Function(_$PurchaseErrorImpl) then) =
      __$$PurchaseErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, PurchaseErrorType errorType, String? productId});
}

/// @nodoc
class __$$PurchaseErrorImplCopyWithImpl<$Res>
    extends _$PurchaseResultCopyWithImpl<$Res, _$PurchaseErrorImpl>
    implements _$$PurchaseErrorImplCopyWith<$Res> {
  __$$PurchaseErrorImplCopyWithImpl(
      _$PurchaseErrorImpl _value, $Res Function(_$PurchaseErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? errorType = null,
    Object? productId = freezed,
  }) {
    return _then(_$PurchaseErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as PurchaseErrorType,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PurchaseErrorImpl implements _PurchaseError {
  const _$PurchaseErrorImpl(
      {required this.message, required this.errorType, this.productId = null});

  @override
  final String message;
  @override
  final PurchaseErrorType errorType;
  @override
  @JsonKey()
  final String? productId;

  @override
  String toString() {
    return 'PurchaseResult.error(message: $message, errorType: $errorType, productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, errorType, productId);

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseErrorImplCopyWith<_$PurchaseErrorImpl> get copyWith =>
      __$$PurchaseErrorImplCopyWithImpl<_$PurchaseErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)
        success,
    required TResult Function(
            String message, PurchaseErrorType errorType, String? productId)
        error,
    required TResult Function(String productId) cancelled,
  }) {
    return error(message, errorType, productId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)?
        success,
    TResult? Function(
            String message, PurchaseErrorType errorType, String? productId)?
        error,
    TResult? Function(String productId)? cancelled,
  }) {
    return error?.call(message, errorType, productId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)?
        success,
    TResult Function(
            String message, PurchaseErrorType errorType, String? productId)?
        error,
    TResult Function(String productId)? cancelled,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, errorType, productId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PurchaseSuccess value) success,
    required TResult Function(_PurchaseError value) error,
    required TResult Function(_PurchaseCancelled value) cancelled,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PurchaseSuccess value)? success,
    TResult? Function(_PurchaseError value)? error,
    TResult? Function(_PurchaseCancelled value)? cancelled,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PurchaseSuccess value)? success,
    TResult Function(_PurchaseError value)? error,
    TResult Function(_PurchaseCancelled value)? cancelled,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _PurchaseError implements PurchaseResult {
  const factory _PurchaseError(
      {required final String message,
      required final PurchaseErrorType errorType,
      final String? productId}) = _$PurchaseErrorImpl;

  String get message;
  PurchaseErrorType get errorType;
  @override
  String? get productId;

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseErrorImplCopyWith<_$PurchaseErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PurchaseCancelledImplCopyWith<$Res>
    implements $PurchaseResultCopyWith<$Res> {
  factory _$$PurchaseCancelledImplCopyWith(_$PurchaseCancelledImpl value,
          $Res Function(_$PurchaseCancelledImpl) then) =
      __$$PurchaseCancelledImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String productId});
}

/// @nodoc
class __$$PurchaseCancelledImplCopyWithImpl<$Res>
    extends _$PurchaseResultCopyWithImpl<$Res, _$PurchaseCancelledImpl>
    implements _$$PurchaseCancelledImplCopyWith<$Res> {
  __$$PurchaseCancelledImplCopyWithImpl(_$PurchaseCancelledImpl _value,
      $Res Function(_$PurchaseCancelledImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_$PurchaseCancelledImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PurchaseCancelledImpl implements _PurchaseCancelled {
  const _$PurchaseCancelledImpl({required this.productId});

  @override
  final String productId;

  @override
  String toString() {
    return 'PurchaseResult.cancelled(productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseCancelledImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productId);

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseCancelledImplCopyWith<_$PurchaseCancelledImpl> get copyWith =>
      __$$PurchaseCancelledImplCopyWithImpl<_$PurchaseCancelledImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)
        success,
    required TResult Function(
            String message, PurchaseErrorType errorType, String? productId)
        error,
    required TResult Function(String productId) cancelled,
  }) {
    return cancelled(productId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)?
        success,
    TResult? Function(
            String message, PurchaseErrorType errorType, String? productId)?
        error,
    TResult? Function(String productId)? cancelled,
  }) {
    return cancelled?.call(productId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String productId, String transactionId,
            DateTime purchaseDate, SubscriptionStatus subscriptionStatus)?
        success,
    TResult Function(
            String message, PurchaseErrorType errorType, String? productId)?
        error,
    TResult Function(String productId)? cancelled,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled(productId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PurchaseSuccess value) success,
    required TResult Function(_PurchaseError value) error,
    required TResult Function(_PurchaseCancelled value) cancelled,
  }) {
    return cancelled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PurchaseSuccess value)? success,
    TResult? Function(_PurchaseError value)? error,
    TResult? Function(_PurchaseCancelled value)? cancelled,
  }) {
    return cancelled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PurchaseSuccess value)? success,
    TResult Function(_PurchaseError value)? error,
    TResult Function(_PurchaseCancelled value)? cancelled,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled(this);
    }
    return orElse();
  }
}

abstract class _PurchaseCancelled implements PurchaseResult {
  const factory _PurchaseCancelled({required final String productId}) =
      _$PurchaseCancelledImpl;

  @override
  String get productId;

  /// Create a copy of PurchaseResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseCancelledImplCopyWith<_$PurchaseCancelledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeatureAccess _$FeatureAccessFromJson(Map<String, dynamic> json) {
  return _FeatureAccess.fromJson(json);
}

/// @nodoc
mixin _$FeatureAccess {
  bool get advancedAnalytics => throw _privateConstructorUsedError;
  bool get dataExport => throw _privateConstructorUsedError;
  bool get cloudSync => throw _privateConstructorUsedError;
  bool get premiumSupport => throw _privateConstructorUsedError;
  bool get adaptivePacing => throw _privateConstructorUsedError;
  bool get unlimitedReadings => throw _privateConstructorUsedError;
  bool get customMetrics => throw _privateConstructorUsedError;
  bool get trendPredictions => throw _privateConstructorUsedError;

  /// Serializes this FeatureAccess to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeatureAccess
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeatureAccessCopyWith<FeatureAccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureAccessCopyWith<$Res> {
  factory $FeatureAccessCopyWith(
          FeatureAccess value, $Res Function(FeatureAccess) then) =
      _$FeatureAccessCopyWithImpl<$Res, FeatureAccess>;
  @useResult
  $Res call(
      {bool advancedAnalytics,
      bool dataExport,
      bool cloudSync,
      bool premiumSupport,
      bool adaptivePacing,
      bool unlimitedReadings,
      bool customMetrics,
      bool trendPredictions});
}

/// @nodoc
class _$FeatureAccessCopyWithImpl<$Res, $Val extends FeatureAccess>
    implements $FeatureAccessCopyWith<$Res> {
  _$FeatureAccessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeatureAccess
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? advancedAnalytics = null,
    Object? dataExport = null,
    Object? cloudSync = null,
    Object? premiumSupport = null,
    Object? adaptivePacing = null,
    Object? unlimitedReadings = null,
    Object? customMetrics = null,
    Object? trendPredictions = null,
  }) {
    return _then(_value.copyWith(
      advancedAnalytics: null == advancedAnalytics
          ? _value.advancedAnalytics
          : advancedAnalytics // ignore: cast_nullable_to_non_nullable
              as bool,
      dataExport: null == dataExport
          ? _value.dataExport
          : dataExport // ignore: cast_nullable_to_non_nullable
              as bool,
      cloudSync: null == cloudSync
          ? _value.cloudSync
          : cloudSync // ignore: cast_nullable_to_non_nullable
              as bool,
      premiumSupport: null == premiumSupport
          ? _value.premiumSupport
          : premiumSupport // ignore: cast_nullable_to_non_nullable
              as bool,
      adaptivePacing: null == adaptivePacing
          ? _value.adaptivePacing
          : adaptivePacing // ignore: cast_nullable_to_non_nullable
              as bool,
      unlimitedReadings: null == unlimitedReadings
          ? _value.unlimitedReadings
          : unlimitedReadings // ignore: cast_nullable_to_non_nullable
              as bool,
      customMetrics: null == customMetrics
          ? _value.customMetrics
          : customMetrics // ignore: cast_nullable_to_non_nullable
              as bool,
      trendPredictions: null == trendPredictions
          ? _value.trendPredictions
          : trendPredictions // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeatureAccessImplCopyWith<$Res>
    implements $FeatureAccessCopyWith<$Res> {
  factory _$$FeatureAccessImplCopyWith(
          _$FeatureAccessImpl value, $Res Function(_$FeatureAccessImpl) then) =
      __$$FeatureAccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool advancedAnalytics,
      bool dataExport,
      bool cloudSync,
      bool premiumSupport,
      bool adaptivePacing,
      bool unlimitedReadings,
      bool customMetrics,
      bool trendPredictions});
}

/// @nodoc
class __$$FeatureAccessImplCopyWithImpl<$Res>
    extends _$FeatureAccessCopyWithImpl<$Res, _$FeatureAccessImpl>
    implements _$$FeatureAccessImplCopyWith<$Res> {
  __$$FeatureAccessImplCopyWithImpl(
      _$FeatureAccessImpl _value, $Res Function(_$FeatureAccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeatureAccess
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? advancedAnalytics = null,
    Object? dataExport = null,
    Object? cloudSync = null,
    Object? premiumSupport = null,
    Object? adaptivePacing = null,
    Object? unlimitedReadings = null,
    Object? customMetrics = null,
    Object? trendPredictions = null,
  }) {
    return _then(_$FeatureAccessImpl(
      advancedAnalytics: null == advancedAnalytics
          ? _value.advancedAnalytics
          : advancedAnalytics // ignore: cast_nullable_to_non_nullable
              as bool,
      dataExport: null == dataExport
          ? _value.dataExport
          : dataExport // ignore: cast_nullable_to_non_nullable
              as bool,
      cloudSync: null == cloudSync
          ? _value.cloudSync
          : cloudSync // ignore: cast_nullable_to_non_nullable
              as bool,
      premiumSupport: null == premiumSupport
          ? _value.premiumSupport
          : premiumSupport // ignore: cast_nullable_to_non_nullable
              as bool,
      adaptivePacing: null == adaptivePacing
          ? _value.adaptivePacing
          : adaptivePacing // ignore: cast_nullable_to_non_nullable
              as bool,
      unlimitedReadings: null == unlimitedReadings
          ? _value.unlimitedReadings
          : unlimitedReadings // ignore: cast_nullable_to_non_nullable
              as bool,
      customMetrics: null == customMetrics
          ? _value.customMetrics
          : customMetrics // ignore: cast_nullable_to_non_nullable
              as bool,
      trendPredictions: null == trendPredictions
          ? _value.trendPredictions
          : trendPredictions // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeatureAccessImpl implements _FeatureAccess {
  const _$FeatureAccessImpl(
      {required this.advancedAnalytics,
      required this.dataExport,
      required this.cloudSync,
      required this.premiumSupport,
      required this.adaptivePacing,
      required this.unlimitedReadings,
      required this.customMetrics,
      required this.trendPredictions});

  factory _$FeatureAccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeatureAccessImplFromJson(json);

  @override
  final bool advancedAnalytics;
  @override
  final bool dataExport;
  @override
  final bool cloudSync;
  @override
  final bool premiumSupport;
  @override
  final bool adaptivePacing;
  @override
  final bool unlimitedReadings;
  @override
  final bool customMetrics;
  @override
  final bool trendPredictions;

  @override
  String toString() {
    return 'FeatureAccess(advancedAnalytics: $advancedAnalytics, dataExport: $dataExport, cloudSync: $cloudSync, premiumSupport: $premiumSupport, adaptivePacing: $adaptivePacing, unlimitedReadings: $unlimitedReadings, customMetrics: $customMetrics, trendPredictions: $trendPredictions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeatureAccessImpl &&
            (identical(other.advancedAnalytics, advancedAnalytics) ||
                other.advancedAnalytics == advancedAnalytics) &&
            (identical(other.dataExport, dataExport) ||
                other.dataExport == dataExport) &&
            (identical(other.cloudSync, cloudSync) ||
                other.cloudSync == cloudSync) &&
            (identical(other.premiumSupport, premiumSupport) ||
                other.premiumSupport == premiumSupport) &&
            (identical(other.adaptivePacing, adaptivePacing) ||
                other.adaptivePacing == adaptivePacing) &&
            (identical(other.unlimitedReadings, unlimitedReadings) ||
                other.unlimitedReadings == unlimitedReadings) &&
            (identical(other.customMetrics, customMetrics) ||
                other.customMetrics == customMetrics) &&
            (identical(other.trendPredictions, trendPredictions) ||
                other.trendPredictions == trendPredictions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      advancedAnalytics,
      dataExport,
      cloudSync,
      premiumSupport,
      adaptivePacing,
      unlimitedReadings,
      customMetrics,
      trendPredictions);

  /// Create a copy of FeatureAccess
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeatureAccessImplCopyWith<_$FeatureAccessImpl> get copyWith =>
      __$$FeatureAccessImplCopyWithImpl<_$FeatureAccessImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeatureAccessImplToJson(
      this,
    );
  }
}

abstract class _FeatureAccess implements FeatureAccess {
  const factory _FeatureAccess(
      {required final bool advancedAnalytics,
      required final bool dataExport,
      required final bool cloudSync,
      required final bool premiumSupport,
      required final bool adaptivePacing,
      required final bool unlimitedReadings,
      required final bool customMetrics,
      required final bool trendPredictions}) = _$FeatureAccessImpl;

  factory _FeatureAccess.fromJson(Map<String, dynamic> json) =
      _$FeatureAccessImpl.fromJson;

  @override
  bool get advancedAnalytics;
  @override
  bool get dataExport;
  @override
  bool get cloudSync;
  @override
  bool get premiumSupport;
  @override
  bool get adaptivePacing;
  @override
  bool get unlimitedReadings;
  @override
  bool get customMetrics;
  @override
  bool get trendPredictions;

  /// Create a copy of FeatureAccess
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeatureAccessImplCopyWith<_$FeatureAccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
