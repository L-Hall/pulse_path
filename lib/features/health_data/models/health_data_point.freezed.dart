// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_data_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HealthDataPoint _$HealthDataPointFromJson(Map<String, dynamic> json) {
  return _HealthDataPoint.fromJson(json);
}

/// @nodoc
mixin _$HealthDataPoint {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  DateTime get dateFrom => throw _privateConstructorUsedError;
  DateTime get dateTo => throw _privateConstructorUsedError;
  String get sourcePlatform => throw _privateConstructorUsedError;
  String get sourceId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this HealthDataPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthDataPointCopyWith<HealthDataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthDataPointCopyWith<$Res> {
  factory $HealthDataPointCopyWith(
          HealthDataPoint value, $Res Function(HealthDataPoint) then) =
      _$HealthDataPointCopyWithImpl<$Res, HealthDataPoint>;
  @useResult
  $Res call(
      {String id,
      String type,
      double value,
      String unit,
      DateTime dateFrom,
      DateTime dateTo,
      String sourcePlatform,
      String sourceId,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$HealthDataPointCopyWithImpl<$Res, $Val extends HealthDataPoint>
    implements $HealthDataPointCopyWith<$Res> {
  _$HealthDataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? value = null,
    Object? unit = null,
    Object? dateFrom = null,
    Object? dateTo = null,
    Object? sourcePlatform = null,
    Object? sourceId = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      dateFrom: null == dateFrom
          ? _value.dateFrom
          : dateFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateTo: null == dateTo
          ? _value.dateTo
          : dateTo // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sourcePlatform: null == sourcePlatform
          ? _value.sourcePlatform
          : sourcePlatform // ignore: cast_nullable_to_non_nullable
              as String,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthDataPointImplCopyWith<$Res>
    implements $HealthDataPointCopyWith<$Res> {
  factory _$$HealthDataPointImplCopyWith(_$HealthDataPointImpl value,
          $Res Function(_$HealthDataPointImpl) then) =
      __$$HealthDataPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      double value,
      String unit,
      DateTime dateFrom,
      DateTime dateTo,
      String sourcePlatform,
      String sourceId,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$HealthDataPointImplCopyWithImpl<$Res>
    extends _$HealthDataPointCopyWithImpl<$Res, _$HealthDataPointImpl>
    implements _$$HealthDataPointImplCopyWith<$Res> {
  __$$HealthDataPointImplCopyWithImpl(
      _$HealthDataPointImpl _value, $Res Function(_$HealthDataPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? value = null,
    Object? unit = null,
    Object? dateFrom = null,
    Object? dateTo = null,
    Object? sourcePlatform = null,
    Object? sourceId = null,
    Object? metadata = freezed,
  }) {
    return _then(_$HealthDataPointImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      dateFrom: null == dateFrom
          ? _value.dateFrom
          : dateFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateTo: null == dateTo
          ? _value.dateTo
          : dateTo // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sourcePlatform: null == sourcePlatform
          ? _value.sourcePlatform
          : sourcePlatform // ignore: cast_nullable_to_non_nullable
              as String,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthDataPointImpl implements _HealthDataPoint {
  const _$HealthDataPointImpl(
      {required this.id,
      required this.type,
      required this.value,
      required this.unit,
      required this.dateFrom,
      required this.dateTo,
      required this.sourcePlatform,
      required this.sourceId,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$HealthDataPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthDataPointImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final double value;
  @override
  final String unit;
  @override
  final DateTime dateFrom;
  @override
  final DateTime dateTo;
  @override
  final String sourcePlatform;
  @override
  final String sourceId;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'HealthDataPoint(id: $id, type: $type, value: $value, unit: $unit, dateFrom: $dateFrom, dateTo: $dateTo, sourcePlatform: $sourcePlatform, sourceId: $sourceId, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthDataPointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.dateFrom, dateFrom) ||
                other.dateFrom == dateFrom) &&
            (identical(other.dateTo, dateTo) || other.dateTo == dateTo) &&
            (identical(other.sourcePlatform, sourcePlatform) ||
                other.sourcePlatform == sourcePlatform) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      value,
      unit,
      dateFrom,
      dateTo,
      sourcePlatform,
      sourceId,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of HealthDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthDataPointImplCopyWith<_$HealthDataPointImpl> get copyWith =>
      __$$HealthDataPointImplCopyWithImpl<_$HealthDataPointImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthDataPointImplToJson(
      this,
    );
  }
}

abstract class _HealthDataPoint implements HealthDataPoint {
  const factory _HealthDataPoint(
      {required final String id,
      required final String type,
      required final double value,
      required final String unit,
      required final DateTime dateFrom,
      required final DateTime dateTo,
      required final String sourcePlatform,
      required final String sourceId,
      final Map<String, dynamic>? metadata}) = _$HealthDataPointImpl;

  factory _HealthDataPoint.fromJson(Map<String, dynamic> json) =
      _$HealthDataPointImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  double get value;
  @override
  String get unit;
  @override
  DateTime get dateFrom;
  @override
  DateTime get dateTo;
  @override
  String get sourcePlatform;
  @override
  String get sourceId;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of HealthDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthDataPointImplCopyWith<_$HealthDataPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthDataSummary _$HealthDataSummaryFromJson(Map<String, dynamic> json) {
  return _HealthDataSummary.fromJson(json);
}

/// @nodoc
mixin _$HealthDataSummary {
  DateTime get date => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;
  double get activeEnergyBurned =>
      throw _privateConstructorUsedError; // in calories
  double get restingHeartRate => throw _privateConstructorUsedError;
  double get averageHeartRate => throw _privateConstructorUsedError;
  double get sleepHours => throw _privateConstructorUsedError;
  double get sleepEfficiency =>
      throw _privateConstructorUsedError; // percentage
  List<WorkoutSession> get workouts => throw _privateConstructorUsedError;
  MenstrualCycleData? get menstrualCycle => throw _privateConstructorUsedError;
  Map<String, dynamic>? get additionalMetrics =>
      throw _privateConstructorUsedError;

  /// Serializes this HealthDataSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthDataSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthDataSummaryCopyWith<HealthDataSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthDataSummaryCopyWith<$Res> {
  factory $HealthDataSummaryCopyWith(
          HealthDataSummary value, $Res Function(HealthDataSummary) then) =
      _$HealthDataSummaryCopyWithImpl<$Res, HealthDataSummary>;
  @useResult
  $Res call(
      {DateTime date,
      int steps,
      double activeEnergyBurned,
      double restingHeartRate,
      double averageHeartRate,
      double sleepHours,
      double sleepEfficiency,
      List<WorkoutSession> workouts,
      MenstrualCycleData? menstrualCycle,
      Map<String, dynamic>? additionalMetrics});

  $MenstrualCycleDataCopyWith<$Res>? get menstrualCycle;
}

/// @nodoc
class _$HealthDataSummaryCopyWithImpl<$Res, $Val extends HealthDataSummary>
    implements $HealthDataSummaryCopyWith<$Res> {
  _$HealthDataSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthDataSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? steps = null,
    Object? activeEnergyBurned = null,
    Object? restingHeartRate = null,
    Object? averageHeartRate = null,
    Object? sleepHours = null,
    Object? sleepEfficiency = null,
    Object? workouts = null,
    Object? menstrualCycle = freezed,
    Object? additionalMetrics = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      activeEnergyBurned: null == activeEnergyBurned
          ? _value.activeEnergyBurned
          : activeEnergyBurned // ignore: cast_nullable_to_non_nullable
              as double,
      restingHeartRate: null == restingHeartRate
          ? _value.restingHeartRate
          : restingHeartRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageHeartRate: null == averageHeartRate
          ? _value.averageHeartRate
          : averageHeartRate // ignore: cast_nullable_to_non_nullable
              as double,
      sleepHours: null == sleepHours
          ? _value.sleepHours
          : sleepHours // ignore: cast_nullable_to_non_nullable
              as double,
      sleepEfficiency: null == sleepEfficiency
          ? _value.sleepEfficiency
          : sleepEfficiency // ignore: cast_nullable_to_non_nullable
              as double,
      workouts: null == workouts
          ? _value.workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      menstrualCycle: freezed == menstrualCycle
          ? _value.menstrualCycle
          : menstrualCycle // ignore: cast_nullable_to_non_nullable
              as MenstrualCycleData?,
      additionalMetrics: freezed == additionalMetrics
          ? _value.additionalMetrics
          : additionalMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of HealthDataSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MenstrualCycleDataCopyWith<$Res>? get menstrualCycle {
    if (_value.menstrualCycle == null) {
      return null;
    }

    return $MenstrualCycleDataCopyWith<$Res>(_value.menstrualCycle!, (value) {
      return _then(_value.copyWith(menstrualCycle: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HealthDataSummaryImplCopyWith<$Res>
    implements $HealthDataSummaryCopyWith<$Res> {
  factory _$$HealthDataSummaryImplCopyWith(_$HealthDataSummaryImpl value,
          $Res Function(_$HealthDataSummaryImpl) then) =
      __$$HealthDataSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      int steps,
      double activeEnergyBurned,
      double restingHeartRate,
      double averageHeartRate,
      double sleepHours,
      double sleepEfficiency,
      List<WorkoutSession> workouts,
      MenstrualCycleData? menstrualCycle,
      Map<String, dynamic>? additionalMetrics});

  @override
  $MenstrualCycleDataCopyWith<$Res>? get menstrualCycle;
}

/// @nodoc
class __$$HealthDataSummaryImplCopyWithImpl<$Res>
    extends _$HealthDataSummaryCopyWithImpl<$Res, _$HealthDataSummaryImpl>
    implements _$$HealthDataSummaryImplCopyWith<$Res> {
  __$$HealthDataSummaryImplCopyWithImpl(_$HealthDataSummaryImpl _value,
      $Res Function(_$HealthDataSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthDataSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? steps = null,
    Object? activeEnergyBurned = null,
    Object? restingHeartRate = null,
    Object? averageHeartRate = null,
    Object? sleepHours = null,
    Object? sleepEfficiency = null,
    Object? workouts = null,
    Object? menstrualCycle = freezed,
    Object? additionalMetrics = freezed,
  }) {
    return _then(_$HealthDataSummaryImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      activeEnergyBurned: null == activeEnergyBurned
          ? _value.activeEnergyBurned
          : activeEnergyBurned // ignore: cast_nullable_to_non_nullable
              as double,
      restingHeartRate: null == restingHeartRate
          ? _value.restingHeartRate
          : restingHeartRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageHeartRate: null == averageHeartRate
          ? _value.averageHeartRate
          : averageHeartRate // ignore: cast_nullable_to_non_nullable
              as double,
      sleepHours: null == sleepHours
          ? _value.sleepHours
          : sleepHours // ignore: cast_nullable_to_non_nullable
              as double,
      sleepEfficiency: null == sleepEfficiency
          ? _value.sleepEfficiency
          : sleepEfficiency // ignore: cast_nullable_to_non_nullable
              as double,
      workouts: null == workouts
          ? _value._workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      menstrualCycle: freezed == menstrualCycle
          ? _value.menstrualCycle
          : menstrualCycle // ignore: cast_nullable_to_non_nullable
              as MenstrualCycleData?,
      additionalMetrics: freezed == additionalMetrics
          ? _value._additionalMetrics
          : additionalMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthDataSummaryImpl implements _HealthDataSummary {
  const _$HealthDataSummaryImpl(
      {required this.date,
      required this.steps,
      required this.activeEnergyBurned,
      required this.restingHeartRate,
      required this.averageHeartRate,
      required this.sleepHours,
      required this.sleepEfficiency,
      required final List<WorkoutSession> workouts,
      this.menstrualCycle,
      final Map<String, dynamic>? additionalMetrics})
      : _workouts = workouts,
        _additionalMetrics = additionalMetrics;

  factory _$HealthDataSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthDataSummaryImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int steps;
  @override
  final double activeEnergyBurned;
// in calories
  @override
  final double restingHeartRate;
  @override
  final double averageHeartRate;
  @override
  final double sleepHours;
  @override
  final double sleepEfficiency;
// percentage
  final List<WorkoutSession> _workouts;
// percentage
  @override
  List<WorkoutSession> get workouts {
    if (_workouts is EqualUnmodifiableListView) return _workouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workouts);
  }

  @override
  final MenstrualCycleData? menstrualCycle;
  final Map<String, dynamic>? _additionalMetrics;
  @override
  Map<String, dynamic>? get additionalMetrics {
    final value = _additionalMetrics;
    if (value == null) return null;
    if (_additionalMetrics is EqualUnmodifiableMapView)
      return _additionalMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'HealthDataSummary(date: $date, steps: $steps, activeEnergyBurned: $activeEnergyBurned, restingHeartRate: $restingHeartRate, averageHeartRate: $averageHeartRate, sleepHours: $sleepHours, sleepEfficiency: $sleepEfficiency, workouts: $workouts, menstrualCycle: $menstrualCycle, additionalMetrics: $additionalMetrics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthDataSummaryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.activeEnergyBurned, activeEnergyBurned) ||
                other.activeEnergyBurned == activeEnergyBurned) &&
            (identical(other.restingHeartRate, restingHeartRate) ||
                other.restingHeartRate == restingHeartRate) &&
            (identical(other.averageHeartRate, averageHeartRate) ||
                other.averageHeartRate == averageHeartRate) &&
            (identical(other.sleepHours, sleepHours) ||
                other.sleepHours == sleepHours) &&
            (identical(other.sleepEfficiency, sleepEfficiency) ||
                other.sleepEfficiency == sleepEfficiency) &&
            const DeepCollectionEquality().equals(other._workouts, _workouts) &&
            (identical(other.menstrualCycle, menstrualCycle) ||
                other.menstrualCycle == menstrualCycle) &&
            const DeepCollectionEquality()
                .equals(other._additionalMetrics, _additionalMetrics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      steps,
      activeEnergyBurned,
      restingHeartRate,
      averageHeartRate,
      sleepHours,
      sleepEfficiency,
      const DeepCollectionEquality().hash(_workouts),
      menstrualCycle,
      const DeepCollectionEquality().hash(_additionalMetrics));

  /// Create a copy of HealthDataSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthDataSummaryImplCopyWith<_$HealthDataSummaryImpl> get copyWith =>
      __$$HealthDataSummaryImplCopyWithImpl<_$HealthDataSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthDataSummaryImplToJson(
      this,
    );
  }
}

abstract class _HealthDataSummary implements HealthDataSummary {
  const factory _HealthDataSummary(
      {required final DateTime date,
      required final int steps,
      required final double activeEnergyBurned,
      required final double restingHeartRate,
      required final double averageHeartRate,
      required final double sleepHours,
      required final double sleepEfficiency,
      required final List<WorkoutSession> workouts,
      final MenstrualCycleData? menstrualCycle,
      final Map<String, dynamic>? additionalMetrics}) = _$HealthDataSummaryImpl;

  factory _HealthDataSummary.fromJson(Map<String, dynamic> json) =
      _$HealthDataSummaryImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get steps;
  @override
  double get activeEnergyBurned; // in calories
  @override
  double get restingHeartRate;
  @override
  double get averageHeartRate;
  @override
  double get sleepHours;
  @override
  double get sleepEfficiency; // percentage
  @override
  List<WorkoutSession> get workouts;
  @override
  MenstrualCycleData? get menstrualCycle;
  @override
  Map<String, dynamic>? get additionalMetrics;

  /// Create a copy of HealthDataSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthDataSummaryImplCopyWith<_$HealthDataSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkoutSession _$WorkoutSessionFromJson(Map<String, dynamic> json) {
  return _WorkoutSession.fromJson(json);
}

/// @nodoc
mixin _$WorkoutSession {
  String get id => throw _privateConstructorUsedError;
  WorkoutType get type => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError; // in minutes
  double get caloriesBurned => throw _privateConstructorUsedError;
  double? get averageHeartRate => throw _privateConstructorUsedError;
  double? get maxHeartRate => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError; // in meters
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this WorkoutSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSessionCopyWith<WorkoutSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSessionCopyWith<$Res> {
  factory $WorkoutSessionCopyWith(
          WorkoutSession value, $Res Function(WorkoutSession) then) =
      _$WorkoutSessionCopyWithImpl<$Res, WorkoutSession>;
  @useResult
  $Res call(
      {String id,
      WorkoutType type,
      DateTime startTime,
      DateTime endTime,
      double duration,
      double caloriesBurned,
      double? averageHeartRate,
      double? maxHeartRate,
      double? distance,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$WorkoutSessionCopyWithImpl<$Res, $Val extends WorkoutSession>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? duration = null,
    Object? caloriesBurned = null,
    Object? averageHeartRate = freezed,
    Object? maxHeartRate = freezed,
    Object? distance = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      caloriesBurned: null == caloriesBurned
          ? _value.caloriesBurned
          : caloriesBurned // ignore: cast_nullable_to_non_nullable
              as double,
      averageHeartRate: freezed == averageHeartRate
          ? _value.averageHeartRate
          : averageHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      maxHeartRate: freezed == maxHeartRate
          ? _value.maxHeartRate
          : maxHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutSessionImplCopyWith<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  factory _$$WorkoutSessionImplCopyWith(_$WorkoutSessionImpl value,
          $Res Function(_$WorkoutSessionImpl) then) =
      __$$WorkoutSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      WorkoutType type,
      DateTime startTime,
      DateTime endTime,
      double duration,
      double caloriesBurned,
      double? averageHeartRate,
      double? maxHeartRate,
      double? distance,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$WorkoutSessionImplCopyWithImpl<$Res>
    extends _$WorkoutSessionCopyWithImpl<$Res, _$WorkoutSessionImpl>
    implements _$$WorkoutSessionImplCopyWith<$Res> {
  __$$WorkoutSessionImplCopyWithImpl(
      _$WorkoutSessionImpl _value, $Res Function(_$WorkoutSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? duration = null,
    Object? caloriesBurned = null,
    Object? averageHeartRate = freezed,
    Object? maxHeartRate = freezed,
    Object? distance = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$WorkoutSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      caloriesBurned: null == caloriesBurned
          ? _value.caloriesBurned
          : caloriesBurned // ignore: cast_nullable_to_non_nullable
              as double,
      averageHeartRate: freezed == averageHeartRate
          ? _value.averageHeartRate
          : averageHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      maxHeartRate: freezed == maxHeartRate
          ? _value.maxHeartRate
          : maxHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutSessionImpl implements _WorkoutSession {
  const _$WorkoutSessionImpl(
      {required this.id,
      required this.type,
      required this.startTime,
      required this.endTime,
      required this.duration,
      required this.caloriesBurned,
      this.averageHeartRate,
      this.maxHeartRate,
      this.distance,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$WorkoutSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutSessionImplFromJson(json);

  @override
  final String id;
  @override
  final WorkoutType type;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final double duration;
// in minutes
  @override
  final double caloriesBurned;
  @override
  final double? averageHeartRate;
  @override
  final double? maxHeartRate;
  @override
  final double? distance;
// in meters
  final Map<String, dynamic>? _metadata;
// in meters
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'WorkoutSession(id: $id, type: $type, startTime: $startTime, endTime: $endTime, duration: $duration, caloriesBurned: $caloriesBurned, averageHeartRate: $averageHeartRate, maxHeartRate: $maxHeartRate, distance: $distance, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.caloriesBurned, caloriesBurned) ||
                other.caloriesBurned == caloriesBurned) &&
            (identical(other.averageHeartRate, averageHeartRate) ||
                other.averageHeartRate == averageHeartRate) &&
            (identical(other.maxHeartRate, maxHeartRate) ||
                other.maxHeartRate == maxHeartRate) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      startTime,
      endTime,
      duration,
      caloriesBurned,
      averageHeartRate,
      maxHeartRate,
      distance,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      __$$WorkoutSessionImplCopyWithImpl<_$WorkoutSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutSessionImplToJson(
      this,
    );
  }
}

abstract class _WorkoutSession implements WorkoutSession {
  const factory _WorkoutSession(
      {required final String id,
      required final WorkoutType type,
      required final DateTime startTime,
      required final DateTime endTime,
      required final double duration,
      required final double caloriesBurned,
      final double? averageHeartRate,
      final double? maxHeartRate,
      final double? distance,
      final Map<String, dynamic>? metadata}) = _$WorkoutSessionImpl;

  factory _WorkoutSession.fromJson(Map<String, dynamic> json) =
      _$WorkoutSessionImpl.fromJson;

  @override
  String get id;
  @override
  WorkoutType get type;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  double get duration; // in minutes
  @override
  double get caloriesBurned;
  @override
  double? get averageHeartRate;
  @override
  double? get maxHeartRate;
  @override
  double? get distance; // in meters
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MenstrualCycleData _$MenstrualCycleDataFromJson(Map<String, dynamic> json) {
  return _MenstrualCycleData.fromJson(json);
}

/// @nodoc
mixin _$MenstrualCycleData {
  DateTime get date => throw _privateConstructorUsedError;
  MenstrualFlow get flow => throw _privateConstructorUsedError;
  List<MenstrualSymptom>? get symptoms => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this MenstrualCycleData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenstrualCycleData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenstrualCycleDataCopyWith<MenstrualCycleData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenstrualCycleDataCopyWith<$Res> {
  factory $MenstrualCycleDataCopyWith(
          MenstrualCycleData value, $Res Function(MenstrualCycleData) then) =
      _$MenstrualCycleDataCopyWithImpl<$Res, MenstrualCycleData>;
  @useResult
  $Res call(
      {DateTime date,
      MenstrualFlow flow,
      List<MenstrualSymptom>? symptoms,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$MenstrualCycleDataCopyWithImpl<$Res, $Val extends MenstrualCycleData>
    implements $MenstrualCycleDataCopyWith<$Res> {
  _$MenstrualCycleDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenstrualCycleData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? flow = null,
    Object? symptoms = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      flow: null == flow
          ? _value.flow
          : flow // ignore: cast_nullable_to_non_nullable
              as MenstrualFlow,
      symptoms: freezed == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<MenstrualSymptom>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenstrualCycleDataImplCopyWith<$Res>
    implements $MenstrualCycleDataCopyWith<$Res> {
  factory _$$MenstrualCycleDataImplCopyWith(_$MenstrualCycleDataImpl value,
          $Res Function(_$MenstrualCycleDataImpl) then) =
      __$$MenstrualCycleDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      MenstrualFlow flow,
      List<MenstrualSymptom>? symptoms,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$MenstrualCycleDataImplCopyWithImpl<$Res>
    extends _$MenstrualCycleDataCopyWithImpl<$Res, _$MenstrualCycleDataImpl>
    implements _$$MenstrualCycleDataImplCopyWith<$Res> {
  __$$MenstrualCycleDataImplCopyWithImpl(_$MenstrualCycleDataImpl _value,
      $Res Function(_$MenstrualCycleDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MenstrualCycleData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? flow = null,
    Object? symptoms = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$MenstrualCycleDataImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      flow: null == flow
          ? _value.flow
          : flow // ignore: cast_nullable_to_non_nullable
              as MenstrualFlow,
      symptoms: freezed == symptoms
          ? _value._symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<MenstrualSymptom>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenstrualCycleDataImpl implements _MenstrualCycleData {
  const _$MenstrualCycleDataImpl(
      {required this.date,
      required this.flow,
      final List<MenstrualSymptom>? symptoms,
      final Map<String, dynamic>? metadata})
      : _symptoms = symptoms,
        _metadata = metadata;

  factory _$MenstrualCycleDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenstrualCycleDataImplFromJson(json);

  @override
  final DateTime date;
  @override
  final MenstrualFlow flow;
  final List<MenstrualSymptom>? _symptoms;
  @override
  List<MenstrualSymptom>? get symptoms {
    final value = _symptoms;
    if (value == null) return null;
    if (_symptoms is EqualUnmodifiableListView) return _symptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MenstrualCycleData(date: $date, flow: $flow, symptoms: $symptoms, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenstrualCycleDataImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.flow, flow) || other.flow == flow) &&
            const DeepCollectionEquality().equals(other._symptoms, _symptoms) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      flow,
      const DeepCollectionEquality().hash(_symptoms),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of MenstrualCycleData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenstrualCycleDataImplCopyWith<_$MenstrualCycleDataImpl> get copyWith =>
      __$$MenstrualCycleDataImplCopyWithImpl<_$MenstrualCycleDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenstrualCycleDataImplToJson(
      this,
    );
  }
}

abstract class _MenstrualCycleData implements MenstrualCycleData {
  const factory _MenstrualCycleData(
      {required final DateTime date,
      required final MenstrualFlow flow,
      final List<MenstrualSymptom>? symptoms,
      final Map<String, dynamic>? metadata}) = _$MenstrualCycleDataImpl;

  factory _MenstrualCycleData.fromJson(Map<String, dynamic> json) =
      _$MenstrualCycleDataImpl.fromJson;

  @override
  DateTime get date;
  @override
  MenstrualFlow get flow;
  @override
  List<MenstrualSymptom>? get symptoms;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of MenstrualCycleData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenstrualCycleDataImplCopyWith<_$MenstrualCycleDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
