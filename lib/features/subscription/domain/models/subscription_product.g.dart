// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionProductImpl _$$SubscriptionProductImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionProductImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      currencyCode: json['currencyCode'] as String,
      rawPrice: (json['rawPrice'] as num).toDouble(),
      type: $enumDecode(_$SubscriptionTypeEnumMap, json['type']),
      duration: $enumDecode(_$SubscriptionDurationEnumMap, json['duration']),
      features:
          (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      isActive: json['isActive'] as bool? ?? false,
      isPopular: json['isPopular'] as bool? ?? false,
      originalPrice: json['originalPrice'] as String? ?? null,
      discountPercentage: json['discountPercentage'] as String? ?? null,
    );

Map<String, dynamic> _$$SubscriptionProductImplToJson(
        _$SubscriptionProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'currencyCode': instance.currencyCode,
      'rawPrice': instance.rawPrice,
      'type': _$SubscriptionTypeEnumMap[instance.type]!,
      'duration': _$SubscriptionDurationEnumMap[instance.duration]!,
      'features': instance.features,
      'isActive': instance.isActive,
      'isPopular': instance.isPopular,
      'originalPrice': instance.originalPrice,
      'discountPercentage': instance.discountPercentage,
    };

const _$SubscriptionTypeEnumMap = {
  SubscriptionType.monthly: 'monthly',
  SubscriptionType.annual: 'annual',
  SubscriptionType.lifetime: 'lifetime',
  SubscriptionType.free: 'free',
};

const _$SubscriptionDurationEnumMap = {
  SubscriptionDuration.month: 'month',
  SubscriptionDuration.year: 'year',
  SubscriptionDuration.lifetime: 'lifetime',
  SubscriptionDuration.free: 'free',
};

_$SubscriptionStatusImpl _$$SubscriptionStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionStatusImpl(
      isActive: json['isActive'] as bool,
      currentType: $enumDecode(_$SubscriptionTypeEnumMap, json['currentType']),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      transactionId: json['transactionId'] as String? ?? null,
      isInTrialPeriod: json['isInTrialPeriod'] as bool? ?? false,
      isInIntroductoryPeriod: json['isInIntroductoryPeriod'] as bool? ?? false,
      autoRenewEnabled: json['autoRenewEnabled'] as bool? ?? false,
    );

Map<String, dynamic> _$$SubscriptionStatusImplToJson(
        _$SubscriptionStatusImpl instance) =>
    <String, dynamic>{
      'isActive': instance.isActive,
      'currentType': _$SubscriptionTypeEnumMap[instance.currentType]!,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'transactionId': instance.transactionId,
      'isInTrialPeriod': instance.isInTrialPeriod,
      'isInIntroductoryPeriod': instance.isInIntroductoryPeriod,
      'autoRenewEnabled': instance.autoRenewEnabled,
    };

_$FeatureAccessImpl _$$FeatureAccessImplFromJson(Map<String, dynamic> json) =>
    _$FeatureAccessImpl(
      advancedAnalytics: json['advancedAnalytics'] as bool,
      dataExport: json['dataExport'] as bool,
      cloudSync: json['cloudSync'] as bool,
      premiumSupport: json['premiumSupport'] as bool,
      adaptivePacing: json['adaptivePacing'] as bool,
      unlimitedReadings: json['unlimitedReadings'] as bool,
      customMetrics: json['customMetrics'] as bool,
      trendPredictions: json['trendPredictions'] as bool,
    );

Map<String, dynamic> _$$FeatureAccessImplToJson(_$FeatureAccessImpl instance) =>
    <String, dynamic>{
      'advancedAnalytics': instance.advancedAnalytics,
      'dataExport': instance.dataExport,
      'cloudSync': instance.cloudSync,
      'premiumSupport': instance.premiumSupport,
      'adaptivePacing': instance.adaptivePacing,
      'unlimitedReadings': instance.unlimitedReadings,
      'customMetrics': instance.customMetrics,
      'trendPredictions': instance.trendPredictions,
    };
