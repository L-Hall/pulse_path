// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hrv_reading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HrvReading _$HrvReadingFromJson(Map<String, dynamic> json) {
  return _HrvReading.fromJson(json);
}

/// @nodoc
mixin _$HrvReading {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  HrvMetrics get metrics => throw _privateConstructorUsedError;
  List<double> get rrIntervals => throw _privateConstructorUsedError;
  HrvScores get scores => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;
  bool get isRealData => throw _privateConstructorUsedError;

  /// Serializes this HrvReading to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HrvReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HrvReadingCopyWith<HrvReading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HrvReadingCopyWith<$Res> {
  factory $HrvReadingCopyWith(
          HrvReading value, $Res Function(HrvReading) then) =
      _$HrvReadingCopyWithImpl<$Res, HrvReading>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      int durationSeconds,
      HrvMetrics metrics,
      List<double> rrIntervals,
      HrvScores scores,
      String? notes,
      List<String>? tags,
      bool isSynced,
      bool isRealData});

  $HrvMetricsCopyWith<$Res> get metrics;
  $HrvScoresCopyWith<$Res> get scores;
}

/// @nodoc
class _$HrvReadingCopyWithImpl<$Res, $Val extends HrvReading>
    implements $HrvReadingCopyWith<$Res> {
  _$HrvReadingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HrvReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? durationSeconds = null,
    Object? metrics = null,
    Object? rrIntervals = null,
    Object? scores = null,
    Object? notes = freezed,
    Object? tags = freezed,
    Object? isSynced = null,
    Object? isRealData = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as HrvMetrics,
      rrIntervals: null == rrIntervals
          ? _value.rrIntervals
          : rrIntervals // ignore: cast_nullable_to_non_nullable
              as List<double>,
      scores: null == scores
          ? _value.scores
          : scores // ignore: cast_nullable_to_non_nullable
              as HrvScores,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      isRealData: null == isRealData
          ? _value.isRealData
          : isRealData // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of HrvReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HrvMetricsCopyWith<$Res> get metrics {
    return $HrvMetricsCopyWith<$Res>(_value.metrics, (value) {
      return _then(_value.copyWith(metrics: value) as $Val);
    });
  }

  /// Create a copy of HrvReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HrvScoresCopyWith<$Res> get scores {
    return $HrvScoresCopyWith<$Res>(_value.scores, (value) {
      return _then(_value.copyWith(scores: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HrvReadingImplCopyWith<$Res>
    implements $HrvReadingCopyWith<$Res> {
  factory _$$HrvReadingImplCopyWith(
          _$HrvReadingImpl value, $Res Function(_$HrvReadingImpl) then) =
      __$$HrvReadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      int durationSeconds,
      HrvMetrics metrics,
      List<double> rrIntervals,
      HrvScores scores,
      String? notes,
      List<String>? tags,
      bool isSynced,
      bool isRealData});

  @override
  $HrvMetricsCopyWith<$Res> get metrics;
  @override
  $HrvScoresCopyWith<$Res> get scores;
}

/// @nodoc
class __$$HrvReadingImplCopyWithImpl<$Res>
    extends _$HrvReadingCopyWithImpl<$Res, _$HrvReadingImpl>
    implements _$$HrvReadingImplCopyWith<$Res> {
  __$$HrvReadingImplCopyWithImpl(
      _$HrvReadingImpl _value, $Res Function(_$HrvReadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of HrvReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? durationSeconds = null,
    Object? metrics = null,
    Object? rrIntervals = null,
    Object? scores = null,
    Object? notes = freezed,
    Object? tags = freezed,
    Object? isSynced = null,
    Object? isRealData = null,
  }) {
    return _then(_$HrvReadingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as HrvMetrics,
      rrIntervals: null == rrIntervals
          ? _value._rrIntervals
          : rrIntervals // ignore: cast_nullable_to_non_nullable
              as List<double>,
      scores: null == scores
          ? _value.scores
          : scores // ignore: cast_nullable_to_non_nullable
              as HrvScores,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      isRealData: null == isRealData
          ? _value.isRealData
          : isRealData // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HrvReadingImpl implements _HrvReading {
  const _$HrvReadingImpl(
      {required this.id,
      required this.timestamp,
      required this.durationSeconds,
      required this.metrics,
      required final List<double> rrIntervals,
      required this.scores,
      this.notes,
      final List<String>? tags,
      this.isSynced = false,
      this.isRealData = true})
      : _rrIntervals = rrIntervals,
        _tags = tags;

  factory _$HrvReadingImpl.fromJson(Map<String, dynamic> json) =>
      _$$HrvReadingImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final int durationSeconds;
  @override
  final HrvMetrics metrics;
  final List<double> _rrIntervals;
  @override
  List<double> get rrIntervals {
    if (_rrIntervals is EqualUnmodifiableListView) return _rrIntervals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rrIntervals);
  }

  @override
  final HrvScores scores;
  @override
  final String? notes;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isSynced;
  @override
  @JsonKey()
  final bool isRealData;

  @override
  String toString() {
    return 'HrvReading(id: $id, timestamp: $timestamp, durationSeconds: $durationSeconds, metrics: $metrics, rrIntervals: $rrIntervals, scores: $scores, notes: $notes, tags: $tags, isSynced: $isSynced, isRealData: $isRealData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HrvReadingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.metrics, metrics) || other.metrics == metrics) &&
            const DeepCollectionEquality()
                .equals(other._rrIntervals, _rrIntervals) &&
            (identical(other.scores, scores) || other.scores == scores) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.isRealData, isRealData) ||
                other.isRealData == isRealData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      durationSeconds,
      metrics,
      const DeepCollectionEquality().hash(_rrIntervals),
      scores,
      notes,
      const DeepCollectionEquality().hash(_tags),
      isSynced,
      isRealData);

  /// Create a copy of HrvReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HrvReadingImplCopyWith<_$HrvReadingImpl> get copyWith =>
      __$$HrvReadingImplCopyWithImpl<_$HrvReadingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HrvReadingImplToJson(
      this,
    );
  }
}

abstract class _HrvReading implements HrvReading {
  const factory _HrvReading(
      {required final String id,
      required final DateTime timestamp,
      required final int durationSeconds,
      required final HrvMetrics metrics,
      required final List<double> rrIntervals,
      required final HrvScores scores,
      final String? notes,
      final List<String>? tags,
      final bool isSynced,
      final bool isRealData}) = _$HrvReadingImpl;

  factory _HrvReading.fromJson(Map<String, dynamic> json) =
      _$HrvReadingImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  int get durationSeconds;
  @override
  HrvMetrics get metrics;
  @override
  List<double> get rrIntervals;
  @override
  HrvScores get scores;
  @override
  String? get notes;
  @override
  List<String>? get tags;
  @override
  bool get isSynced;
  @override
  bool get isRealData;

  /// Create a copy of HrvReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HrvReadingImplCopyWith<_$HrvReadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HrvMetrics _$HrvMetricsFromJson(Map<String, dynamic> json) {
  return _HrvMetrics.fromJson(json);
}

/// @nodoc
mixin _$HrvMetrics {
  double get rmssd => throw _privateConstructorUsedError;
  double get meanRr => throw _privateConstructorUsedError;
  double get sdnn => throw _privateConstructorUsedError;
  double get lowFrequency => throw _privateConstructorUsedError;
  double get highFrequency => throw _privateConstructorUsedError;
  double get lfHfRatio => throw _privateConstructorUsedError;
  double get baevsky => throw _privateConstructorUsedError;
  double get coefficientOfVariance => throw _privateConstructorUsedError;
  double get mxdmn => throw _privateConstructorUsedError;
  double get moda => throw _privateConstructorUsedError;
  double get amo50 => throw _privateConstructorUsedError;
  double get pnn50 => throw _privateConstructorUsedError;
  double get pnn20 => throw _privateConstructorUsedError;
  double get totalPower => throw _privateConstructorUsedError;
  double get dfaAlpha1 => throw _privateConstructorUsedError;

  /// Serializes this HrvMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HrvMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HrvMetricsCopyWith<HrvMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HrvMetricsCopyWith<$Res> {
  factory $HrvMetricsCopyWith(
          HrvMetrics value, $Res Function(HrvMetrics) then) =
      _$HrvMetricsCopyWithImpl<$Res, HrvMetrics>;
  @useResult
  $Res call(
      {double rmssd,
      double meanRr,
      double sdnn,
      double lowFrequency,
      double highFrequency,
      double lfHfRatio,
      double baevsky,
      double coefficientOfVariance,
      double mxdmn,
      double moda,
      double amo50,
      double pnn50,
      double pnn20,
      double totalPower,
      double dfaAlpha1});
}

/// @nodoc
class _$HrvMetricsCopyWithImpl<$Res, $Val extends HrvMetrics>
    implements $HrvMetricsCopyWith<$Res> {
  _$HrvMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HrvMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rmssd = null,
    Object? meanRr = null,
    Object? sdnn = null,
    Object? lowFrequency = null,
    Object? highFrequency = null,
    Object? lfHfRatio = null,
    Object? baevsky = null,
    Object? coefficientOfVariance = null,
    Object? mxdmn = null,
    Object? moda = null,
    Object? amo50 = null,
    Object? pnn50 = null,
    Object? pnn20 = null,
    Object? totalPower = null,
    Object? dfaAlpha1 = null,
  }) {
    return _then(_value.copyWith(
      rmssd: null == rmssd
          ? _value.rmssd
          : rmssd // ignore: cast_nullable_to_non_nullable
              as double,
      meanRr: null == meanRr
          ? _value.meanRr
          : meanRr // ignore: cast_nullable_to_non_nullable
              as double,
      sdnn: null == sdnn
          ? _value.sdnn
          : sdnn // ignore: cast_nullable_to_non_nullable
              as double,
      lowFrequency: null == lowFrequency
          ? _value.lowFrequency
          : lowFrequency // ignore: cast_nullable_to_non_nullable
              as double,
      highFrequency: null == highFrequency
          ? _value.highFrequency
          : highFrequency // ignore: cast_nullable_to_non_nullable
              as double,
      lfHfRatio: null == lfHfRatio
          ? _value.lfHfRatio
          : lfHfRatio // ignore: cast_nullable_to_non_nullable
              as double,
      baevsky: null == baevsky
          ? _value.baevsky
          : baevsky // ignore: cast_nullable_to_non_nullable
              as double,
      coefficientOfVariance: null == coefficientOfVariance
          ? _value.coefficientOfVariance
          : coefficientOfVariance // ignore: cast_nullable_to_non_nullable
              as double,
      mxdmn: null == mxdmn
          ? _value.mxdmn
          : mxdmn // ignore: cast_nullable_to_non_nullable
              as double,
      moda: null == moda
          ? _value.moda
          : moda // ignore: cast_nullable_to_non_nullable
              as double,
      amo50: null == amo50
          ? _value.amo50
          : amo50 // ignore: cast_nullable_to_non_nullable
              as double,
      pnn50: null == pnn50
          ? _value.pnn50
          : pnn50 // ignore: cast_nullable_to_non_nullable
              as double,
      pnn20: null == pnn20
          ? _value.pnn20
          : pnn20 // ignore: cast_nullable_to_non_nullable
              as double,
      totalPower: null == totalPower
          ? _value.totalPower
          : totalPower // ignore: cast_nullable_to_non_nullable
              as double,
      dfaAlpha1: null == dfaAlpha1
          ? _value.dfaAlpha1
          : dfaAlpha1 // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HrvMetricsImplCopyWith<$Res>
    implements $HrvMetricsCopyWith<$Res> {
  factory _$$HrvMetricsImplCopyWith(
          _$HrvMetricsImpl value, $Res Function(_$HrvMetricsImpl) then) =
      __$$HrvMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double rmssd,
      double meanRr,
      double sdnn,
      double lowFrequency,
      double highFrequency,
      double lfHfRatio,
      double baevsky,
      double coefficientOfVariance,
      double mxdmn,
      double moda,
      double amo50,
      double pnn50,
      double pnn20,
      double totalPower,
      double dfaAlpha1});
}

/// @nodoc
class __$$HrvMetricsImplCopyWithImpl<$Res>
    extends _$HrvMetricsCopyWithImpl<$Res, _$HrvMetricsImpl>
    implements _$$HrvMetricsImplCopyWith<$Res> {
  __$$HrvMetricsImplCopyWithImpl(
      _$HrvMetricsImpl _value, $Res Function(_$HrvMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of HrvMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rmssd = null,
    Object? meanRr = null,
    Object? sdnn = null,
    Object? lowFrequency = null,
    Object? highFrequency = null,
    Object? lfHfRatio = null,
    Object? baevsky = null,
    Object? coefficientOfVariance = null,
    Object? mxdmn = null,
    Object? moda = null,
    Object? amo50 = null,
    Object? pnn50 = null,
    Object? pnn20 = null,
    Object? totalPower = null,
    Object? dfaAlpha1 = null,
  }) {
    return _then(_$HrvMetricsImpl(
      rmssd: null == rmssd
          ? _value.rmssd
          : rmssd // ignore: cast_nullable_to_non_nullable
              as double,
      meanRr: null == meanRr
          ? _value.meanRr
          : meanRr // ignore: cast_nullable_to_non_nullable
              as double,
      sdnn: null == sdnn
          ? _value.sdnn
          : sdnn // ignore: cast_nullable_to_non_nullable
              as double,
      lowFrequency: null == lowFrequency
          ? _value.lowFrequency
          : lowFrequency // ignore: cast_nullable_to_non_nullable
              as double,
      highFrequency: null == highFrequency
          ? _value.highFrequency
          : highFrequency // ignore: cast_nullable_to_non_nullable
              as double,
      lfHfRatio: null == lfHfRatio
          ? _value.lfHfRatio
          : lfHfRatio // ignore: cast_nullable_to_non_nullable
              as double,
      baevsky: null == baevsky
          ? _value.baevsky
          : baevsky // ignore: cast_nullable_to_non_nullable
              as double,
      coefficientOfVariance: null == coefficientOfVariance
          ? _value.coefficientOfVariance
          : coefficientOfVariance // ignore: cast_nullable_to_non_nullable
              as double,
      mxdmn: null == mxdmn
          ? _value.mxdmn
          : mxdmn // ignore: cast_nullable_to_non_nullable
              as double,
      moda: null == moda
          ? _value.moda
          : moda // ignore: cast_nullable_to_non_nullable
              as double,
      amo50: null == amo50
          ? _value.amo50
          : amo50 // ignore: cast_nullable_to_non_nullable
              as double,
      pnn50: null == pnn50
          ? _value.pnn50
          : pnn50 // ignore: cast_nullable_to_non_nullable
              as double,
      pnn20: null == pnn20
          ? _value.pnn20
          : pnn20 // ignore: cast_nullable_to_non_nullable
              as double,
      totalPower: null == totalPower
          ? _value.totalPower
          : totalPower // ignore: cast_nullable_to_non_nullable
              as double,
      dfaAlpha1: null == dfaAlpha1
          ? _value.dfaAlpha1
          : dfaAlpha1 // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HrvMetricsImpl implements _HrvMetrics {
  const _$HrvMetricsImpl(
      {required this.rmssd,
      required this.meanRr,
      required this.sdnn,
      required this.lowFrequency,
      required this.highFrequency,
      required this.lfHfRatio,
      required this.baevsky,
      required this.coefficientOfVariance,
      required this.mxdmn,
      required this.moda,
      required this.amo50,
      required this.pnn50,
      required this.pnn20,
      required this.totalPower,
      required this.dfaAlpha1});

  factory _$HrvMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$HrvMetricsImplFromJson(json);

  @override
  final double rmssd;
  @override
  final double meanRr;
  @override
  final double sdnn;
  @override
  final double lowFrequency;
  @override
  final double highFrequency;
  @override
  final double lfHfRatio;
  @override
  final double baevsky;
  @override
  final double coefficientOfVariance;
  @override
  final double mxdmn;
  @override
  final double moda;
  @override
  final double amo50;
  @override
  final double pnn50;
  @override
  final double pnn20;
  @override
  final double totalPower;
  @override
  final double dfaAlpha1;

  @override
  String toString() {
    return 'HrvMetrics(rmssd: $rmssd, meanRr: $meanRr, sdnn: $sdnn, lowFrequency: $lowFrequency, highFrequency: $highFrequency, lfHfRatio: $lfHfRatio, baevsky: $baevsky, coefficientOfVariance: $coefficientOfVariance, mxdmn: $mxdmn, moda: $moda, amo50: $amo50, pnn50: $pnn50, pnn20: $pnn20, totalPower: $totalPower, dfaAlpha1: $dfaAlpha1)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HrvMetricsImpl &&
            (identical(other.rmssd, rmssd) || other.rmssd == rmssd) &&
            (identical(other.meanRr, meanRr) || other.meanRr == meanRr) &&
            (identical(other.sdnn, sdnn) || other.sdnn == sdnn) &&
            (identical(other.lowFrequency, lowFrequency) ||
                other.lowFrequency == lowFrequency) &&
            (identical(other.highFrequency, highFrequency) ||
                other.highFrequency == highFrequency) &&
            (identical(other.lfHfRatio, lfHfRatio) ||
                other.lfHfRatio == lfHfRatio) &&
            (identical(other.baevsky, baevsky) || other.baevsky == baevsky) &&
            (identical(other.coefficientOfVariance, coefficientOfVariance) ||
                other.coefficientOfVariance == coefficientOfVariance) &&
            (identical(other.mxdmn, mxdmn) || other.mxdmn == mxdmn) &&
            (identical(other.moda, moda) || other.moda == moda) &&
            (identical(other.amo50, amo50) || other.amo50 == amo50) &&
            (identical(other.pnn50, pnn50) || other.pnn50 == pnn50) &&
            (identical(other.pnn20, pnn20) || other.pnn20 == pnn20) &&
            (identical(other.totalPower, totalPower) ||
                other.totalPower == totalPower) &&
            (identical(other.dfaAlpha1, dfaAlpha1) ||
                other.dfaAlpha1 == dfaAlpha1));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      rmssd,
      meanRr,
      sdnn,
      lowFrequency,
      highFrequency,
      lfHfRatio,
      baevsky,
      coefficientOfVariance,
      mxdmn,
      moda,
      amo50,
      pnn50,
      pnn20,
      totalPower,
      dfaAlpha1);

  /// Create a copy of HrvMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HrvMetricsImplCopyWith<_$HrvMetricsImpl> get copyWith =>
      __$$HrvMetricsImplCopyWithImpl<_$HrvMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HrvMetricsImplToJson(
      this,
    );
  }
}

abstract class _HrvMetrics implements HrvMetrics {
  const factory _HrvMetrics(
      {required final double rmssd,
      required final double meanRr,
      required final double sdnn,
      required final double lowFrequency,
      required final double highFrequency,
      required final double lfHfRatio,
      required final double baevsky,
      required final double coefficientOfVariance,
      required final double mxdmn,
      required final double moda,
      required final double amo50,
      required final double pnn50,
      required final double pnn20,
      required final double totalPower,
      required final double dfaAlpha1}) = _$HrvMetricsImpl;

  factory _HrvMetrics.fromJson(Map<String, dynamic> json) =
      _$HrvMetricsImpl.fromJson;

  @override
  double get rmssd;
  @override
  double get meanRr;
  @override
  double get sdnn;
  @override
  double get lowFrequency;
  @override
  double get highFrequency;
  @override
  double get lfHfRatio;
  @override
  double get baevsky;
  @override
  double get coefficientOfVariance;
  @override
  double get mxdmn;
  @override
  double get moda;
  @override
  double get amo50;
  @override
  double get pnn50;
  @override
  double get pnn20;
  @override
  double get totalPower;
  @override
  double get dfaAlpha1;

  /// Create a copy of HrvMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HrvMetricsImplCopyWith<_$HrvMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HrvScores _$HrvScoresFromJson(Map<String, dynamic> json) {
  return _HrvScores.fromJson(json);
}

/// @nodoc
mixin _$HrvScores {
  int get stress => throw _privateConstructorUsedError;
  int get recovery => throw _privateConstructorUsedError;
  int get energy => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  /// Serializes this HrvScores to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HrvScores
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HrvScoresCopyWith<HrvScores> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HrvScoresCopyWith<$Res> {
  factory $HrvScoresCopyWith(HrvScores value, $Res Function(HrvScores) then) =
      _$HrvScoresCopyWithImpl<$Res, HrvScores>;
  @useResult
  $Res call({int stress, int recovery, int energy, double confidence});
}

/// @nodoc
class _$HrvScoresCopyWithImpl<$Res, $Val extends HrvScores>
    implements $HrvScoresCopyWith<$Res> {
  _$HrvScoresCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HrvScores
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stress = null,
    Object? recovery = null,
    Object? energy = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      stress: null == stress
          ? _value.stress
          : stress // ignore: cast_nullable_to_non_nullable
              as int,
      recovery: null == recovery
          ? _value.recovery
          : recovery // ignore: cast_nullable_to_non_nullable
              as int,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HrvScoresImplCopyWith<$Res>
    implements $HrvScoresCopyWith<$Res> {
  factory _$$HrvScoresImplCopyWith(
          _$HrvScoresImpl value, $Res Function(_$HrvScoresImpl) then) =
      __$$HrvScoresImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int stress, int recovery, int energy, double confidence});
}

/// @nodoc
class __$$HrvScoresImplCopyWithImpl<$Res>
    extends _$HrvScoresCopyWithImpl<$Res, _$HrvScoresImpl>
    implements _$$HrvScoresImplCopyWith<$Res> {
  __$$HrvScoresImplCopyWithImpl(
      _$HrvScoresImpl _value, $Res Function(_$HrvScoresImpl) _then)
      : super(_value, _then);

  /// Create a copy of HrvScores
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stress = null,
    Object? recovery = null,
    Object? energy = null,
    Object? confidence = null,
  }) {
    return _then(_$HrvScoresImpl(
      stress: null == stress
          ? _value.stress
          : stress // ignore: cast_nullable_to_non_nullable
              as int,
      recovery: null == recovery
          ? _value.recovery
          : recovery // ignore: cast_nullable_to_non_nullable
              as int,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HrvScoresImpl implements _HrvScores {
  const _$HrvScoresImpl(
      {required this.stress,
      required this.recovery,
      required this.energy,
      required this.confidence});

  factory _$HrvScoresImpl.fromJson(Map<String, dynamic> json) =>
      _$$HrvScoresImplFromJson(json);

  @override
  final int stress;
  @override
  final int recovery;
  @override
  final int energy;
  @override
  final double confidence;

  @override
  String toString() {
    return 'HrvScores(stress: $stress, recovery: $recovery, energy: $energy, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HrvScoresImpl &&
            (identical(other.stress, stress) || other.stress == stress) &&
            (identical(other.recovery, recovery) ||
                other.recovery == recovery) &&
            (identical(other.energy, energy) || other.energy == energy) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, stress, recovery, energy, confidence);

  /// Create a copy of HrvScores
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HrvScoresImplCopyWith<_$HrvScoresImpl> get copyWith =>
      __$$HrvScoresImplCopyWithImpl<_$HrvScoresImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HrvScoresImplToJson(
      this,
    );
  }
}

abstract class _HrvScores implements HrvScores {
  const factory _HrvScores(
      {required final int stress,
      required final int recovery,
      required final int energy,
      required final double confidence}) = _$HrvScoresImpl;

  factory _HrvScores.fromJson(Map<String, dynamic> json) =
      _$HrvScoresImpl.fromJson;

  @override
  int get stress;
  @override
  int get recovery;
  @override
  int get energy;
  @override
  double get confidence;

  /// Create a copy of HrvScores
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HrvScoresImplCopyWith<_$HrvScoresImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
