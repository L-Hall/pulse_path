// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adaptive_pacing_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdaptivePacingAssessment _$AdaptivePacingAssessmentFromJson(
    Map<String, dynamic> json) {
  return _AdaptivePacingAssessment.fromJson(json);
}

/// @nodoc
mixin _$AdaptivePacingAssessment {
  String get id => throw _privateConstructorUsedError;
  DateTime get date =>
      throw _privateConstructorUsedError; // Current state assessment
  PacingState get currentState => throw _privateConstructorUsedError;
  PemRiskLevel get pemRisk => throw _privateConstructorUsedError;
  int get energyEnvelopePercentage =>
      throw _privateConstructorUsedError; // 0-100% of personal energy envelope
// Contributing factors
  HrvContribution get hrvContribution => throw _privateConstructorUsedError;
  ActivityContribution get activityContribution =>
      throw _privateConstructorUsedError;
  SleepContribution get sleepContribution => throw _privateConstructorUsedError;
  MenstrualContribution? get menstrualContribution =>
      throw _privateConstructorUsedError; // Recommendations
  List<PacingRecommendation> get recommendations =>
      throw _privateConstructorUsedError;
  ActivityGuidance get activityGuidance =>
      throw _privateConstructorUsedError; // Trend analysis
  List<String> get trendWarnings => throw _privateConstructorUsedError;
  int get consecutiveHighRiskDays => throw _privateConstructorUsedError;
  double get sevenDayEnergyTrend =>
      throw _privateConstructorUsedError; // -1.0 to 1.0
// Personalization factors
  ChronicConditionProfile get conditionProfile =>
      throw _privateConstructorUsedError;
  double get personalSensitivity =>
      throw _privateConstructorUsedError; // 0.5-2.0 multiplier
// Metadata
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;

  /// Serializes this AdaptivePacingAssessment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdaptivePacingAssessmentCopyWith<AdaptivePacingAssessment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdaptivePacingAssessmentCopyWith<$Res> {
  factory $AdaptivePacingAssessmentCopyWith(AdaptivePacingAssessment value,
          $Res Function(AdaptivePacingAssessment) then) =
      _$AdaptivePacingAssessmentCopyWithImpl<$Res, AdaptivePacingAssessment>;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      PacingState currentState,
      PemRiskLevel pemRisk,
      int energyEnvelopePercentage,
      HrvContribution hrvContribution,
      ActivityContribution activityContribution,
      SleepContribution sleepContribution,
      MenstrualContribution? menstrualContribution,
      List<PacingRecommendation> recommendations,
      ActivityGuidance activityGuidance,
      List<String> trendWarnings,
      int consecutiveHighRiskDays,
      double sevenDayEnergyTrend,
      ChronicConditionProfile conditionProfile,
      double personalSensitivity,
      DateTime createdAt,
      bool isSynced});

  $PacingStateCopyWith<$Res> get currentState;
  $HrvContributionCopyWith<$Res> get hrvContribution;
  $ActivityContributionCopyWith<$Res> get activityContribution;
  $SleepContributionCopyWith<$Res> get sleepContribution;
  $MenstrualContributionCopyWith<$Res>? get menstrualContribution;
  $ActivityGuidanceCopyWith<$Res> get activityGuidance;
  $ChronicConditionProfileCopyWith<$Res> get conditionProfile;
}

/// @nodoc
class _$AdaptivePacingAssessmentCopyWithImpl<$Res,
        $Val extends AdaptivePacingAssessment>
    implements $AdaptivePacingAssessmentCopyWith<$Res> {
  _$AdaptivePacingAssessmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? currentState = null,
    Object? pemRisk = null,
    Object? energyEnvelopePercentage = null,
    Object? hrvContribution = null,
    Object? activityContribution = null,
    Object? sleepContribution = null,
    Object? menstrualContribution = freezed,
    Object? recommendations = null,
    Object? activityGuidance = null,
    Object? trendWarnings = null,
    Object? consecutiveHighRiskDays = null,
    Object? sevenDayEnergyTrend = null,
    Object? conditionProfile = null,
    Object? personalSensitivity = null,
    Object? createdAt = null,
    Object? isSynced = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentState: null == currentState
          ? _value.currentState
          : currentState // ignore: cast_nullable_to_non_nullable
              as PacingState,
      pemRisk: null == pemRisk
          ? _value.pemRisk
          : pemRisk // ignore: cast_nullable_to_non_nullable
              as PemRiskLevel,
      energyEnvelopePercentage: null == energyEnvelopePercentage
          ? _value.energyEnvelopePercentage
          : energyEnvelopePercentage // ignore: cast_nullable_to_non_nullable
              as int,
      hrvContribution: null == hrvContribution
          ? _value.hrvContribution
          : hrvContribution // ignore: cast_nullable_to_non_nullable
              as HrvContribution,
      activityContribution: null == activityContribution
          ? _value.activityContribution
          : activityContribution // ignore: cast_nullable_to_non_nullable
              as ActivityContribution,
      sleepContribution: null == sleepContribution
          ? _value.sleepContribution
          : sleepContribution // ignore: cast_nullable_to_non_nullable
              as SleepContribution,
      menstrualContribution: freezed == menstrualContribution
          ? _value.menstrualContribution
          : menstrualContribution // ignore: cast_nullable_to_non_nullable
              as MenstrualContribution?,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<PacingRecommendation>,
      activityGuidance: null == activityGuidance
          ? _value.activityGuidance
          : activityGuidance // ignore: cast_nullable_to_non_nullable
              as ActivityGuidance,
      trendWarnings: null == trendWarnings
          ? _value.trendWarnings
          : trendWarnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      consecutiveHighRiskDays: null == consecutiveHighRiskDays
          ? _value.consecutiveHighRiskDays
          : consecutiveHighRiskDays // ignore: cast_nullable_to_non_nullable
              as int,
      sevenDayEnergyTrend: null == sevenDayEnergyTrend
          ? _value.sevenDayEnergyTrend
          : sevenDayEnergyTrend // ignore: cast_nullable_to_non_nullable
              as double,
      conditionProfile: null == conditionProfile
          ? _value.conditionProfile
          : conditionProfile // ignore: cast_nullable_to_non_nullable
              as ChronicConditionProfile,
      personalSensitivity: null == personalSensitivity
          ? _value.personalSensitivity
          : personalSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PacingStateCopyWith<$Res> get currentState {
    return $PacingStateCopyWith<$Res>(_value.currentState, (value) {
      return _then(_value.copyWith(currentState: value) as $Val);
    });
  }

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HrvContributionCopyWith<$Res> get hrvContribution {
    return $HrvContributionCopyWith<$Res>(_value.hrvContribution, (value) {
      return _then(_value.copyWith(hrvContribution: value) as $Val);
    });
  }

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivityContributionCopyWith<$Res> get activityContribution {
    return $ActivityContributionCopyWith<$Res>(_value.activityContribution,
        (value) {
      return _then(_value.copyWith(activityContribution: value) as $Val);
    });
  }

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SleepContributionCopyWith<$Res> get sleepContribution {
    return $SleepContributionCopyWith<$Res>(_value.sleepContribution, (value) {
      return _then(_value.copyWith(sleepContribution: value) as $Val);
    });
  }

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MenstrualContributionCopyWith<$Res>? get menstrualContribution {
    if (_value.menstrualContribution == null) {
      return null;
    }

    return $MenstrualContributionCopyWith<$Res>(_value.menstrualContribution!,
        (value) {
      return _then(_value.copyWith(menstrualContribution: value) as $Val);
    });
  }

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivityGuidanceCopyWith<$Res> get activityGuidance {
    return $ActivityGuidanceCopyWith<$Res>(_value.activityGuidance, (value) {
      return _then(_value.copyWith(activityGuidance: value) as $Val);
    });
  }

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChronicConditionProfileCopyWith<$Res> get conditionProfile {
    return $ChronicConditionProfileCopyWith<$Res>(_value.conditionProfile,
        (value) {
      return _then(_value.copyWith(conditionProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdaptivePacingAssessmentImplCopyWith<$Res>
    implements $AdaptivePacingAssessmentCopyWith<$Res> {
  factory _$$AdaptivePacingAssessmentImplCopyWith(
          _$AdaptivePacingAssessmentImpl value,
          $Res Function(_$AdaptivePacingAssessmentImpl) then) =
      __$$AdaptivePacingAssessmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      PacingState currentState,
      PemRiskLevel pemRisk,
      int energyEnvelopePercentage,
      HrvContribution hrvContribution,
      ActivityContribution activityContribution,
      SleepContribution sleepContribution,
      MenstrualContribution? menstrualContribution,
      List<PacingRecommendation> recommendations,
      ActivityGuidance activityGuidance,
      List<String> trendWarnings,
      int consecutiveHighRiskDays,
      double sevenDayEnergyTrend,
      ChronicConditionProfile conditionProfile,
      double personalSensitivity,
      DateTime createdAt,
      bool isSynced});

  @override
  $PacingStateCopyWith<$Res> get currentState;
  @override
  $HrvContributionCopyWith<$Res> get hrvContribution;
  @override
  $ActivityContributionCopyWith<$Res> get activityContribution;
  @override
  $SleepContributionCopyWith<$Res> get sleepContribution;
  @override
  $MenstrualContributionCopyWith<$Res>? get menstrualContribution;
  @override
  $ActivityGuidanceCopyWith<$Res> get activityGuidance;
  @override
  $ChronicConditionProfileCopyWith<$Res> get conditionProfile;
}

/// @nodoc
class __$$AdaptivePacingAssessmentImplCopyWithImpl<$Res>
    extends _$AdaptivePacingAssessmentCopyWithImpl<$Res,
        _$AdaptivePacingAssessmentImpl>
    implements _$$AdaptivePacingAssessmentImplCopyWith<$Res> {
  __$$AdaptivePacingAssessmentImplCopyWithImpl(
      _$AdaptivePacingAssessmentImpl _value,
      $Res Function(_$AdaptivePacingAssessmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? currentState = null,
    Object? pemRisk = null,
    Object? energyEnvelopePercentage = null,
    Object? hrvContribution = null,
    Object? activityContribution = null,
    Object? sleepContribution = null,
    Object? menstrualContribution = freezed,
    Object? recommendations = null,
    Object? activityGuidance = null,
    Object? trendWarnings = null,
    Object? consecutiveHighRiskDays = null,
    Object? sevenDayEnergyTrend = null,
    Object? conditionProfile = null,
    Object? personalSensitivity = null,
    Object? createdAt = null,
    Object? isSynced = null,
  }) {
    return _then(_$AdaptivePacingAssessmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentState: null == currentState
          ? _value.currentState
          : currentState // ignore: cast_nullable_to_non_nullable
              as PacingState,
      pemRisk: null == pemRisk
          ? _value.pemRisk
          : pemRisk // ignore: cast_nullable_to_non_nullable
              as PemRiskLevel,
      energyEnvelopePercentage: null == energyEnvelopePercentage
          ? _value.energyEnvelopePercentage
          : energyEnvelopePercentage // ignore: cast_nullable_to_non_nullable
              as int,
      hrvContribution: null == hrvContribution
          ? _value.hrvContribution
          : hrvContribution // ignore: cast_nullable_to_non_nullable
              as HrvContribution,
      activityContribution: null == activityContribution
          ? _value.activityContribution
          : activityContribution // ignore: cast_nullable_to_non_nullable
              as ActivityContribution,
      sleepContribution: null == sleepContribution
          ? _value.sleepContribution
          : sleepContribution // ignore: cast_nullable_to_non_nullable
              as SleepContribution,
      menstrualContribution: freezed == menstrualContribution
          ? _value.menstrualContribution
          : menstrualContribution // ignore: cast_nullable_to_non_nullable
              as MenstrualContribution?,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<PacingRecommendation>,
      activityGuidance: null == activityGuidance
          ? _value.activityGuidance
          : activityGuidance // ignore: cast_nullable_to_non_nullable
              as ActivityGuidance,
      trendWarnings: null == trendWarnings
          ? _value._trendWarnings
          : trendWarnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      consecutiveHighRiskDays: null == consecutiveHighRiskDays
          ? _value.consecutiveHighRiskDays
          : consecutiveHighRiskDays // ignore: cast_nullable_to_non_nullable
              as int,
      sevenDayEnergyTrend: null == sevenDayEnergyTrend
          ? _value.sevenDayEnergyTrend
          : sevenDayEnergyTrend // ignore: cast_nullable_to_non_nullable
              as double,
      conditionProfile: null == conditionProfile
          ? _value.conditionProfile
          : conditionProfile // ignore: cast_nullable_to_non_nullable
              as ChronicConditionProfile,
      personalSensitivity: null == personalSensitivity
          ? _value.personalSensitivity
          : personalSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdaptivePacingAssessmentImpl implements _AdaptivePacingAssessment {
  const _$AdaptivePacingAssessmentImpl(
      {required this.id,
      required this.date,
      required this.currentState,
      required this.pemRisk,
      required this.energyEnvelopePercentage,
      required this.hrvContribution,
      required this.activityContribution,
      required this.sleepContribution,
      this.menstrualContribution = null,
      required final List<PacingRecommendation> recommendations,
      required this.activityGuidance,
      final List<String> trendWarnings = const [],
      this.consecutiveHighRiskDays = 0,
      this.sevenDayEnergyTrend = 0.0,
      required this.conditionProfile,
      this.personalSensitivity = 1.0,
      required this.createdAt,
      this.isSynced = false})
      : _recommendations = recommendations,
        _trendWarnings = trendWarnings;

  factory _$AdaptivePacingAssessmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdaptivePacingAssessmentImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
// Current state assessment
  @override
  final PacingState currentState;
  @override
  final PemRiskLevel pemRisk;
  @override
  final int energyEnvelopePercentage;
// 0-100% of personal energy envelope
// Contributing factors
  @override
  final HrvContribution hrvContribution;
  @override
  final ActivityContribution activityContribution;
  @override
  final SleepContribution sleepContribution;
  @override
  @JsonKey()
  final MenstrualContribution? menstrualContribution;
// Recommendations
  final List<PacingRecommendation> _recommendations;
// Recommendations
  @override
  List<PacingRecommendation> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  final ActivityGuidance activityGuidance;
// Trend analysis
  final List<String> _trendWarnings;
// Trend analysis
  @override
  @JsonKey()
  List<String> get trendWarnings {
    if (_trendWarnings is EqualUnmodifiableListView) return _trendWarnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trendWarnings);
  }

  @override
  @JsonKey()
  final int consecutiveHighRiskDays;
  @override
  @JsonKey()
  final double sevenDayEnergyTrend;
// -1.0 to 1.0
// Personalization factors
  @override
  final ChronicConditionProfile conditionProfile;
  @override
  @JsonKey()
  final double personalSensitivity;
// 0.5-2.0 multiplier
// Metadata
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isSynced;

  @override
  String toString() {
    return 'AdaptivePacingAssessment(id: $id, date: $date, currentState: $currentState, pemRisk: $pemRisk, energyEnvelopePercentage: $energyEnvelopePercentage, hrvContribution: $hrvContribution, activityContribution: $activityContribution, sleepContribution: $sleepContribution, menstrualContribution: $menstrualContribution, recommendations: $recommendations, activityGuidance: $activityGuidance, trendWarnings: $trendWarnings, consecutiveHighRiskDays: $consecutiveHighRiskDays, sevenDayEnergyTrend: $sevenDayEnergyTrend, conditionProfile: $conditionProfile, personalSensitivity: $personalSensitivity, createdAt: $createdAt, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdaptivePacingAssessmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.currentState, currentState) ||
                other.currentState == currentState) &&
            (identical(other.pemRisk, pemRisk) || other.pemRisk == pemRisk) &&
            (identical(
                    other.energyEnvelopePercentage, energyEnvelopePercentage) ||
                other.energyEnvelopePercentage == energyEnvelopePercentage) &&
            (identical(other.hrvContribution, hrvContribution) ||
                other.hrvContribution == hrvContribution) &&
            (identical(other.activityContribution, activityContribution) ||
                other.activityContribution == activityContribution) &&
            (identical(other.sleepContribution, sleepContribution) ||
                other.sleepContribution == sleepContribution) &&
            (identical(other.menstrualContribution, menstrualContribution) ||
                other.menstrualContribution == menstrualContribution) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.activityGuidance, activityGuidance) ||
                other.activityGuidance == activityGuidance) &&
            const DeepCollectionEquality()
                .equals(other._trendWarnings, _trendWarnings) &&
            (identical(
                    other.consecutiveHighRiskDays, consecutiveHighRiskDays) ||
                other.consecutiveHighRiskDays == consecutiveHighRiskDays) &&
            (identical(other.sevenDayEnergyTrend, sevenDayEnergyTrend) ||
                other.sevenDayEnergyTrend == sevenDayEnergyTrend) &&
            (identical(other.conditionProfile, conditionProfile) ||
                other.conditionProfile == conditionProfile) &&
            (identical(other.personalSensitivity, personalSensitivity) ||
                other.personalSensitivity == personalSensitivity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      currentState,
      pemRisk,
      energyEnvelopePercentage,
      hrvContribution,
      activityContribution,
      sleepContribution,
      menstrualContribution,
      const DeepCollectionEquality().hash(_recommendations),
      activityGuidance,
      const DeepCollectionEquality().hash(_trendWarnings),
      consecutiveHighRiskDays,
      sevenDayEnergyTrend,
      conditionProfile,
      personalSensitivity,
      createdAt,
      isSynced);

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdaptivePacingAssessmentImplCopyWith<_$AdaptivePacingAssessmentImpl>
      get copyWith => __$$AdaptivePacingAssessmentImplCopyWithImpl<
          _$AdaptivePacingAssessmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdaptivePacingAssessmentImplToJson(
      this,
    );
  }
}

abstract class _AdaptivePacingAssessment implements AdaptivePacingAssessment {
  const factory _AdaptivePacingAssessment(
      {required final String id,
      required final DateTime date,
      required final PacingState currentState,
      required final PemRiskLevel pemRisk,
      required final int energyEnvelopePercentage,
      required final HrvContribution hrvContribution,
      required final ActivityContribution activityContribution,
      required final SleepContribution sleepContribution,
      final MenstrualContribution? menstrualContribution,
      required final List<PacingRecommendation> recommendations,
      required final ActivityGuidance activityGuidance,
      final List<String> trendWarnings,
      final int consecutiveHighRiskDays,
      final double sevenDayEnergyTrend,
      required final ChronicConditionProfile conditionProfile,
      final double personalSensitivity,
      required final DateTime createdAt,
      final bool isSynced}) = _$AdaptivePacingAssessmentImpl;

  factory _AdaptivePacingAssessment.fromJson(Map<String, dynamic> json) =
      _$AdaptivePacingAssessmentImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date; // Current state assessment
  @override
  PacingState get currentState;
  @override
  PemRiskLevel get pemRisk;
  @override
  int get energyEnvelopePercentage; // 0-100% of personal energy envelope
// Contributing factors
  @override
  HrvContribution get hrvContribution;
  @override
  ActivityContribution get activityContribution;
  @override
  SleepContribution get sleepContribution;
  @override
  MenstrualContribution? get menstrualContribution; // Recommendations
  @override
  List<PacingRecommendation> get recommendations;
  @override
  ActivityGuidance get activityGuidance; // Trend analysis
  @override
  List<String> get trendWarnings;
  @override
  int get consecutiveHighRiskDays;
  @override
  double get sevenDayEnergyTrend; // -1.0 to 1.0
// Personalization factors
  @override
  ChronicConditionProfile get conditionProfile;
  @override
  double get personalSensitivity; // 0.5-2.0 multiplier
// Metadata
  @override
  DateTime get createdAt;
  @override
  bool get isSynced;

  /// Create a copy of AdaptivePacingAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdaptivePacingAssessmentImplCopyWith<_$AdaptivePacingAssessmentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PacingState _$PacingStateFromJson(Map<String, dynamic> json) {
  return _PacingState.fromJson(json);
}

/// @nodoc
mixin _$PacingState {
  PacingStateType get type => throw _privateConstructorUsedError;
  int get overallScore => throw _privateConstructorUsedError; // 0-100
  String get description => throw _privateConstructorUsedError;
  String get reasoning => throw _privateConstructorUsedError;
  DateTime? get recommendedActivityTime => throw _privateConstructorUsedError;
  Duration? get recommendedRestDuration => throw _privateConstructorUsedError;

  /// Serializes this PacingState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PacingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PacingStateCopyWith<PacingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PacingStateCopyWith<$Res> {
  factory $PacingStateCopyWith(
          PacingState value, $Res Function(PacingState) then) =
      _$PacingStateCopyWithImpl<$Res, PacingState>;
  @useResult
  $Res call(
      {PacingStateType type,
      int overallScore,
      String description,
      String reasoning,
      DateTime? recommendedActivityTime,
      Duration? recommendedRestDuration});
}

/// @nodoc
class _$PacingStateCopyWithImpl<$Res, $Val extends PacingState>
    implements $PacingStateCopyWith<$Res> {
  _$PacingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PacingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? overallScore = null,
    Object? description = null,
    Object? reasoning = null,
    Object? recommendedActivityTime = freezed,
    Object? recommendedRestDuration = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PacingStateType,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedActivityTime: freezed == recommendedActivityTime
          ? _value.recommendedActivityTime
          : recommendedActivityTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recommendedRestDuration: freezed == recommendedRestDuration
          ? _value.recommendedRestDuration
          : recommendedRestDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PacingStateImplCopyWith<$Res>
    implements $PacingStateCopyWith<$Res> {
  factory _$$PacingStateImplCopyWith(
          _$PacingStateImpl value, $Res Function(_$PacingStateImpl) then) =
      __$$PacingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PacingStateType type,
      int overallScore,
      String description,
      String reasoning,
      DateTime? recommendedActivityTime,
      Duration? recommendedRestDuration});
}

/// @nodoc
class __$$PacingStateImplCopyWithImpl<$Res>
    extends _$PacingStateCopyWithImpl<$Res, _$PacingStateImpl>
    implements _$$PacingStateImplCopyWith<$Res> {
  __$$PacingStateImplCopyWithImpl(
      _$PacingStateImpl _value, $Res Function(_$PacingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PacingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? overallScore = null,
    Object? description = null,
    Object? reasoning = null,
    Object? recommendedActivityTime = freezed,
    Object? recommendedRestDuration = freezed,
  }) {
    return _then(_$PacingStateImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PacingStateType,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedActivityTime: freezed == recommendedActivityTime
          ? _value.recommendedActivityTime
          : recommendedActivityTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recommendedRestDuration: freezed == recommendedRestDuration
          ? _value.recommendedRestDuration
          : recommendedRestDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PacingStateImpl implements _PacingState {
  const _$PacingStateImpl(
      {required this.type,
      required this.overallScore,
      required this.description,
      this.reasoning = '',
      this.recommendedActivityTime = null,
      this.recommendedRestDuration = null});

  factory _$PacingStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PacingStateImplFromJson(json);

  @override
  final PacingStateType type;
  @override
  final int overallScore;
// 0-100
  @override
  final String description;
  @override
  @JsonKey()
  final String reasoning;
  @override
  @JsonKey()
  final DateTime? recommendedActivityTime;
  @override
  @JsonKey()
  final Duration? recommendedRestDuration;

  @override
  String toString() {
    return 'PacingState(type: $type, overallScore: $overallScore, description: $description, reasoning: $reasoning, recommendedActivityTime: $recommendedActivityTime, recommendedRestDuration: $recommendedRestDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PacingStateImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning) &&
            (identical(
                    other.recommendedActivityTime, recommendedActivityTime) ||
                other.recommendedActivityTime == recommendedActivityTime) &&
            (identical(
                    other.recommendedRestDuration, recommendedRestDuration) ||
                other.recommendedRestDuration == recommendedRestDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, overallScore, description,
      reasoning, recommendedActivityTime, recommendedRestDuration);

  /// Create a copy of PacingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PacingStateImplCopyWith<_$PacingStateImpl> get copyWith =>
      __$$PacingStateImplCopyWithImpl<_$PacingStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PacingStateImplToJson(
      this,
    );
  }
}

abstract class _PacingState implements PacingState {
  const factory _PacingState(
      {required final PacingStateType type,
      required final int overallScore,
      required final String description,
      final String reasoning,
      final DateTime? recommendedActivityTime,
      final Duration? recommendedRestDuration}) = _$PacingStateImpl;

  factory _PacingState.fromJson(Map<String, dynamic> json) =
      _$PacingStateImpl.fromJson;

  @override
  PacingStateType get type;
  @override
  int get overallScore; // 0-100
  @override
  String get description;
  @override
  String get reasoning;
  @override
  DateTime? get recommendedActivityTime;
  @override
  Duration? get recommendedRestDuration;

  /// Create a copy of PacingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PacingStateImplCopyWith<_$PacingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HrvContribution _$HrvContributionFromJson(Map<String, dynamic> json) {
  return _HrvContribution.fromJson(json);
}

/// @nodoc
mixin _$HrvContribution {
  double get currentHrvScore => throw _privateConstructorUsedError; // 0-100
  double get sevenDayAverage => throw _privateConstructorUsedError;
  double get personalBaseline => throw _privateConstructorUsedError;
  double get percentageOfBaseline =>
      throw _privateConstructorUsedError; // Current vs baseline
  TrendDirection get trend => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;

  /// Serializes this HrvContribution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HrvContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HrvContributionCopyWith<HrvContribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HrvContributionCopyWith<$Res> {
  factory $HrvContributionCopyWith(
          HrvContribution value, $Res Function(HrvContribution) then) =
      _$HrvContributionCopyWithImpl<$Res, HrvContribution>;
  @useResult
  $Res call(
      {double currentHrvScore,
      double sevenDayAverage,
      double personalBaseline,
      double percentageOfBaseline,
      TrendDirection trend,
      double weight});
}

/// @nodoc
class _$HrvContributionCopyWithImpl<$Res, $Val extends HrvContribution>
    implements $HrvContributionCopyWith<$Res> {
  _$HrvContributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HrvContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentHrvScore = null,
    Object? sevenDayAverage = null,
    Object? personalBaseline = null,
    Object? percentageOfBaseline = null,
    Object? trend = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      currentHrvScore: null == currentHrvScore
          ? _value.currentHrvScore
          : currentHrvScore // ignore: cast_nullable_to_non_nullable
              as double,
      sevenDayAverage: null == sevenDayAverage
          ? _value.sevenDayAverage
          : sevenDayAverage // ignore: cast_nullable_to_non_nullable
              as double,
      personalBaseline: null == personalBaseline
          ? _value.personalBaseline
          : personalBaseline // ignore: cast_nullable_to_non_nullable
              as double,
      percentageOfBaseline: null == percentageOfBaseline
          ? _value.percentageOfBaseline
          : percentageOfBaseline // ignore: cast_nullable_to_non_nullable
              as double,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HrvContributionImplCopyWith<$Res>
    implements $HrvContributionCopyWith<$Res> {
  factory _$$HrvContributionImplCopyWith(_$HrvContributionImpl value,
          $Res Function(_$HrvContributionImpl) then) =
      __$$HrvContributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double currentHrvScore,
      double sevenDayAverage,
      double personalBaseline,
      double percentageOfBaseline,
      TrendDirection trend,
      double weight});
}

/// @nodoc
class __$$HrvContributionImplCopyWithImpl<$Res>
    extends _$HrvContributionCopyWithImpl<$Res, _$HrvContributionImpl>
    implements _$$HrvContributionImplCopyWith<$Res> {
  __$$HrvContributionImplCopyWithImpl(
      _$HrvContributionImpl _value, $Res Function(_$HrvContributionImpl) _then)
      : super(_value, _then);

  /// Create a copy of HrvContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentHrvScore = null,
    Object? sevenDayAverage = null,
    Object? personalBaseline = null,
    Object? percentageOfBaseline = null,
    Object? trend = null,
    Object? weight = null,
  }) {
    return _then(_$HrvContributionImpl(
      currentHrvScore: null == currentHrvScore
          ? _value.currentHrvScore
          : currentHrvScore // ignore: cast_nullable_to_non_nullable
              as double,
      sevenDayAverage: null == sevenDayAverage
          ? _value.sevenDayAverage
          : sevenDayAverage // ignore: cast_nullable_to_non_nullable
              as double,
      personalBaseline: null == personalBaseline
          ? _value.personalBaseline
          : personalBaseline // ignore: cast_nullable_to_non_nullable
              as double,
      percentageOfBaseline: null == percentageOfBaseline
          ? _value.percentageOfBaseline
          : percentageOfBaseline // ignore: cast_nullable_to_non_nullable
              as double,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HrvContributionImpl implements _HrvContribution {
  const _$HrvContributionImpl(
      {required this.currentHrvScore,
      required this.sevenDayAverage,
      required this.personalBaseline,
      required this.percentageOfBaseline,
      required this.trend,
      this.weight = 0.4});

  factory _$HrvContributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$HrvContributionImplFromJson(json);

  @override
  final double currentHrvScore;
// 0-100
  @override
  final double sevenDayAverage;
  @override
  final double personalBaseline;
  @override
  final double percentageOfBaseline;
// Current vs baseline
  @override
  final TrendDirection trend;
  @override
  @JsonKey()
  final double weight;

  @override
  String toString() {
    return 'HrvContribution(currentHrvScore: $currentHrvScore, sevenDayAverage: $sevenDayAverage, personalBaseline: $personalBaseline, percentageOfBaseline: $percentageOfBaseline, trend: $trend, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HrvContributionImpl &&
            (identical(other.currentHrvScore, currentHrvScore) ||
                other.currentHrvScore == currentHrvScore) &&
            (identical(other.sevenDayAverage, sevenDayAverage) ||
                other.sevenDayAverage == sevenDayAverage) &&
            (identical(other.personalBaseline, personalBaseline) ||
                other.personalBaseline == personalBaseline) &&
            (identical(other.percentageOfBaseline, percentageOfBaseline) ||
                other.percentageOfBaseline == percentageOfBaseline) &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentHrvScore, sevenDayAverage,
      personalBaseline, percentageOfBaseline, trend, weight);

  /// Create a copy of HrvContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HrvContributionImplCopyWith<_$HrvContributionImpl> get copyWith =>
      __$$HrvContributionImplCopyWithImpl<_$HrvContributionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HrvContributionImplToJson(
      this,
    );
  }
}

abstract class _HrvContribution implements HrvContribution {
  const factory _HrvContribution(
      {required final double currentHrvScore,
      required final double sevenDayAverage,
      required final double personalBaseline,
      required final double percentageOfBaseline,
      required final TrendDirection trend,
      final double weight}) = _$HrvContributionImpl;

  factory _HrvContribution.fromJson(Map<String, dynamic> json) =
      _$HrvContributionImpl.fromJson;

  @override
  double get currentHrvScore; // 0-100
  @override
  double get sevenDayAverage;
  @override
  double get personalBaseline;
  @override
  double get percentageOfBaseline; // Current vs baseline
  @override
  TrendDirection get trend;
  @override
  double get weight;

  /// Create a copy of HrvContribution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HrvContributionImplCopyWith<_$HrvContributionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActivityContribution _$ActivityContributionFromJson(Map<String, dynamic> json) {
  return _ActivityContribution.fromJson(json);
}

/// @nodoc
mixin _$ActivityContribution {
  int get yesterdaySteps => throw _privateConstructorUsedError;
  int get sevenDayAverageSteps => throw _privateConstructorUsedError;
  List<WorkoutSession> get recentWorkouts => throw _privateConstructorUsedError;
  int get cumulativeIntensityScore =>
      throw _privateConstructorUsedError; // Last 3 days
  ActivityLoadLevel get loadLevel => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;

  /// Serializes this ActivityContribution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityContributionCopyWith<ActivityContribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityContributionCopyWith<$Res> {
  factory $ActivityContributionCopyWith(ActivityContribution value,
          $Res Function(ActivityContribution) then) =
      _$ActivityContributionCopyWithImpl<$Res, ActivityContribution>;
  @useResult
  $Res call(
      {int yesterdaySteps,
      int sevenDayAverageSteps,
      List<WorkoutSession> recentWorkouts,
      int cumulativeIntensityScore,
      ActivityLoadLevel loadLevel,
      double weight});
}

/// @nodoc
class _$ActivityContributionCopyWithImpl<$Res,
        $Val extends ActivityContribution>
    implements $ActivityContributionCopyWith<$Res> {
  _$ActivityContributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? yesterdaySteps = null,
    Object? sevenDayAverageSteps = null,
    Object? recentWorkouts = null,
    Object? cumulativeIntensityScore = null,
    Object? loadLevel = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      yesterdaySteps: null == yesterdaySteps
          ? _value.yesterdaySteps
          : yesterdaySteps // ignore: cast_nullable_to_non_nullable
              as int,
      sevenDayAverageSteps: null == sevenDayAverageSteps
          ? _value.sevenDayAverageSteps
          : sevenDayAverageSteps // ignore: cast_nullable_to_non_nullable
              as int,
      recentWorkouts: null == recentWorkouts
          ? _value.recentWorkouts
          : recentWorkouts // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      cumulativeIntensityScore: null == cumulativeIntensityScore
          ? _value.cumulativeIntensityScore
          : cumulativeIntensityScore // ignore: cast_nullable_to_non_nullable
              as int,
      loadLevel: null == loadLevel
          ? _value.loadLevel
          : loadLevel // ignore: cast_nullable_to_non_nullable
              as ActivityLoadLevel,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityContributionImplCopyWith<$Res>
    implements $ActivityContributionCopyWith<$Res> {
  factory _$$ActivityContributionImplCopyWith(_$ActivityContributionImpl value,
          $Res Function(_$ActivityContributionImpl) then) =
      __$$ActivityContributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int yesterdaySteps,
      int sevenDayAverageSteps,
      List<WorkoutSession> recentWorkouts,
      int cumulativeIntensityScore,
      ActivityLoadLevel loadLevel,
      double weight});
}

/// @nodoc
class __$$ActivityContributionImplCopyWithImpl<$Res>
    extends _$ActivityContributionCopyWithImpl<$Res, _$ActivityContributionImpl>
    implements _$$ActivityContributionImplCopyWith<$Res> {
  __$$ActivityContributionImplCopyWithImpl(_$ActivityContributionImpl _value,
      $Res Function(_$ActivityContributionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActivityContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? yesterdaySteps = null,
    Object? sevenDayAverageSteps = null,
    Object? recentWorkouts = null,
    Object? cumulativeIntensityScore = null,
    Object? loadLevel = null,
    Object? weight = null,
  }) {
    return _then(_$ActivityContributionImpl(
      yesterdaySteps: null == yesterdaySteps
          ? _value.yesterdaySteps
          : yesterdaySteps // ignore: cast_nullable_to_non_nullable
              as int,
      sevenDayAverageSteps: null == sevenDayAverageSteps
          ? _value.sevenDayAverageSteps
          : sevenDayAverageSteps // ignore: cast_nullable_to_non_nullable
              as int,
      recentWorkouts: null == recentWorkouts
          ? _value._recentWorkouts
          : recentWorkouts // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      cumulativeIntensityScore: null == cumulativeIntensityScore
          ? _value.cumulativeIntensityScore
          : cumulativeIntensityScore // ignore: cast_nullable_to_non_nullable
              as int,
      loadLevel: null == loadLevel
          ? _value.loadLevel
          : loadLevel // ignore: cast_nullable_to_non_nullable
              as ActivityLoadLevel,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityContributionImpl implements _ActivityContribution {
  const _$ActivityContributionImpl(
      {required this.yesterdaySteps,
      required this.sevenDayAverageSteps,
      required final List<WorkoutSession> recentWorkouts,
      required this.cumulativeIntensityScore,
      required this.loadLevel,
      this.weight = 0.3})
      : _recentWorkouts = recentWorkouts;

  factory _$ActivityContributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityContributionImplFromJson(json);

  @override
  final int yesterdaySteps;
  @override
  final int sevenDayAverageSteps;
  final List<WorkoutSession> _recentWorkouts;
  @override
  List<WorkoutSession> get recentWorkouts {
    if (_recentWorkouts is EqualUnmodifiableListView) return _recentWorkouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentWorkouts);
  }

  @override
  final int cumulativeIntensityScore;
// Last 3 days
  @override
  final ActivityLoadLevel loadLevel;
  @override
  @JsonKey()
  final double weight;

  @override
  String toString() {
    return 'ActivityContribution(yesterdaySteps: $yesterdaySteps, sevenDayAverageSteps: $sevenDayAverageSteps, recentWorkouts: $recentWorkouts, cumulativeIntensityScore: $cumulativeIntensityScore, loadLevel: $loadLevel, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityContributionImpl &&
            (identical(other.yesterdaySteps, yesterdaySteps) ||
                other.yesterdaySteps == yesterdaySteps) &&
            (identical(other.sevenDayAverageSteps, sevenDayAverageSteps) ||
                other.sevenDayAverageSteps == sevenDayAverageSteps) &&
            const DeepCollectionEquality()
                .equals(other._recentWorkouts, _recentWorkouts) &&
            (identical(
                    other.cumulativeIntensityScore, cumulativeIntensityScore) ||
                other.cumulativeIntensityScore == cumulativeIntensityScore) &&
            (identical(other.loadLevel, loadLevel) ||
                other.loadLevel == loadLevel) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      yesterdaySteps,
      sevenDayAverageSteps,
      const DeepCollectionEquality().hash(_recentWorkouts),
      cumulativeIntensityScore,
      loadLevel,
      weight);

  /// Create a copy of ActivityContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityContributionImplCopyWith<_$ActivityContributionImpl>
      get copyWith =>
          __$$ActivityContributionImplCopyWithImpl<_$ActivityContributionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityContributionImplToJson(
      this,
    );
  }
}

abstract class _ActivityContribution implements ActivityContribution {
  const factory _ActivityContribution(
      {required final int yesterdaySteps,
      required final int sevenDayAverageSteps,
      required final List<WorkoutSession> recentWorkouts,
      required final int cumulativeIntensityScore,
      required final ActivityLoadLevel loadLevel,
      final double weight}) = _$ActivityContributionImpl;

  factory _ActivityContribution.fromJson(Map<String, dynamic> json) =
      _$ActivityContributionImpl.fromJson;

  @override
  int get yesterdaySteps;
  @override
  int get sevenDayAverageSteps;
  @override
  List<WorkoutSession> get recentWorkouts;
  @override
  int get cumulativeIntensityScore; // Last 3 days
  @override
  ActivityLoadLevel get loadLevel;
  @override
  double get weight;

  /// Create a copy of ActivityContribution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityContributionImplCopyWith<_$ActivityContributionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SleepContribution _$SleepContributionFromJson(Map<String, dynamic> json) {
  return _SleepContribution.fromJson(json);
}

/// @nodoc
mixin _$SleepContribution {
  Duration? get lastNightSleep => throw _privateConstructorUsedError;
  int? get sleepQuality => throw _privateConstructorUsedError; // 1-10
  Duration get sevenDayAverageSleep => throw _privateConstructorUsedError;
  SleepDebtLevel get sleepDebt => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;

  /// Serializes this SleepContribution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SleepContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SleepContributionCopyWith<SleepContribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepContributionCopyWith<$Res> {
  factory $SleepContributionCopyWith(
          SleepContribution value, $Res Function(SleepContribution) then) =
      _$SleepContributionCopyWithImpl<$Res, SleepContribution>;
  @useResult
  $Res call(
      {Duration? lastNightSleep,
      int? sleepQuality,
      Duration sevenDayAverageSleep,
      SleepDebtLevel sleepDebt,
      double weight});
}

/// @nodoc
class _$SleepContributionCopyWithImpl<$Res, $Val extends SleepContribution>
    implements $SleepContributionCopyWith<$Res> {
  _$SleepContributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SleepContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastNightSleep = freezed,
    Object? sleepQuality = freezed,
    Object? sevenDayAverageSleep = null,
    Object? sleepDebt = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      lastNightSleep: freezed == lastNightSleep
          ? _value.lastNightSleep
          : lastNightSleep // ignore: cast_nullable_to_non_nullable
              as Duration?,
      sleepQuality: freezed == sleepQuality
          ? _value.sleepQuality
          : sleepQuality // ignore: cast_nullable_to_non_nullable
              as int?,
      sevenDayAverageSleep: null == sevenDayAverageSleep
          ? _value.sevenDayAverageSleep
          : sevenDayAverageSleep // ignore: cast_nullable_to_non_nullable
              as Duration,
      sleepDebt: null == sleepDebt
          ? _value.sleepDebt
          : sleepDebt // ignore: cast_nullable_to_non_nullable
              as SleepDebtLevel,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SleepContributionImplCopyWith<$Res>
    implements $SleepContributionCopyWith<$Res> {
  factory _$$SleepContributionImplCopyWith(_$SleepContributionImpl value,
          $Res Function(_$SleepContributionImpl) then) =
      __$$SleepContributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration? lastNightSleep,
      int? sleepQuality,
      Duration sevenDayAverageSleep,
      SleepDebtLevel sleepDebt,
      double weight});
}

/// @nodoc
class __$$SleepContributionImplCopyWithImpl<$Res>
    extends _$SleepContributionCopyWithImpl<$Res, _$SleepContributionImpl>
    implements _$$SleepContributionImplCopyWith<$Res> {
  __$$SleepContributionImplCopyWithImpl(_$SleepContributionImpl _value,
      $Res Function(_$SleepContributionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SleepContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastNightSleep = freezed,
    Object? sleepQuality = freezed,
    Object? sevenDayAverageSleep = null,
    Object? sleepDebt = null,
    Object? weight = null,
  }) {
    return _then(_$SleepContributionImpl(
      lastNightSleep: freezed == lastNightSleep
          ? _value.lastNightSleep
          : lastNightSleep // ignore: cast_nullable_to_non_nullable
              as Duration?,
      sleepQuality: freezed == sleepQuality
          ? _value.sleepQuality
          : sleepQuality // ignore: cast_nullable_to_non_nullable
              as int?,
      sevenDayAverageSleep: null == sevenDayAverageSleep
          ? _value.sevenDayAverageSleep
          : sevenDayAverageSleep // ignore: cast_nullable_to_non_nullable
              as Duration,
      sleepDebt: null == sleepDebt
          ? _value.sleepDebt
          : sleepDebt // ignore: cast_nullable_to_non_nullable
              as SleepDebtLevel,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SleepContributionImpl implements _SleepContribution {
  const _$SleepContributionImpl(
      {this.lastNightSleep = null,
      this.sleepQuality = null,
      required this.sevenDayAverageSleep,
      required this.sleepDebt,
      this.weight = 0.2});

  factory _$SleepContributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepContributionImplFromJson(json);

  @override
  @JsonKey()
  final Duration? lastNightSleep;
  @override
  @JsonKey()
  final int? sleepQuality;
// 1-10
  @override
  final Duration sevenDayAverageSleep;
  @override
  final SleepDebtLevel sleepDebt;
  @override
  @JsonKey()
  final double weight;

  @override
  String toString() {
    return 'SleepContribution(lastNightSleep: $lastNightSleep, sleepQuality: $sleepQuality, sevenDayAverageSleep: $sevenDayAverageSleep, sleepDebt: $sleepDebt, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepContributionImpl &&
            (identical(other.lastNightSleep, lastNightSleep) ||
                other.lastNightSleep == lastNightSleep) &&
            (identical(other.sleepQuality, sleepQuality) ||
                other.sleepQuality == sleepQuality) &&
            (identical(other.sevenDayAverageSleep, sevenDayAverageSleep) ||
                other.sevenDayAverageSleep == sevenDayAverageSleep) &&
            (identical(other.sleepDebt, sleepDebt) ||
                other.sleepDebt == sleepDebt) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lastNightSleep, sleepQuality,
      sevenDayAverageSleep, sleepDebt, weight);

  /// Create a copy of SleepContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepContributionImplCopyWith<_$SleepContributionImpl> get copyWith =>
      __$$SleepContributionImplCopyWithImpl<_$SleepContributionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SleepContributionImplToJson(
      this,
    );
  }
}

abstract class _SleepContribution implements SleepContribution {
  const factory _SleepContribution(
      {final Duration? lastNightSleep,
      final int? sleepQuality,
      required final Duration sevenDayAverageSleep,
      required final SleepDebtLevel sleepDebt,
      final double weight}) = _$SleepContributionImpl;

  factory _SleepContribution.fromJson(Map<String, dynamic> json) =
      _$SleepContributionImpl.fromJson;

  @override
  Duration? get lastNightSleep;
  @override
  int? get sleepQuality; // 1-10
  @override
  Duration get sevenDayAverageSleep;
  @override
  SleepDebtLevel get sleepDebt;
  @override
  double get weight;

  /// Create a copy of SleepContribution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SleepContributionImplCopyWith<_$SleepContributionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MenstrualContribution _$MenstrualContributionFromJson(
    Map<String, dynamic> json) {
  return _MenstrualContribution.fromJson(json);
}

/// @nodoc
mixin _$MenstrualContribution {
  MenstrualPhase get currentPhase => throw _privateConstructorUsedError;
  int get energyImpact => throw _privateConstructorUsedError; // 1-10 scale
  List<MenstrualSymptom> get activeSymptoms =>
      throw _privateConstructorUsedError;
  int get totalSymptomImpact =>
      throw _privateConstructorUsedError; // Sum of symptom impacts
  double get weight => throw _privateConstructorUsedError;

  /// Serializes this MenstrualContribution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenstrualContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenstrualContributionCopyWith<MenstrualContribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenstrualContributionCopyWith<$Res> {
  factory $MenstrualContributionCopyWith(MenstrualContribution value,
          $Res Function(MenstrualContribution) then) =
      _$MenstrualContributionCopyWithImpl<$Res, MenstrualContribution>;
  @useResult
  $Res call(
      {MenstrualPhase currentPhase,
      int energyImpact,
      List<MenstrualSymptom> activeSymptoms,
      int totalSymptomImpact,
      double weight});
}

/// @nodoc
class _$MenstrualContributionCopyWithImpl<$Res,
        $Val extends MenstrualContribution>
    implements $MenstrualContributionCopyWith<$Res> {
  _$MenstrualContributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenstrualContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPhase = null,
    Object? energyImpact = null,
    Object? activeSymptoms = null,
    Object? totalSymptomImpact = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      currentPhase: null == currentPhase
          ? _value.currentPhase
          : currentPhase // ignore: cast_nullable_to_non_nullable
              as MenstrualPhase,
      energyImpact: null == energyImpact
          ? _value.energyImpact
          : energyImpact // ignore: cast_nullable_to_non_nullable
              as int,
      activeSymptoms: null == activeSymptoms
          ? _value.activeSymptoms
          : activeSymptoms // ignore: cast_nullable_to_non_nullable
              as List<MenstrualSymptom>,
      totalSymptomImpact: null == totalSymptomImpact
          ? _value.totalSymptomImpact
          : totalSymptomImpact // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenstrualContributionImplCopyWith<$Res>
    implements $MenstrualContributionCopyWith<$Res> {
  factory _$$MenstrualContributionImplCopyWith(
          _$MenstrualContributionImpl value,
          $Res Function(_$MenstrualContributionImpl) then) =
      __$$MenstrualContributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MenstrualPhase currentPhase,
      int energyImpact,
      List<MenstrualSymptom> activeSymptoms,
      int totalSymptomImpact,
      double weight});
}

/// @nodoc
class __$$MenstrualContributionImplCopyWithImpl<$Res>
    extends _$MenstrualContributionCopyWithImpl<$Res,
        _$MenstrualContributionImpl>
    implements _$$MenstrualContributionImplCopyWith<$Res> {
  __$$MenstrualContributionImplCopyWithImpl(_$MenstrualContributionImpl _value,
      $Res Function(_$MenstrualContributionImpl) _then)
      : super(_value, _then);

  /// Create a copy of MenstrualContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPhase = null,
    Object? energyImpact = null,
    Object? activeSymptoms = null,
    Object? totalSymptomImpact = null,
    Object? weight = null,
  }) {
    return _then(_$MenstrualContributionImpl(
      currentPhase: null == currentPhase
          ? _value.currentPhase
          : currentPhase // ignore: cast_nullable_to_non_nullable
              as MenstrualPhase,
      energyImpact: null == energyImpact
          ? _value.energyImpact
          : energyImpact // ignore: cast_nullable_to_non_nullable
              as int,
      activeSymptoms: null == activeSymptoms
          ? _value._activeSymptoms
          : activeSymptoms // ignore: cast_nullable_to_non_nullable
              as List<MenstrualSymptom>,
      totalSymptomImpact: null == totalSymptomImpact
          ? _value.totalSymptomImpact
          : totalSymptomImpact // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenstrualContributionImpl implements _MenstrualContribution {
  const _$MenstrualContributionImpl(
      {required this.currentPhase,
      required this.energyImpact,
      final List<MenstrualSymptom> activeSymptoms = const [],
      required this.totalSymptomImpact,
      this.weight = 0.1})
      : _activeSymptoms = activeSymptoms;

  factory _$MenstrualContributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenstrualContributionImplFromJson(json);

  @override
  final MenstrualPhase currentPhase;
  @override
  final int energyImpact;
// 1-10 scale
  final List<MenstrualSymptom> _activeSymptoms;
// 1-10 scale
  @override
  @JsonKey()
  List<MenstrualSymptom> get activeSymptoms {
    if (_activeSymptoms is EqualUnmodifiableListView) return _activeSymptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeSymptoms);
  }

  @override
  final int totalSymptomImpact;
// Sum of symptom impacts
  @override
  @JsonKey()
  final double weight;

  @override
  String toString() {
    return 'MenstrualContribution(currentPhase: $currentPhase, energyImpact: $energyImpact, activeSymptoms: $activeSymptoms, totalSymptomImpact: $totalSymptomImpact, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenstrualContributionImpl &&
            (identical(other.currentPhase, currentPhase) ||
                other.currentPhase == currentPhase) &&
            (identical(other.energyImpact, energyImpact) ||
                other.energyImpact == energyImpact) &&
            const DeepCollectionEquality()
                .equals(other._activeSymptoms, _activeSymptoms) &&
            (identical(other.totalSymptomImpact, totalSymptomImpact) ||
                other.totalSymptomImpact == totalSymptomImpact) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentPhase,
      energyImpact,
      const DeepCollectionEquality().hash(_activeSymptoms),
      totalSymptomImpact,
      weight);

  /// Create a copy of MenstrualContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenstrualContributionImplCopyWith<_$MenstrualContributionImpl>
      get copyWith => __$$MenstrualContributionImplCopyWithImpl<
          _$MenstrualContributionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenstrualContributionImplToJson(
      this,
    );
  }
}

abstract class _MenstrualContribution implements MenstrualContribution {
  const factory _MenstrualContribution(
      {required final MenstrualPhase currentPhase,
      required final int energyImpact,
      final List<MenstrualSymptom> activeSymptoms,
      required final int totalSymptomImpact,
      final double weight}) = _$MenstrualContributionImpl;

  factory _MenstrualContribution.fromJson(Map<String, dynamic> json) =
      _$MenstrualContributionImpl.fromJson;

  @override
  MenstrualPhase get currentPhase;
  @override
  int get energyImpact; // 1-10 scale
  @override
  List<MenstrualSymptom> get activeSymptoms;
  @override
  int get totalSymptomImpact; // Sum of symptom impacts
  @override
  double get weight;

  /// Create a copy of MenstrualContribution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenstrualContributionImplCopyWith<_$MenstrualContributionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PacingRecommendation _$PacingRecommendationFromJson(Map<String, dynamic> json) {
  return _PacingRecommendation.fromJson(json);
}

/// @nodoc
mixin _$PacingRecommendation {
  RecommendationType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  PriorityLevel get priority => throw _privateConstructorUsedError;
  Duration? get duration => throw _privateConstructorUsedError;
  List<String> get specificActions => throw _privateConstructorUsedError;
  String get reasoning => throw _privateConstructorUsedError;

  /// Serializes this PacingRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PacingRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PacingRecommendationCopyWith<PacingRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PacingRecommendationCopyWith<$Res> {
  factory $PacingRecommendationCopyWith(PacingRecommendation value,
          $Res Function(PacingRecommendation) then) =
      _$PacingRecommendationCopyWithImpl<$Res, PacingRecommendation>;
  @useResult
  $Res call(
      {RecommendationType type,
      String title,
      String description,
      PriorityLevel priority,
      Duration? duration,
      List<String> specificActions,
      String reasoning});
}

/// @nodoc
class _$PacingRecommendationCopyWithImpl<$Res,
        $Val extends PacingRecommendation>
    implements $PacingRecommendationCopyWith<$Res> {
  _$PacingRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PacingRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? duration = freezed,
    Object? specificActions = null,
    Object? reasoning = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecommendationType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as PriorityLevel,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      specificActions: null == specificActions
          ? _value.specificActions
          : specificActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PacingRecommendationImplCopyWith<$Res>
    implements $PacingRecommendationCopyWith<$Res> {
  factory _$$PacingRecommendationImplCopyWith(_$PacingRecommendationImpl value,
          $Res Function(_$PacingRecommendationImpl) then) =
      __$$PacingRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RecommendationType type,
      String title,
      String description,
      PriorityLevel priority,
      Duration? duration,
      List<String> specificActions,
      String reasoning});
}

/// @nodoc
class __$$PacingRecommendationImplCopyWithImpl<$Res>
    extends _$PacingRecommendationCopyWithImpl<$Res, _$PacingRecommendationImpl>
    implements _$$PacingRecommendationImplCopyWith<$Res> {
  __$$PacingRecommendationImplCopyWithImpl(_$PacingRecommendationImpl _value,
      $Res Function(_$PacingRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of PacingRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? duration = freezed,
    Object? specificActions = null,
    Object? reasoning = null,
  }) {
    return _then(_$PacingRecommendationImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecommendationType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as PriorityLevel,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      specificActions: null == specificActions
          ? _value._specificActions
          : specificActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PacingRecommendationImpl implements _PacingRecommendation {
  const _$PacingRecommendationImpl(
      {required this.type,
      required this.title,
      required this.description,
      required this.priority,
      this.duration = null,
      final List<String> specificActions = const [],
      this.reasoning = ''})
      : _specificActions = specificActions;

  factory _$PacingRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PacingRecommendationImplFromJson(json);

  @override
  final RecommendationType type;
  @override
  final String title;
  @override
  final String description;
  @override
  final PriorityLevel priority;
  @override
  @JsonKey()
  final Duration? duration;
  final List<String> _specificActions;
  @override
  @JsonKey()
  List<String> get specificActions {
    if (_specificActions is EqualUnmodifiableListView) return _specificActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specificActions);
  }

  @override
  @JsonKey()
  final String reasoning;

  @override
  String toString() {
    return 'PacingRecommendation(type: $type, title: $title, description: $description, priority: $priority, duration: $duration, specificActions: $specificActions, reasoning: $reasoning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PacingRecommendationImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality()
                .equals(other._specificActions, _specificActions) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      title,
      description,
      priority,
      duration,
      const DeepCollectionEquality().hash(_specificActions),
      reasoning);

  /// Create a copy of PacingRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PacingRecommendationImplCopyWith<_$PacingRecommendationImpl>
      get copyWith =>
          __$$PacingRecommendationImplCopyWithImpl<_$PacingRecommendationImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PacingRecommendationImplToJson(
      this,
    );
  }
}

abstract class _PacingRecommendation implements PacingRecommendation {
  const factory _PacingRecommendation(
      {required final RecommendationType type,
      required final String title,
      required final String description,
      required final PriorityLevel priority,
      final Duration? duration,
      final List<String> specificActions,
      final String reasoning}) = _$PacingRecommendationImpl;

  factory _PacingRecommendation.fromJson(Map<String, dynamic> json) =
      _$PacingRecommendationImpl.fromJson;

  @override
  RecommendationType get type;
  @override
  String get title;
  @override
  String get description;
  @override
  PriorityLevel get priority;
  @override
  Duration? get duration;
  @override
  List<String> get specificActions;
  @override
  String get reasoning;

  /// Create a copy of PacingRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PacingRecommendationImplCopyWith<_$PacingRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ActivityGuidance _$ActivityGuidanceFromJson(Map<String, dynamic> json) {
  return _ActivityGuidance.fromJson(json);
}

/// @nodoc
mixin _$ActivityGuidance {
  ActivityRecommendation get mainRecommendation =>
      throw _privateConstructorUsedError;
  int? get maxRecommendedSteps => throw _privateConstructorUsedError;
  Duration? get maxRecommendedActivity => throw _privateConstructorUsedError;
  List<WorkoutType> get recommendedActivities =>
      throw _privateConstructorUsedError;
  List<WorkoutType> get activitiesToAvoid => throw _privateConstructorUsedError;
  int? get maxPerceivedExertion =>
      throw _privateConstructorUsedError; // 1-10 RPE scale
  List<String> get specificGuidance => throw _privateConstructorUsedError;

  /// Serializes this ActivityGuidance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityGuidance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityGuidanceCopyWith<ActivityGuidance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityGuidanceCopyWith<$Res> {
  factory $ActivityGuidanceCopyWith(
          ActivityGuidance value, $Res Function(ActivityGuidance) then) =
      _$ActivityGuidanceCopyWithImpl<$Res, ActivityGuidance>;
  @useResult
  $Res call(
      {ActivityRecommendation mainRecommendation,
      int? maxRecommendedSteps,
      Duration? maxRecommendedActivity,
      List<WorkoutType> recommendedActivities,
      List<WorkoutType> activitiesToAvoid,
      int? maxPerceivedExertion,
      List<String> specificGuidance});
}

/// @nodoc
class _$ActivityGuidanceCopyWithImpl<$Res, $Val extends ActivityGuidance>
    implements $ActivityGuidanceCopyWith<$Res> {
  _$ActivityGuidanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityGuidance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainRecommendation = null,
    Object? maxRecommendedSteps = freezed,
    Object? maxRecommendedActivity = freezed,
    Object? recommendedActivities = null,
    Object? activitiesToAvoid = null,
    Object? maxPerceivedExertion = freezed,
    Object? specificGuidance = null,
  }) {
    return _then(_value.copyWith(
      mainRecommendation: null == mainRecommendation
          ? _value.mainRecommendation
          : mainRecommendation // ignore: cast_nullable_to_non_nullable
              as ActivityRecommendation,
      maxRecommendedSteps: freezed == maxRecommendedSteps
          ? _value.maxRecommendedSteps
          : maxRecommendedSteps // ignore: cast_nullable_to_non_nullable
              as int?,
      maxRecommendedActivity: freezed == maxRecommendedActivity
          ? _value.maxRecommendedActivity
          : maxRecommendedActivity // ignore: cast_nullable_to_non_nullable
              as Duration?,
      recommendedActivities: null == recommendedActivities
          ? _value.recommendedActivities
          : recommendedActivities // ignore: cast_nullable_to_non_nullable
              as List<WorkoutType>,
      activitiesToAvoid: null == activitiesToAvoid
          ? _value.activitiesToAvoid
          : activitiesToAvoid // ignore: cast_nullable_to_non_nullable
              as List<WorkoutType>,
      maxPerceivedExertion: freezed == maxPerceivedExertion
          ? _value.maxPerceivedExertion
          : maxPerceivedExertion // ignore: cast_nullable_to_non_nullable
              as int?,
      specificGuidance: null == specificGuidance
          ? _value.specificGuidance
          : specificGuidance // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityGuidanceImplCopyWith<$Res>
    implements $ActivityGuidanceCopyWith<$Res> {
  factory _$$ActivityGuidanceImplCopyWith(_$ActivityGuidanceImpl value,
          $Res Function(_$ActivityGuidanceImpl) then) =
      __$$ActivityGuidanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ActivityRecommendation mainRecommendation,
      int? maxRecommendedSteps,
      Duration? maxRecommendedActivity,
      List<WorkoutType> recommendedActivities,
      List<WorkoutType> activitiesToAvoid,
      int? maxPerceivedExertion,
      List<String> specificGuidance});
}

/// @nodoc
class __$$ActivityGuidanceImplCopyWithImpl<$Res>
    extends _$ActivityGuidanceCopyWithImpl<$Res, _$ActivityGuidanceImpl>
    implements _$$ActivityGuidanceImplCopyWith<$Res> {
  __$$ActivityGuidanceImplCopyWithImpl(_$ActivityGuidanceImpl _value,
      $Res Function(_$ActivityGuidanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActivityGuidance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainRecommendation = null,
    Object? maxRecommendedSteps = freezed,
    Object? maxRecommendedActivity = freezed,
    Object? recommendedActivities = null,
    Object? activitiesToAvoid = null,
    Object? maxPerceivedExertion = freezed,
    Object? specificGuidance = null,
  }) {
    return _then(_$ActivityGuidanceImpl(
      mainRecommendation: null == mainRecommendation
          ? _value.mainRecommendation
          : mainRecommendation // ignore: cast_nullable_to_non_nullable
              as ActivityRecommendation,
      maxRecommendedSteps: freezed == maxRecommendedSteps
          ? _value.maxRecommendedSteps
          : maxRecommendedSteps // ignore: cast_nullable_to_non_nullable
              as int?,
      maxRecommendedActivity: freezed == maxRecommendedActivity
          ? _value.maxRecommendedActivity
          : maxRecommendedActivity // ignore: cast_nullable_to_non_nullable
              as Duration?,
      recommendedActivities: null == recommendedActivities
          ? _value._recommendedActivities
          : recommendedActivities // ignore: cast_nullable_to_non_nullable
              as List<WorkoutType>,
      activitiesToAvoid: null == activitiesToAvoid
          ? _value._activitiesToAvoid
          : activitiesToAvoid // ignore: cast_nullable_to_non_nullable
              as List<WorkoutType>,
      maxPerceivedExertion: freezed == maxPerceivedExertion
          ? _value.maxPerceivedExertion
          : maxPerceivedExertion // ignore: cast_nullable_to_non_nullable
              as int?,
      specificGuidance: null == specificGuidance
          ? _value._specificGuidance
          : specificGuidance // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityGuidanceImpl implements _ActivityGuidance {
  const _$ActivityGuidanceImpl(
      {required this.mainRecommendation,
      this.maxRecommendedSteps = null,
      this.maxRecommendedActivity = null,
      final List<WorkoutType> recommendedActivities = const [],
      final List<WorkoutType> activitiesToAvoid = const [],
      this.maxPerceivedExertion = null,
      final List<String> specificGuidance = const []})
      : _recommendedActivities = recommendedActivities,
        _activitiesToAvoid = activitiesToAvoid,
        _specificGuidance = specificGuidance;

  factory _$ActivityGuidanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityGuidanceImplFromJson(json);

  @override
  final ActivityRecommendation mainRecommendation;
  @override
  @JsonKey()
  final int? maxRecommendedSteps;
  @override
  @JsonKey()
  final Duration? maxRecommendedActivity;
  final List<WorkoutType> _recommendedActivities;
  @override
  @JsonKey()
  List<WorkoutType> get recommendedActivities {
    if (_recommendedActivities is EqualUnmodifiableListView)
      return _recommendedActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedActivities);
  }

  final List<WorkoutType> _activitiesToAvoid;
  @override
  @JsonKey()
  List<WorkoutType> get activitiesToAvoid {
    if (_activitiesToAvoid is EqualUnmodifiableListView)
      return _activitiesToAvoid;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activitiesToAvoid);
  }

  @override
  @JsonKey()
  final int? maxPerceivedExertion;
// 1-10 RPE scale
  final List<String> _specificGuidance;
// 1-10 RPE scale
  @override
  @JsonKey()
  List<String> get specificGuidance {
    if (_specificGuidance is EqualUnmodifiableListView)
      return _specificGuidance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specificGuidance);
  }

  @override
  String toString() {
    return 'ActivityGuidance(mainRecommendation: $mainRecommendation, maxRecommendedSteps: $maxRecommendedSteps, maxRecommendedActivity: $maxRecommendedActivity, recommendedActivities: $recommendedActivities, activitiesToAvoid: $activitiesToAvoid, maxPerceivedExertion: $maxPerceivedExertion, specificGuidance: $specificGuidance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityGuidanceImpl &&
            (identical(other.mainRecommendation, mainRecommendation) ||
                other.mainRecommendation == mainRecommendation) &&
            (identical(other.maxRecommendedSteps, maxRecommendedSteps) ||
                other.maxRecommendedSteps == maxRecommendedSteps) &&
            (identical(other.maxRecommendedActivity, maxRecommendedActivity) ||
                other.maxRecommendedActivity == maxRecommendedActivity) &&
            const DeepCollectionEquality()
                .equals(other._recommendedActivities, _recommendedActivities) &&
            const DeepCollectionEquality()
                .equals(other._activitiesToAvoid, _activitiesToAvoid) &&
            (identical(other.maxPerceivedExertion, maxPerceivedExertion) ||
                other.maxPerceivedExertion == maxPerceivedExertion) &&
            const DeepCollectionEquality()
                .equals(other._specificGuidance, _specificGuidance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mainRecommendation,
      maxRecommendedSteps,
      maxRecommendedActivity,
      const DeepCollectionEquality().hash(_recommendedActivities),
      const DeepCollectionEquality().hash(_activitiesToAvoid),
      maxPerceivedExertion,
      const DeepCollectionEquality().hash(_specificGuidance));

  /// Create a copy of ActivityGuidance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityGuidanceImplCopyWith<_$ActivityGuidanceImpl> get copyWith =>
      __$$ActivityGuidanceImplCopyWithImpl<_$ActivityGuidanceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityGuidanceImplToJson(
      this,
    );
  }
}

abstract class _ActivityGuidance implements ActivityGuidance {
  const factory _ActivityGuidance(
      {required final ActivityRecommendation mainRecommendation,
      final int? maxRecommendedSteps,
      final Duration? maxRecommendedActivity,
      final List<WorkoutType> recommendedActivities,
      final List<WorkoutType> activitiesToAvoid,
      final int? maxPerceivedExertion,
      final List<String> specificGuidance}) = _$ActivityGuidanceImpl;

  factory _ActivityGuidance.fromJson(Map<String, dynamic> json) =
      _$ActivityGuidanceImpl.fromJson;

  @override
  ActivityRecommendation get mainRecommendation;
  @override
  int? get maxRecommendedSteps;
  @override
  Duration? get maxRecommendedActivity;
  @override
  List<WorkoutType> get recommendedActivities;
  @override
  List<WorkoutType> get activitiesToAvoid;
  @override
  int? get maxPerceivedExertion; // 1-10 RPE scale
  @override
  List<String> get specificGuidance;

  /// Create a copy of ActivityGuidance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityGuidanceImplCopyWith<_$ActivityGuidanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChronicConditionProfile _$ChronicConditionProfileFromJson(
    Map<String, dynamic> json) {
  return _ChronicConditionProfile.fromJson(json);
}

/// @nodoc
mixin _$ChronicConditionProfile {
  List<ChronicCondition> get conditions => throw _privateConstructorUsedError;
  double get pemSensitivity => throw _privateConstructorUsedError; // 0.5-2.0
  double get recoveryTimeMultiplier =>
      throw _privateConstructorUsedError; // 0.5-3.0
  int get baselineEnergyLevel => throw _privateConstructorUsedError; // 0-100
  List<String> get triggerActivities => throw _privateConstructorUsedError;
  List<String> get safetActivities => throw _privateConstructorUsedError;

  /// Serializes this ChronicConditionProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChronicConditionProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChronicConditionProfileCopyWith<ChronicConditionProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChronicConditionProfileCopyWith<$Res> {
  factory $ChronicConditionProfileCopyWith(ChronicConditionProfile value,
          $Res Function(ChronicConditionProfile) then) =
      _$ChronicConditionProfileCopyWithImpl<$Res, ChronicConditionProfile>;
  @useResult
  $Res call(
      {List<ChronicCondition> conditions,
      double pemSensitivity,
      double recoveryTimeMultiplier,
      int baselineEnergyLevel,
      List<String> triggerActivities,
      List<String> safetActivities});
}

/// @nodoc
class _$ChronicConditionProfileCopyWithImpl<$Res,
        $Val extends ChronicConditionProfile>
    implements $ChronicConditionProfileCopyWith<$Res> {
  _$ChronicConditionProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChronicConditionProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conditions = null,
    Object? pemSensitivity = null,
    Object? recoveryTimeMultiplier = null,
    Object? baselineEnergyLevel = null,
    Object? triggerActivities = null,
    Object? safetActivities = null,
  }) {
    return _then(_value.copyWith(
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<ChronicCondition>,
      pemSensitivity: null == pemSensitivity
          ? _value.pemSensitivity
          : pemSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      recoveryTimeMultiplier: null == recoveryTimeMultiplier
          ? _value.recoveryTimeMultiplier
          : recoveryTimeMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      baselineEnergyLevel: null == baselineEnergyLevel
          ? _value.baselineEnergyLevel
          : baselineEnergyLevel // ignore: cast_nullable_to_non_nullable
              as int,
      triggerActivities: null == triggerActivities
          ? _value.triggerActivities
          : triggerActivities // ignore: cast_nullable_to_non_nullable
              as List<String>,
      safetActivities: null == safetActivities
          ? _value.safetActivities
          : safetActivities // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChronicConditionProfileImplCopyWith<$Res>
    implements $ChronicConditionProfileCopyWith<$Res> {
  factory _$$ChronicConditionProfileImplCopyWith(
          _$ChronicConditionProfileImpl value,
          $Res Function(_$ChronicConditionProfileImpl) then) =
      __$$ChronicConditionProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ChronicCondition> conditions,
      double pemSensitivity,
      double recoveryTimeMultiplier,
      int baselineEnergyLevel,
      List<String> triggerActivities,
      List<String> safetActivities});
}

/// @nodoc
class __$$ChronicConditionProfileImplCopyWithImpl<$Res>
    extends _$ChronicConditionProfileCopyWithImpl<$Res,
        _$ChronicConditionProfileImpl>
    implements _$$ChronicConditionProfileImplCopyWith<$Res> {
  __$$ChronicConditionProfileImplCopyWithImpl(
      _$ChronicConditionProfileImpl _value,
      $Res Function(_$ChronicConditionProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChronicConditionProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conditions = null,
    Object? pemSensitivity = null,
    Object? recoveryTimeMultiplier = null,
    Object? baselineEnergyLevel = null,
    Object? triggerActivities = null,
    Object? safetActivities = null,
  }) {
    return _then(_$ChronicConditionProfileImpl(
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<ChronicCondition>,
      pemSensitivity: null == pemSensitivity
          ? _value.pemSensitivity
          : pemSensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      recoveryTimeMultiplier: null == recoveryTimeMultiplier
          ? _value.recoveryTimeMultiplier
          : recoveryTimeMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      baselineEnergyLevel: null == baselineEnergyLevel
          ? _value.baselineEnergyLevel
          : baselineEnergyLevel // ignore: cast_nullable_to_non_nullable
              as int,
      triggerActivities: null == triggerActivities
          ? _value._triggerActivities
          : triggerActivities // ignore: cast_nullable_to_non_nullable
              as List<String>,
      safetActivities: null == safetActivities
          ? _value._safetActivities
          : safetActivities // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChronicConditionProfileImpl implements _ChronicConditionProfile {
  const _$ChronicConditionProfileImpl(
      {final List<ChronicCondition> conditions = const [],
      this.pemSensitivity = 1.0,
      this.recoveryTimeMultiplier = 1.0,
      this.baselineEnergyLevel = 50,
      final List<String> triggerActivities = const [],
      final List<String> safetActivities = const []})
      : _conditions = conditions,
        _triggerActivities = triggerActivities,
        _safetActivities = safetActivities;

  factory _$ChronicConditionProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChronicConditionProfileImplFromJson(json);

  final List<ChronicCondition> _conditions;
  @override
  @JsonKey()
  List<ChronicCondition> get conditions {
    if (_conditions is EqualUnmodifiableListView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditions);
  }

  @override
  @JsonKey()
  final double pemSensitivity;
// 0.5-2.0
  @override
  @JsonKey()
  final double recoveryTimeMultiplier;
// 0.5-3.0
  @override
  @JsonKey()
  final int baselineEnergyLevel;
// 0-100
  final List<String> _triggerActivities;
// 0-100
  @override
  @JsonKey()
  List<String> get triggerActivities {
    if (_triggerActivities is EqualUnmodifiableListView)
      return _triggerActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_triggerActivities);
  }

  final List<String> _safetActivities;
  @override
  @JsonKey()
  List<String> get safetActivities {
    if (_safetActivities is EqualUnmodifiableListView) return _safetActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_safetActivities);
  }

  @override
  String toString() {
    return 'ChronicConditionProfile(conditions: $conditions, pemSensitivity: $pemSensitivity, recoveryTimeMultiplier: $recoveryTimeMultiplier, baselineEnergyLevel: $baselineEnergyLevel, triggerActivities: $triggerActivities, safetActivities: $safetActivities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChronicConditionProfileImpl &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions) &&
            (identical(other.pemSensitivity, pemSensitivity) ||
                other.pemSensitivity == pemSensitivity) &&
            (identical(other.recoveryTimeMultiplier, recoveryTimeMultiplier) ||
                other.recoveryTimeMultiplier == recoveryTimeMultiplier) &&
            (identical(other.baselineEnergyLevel, baselineEnergyLevel) ||
                other.baselineEnergyLevel == baselineEnergyLevel) &&
            const DeepCollectionEquality()
                .equals(other._triggerActivities, _triggerActivities) &&
            const DeepCollectionEquality()
                .equals(other._safetActivities, _safetActivities));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_conditions),
      pemSensitivity,
      recoveryTimeMultiplier,
      baselineEnergyLevel,
      const DeepCollectionEquality().hash(_triggerActivities),
      const DeepCollectionEquality().hash(_safetActivities));

  /// Create a copy of ChronicConditionProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChronicConditionProfileImplCopyWith<_$ChronicConditionProfileImpl>
      get copyWith => __$$ChronicConditionProfileImplCopyWithImpl<
          _$ChronicConditionProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChronicConditionProfileImplToJson(
      this,
    );
  }
}

abstract class _ChronicConditionProfile implements ChronicConditionProfile {
  const factory _ChronicConditionProfile(
      {final List<ChronicCondition> conditions,
      final double pemSensitivity,
      final double recoveryTimeMultiplier,
      final int baselineEnergyLevel,
      final List<String> triggerActivities,
      final List<String> safetActivities}) = _$ChronicConditionProfileImpl;

  factory _ChronicConditionProfile.fromJson(Map<String, dynamic> json) =
      _$ChronicConditionProfileImpl.fromJson;

  @override
  List<ChronicCondition> get conditions;
  @override
  double get pemSensitivity; // 0.5-2.0
  @override
  double get recoveryTimeMultiplier; // 0.5-3.0
  @override
  int get baselineEnergyLevel; // 0-100
  @override
  List<String> get triggerActivities;
  @override
  List<String> get safetActivities;

  /// Create a copy of ChronicConditionProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChronicConditionProfileImplCopyWith<_$ChronicConditionProfileImpl>
      get copyWith => throw _privateConstructorUsedError;
}
