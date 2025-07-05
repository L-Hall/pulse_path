// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_health_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyHealthMetrics _$DailyHealthMetricsFromJson(Map<String, dynamic> json) {
  return _DailyHealthMetrics.fromJson(json);
}

/// @nodoc
mixin _$DailyHealthMetrics {
  String get id => throw _privateConstructorUsedError;
  DateTime get date =>
      throw _privateConstructorUsedError; // Step and movement data
  int get stepCount => throw _privateConstructorUsedError;
  double get distanceKm => throw _privateConstructorUsedError;
  int get activeMinutes => throw _privateConstructorUsedError;
  int get flightsClimbed => throw _privateConstructorUsedError; // Sleep data
  SleepData? get sleepData =>
      throw _privateConstructorUsedError; // Workout sessions
  List<WorkoutSession> get workouts =>
      throw _privateConstructorUsedError; // Menstrual cycle data (optional)
  MenstrualCycleData? get menstrualData =>
      throw _privateConstructorUsedError; // Energy and symptoms (user-reported)
  int? get energyLevel => throw _privateConstructorUsedError; // 1-10 scale
  int? get stressLevel => throw _privateConstructorUsedError; // 1-10 scale
  List<String> get symptoms => throw _privateConstructorUsedError;
  String get notes =>
      throw _privateConstructorUsedError; // Data quality indicators
  bool get isComplete => throw _privateConstructorUsedError;
  List<String> get dataSources =>
      throw _privateConstructorUsedError; // 'health_kit', 'google_fit', 'manual'
// Metadata
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;

  /// Serializes this DailyHealthMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyHealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyHealthMetricsCopyWith<DailyHealthMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyHealthMetricsCopyWith<$Res> {
  factory $DailyHealthMetricsCopyWith(
          DailyHealthMetrics value, $Res Function(DailyHealthMetrics) then) =
      _$DailyHealthMetricsCopyWithImpl<$Res, DailyHealthMetrics>;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      int stepCount,
      double distanceKm,
      int activeMinutes,
      int flightsClimbed,
      SleepData? sleepData,
      List<WorkoutSession> workouts,
      MenstrualCycleData? menstrualData,
      int? energyLevel,
      int? stressLevel,
      List<String> symptoms,
      String notes,
      bool isComplete,
      List<String> dataSources,
      DateTime createdAt,
      DateTime updatedAt,
      bool isSynced});

  $SleepDataCopyWith<$Res>? get sleepData;
  $MenstrualCycleDataCopyWith<$Res>? get menstrualData;
}

/// @nodoc
class _$DailyHealthMetricsCopyWithImpl<$Res, $Val extends DailyHealthMetrics>
    implements $DailyHealthMetricsCopyWith<$Res> {
  _$DailyHealthMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyHealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? stepCount = null,
    Object? distanceKm = null,
    Object? activeMinutes = null,
    Object? flightsClimbed = null,
    Object? sleepData = freezed,
    Object? workouts = null,
    Object? menstrualData = freezed,
    Object? energyLevel = freezed,
    Object? stressLevel = freezed,
    Object? symptoms = null,
    Object? notes = null,
    Object? isComplete = null,
    Object? dataSources = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      stepCount: null == stepCount
          ? _value.stepCount
          : stepCount // ignore: cast_nullable_to_non_nullable
              as int,
      distanceKm: null == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double,
      activeMinutes: null == activeMinutes
          ? _value.activeMinutes
          : activeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      flightsClimbed: null == flightsClimbed
          ? _value.flightsClimbed
          : flightsClimbed // ignore: cast_nullable_to_non_nullable
              as int,
      sleepData: freezed == sleepData
          ? _value.sleepData
          : sleepData // ignore: cast_nullable_to_non_nullable
              as SleepData?,
      workouts: null == workouts
          ? _value.workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      menstrualData: freezed == menstrualData
          ? _value.menstrualData
          : menstrualData // ignore: cast_nullable_to_non_nullable
              as MenstrualCycleData?,
      energyLevel: freezed == energyLevel
          ? _value.energyLevel
          : energyLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      stressLevel: freezed == stressLevel
          ? _value.stressLevel
          : stressLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      symptoms: null == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      dataSources: null == dataSources
          ? _value.dataSources
          : dataSources // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of DailyHealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SleepDataCopyWith<$Res>? get sleepData {
    if (_value.sleepData == null) {
      return null;
    }

    return $SleepDataCopyWith<$Res>(_value.sleepData!, (value) {
      return _then(_value.copyWith(sleepData: value) as $Val);
    });
  }

  /// Create a copy of DailyHealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MenstrualCycleDataCopyWith<$Res>? get menstrualData {
    if (_value.menstrualData == null) {
      return null;
    }

    return $MenstrualCycleDataCopyWith<$Res>(_value.menstrualData!, (value) {
      return _then(_value.copyWith(menstrualData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailyHealthMetricsImplCopyWith<$Res>
    implements $DailyHealthMetricsCopyWith<$Res> {
  factory _$$DailyHealthMetricsImplCopyWith(_$DailyHealthMetricsImpl value,
          $Res Function(_$DailyHealthMetricsImpl) then) =
      __$$DailyHealthMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      int stepCount,
      double distanceKm,
      int activeMinutes,
      int flightsClimbed,
      SleepData? sleepData,
      List<WorkoutSession> workouts,
      MenstrualCycleData? menstrualData,
      int? energyLevel,
      int? stressLevel,
      List<String> symptoms,
      String notes,
      bool isComplete,
      List<String> dataSources,
      DateTime createdAt,
      DateTime updatedAt,
      bool isSynced});

  @override
  $SleepDataCopyWith<$Res>? get sleepData;
  @override
  $MenstrualCycleDataCopyWith<$Res>? get menstrualData;
}

/// @nodoc
class __$$DailyHealthMetricsImplCopyWithImpl<$Res>
    extends _$DailyHealthMetricsCopyWithImpl<$Res, _$DailyHealthMetricsImpl>
    implements _$$DailyHealthMetricsImplCopyWith<$Res> {
  __$$DailyHealthMetricsImplCopyWithImpl(_$DailyHealthMetricsImpl _value,
      $Res Function(_$DailyHealthMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyHealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? stepCount = null,
    Object? distanceKm = null,
    Object? activeMinutes = null,
    Object? flightsClimbed = null,
    Object? sleepData = freezed,
    Object? workouts = null,
    Object? menstrualData = freezed,
    Object? energyLevel = freezed,
    Object? stressLevel = freezed,
    Object? symptoms = null,
    Object? notes = null,
    Object? isComplete = null,
    Object? dataSources = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isSynced = null,
  }) {
    return _then(_$DailyHealthMetricsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stepCount: null == stepCount
          ? _value.stepCount
          : stepCount // ignore: cast_nullable_to_non_nullable
              as int,
      distanceKm: null == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double,
      activeMinutes: null == activeMinutes
          ? _value.activeMinutes
          : activeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      flightsClimbed: null == flightsClimbed
          ? _value.flightsClimbed
          : flightsClimbed // ignore: cast_nullable_to_non_nullable
              as int,
      sleepData: freezed == sleepData
          ? _value.sleepData
          : sleepData // ignore: cast_nullable_to_non_nullable
              as SleepData?,
      workouts: null == workouts
          ? _value._workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      menstrualData: freezed == menstrualData
          ? _value.menstrualData
          : menstrualData // ignore: cast_nullable_to_non_nullable
              as MenstrualCycleData?,
      energyLevel: freezed == energyLevel
          ? _value.energyLevel
          : energyLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      stressLevel: freezed == stressLevel
          ? _value.stressLevel
          : stressLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      symptoms: null == symptoms
          ? _value._symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      dataSources: null == dataSources
          ? _value._dataSources
          : dataSources // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
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
class _$DailyHealthMetricsImpl implements _DailyHealthMetrics {
  const _$DailyHealthMetricsImpl(
      {required this.id,
      required this.date,
      this.stepCount = 0,
      this.distanceKm = 0.0,
      this.activeMinutes = 0,
      this.flightsClimbed = 0,
      this.sleepData = null,
      final List<WorkoutSession> workouts = const [],
      this.menstrualData = null,
      this.energyLevel = null,
      this.stressLevel = null,
      final List<String> symptoms = const [],
      this.notes = '',
      this.isComplete = true,
      final List<String> dataSources = const [],
      required this.createdAt,
      required this.updatedAt,
      this.isSynced = false})
      : _workouts = workouts,
        _symptoms = symptoms,
        _dataSources = dataSources;

  factory _$DailyHealthMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyHealthMetricsImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
// Step and movement data
  @override
  @JsonKey()
  final int stepCount;
  @override
  @JsonKey()
  final double distanceKm;
  @override
  @JsonKey()
  final int activeMinutes;
  @override
  @JsonKey()
  final int flightsClimbed;
// Sleep data
  @override
  @JsonKey()
  final SleepData? sleepData;
// Workout sessions
  final List<WorkoutSession> _workouts;
// Workout sessions
  @override
  @JsonKey()
  List<WorkoutSession> get workouts {
    if (_workouts is EqualUnmodifiableListView) return _workouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workouts);
  }

// Menstrual cycle data (optional)
  @override
  @JsonKey()
  final MenstrualCycleData? menstrualData;
// Energy and symptoms (user-reported)
  @override
  @JsonKey()
  final int? energyLevel;
// 1-10 scale
  @override
  @JsonKey()
  final int? stressLevel;
// 1-10 scale
  final List<String> _symptoms;
// 1-10 scale
  @override
  @JsonKey()
  List<String> get symptoms {
    if (_symptoms is EqualUnmodifiableListView) return _symptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symptoms);
  }

  @override
  @JsonKey()
  final String notes;
// Data quality indicators
  @override
  @JsonKey()
  final bool isComplete;
  final List<String> _dataSources;
  @override
  @JsonKey()
  List<String> get dataSources {
    if (_dataSources is EqualUnmodifiableListView) return _dataSources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataSources);
  }

// 'health_kit', 'google_fit', 'manual'
// Metadata
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool isSynced;

  @override
  String toString() {
    return 'DailyHealthMetrics(id: $id, date: $date, stepCount: $stepCount, distanceKm: $distanceKm, activeMinutes: $activeMinutes, flightsClimbed: $flightsClimbed, sleepData: $sleepData, workouts: $workouts, menstrualData: $menstrualData, energyLevel: $energyLevel, stressLevel: $stressLevel, symptoms: $symptoms, notes: $notes, isComplete: $isComplete, dataSources: $dataSources, createdAt: $createdAt, updatedAt: $updatedAt, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyHealthMetricsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.stepCount, stepCount) ||
                other.stepCount == stepCount) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.activeMinutes, activeMinutes) ||
                other.activeMinutes == activeMinutes) &&
            (identical(other.flightsClimbed, flightsClimbed) ||
                other.flightsClimbed == flightsClimbed) &&
            (identical(other.sleepData, sleepData) ||
                other.sleepData == sleepData) &&
            const DeepCollectionEquality().equals(other._workouts, _workouts) &&
            (identical(other.menstrualData, menstrualData) ||
                other.menstrualData == menstrualData) &&
            (identical(other.energyLevel, energyLevel) ||
                other.energyLevel == energyLevel) &&
            (identical(other.stressLevel, stressLevel) ||
                other.stressLevel == stressLevel) &&
            const DeepCollectionEquality().equals(other._symptoms, _symptoms) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete) &&
            const DeepCollectionEquality()
                .equals(other._dataSources, _dataSources) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      stepCount,
      distanceKm,
      activeMinutes,
      flightsClimbed,
      sleepData,
      const DeepCollectionEquality().hash(_workouts),
      menstrualData,
      energyLevel,
      stressLevel,
      const DeepCollectionEquality().hash(_symptoms),
      notes,
      isComplete,
      const DeepCollectionEquality().hash(_dataSources),
      createdAt,
      updatedAt,
      isSynced);

  /// Create a copy of DailyHealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyHealthMetricsImplCopyWith<_$DailyHealthMetricsImpl> get copyWith =>
      __$$DailyHealthMetricsImplCopyWithImpl<_$DailyHealthMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyHealthMetricsImplToJson(
      this,
    );
  }
}

abstract class _DailyHealthMetrics implements DailyHealthMetrics {
  const factory _DailyHealthMetrics(
      {required final String id,
      required final DateTime date,
      final int stepCount,
      final double distanceKm,
      final int activeMinutes,
      final int flightsClimbed,
      final SleepData? sleepData,
      final List<WorkoutSession> workouts,
      final MenstrualCycleData? menstrualData,
      final int? energyLevel,
      final int? stressLevel,
      final List<String> symptoms,
      final String notes,
      final bool isComplete,
      final List<String> dataSources,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final bool isSynced}) = _$DailyHealthMetricsImpl;

  factory _DailyHealthMetrics.fromJson(Map<String, dynamic> json) =
      _$DailyHealthMetricsImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date; // Step and movement data
  @override
  int get stepCount;
  @override
  double get distanceKm;
  @override
  int get activeMinutes;
  @override
  int get flightsClimbed; // Sleep data
  @override
  SleepData? get sleepData; // Workout sessions
  @override
  List<WorkoutSession> get workouts; // Menstrual cycle data (optional)
  @override
  MenstrualCycleData? get menstrualData; // Energy and symptoms (user-reported)
  @override
  int? get energyLevel; // 1-10 scale
  @override
  int? get stressLevel; // 1-10 scale
  @override
  List<String> get symptoms;
  @override
  String get notes; // Data quality indicators
  @override
  bool get isComplete;
  @override
  List<String> get dataSources; // 'health_kit', 'google_fit', 'manual'
// Metadata
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  bool get isSynced;

  /// Create a copy of DailyHealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyHealthMetricsImplCopyWith<_$DailyHealthMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SleepData _$SleepDataFromJson(Map<String, dynamic> json) {
  return _SleepData.fromJson(json);
}

/// @nodoc
mixin _$SleepData {
  DateTime get bedTime => throw _privateConstructorUsedError;
  DateTime get wakeTime => throw _privateConstructorUsedError;
  Duration get totalSleepTime => throw _privateConstructorUsedError;
  Duration? get deepSleepTime => throw _privateConstructorUsedError;
  Duration? get remSleepTime => throw _privateConstructorUsedError;
  Duration? get lightSleepTime => throw _privateConstructorUsedError;
  int? get sleepQuality =>
      throw _privateConstructorUsedError; // 1-10 scale if available
  int get awakenings => throw _privateConstructorUsedError;
  Duration? get timeToFallAsleep => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;

  /// Serializes this SleepData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SleepData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SleepDataCopyWith<SleepData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepDataCopyWith<$Res> {
  factory $SleepDataCopyWith(SleepData value, $Res Function(SleepData) then) =
      _$SleepDataCopyWithImpl<$Res, SleepData>;
  @useResult
  $Res call(
      {DateTime bedTime,
      DateTime wakeTime,
      Duration totalSleepTime,
      Duration? deepSleepTime,
      Duration? remSleepTime,
      Duration? lightSleepTime,
      int? sleepQuality,
      int awakenings,
      Duration? timeToFallAsleep,
      String source});
}

/// @nodoc
class _$SleepDataCopyWithImpl<$Res, $Val extends SleepData>
    implements $SleepDataCopyWith<$Res> {
  _$SleepDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SleepData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bedTime = null,
    Object? wakeTime = null,
    Object? totalSleepTime = null,
    Object? deepSleepTime = freezed,
    Object? remSleepTime = freezed,
    Object? lightSleepTime = freezed,
    Object? sleepQuality = freezed,
    Object? awakenings = null,
    Object? timeToFallAsleep = freezed,
    Object? source = null,
  }) {
    return _then(_value.copyWith(
      bedTime: null == bedTime
          ? _value.bedTime
          : bedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      wakeTime: null == wakeTime
          ? _value.wakeTime
          : wakeTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSleepTime: null == totalSleepTime
          ? _value.totalSleepTime
          : totalSleepTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      deepSleepTime: freezed == deepSleepTime
          ? _value.deepSleepTime
          : deepSleepTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      remSleepTime: freezed == remSleepTime
          ? _value.remSleepTime
          : remSleepTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      lightSleepTime: freezed == lightSleepTime
          ? _value.lightSleepTime
          : lightSleepTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      sleepQuality: freezed == sleepQuality
          ? _value.sleepQuality
          : sleepQuality // ignore: cast_nullable_to_non_nullable
              as int?,
      awakenings: null == awakenings
          ? _value.awakenings
          : awakenings // ignore: cast_nullable_to_non_nullable
              as int,
      timeToFallAsleep: freezed == timeToFallAsleep
          ? _value.timeToFallAsleep
          : timeToFallAsleep // ignore: cast_nullable_to_non_nullable
              as Duration?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SleepDataImplCopyWith<$Res>
    implements $SleepDataCopyWith<$Res> {
  factory _$$SleepDataImplCopyWith(
          _$SleepDataImpl value, $Res Function(_$SleepDataImpl) then) =
      __$$SleepDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime bedTime,
      DateTime wakeTime,
      Duration totalSleepTime,
      Duration? deepSleepTime,
      Duration? remSleepTime,
      Duration? lightSleepTime,
      int? sleepQuality,
      int awakenings,
      Duration? timeToFallAsleep,
      String source});
}

/// @nodoc
class __$$SleepDataImplCopyWithImpl<$Res>
    extends _$SleepDataCopyWithImpl<$Res, _$SleepDataImpl>
    implements _$$SleepDataImplCopyWith<$Res> {
  __$$SleepDataImplCopyWithImpl(
      _$SleepDataImpl _value, $Res Function(_$SleepDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SleepData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bedTime = null,
    Object? wakeTime = null,
    Object? totalSleepTime = null,
    Object? deepSleepTime = freezed,
    Object? remSleepTime = freezed,
    Object? lightSleepTime = freezed,
    Object? sleepQuality = freezed,
    Object? awakenings = null,
    Object? timeToFallAsleep = freezed,
    Object? source = null,
  }) {
    return _then(_$SleepDataImpl(
      bedTime: null == bedTime
          ? _value.bedTime
          : bedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      wakeTime: null == wakeTime
          ? _value.wakeTime
          : wakeTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSleepTime: null == totalSleepTime
          ? _value.totalSleepTime
          : totalSleepTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      deepSleepTime: freezed == deepSleepTime
          ? _value.deepSleepTime
          : deepSleepTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      remSleepTime: freezed == remSleepTime
          ? _value.remSleepTime
          : remSleepTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      lightSleepTime: freezed == lightSleepTime
          ? _value.lightSleepTime
          : lightSleepTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      sleepQuality: freezed == sleepQuality
          ? _value.sleepQuality
          : sleepQuality // ignore: cast_nullable_to_non_nullable
              as int?,
      awakenings: null == awakenings
          ? _value.awakenings
          : awakenings // ignore: cast_nullable_to_non_nullable
              as int,
      timeToFallAsleep: freezed == timeToFallAsleep
          ? _value.timeToFallAsleep
          : timeToFallAsleep // ignore: cast_nullable_to_non_nullable
              as Duration?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SleepDataImpl implements _SleepData {
  const _$SleepDataImpl(
      {required this.bedTime,
      required this.wakeTime,
      required this.totalSleepTime,
      this.deepSleepTime = null,
      this.remSleepTime = null,
      this.lightSleepTime = null,
      this.sleepQuality = null,
      this.awakenings = 0,
      this.timeToFallAsleep = null,
      this.source = 'unknown'});

  factory _$SleepDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepDataImplFromJson(json);

  @override
  final DateTime bedTime;
  @override
  final DateTime wakeTime;
  @override
  final Duration totalSleepTime;
  @override
  @JsonKey()
  final Duration? deepSleepTime;
  @override
  @JsonKey()
  final Duration? remSleepTime;
  @override
  @JsonKey()
  final Duration? lightSleepTime;
  @override
  @JsonKey()
  final int? sleepQuality;
// 1-10 scale if available
  @override
  @JsonKey()
  final int awakenings;
  @override
  @JsonKey()
  final Duration? timeToFallAsleep;
  @override
  @JsonKey()
  final String source;

  @override
  String toString() {
    return 'SleepData(bedTime: $bedTime, wakeTime: $wakeTime, totalSleepTime: $totalSleepTime, deepSleepTime: $deepSleepTime, remSleepTime: $remSleepTime, lightSleepTime: $lightSleepTime, sleepQuality: $sleepQuality, awakenings: $awakenings, timeToFallAsleep: $timeToFallAsleep, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepDataImpl &&
            (identical(other.bedTime, bedTime) || other.bedTime == bedTime) &&
            (identical(other.wakeTime, wakeTime) ||
                other.wakeTime == wakeTime) &&
            (identical(other.totalSleepTime, totalSleepTime) ||
                other.totalSleepTime == totalSleepTime) &&
            (identical(other.deepSleepTime, deepSleepTime) ||
                other.deepSleepTime == deepSleepTime) &&
            (identical(other.remSleepTime, remSleepTime) ||
                other.remSleepTime == remSleepTime) &&
            (identical(other.lightSleepTime, lightSleepTime) ||
                other.lightSleepTime == lightSleepTime) &&
            (identical(other.sleepQuality, sleepQuality) ||
                other.sleepQuality == sleepQuality) &&
            (identical(other.awakenings, awakenings) ||
                other.awakenings == awakenings) &&
            (identical(other.timeToFallAsleep, timeToFallAsleep) ||
                other.timeToFallAsleep == timeToFallAsleep) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bedTime,
      wakeTime,
      totalSleepTime,
      deepSleepTime,
      remSleepTime,
      lightSleepTime,
      sleepQuality,
      awakenings,
      timeToFallAsleep,
      source);

  /// Create a copy of SleepData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepDataImplCopyWith<_$SleepDataImpl> get copyWith =>
      __$$SleepDataImplCopyWithImpl<_$SleepDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SleepDataImplToJson(
      this,
    );
  }
}

abstract class _SleepData implements SleepData {
  const factory _SleepData(
      {required final DateTime bedTime,
      required final DateTime wakeTime,
      required final Duration totalSleepTime,
      final Duration? deepSleepTime,
      final Duration? remSleepTime,
      final Duration? lightSleepTime,
      final int? sleepQuality,
      final int awakenings,
      final Duration? timeToFallAsleep,
      final String source}) = _$SleepDataImpl;

  factory _SleepData.fromJson(Map<String, dynamic> json) =
      _$SleepDataImpl.fromJson;

  @override
  DateTime get bedTime;
  @override
  DateTime get wakeTime;
  @override
  Duration get totalSleepTime;
  @override
  Duration? get deepSleepTime;
  @override
  Duration? get remSleepTime;
  @override
  Duration? get lightSleepTime;
  @override
  int? get sleepQuality; // 1-10 scale if available
  @override
  int get awakenings;
  @override
  Duration? get timeToFallAsleep;
  @override
  String get source;

  /// Create a copy of SleepData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SleepDataImplCopyWith<_$SleepDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkoutSession _$WorkoutSessionFromJson(Map<String, dynamic> json) {
  return _WorkoutSession.fromJson(json);
}

/// @nodoc
mixin _$WorkoutSession {
  String get id => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  WorkoutType get type => throw _privateConstructorUsedError;
  Duration get duration =>
      throw _privateConstructorUsedError; // Intensity and effort
  int? get perceivedExertion =>
      throw _privateConstructorUsedError; // RPE 1-10 scale
  double? get averageHeartRate => throw _privateConstructorUsedError;
  double? get maxHeartRate => throw _privateConstructorUsedError;
  int? get caloriesBurned =>
      throw _privateConstructorUsedError; // Activity-specific metrics
  double? get distanceKm => throw _privateConstructorUsedError;
  int? get steps => throw _privateConstructorUsedError;
  double? get avgSpeed => throw _privateConstructorUsedError; // km/h
  double? get elevationGain => throw _privateConstructorUsedError; // meters
// Recovery metrics
  int? get recoveryHeartRate =>
      throw _privateConstructorUsedError; // BPM after 1 minute
  Duration? get recoveryTime =>
      throw _privateConstructorUsedError; // Time to return to resting HR
  String get notes => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError; // Metadata
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;

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
      DateTime startTime,
      DateTime endTime,
      WorkoutType type,
      Duration duration,
      int? perceivedExertion,
      double? averageHeartRate,
      double? maxHeartRate,
      int? caloriesBurned,
      double? distanceKm,
      int? steps,
      double? avgSpeed,
      double? elevationGain,
      int? recoveryHeartRate,
      Duration? recoveryTime,
      String notes,
      String source,
      DateTime createdAt,
      bool isSynced});
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
    Object? startTime = null,
    Object? endTime = null,
    Object? type = null,
    Object? duration = null,
    Object? perceivedExertion = freezed,
    Object? averageHeartRate = freezed,
    Object? maxHeartRate = freezed,
    Object? caloriesBurned = freezed,
    Object? distanceKm = freezed,
    Object? steps = freezed,
    Object? avgSpeed = freezed,
    Object? elevationGain = freezed,
    Object? recoveryHeartRate = freezed,
    Object? recoveryTime = freezed,
    Object? notes = null,
    Object? source = null,
    Object? createdAt = null,
    Object? isSynced = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      perceivedExertion: freezed == perceivedExertion
          ? _value.perceivedExertion
          : perceivedExertion // ignore: cast_nullable_to_non_nullable
              as int?,
      averageHeartRate: freezed == averageHeartRate
          ? _value.averageHeartRate
          : averageHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      maxHeartRate: freezed == maxHeartRate
          ? _value.maxHeartRate
          : maxHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      caloriesBurned: freezed == caloriesBurned
          ? _value.caloriesBurned
          : caloriesBurned // ignore: cast_nullable_to_non_nullable
              as int?,
      distanceKm: freezed == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double?,
      steps: freezed == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int?,
      avgSpeed: freezed == avgSpeed
          ? _value.avgSpeed
          : avgSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      elevationGain: freezed == elevationGain
          ? _value.elevationGain
          : elevationGain // ignore: cast_nullable_to_non_nullable
              as double?,
      recoveryHeartRate: freezed == recoveryHeartRate
          ? _value.recoveryHeartRate
          : recoveryHeartRate // ignore: cast_nullable_to_non_nullable
              as int?,
      recoveryTime: freezed == recoveryTime
          ? _value.recoveryTime
          : recoveryTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
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
      DateTime startTime,
      DateTime endTime,
      WorkoutType type,
      Duration duration,
      int? perceivedExertion,
      double? averageHeartRate,
      double? maxHeartRate,
      int? caloriesBurned,
      double? distanceKm,
      int? steps,
      double? avgSpeed,
      double? elevationGain,
      int? recoveryHeartRate,
      Duration? recoveryTime,
      String notes,
      String source,
      DateTime createdAt,
      bool isSynced});
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
    Object? startTime = null,
    Object? endTime = null,
    Object? type = null,
    Object? duration = null,
    Object? perceivedExertion = freezed,
    Object? averageHeartRate = freezed,
    Object? maxHeartRate = freezed,
    Object? caloriesBurned = freezed,
    Object? distanceKm = freezed,
    Object? steps = freezed,
    Object? avgSpeed = freezed,
    Object? elevationGain = freezed,
    Object? recoveryHeartRate = freezed,
    Object? recoveryTime = freezed,
    Object? notes = null,
    Object? source = null,
    Object? createdAt = null,
    Object? isSynced = null,
  }) {
    return _then(_$WorkoutSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkoutType,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      perceivedExertion: freezed == perceivedExertion
          ? _value.perceivedExertion
          : perceivedExertion // ignore: cast_nullable_to_non_nullable
              as int?,
      averageHeartRate: freezed == averageHeartRate
          ? _value.averageHeartRate
          : averageHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      maxHeartRate: freezed == maxHeartRate
          ? _value.maxHeartRate
          : maxHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      caloriesBurned: freezed == caloriesBurned
          ? _value.caloriesBurned
          : caloriesBurned // ignore: cast_nullable_to_non_nullable
              as int?,
      distanceKm: freezed == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double?,
      steps: freezed == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int?,
      avgSpeed: freezed == avgSpeed
          ? _value.avgSpeed
          : avgSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      elevationGain: freezed == elevationGain
          ? _value.elevationGain
          : elevationGain // ignore: cast_nullable_to_non_nullable
              as double?,
      recoveryHeartRate: freezed == recoveryHeartRate
          ? _value.recoveryHeartRate
          : recoveryHeartRate // ignore: cast_nullable_to_non_nullable
              as int?,
      recoveryTime: freezed == recoveryTime
          ? _value.recoveryTime
          : recoveryTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$WorkoutSessionImpl implements _WorkoutSession {
  const _$WorkoutSessionImpl(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.type,
      required this.duration,
      this.perceivedExertion = null,
      this.averageHeartRate = null,
      this.maxHeartRate = null,
      this.caloriesBurned = null,
      this.distanceKm = null,
      this.steps = null,
      this.avgSpeed = null,
      this.elevationGain = null,
      this.recoveryHeartRate = null,
      this.recoveryTime = null,
      this.notes = '',
      this.source = 'unknown',
      required this.createdAt,
      this.isSynced = false});

  factory _$WorkoutSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutSessionImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final WorkoutType type;
  @override
  final Duration duration;
// Intensity and effort
  @override
  @JsonKey()
  final int? perceivedExertion;
// RPE 1-10 scale
  @override
  @JsonKey()
  final double? averageHeartRate;
  @override
  @JsonKey()
  final double? maxHeartRate;
  @override
  @JsonKey()
  final int? caloriesBurned;
// Activity-specific metrics
  @override
  @JsonKey()
  final double? distanceKm;
  @override
  @JsonKey()
  final int? steps;
  @override
  @JsonKey()
  final double? avgSpeed;
// km/h
  @override
  @JsonKey()
  final double? elevationGain;
// meters
// Recovery metrics
  @override
  @JsonKey()
  final int? recoveryHeartRate;
// BPM after 1 minute
  @override
  @JsonKey()
  final Duration? recoveryTime;
// Time to return to resting HR
  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey()
  final String source;
// Metadata
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isSynced;

  @override
  String toString() {
    return 'WorkoutSession(id: $id, startTime: $startTime, endTime: $endTime, type: $type, duration: $duration, perceivedExertion: $perceivedExertion, averageHeartRate: $averageHeartRate, maxHeartRate: $maxHeartRate, caloriesBurned: $caloriesBurned, distanceKm: $distanceKm, steps: $steps, avgSpeed: $avgSpeed, elevationGain: $elevationGain, recoveryHeartRate: $recoveryHeartRate, recoveryTime: $recoveryTime, notes: $notes, source: $source, createdAt: $createdAt, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.perceivedExertion, perceivedExertion) ||
                other.perceivedExertion == perceivedExertion) &&
            (identical(other.averageHeartRate, averageHeartRate) ||
                other.averageHeartRate == averageHeartRate) &&
            (identical(other.maxHeartRate, maxHeartRate) ||
                other.maxHeartRate == maxHeartRate) &&
            (identical(other.caloriesBurned, caloriesBurned) ||
                other.caloriesBurned == caloriesBurned) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.avgSpeed, avgSpeed) ||
                other.avgSpeed == avgSpeed) &&
            (identical(other.elevationGain, elevationGain) ||
                other.elevationGain == elevationGain) &&
            (identical(other.recoveryHeartRate, recoveryHeartRate) ||
                other.recoveryHeartRate == recoveryHeartRate) &&
            (identical(other.recoveryTime, recoveryTime) ||
                other.recoveryTime == recoveryTime) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        startTime,
        endTime,
        type,
        duration,
        perceivedExertion,
        averageHeartRate,
        maxHeartRate,
        caloriesBurned,
        distanceKm,
        steps,
        avgSpeed,
        elevationGain,
        recoveryHeartRate,
        recoveryTime,
        notes,
        source,
        createdAt,
        isSynced
      ]);

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
      required final DateTime startTime,
      required final DateTime endTime,
      required final WorkoutType type,
      required final Duration duration,
      final int? perceivedExertion,
      final double? averageHeartRate,
      final double? maxHeartRate,
      final int? caloriesBurned,
      final double? distanceKm,
      final int? steps,
      final double? avgSpeed,
      final double? elevationGain,
      final int? recoveryHeartRate,
      final Duration? recoveryTime,
      final String notes,
      final String source,
      required final DateTime createdAt,
      final bool isSynced}) = _$WorkoutSessionImpl;

  factory _WorkoutSession.fromJson(Map<String, dynamic> json) =
      _$WorkoutSessionImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  WorkoutType get type;
  @override
  Duration get duration; // Intensity and effort
  @override
  int? get perceivedExertion; // RPE 1-10 scale
  @override
  double? get averageHeartRate;
  @override
  double? get maxHeartRate;
  @override
  int? get caloriesBurned; // Activity-specific metrics
  @override
  double? get distanceKm;
  @override
  int? get steps;
  @override
  double? get avgSpeed; // km/h
  @override
  double? get elevationGain; // meters
// Recovery metrics
  @override
  int? get recoveryHeartRate; // BPM after 1 minute
  @override
  Duration? get recoveryTime; // Time to return to resting HR
  @override
  String get notes;
  @override
  String get source; // Metadata
  @override
  DateTime get createdAt;
  @override
  bool get isSynced;

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
  MenstrualPhase get phase => throw _privateConstructorUsedError;
  FlowIntensity? get flowIntensity => throw _privateConstructorUsedError;
  List<MenstrualSymptom> get symptoms => throw _privateConstructorUsedError;
  int? get moodRating => throw _privateConstructorUsedError; // 1-10 scale
  int? get energyRating => throw _privateConstructorUsedError; // 1-10 scale
  int? get painLevel => throw _privateConstructorUsedError; // 1-10 scale
  String get notes => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError; // Cycle predictions
  DateTime? get predictedNextPeriod => throw _privateConstructorUsedError;
  DateTime? get predictedOvulation =>
      throw _privateConstructorUsedError; // Metadata
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;

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
      MenstrualPhase phase,
      FlowIntensity? flowIntensity,
      List<MenstrualSymptom> symptoms,
      int? moodRating,
      int? energyRating,
      int? painLevel,
      String notes,
      String source,
      DateTime? predictedNextPeriod,
      DateTime? predictedOvulation,
      DateTime createdAt,
      bool isSynced});
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
    Object? phase = null,
    Object? flowIntensity = freezed,
    Object? symptoms = null,
    Object? moodRating = freezed,
    Object? energyRating = freezed,
    Object? painLevel = freezed,
    Object? notes = null,
    Object? source = null,
    Object? predictedNextPeriod = freezed,
    Object? predictedOvulation = freezed,
    Object? createdAt = null,
    Object? isSynced = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as MenstrualPhase,
      flowIntensity: freezed == flowIntensity
          ? _value.flowIntensity
          : flowIntensity // ignore: cast_nullable_to_non_nullable
              as FlowIntensity?,
      symptoms: null == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<MenstrualSymptom>,
      moodRating: freezed == moodRating
          ? _value.moodRating
          : moodRating // ignore: cast_nullable_to_non_nullable
              as int?,
      energyRating: freezed == energyRating
          ? _value.energyRating
          : energyRating // ignore: cast_nullable_to_non_nullable
              as int?,
      painLevel: freezed == painLevel
          ? _value.painLevel
          : painLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      predictedNextPeriod: freezed == predictedNextPeriod
          ? _value.predictedNextPeriod
          : predictedNextPeriod // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      predictedOvulation: freezed == predictedOvulation
          ? _value.predictedOvulation
          : predictedOvulation // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      MenstrualPhase phase,
      FlowIntensity? flowIntensity,
      List<MenstrualSymptom> symptoms,
      int? moodRating,
      int? energyRating,
      int? painLevel,
      String notes,
      String source,
      DateTime? predictedNextPeriod,
      DateTime? predictedOvulation,
      DateTime createdAt,
      bool isSynced});
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
    Object? phase = null,
    Object? flowIntensity = freezed,
    Object? symptoms = null,
    Object? moodRating = freezed,
    Object? energyRating = freezed,
    Object? painLevel = freezed,
    Object? notes = null,
    Object? source = null,
    Object? predictedNextPeriod = freezed,
    Object? predictedOvulation = freezed,
    Object? createdAt = null,
    Object? isSynced = null,
  }) {
    return _then(_$MenstrualCycleDataImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as MenstrualPhase,
      flowIntensity: freezed == flowIntensity
          ? _value.flowIntensity
          : flowIntensity // ignore: cast_nullable_to_non_nullable
              as FlowIntensity?,
      symptoms: null == symptoms
          ? _value._symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<MenstrualSymptom>,
      moodRating: freezed == moodRating
          ? _value.moodRating
          : moodRating // ignore: cast_nullable_to_non_nullable
              as int?,
      energyRating: freezed == energyRating
          ? _value.energyRating
          : energyRating // ignore: cast_nullable_to_non_nullable
              as int?,
      painLevel: freezed == painLevel
          ? _value.painLevel
          : painLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      predictedNextPeriod: freezed == predictedNextPeriod
          ? _value.predictedNextPeriod
          : predictedNextPeriod // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      predictedOvulation: freezed == predictedOvulation
          ? _value.predictedOvulation
          : predictedOvulation // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$MenstrualCycleDataImpl implements _MenstrualCycleData {
  const _$MenstrualCycleDataImpl(
      {required this.date,
      required this.phase,
      this.flowIntensity = null,
      final List<MenstrualSymptom> symptoms = const [],
      this.moodRating = null,
      this.energyRating = null,
      this.painLevel = null,
      this.notes = '',
      this.source = 'unknown',
      this.predictedNextPeriod = null,
      this.predictedOvulation = null,
      required this.createdAt,
      this.isSynced = false})
      : _symptoms = symptoms;

  factory _$MenstrualCycleDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenstrualCycleDataImplFromJson(json);

  @override
  final DateTime date;
  @override
  final MenstrualPhase phase;
  @override
  @JsonKey()
  final FlowIntensity? flowIntensity;
  final List<MenstrualSymptom> _symptoms;
  @override
  @JsonKey()
  List<MenstrualSymptom> get symptoms {
    if (_symptoms is EqualUnmodifiableListView) return _symptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symptoms);
  }

  @override
  @JsonKey()
  final int? moodRating;
// 1-10 scale
  @override
  @JsonKey()
  final int? energyRating;
// 1-10 scale
  @override
  @JsonKey()
  final int? painLevel;
// 1-10 scale
  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey()
  final String source;
// Cycle predictions
  @override
  @JsonKey()
  final DateTime? predictedNextPeriod;
  @override
  @JsonKey()
  final DateTime? predictedOvulation;
// Metadata
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isSynced;

  @override
  String toString() {
    return 'MenstrualCycleData(date: $date, phase: $phase, flowIntensity: $flowIntensity, symptoms: $symptoms, moodRating: $moodRating, energyRating: $energyRating, painLevel: $painLevel, notes: $notes, source: $source, predictedNextPeriod: $predictedNextPeriod, predictedOvulation: $predictedOvulation, createdAt: $createdAt, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenstrualCycleDataImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.flowIntensity, flowIntensity) ||
                other.flowIntensity == flowIntensity) &&
            const DeepCollectionEquality().equals(other._symptoms, _symptoms) &&
            (identical(other.moodRating, moodRating) ||
                other.moodRating == moodRating) &&
            (identical(other.energyRating, energyRating) ||
                other.energyRating == energyRating) &&
            (identical(other.painLevel, painLevel) ||
                other.painLevel == painLevel) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.predictedNextPeriod, predictedNextPeriod) ||
                other.predictedNextPeriod == predictedNextPeriod) &&
            (identical(other.predictedOvulation, predictedOvulation) ||
                other.predictedOvulation == predictedOvulation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      phase,
      flowIntensity,
      const DeepCollectionEquality().hash(_symptoms),
      moodRating,
      energyRating,
      painLevel,
      notes,
      source,
      predictedNextPeriod,
      predictedOvulation,
      createdAt,
      isSynced);

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
      required final MenstrualPhase phase,
      final FlowIntensity? flowIntensity,
      final List<MenstrualSymptom> symptoms,
      final int? moodRating,
      final int? energyRating,
      final int? painLevel,
      final String notes,
      final String source,
      final DateTime? predictedNextPeriod,
      final DateTime? predictedOvulation,
      required final DateTime createdAt,
      final bool isSynced}) = _$MenstrualCycleDataImpl;

  factory _MenstrualCycleData.fromJson(Map<String, dynamic> json) =
      _$MenstrualCycleDataImpl.fromJson;

  @override
  DateTime get date;
  @override
  MenstrualPhase get phase;
  @override
  FlowIntensity? get flowIntensity;
  @override
  List<MenstrualSymptom> get symptoms;
  @override
  int? get moodRating; // 1-10 scale
  @override
  int? get energyRating; // 1-10 scale
  @override
  int? get painLevel; // 1-10 scale
  @override
  String get notes;
  @override
  String get source; // Cycle predictions
  @override
  DateTime? get predictedNextPeriod;
  @override
  DateTime? get predictedOvulation; // Metadata
  @override
  DateTime get createdAt;
  @override
  bool get isSynced;

  /// Create a copy of MenstrualCycleData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenstrualCycleDataImplCopyWith<_$MenstrualCycleDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
