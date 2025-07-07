// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apple_watch_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppleWatchReading _$AppleWatchReadingFromJson(Map<String, dynamic> json) {
  return _AppleWatchReading.fromJson(json);
}

/// @nodoc
mixin _$AppleWatchReading {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  double get heartRate => throw _privateConstructorUsedError;
  double? get heartRateVariabilityRMSSD => throw _privateConstructorUsedError;
  double? get heartRateVariabilitySDNN => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError; // in meters
  String get deviceModel =>
      throw _privateConstructorUsedError; // e.g., "Apple Watch Series 9"
  String get watchOSVersion => throw _privateConstructorUsedError;
  String get sourceBundleId => throw _privateConstructorUsedError;
  ReadingQuality get quality => throw _privateConstructorUsedError;
  WorkoutContext? get workoutContext => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this AppleWatchReading to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppleWatchReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppleWatchReadingCopyWith<AppleWatchReading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppleWatchReadingCopyWith<$Res> {
  factory $AppleWatchReadingCopyWith(
          AppleWatchReading value, $Res Function(AppleWatchReading) then) =
      _$AppleWatchReadingCopyWithImpl<$Res, AppleWatchReading>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      double heartRate,
      double? heartRateVariabilityRMSSD,
      double? heartRateVariabilitySDNN,
      int steps,
      double? distance,
      String deviceModel,
      String watchOSVersion,
      String sourceBundleId,
      ReadingQuality quality,
      WorkoutContext? workoutContext,
      Map<String, dynamic>? metadata});

  $WorkoutContextCopyWith<$Res>? get workoutContext;
}

/// @nodoc
class _$AppleWatchReadingCopyWithImpl<$Res, $Val extends AppleWatchReading>
    implements $AppleWatchReadingCopyWith<$Res> {
  _$AppleWatchReadingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppleWatchReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? heartRate = null,
    Object? heartRateVariabilityRMSSD = freezed,
    Object? heartRateVariabilitySDNN = freezed,
    Object? steps = null,
    Object? distance = freezed,
    Object? deviceModel = null,
    Object? watchOSVersion = null,
    Object? sourceBundleId = null,
    Object? quality = null,
    Object? workoutContext = freezed,
    Object? metadata = freezed,
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
      heartRate: null == heartRate
          ? _value.heartRate
          : heartRate // ignore: cast_nullable_to_non_nullable
              as double,
      heartRateVariabilityRMSSD: freezed == heartRateVariabilityRMSSD
          ? _value.heartRateVariabilityRMSSD
          : heartRateVariabilityRMSSD // ignore: cast_nullable_to_non_nullable
              as double?,
      heartRateVariabilitySDNN: freezed == heartRateVariabilitySDNN
          ? _value.heartRateVariabilitySDNN
          : heartRateVariabilitySDNN // ignore: cast_nullable_to_non_nullable
              as double?,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      deviceModel: null == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String,
      watchOSVersion: null == watchOSVersion
          ? _value.watchOSVersion
          : watchOSVersion // ignore: cast_nullable_to_non_nullable
              as String,
      sourceBundleId: null == sourceBundleId
          ? _value.sourceBundleId
          : sourceBundleId // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as ReadingQuality,
      workoutContext: freezed == workoutContext
          ? _value.workoutContext
          : workoutContext // ignore: cast_nullable_to_non_nullable
              as WorkoutContext?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of AppleWatchReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutContextCopyWith<$Res>? get workoutContext {
    if (_value.workoutContext == null) {
      return null;
    }

    return $WorkoutContextCopyWith<$Res>(_value.workoutContext!, (value) {
      return _then(_value.copyWith(workoutContext: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppleWatchReadingImplCopyWith<$Res>
    implements $AppleWatchReadingCopyWith<$Res> {
  factory _$$AppleWatchReadingImplCopyWith(_$AppleWatchReadingImpl value,
          $Res Function(_$AppleWatchReadingImpl) then) =
      __$$AppleWatchReadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      double heartRate,
      double? heartRateVariabilityRMSSD,
      double? heartRateVariabilitySDNN,
      int steps,
      double? distance,
      String deviceModel,
      String watchOSVersion,
      String sourceBundleId,
      ReadingQuality quality,
      WorkoutContext? workoutContext,
      Map<String, dynamic>? metadata});

  @override
  $WorkoutContextCopyWith<$Res>? get workoutContext;
}

/// @nodoc
class __$$AppleWatchReadingImplCopyWithImpl<$Res>
    extends _$AppleWatchReadingCopyWithImpl<$Res, _$AppleWatchReadingImpl>
    implements _$$AppleWatchReadingImplCopyWith<$Res> {
  __$$AppleWatchReadingImplCopyWithImpl(_$AppleWatchReadingImpl _value,
      $Res Function(_$AppleWatchReadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppleWatchReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? heartRate = null,
    Object? heartRateVariabilityRMSSD = freezed,
    Object? heartRateVariabilitySDNN = freezed,
    Object? steps = null,
    Object? distance = freezed,
    Object? deviceModel = null,
    Object? watchOSVersion = null,
    Object? sourceBundleId = null,
    Object? quality = null,
    Object? workoutContext = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$AppleWatchReadingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      heartRate: null == heartRate
          ? _value.heartRate
          : heartRate // ignore: cast_nullable_to_non_nullable
              as double,
      heartRateVariabilityRMSSD: freezed == heartRateVariabilityRMSSD
          ? _value.heartRateVariabilityRMSSD
          : heartRateVariabilityRMSSD // ignore: cast_nullable_to_non_nullable
              as double?,
      heartRateVariabilitySDNN: freezed == heartRateVariabilitySDNN
          ? _value.heartRateVariabilitySDNN
          : heartRateVariabilitySDNN // ignore: cast_nullable_to_non_nullable
              as double?,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      deviceModel: null == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String,
      watchOSVersion: null == watchOSVersion
          ? _value.watchOSVersion
          : watchOSVersion // ignore: cast_nullable_to_non_nullable
              as String,
      sourceBundleId: null == sourceBundleId
          ? _value.sourceBundleId
          : sourceBundleId // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as ReadingQuality,
      workoutContext: freezed == workoutContext
          ? _value.workoutContext
          : workoutContext // ignore: cast_nullable_to_non_nullable
              as WorkoutContext?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppleWatchReadingImpl implements _AppleWatchReading {
  const _$AppleWatchReadingImpl(
      {required this.id,
      required this.timestamp,
      required this.heartRate,
      this.heartRateVariabilityRMSSD,
      this.heartRateVariabilitySDNN,
      required this.steps,
      this.distance,
      required this.deviceModel,
      required this.watchOSVersion,
      required this.sourceBundleId,
      required this.quality,
      this.workoutContext,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$AppleWatchReadingImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppleWatchReadingImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final double heartRate;
  @override
  final double? heartRateVariabilityRMSSD;
  @override
  final double? heartRateVariabilitySDNN;
  @override
  final int steps;
  @override
  final double? distance;
// in meters
  @override
  final String deviceModel;
// e.g., "Apple Watch Series 9"
  @override
  final String watchOSVersion;
  @override
  final String sourceBundleId;
  @override
  final ReadingQuality quality;
  @override
  final WorkoutContext? workoutContext;
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
    return 'AppleWatchReading(id: $id, timestamp: $timestamp, heartRate: $heartRate, heartRateVariabilityRMSSD: $heartRateVariabilityRMSSD, heartRateVariabilitySDNN: $heartRateVariabilitySDNN, steps: $steps, distance: $distance, deviceModel: $deviceModel, watchOSVersion: $watchOSVersion, sourceBundleId: $sourceBundleId, quality: $quality, workoutContext: $workoutContext, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppleWatchReadingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            (identical(other.heartRateVariabilityRMSSD,
                    heartRateVariabilityRMSSD) ||
                other.heartRateVariabilityRMSSD == heartRateVariabilityRMSSD) &&
            (identical(
                    other.heartRateVariabilitySDNN, heartRateVariabilitySDNN) ||
                other.heartRateVariabilitySDNN == heartRateVariabilitySDNN) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.deviceModel, deviceModel) ||
                other.deviceModel == deviceModel) &&
            (identical(other.watchOSVersion, watchOSVersion) ||
                other.watchOSVersion == watchOSVersion) &&
            (identical(other.sourceBundleId, sourceBundleId) ||
                other.sourceBundleId == sourceBundleId) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.workoutContext, workoutContext) ||
                other.workoutContext == workoutContext) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      heartRate,
      heartRateVariabilityRMSSD,
      heartRateVariabilitySDNN,
      steps,
      distance,
      deviceModel,
      watchOSVersion,
      sourceBundleId,
      quality,
      workoutContext,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of AppleWatchReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppleWatchReadingImplCopyWith<_$AppleWatchReadingImpl> get copyWith =>
      __$$AppleWatchReadingImplCopyWithImpl<_$AppleWatchReadingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppleWatchReadingImplToJson(
      this,
    );
  }
}

abstract class _AppleWatchReading implements AppleWatchReading {
  const factory _AppleWatchReading(
      {required final String id,
      required final DateTime timestamp,
      required final double heartRate,
      final double? heartRateVariabilityRMSSD,
      final double? heartRateVariabilitySDNN,
      required final int steps,
      final double? distance,
      required final String deviceModel,
      required final String watchOSVersion,
      required final String sourceBundleId,
      required final ReadingQuality quality,
      final WorkoutContext? workoutContext,
      final Map<String, dynamic>? metadata}) = _$AppleWatchReadingImpl;

  factory _AppleWatchReading.fromJson(Map<String, dynamic> json) =
      _$AppleWatchReadingImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  double get heartRate;
  @override
  double? get heartRateVariabilityRMSSD;
  @override
  double? get heartRateVariabilitySDNN;
  @override
  int get steps;
  @override
  double? get distance; // in meters
  @override
  String get deviceModel; // e.g., "Apple Watch Series 9"
  @override
  String get watchOSVersion;
  @override
  String get sourceBundleId;
  @override
  ReadingQuality get quality;
  @override
  WorkoutContext? get workoutContext;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of AppleWatchReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppleWatchReadingImplCopyWith<_$AppleWatchReadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkoutContext _$WorkoutContextFromJson(Map<String, dynamic> json) {
  return _WorkoutContext.fromJson(json);
}

/// @nodoc
mixin _$WorkoutContext {
  String get workoutType => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  double? get duration => throw _privateConstructorUsedError; // in minutes
  double? get averageHeartRate => throw _privateConstructorUsedError;
  double? get maxHeartRate => throw _privateConstructorUsedError;
  double? get calories => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;

  /// Serializes this WorkoutContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutContextCopyWith<WorkoutContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutContextCopyWith<$Res> {
  factory $WorkoutContextCopyWith(
          WorkoutContext value, $Res Function(WorkoutContext) then) =
      _$WorkoutContextCopyWithImpl<$Res, WorkoutContext>;
  @useResult
  $Res call(
      {String workoutType,
      DateTime startTime,
      double? duration,
      double? averageHeartRate,
      double? maxHeartRate,
      double? calories,
      double? distance});
}

/// @nodoc
class _$WorkoutContextCopyWithImpl<$Res, $Val extends WorkoutContext>
    implements $WorkoutContextCopyWith<$Res> {
  _$WorkoutContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workoutType = null,
    Object? startTime = null,
    Object? duration = freezed,
    Object? averageHeartRate = freezed,
    Object? maxHeartRate = freezed,
    Object? calories = freezed,
    Object? distance = freezed,
  }) {
    return _then(_value.copyWith(
      workoutType: null == workoutType
          ? _value.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double?,
      averageHeartRate: freezed == averageHeartRate
          ? _value.averageHeartRate
          : averageHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      maxHeartRate: freezed == maxHeartRate
          ? _value.maxHeartRate
          : maxHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      calories: freezed == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutContextImplCopyWith<$Res>
    implements $WorkoutContextCopyWith<$Res> {
  factory _$$WorkoutContextImplCopyWith(_$WorkoutContextImpl value,
          $Res Function(_$WorkoutContextImpl) then) =
      __$$WorkoutContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String workoutType,
      DateTime startTime,
      double? duration,
      double? averageHeartRate,
      double? maxHeartRate,
      double? calories,
      double? distance});
}

/// @nodoc
class __$$WorkoutContextImplCopyWithImpl<$Res>
    extends _$WorkoutContextCopyWithImpl<$Res, _$WorkoutContextImpl>
    implements _$$WorkoutContextImplCopyWith<$Res> {
  __$$WorkoutContextImplCopyWithImpl(
      _$WorkoutContextImpl _value, $Res Function(_$WorkoutContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workoutType = null,
    Object? startTime = null,
    Object? duration = freezed,
    Object? averageHeartRate = freezed,
    Object? maxHeartRate = freezed,
    Object? calories = freezed,
    Object? distance = freezed,
  }) {
    return _then(_$WorkoutContextImpl(
      workoutType: null == workoutType
          ? _value.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double?,
      averageHeartRate: freezed == averageHeartRate
          ? _value.averageHeartRate
          : averageHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      maxHeartRate: freezed == maxHeartRate
          ? _value.maxHeartRate
          : maxHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      calories: freezed == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutContextImpl implements _WorkoutContext {
  const _$WorkoutContextImpl(
      {required this.workoutType,
      required this.startTime,
      this.duration,
      this.averageHeartRate,
      this.maxHeartRate,
      this.calories,
      this.distance});

  factory _$WorkoutContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutContextImplFromJson(json);

  @override
  final String workoutType;
  @override
  final DateTime startTime;
  @override
  final double? duration;
// in minutes
  @override
  final double? averageHeartRate;
  @override
  final double? maxHeartRate;
  @override
  final double? calories;
  @override
  final double? distance;

  @override
  String toString() {
    return 'WorkoutContext(workoutType: $workoutType, startTime: $startTime, duration: $duration, averageHeartRate: $averageHeartRate, maxHeartRate: $maxHeartRate, calories: $calories, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutContextImpl &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.averageHeartRate, averageHeartRate) ||
                other.averageHeartRate == averageHeartRate) &&
            (identical(other.maxHeartRate, maxHeartRate) ||
                other.maxHeartRate == maxHeartRate) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, workoutType, startTime, duration,
      averageHeartRate, maxHeartRate, calories, distance);

  /// Create a copy of WorkoutContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutContextImplCopyWith<_$WorkoutContextImpl> get copyWith =>
      __$$WorkoutContextImplCopyWithImpl<_$WorkoutContextImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutContextImplToJson(
      this,
    );
  }
}

abstract class _WorkoutContext implements WorkoutContext {
  const factory _WorkoutContext(
      {required final String workoutType,
      required final DateTime startTime,
      final double? duration,
      final double? averageHeartRate,
      final double? maxHeartRate,
      final double? calories,
      final double? distance}) = _$WorkoutContextImpl;

  factory _WorkoutContext.fromJson(Map<String, dynamic> json) =
      _$WorkoutContextImpl.fromJson;

  @override
  String get workoutType;
  @override
  DateTime get startTime;
  @override
  double? get duration; // in minutes
  @override
  double? get averageHeartRate;
  @override
  double? get maxHeartRate;
  @override
  double? get calories;
  @override
  double? get distance;

  /// Create a copy of WorkoutContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutContextImplCopyWith<_$WorkoutContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppleWatchStatus _$AppleWatchStatusFromJson(Map<String, dynamic> json) {
  return _AppleWatchStatus.fromJson(json);
}

/// @nodoc
mixin _$AppleWatchStatus {
  bool get isConnected => throw _privateConstructorUsedError;
  bool get isReachable => throw _privateConstructorUsedError;
  String? get deviceModel => throw _privateConstructorUsedError;
  String? get watchOSVersion => throw _privateConstructorUsedError;
  double? get batteryLevel => throw _privateConstructorUsedError;
  DateTime? get lastDataSync => throw _privateConstructorUsedError;
  DateTime? get lastCommunication => throw _privateConstructorUsedError;
  List<WatchCapability> get supportedCapabilities =>
      throw _privateConstructorUsedError;

  /// Serializes this AppleWatchStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppleWatchStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppleWatchStatusCopyWith<AppleWatchStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppleWatchStatusCopyWith<$Res> {
  factory $AppleWatchStatusCopyWith(
          AppleWatchStatus value, $Res Function(AppleWatchStatus) then) =
      _$AppleWatchStatusCopyWithImpl<$Res, AppleWatchStatus>;
  @useResult
  $Res call(
      {bool isConnected,
      bool isReachable,
      String? deviceModel,
      String? watchOSVersion,
      double? batteryLevel,
      DateTime? lastDataSync,
      DateTime? lastCommunication,
      List<WatchCapability> supportedCapabilities});
}

/// @nodoc
class _$AppleWatchStatusCopyWithImpl<$Res, $Val extends AppleWatchStatus>
    implements $AppleWatchStatusCopyWith<$Res> {
  _$AppleWatchStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppleWatchStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? isReachable = null,
    Object? deviceModel = freezed,
    Object? watchOSVersion = freezed,
    Object? batteryLevel = freezed,
    Object? lastDataSync = freezed,
    Object? lastCommunication = freezed,
    Object? supportedCapabilities = null,
  }) {
    return _then(_value.copyWith(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isReachable: null == isReachable
          ? _value.isReachable
          : isReachable // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceModel: freezed == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
      watchOSVersion: freezed == watchOSVersion
          ? _value.watchOSVersion
          : watchOSVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      batteryLevel: freezed == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      lastDataSync: freezed == lastDataSync
          ? _value.lastDataSync
          : lastDataSync // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastCommunication: freezed == lastCommunication
          ? _value.lastCommunication
          : lastCommunication // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      supportedCapabilities: null == supportedCapabilities
          ? _value.supportedCapabilities
          : supportedCapabilities // ignore: cast_nullable_to_non_nullable
              as List<WatchCapability>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppleWatchStatusImplCopyWith<$Res>
    implements $AppleWatchStatusCopyWith<$Res> {
  factory _$$AppleWatchStatusImplCopyWith(_$AppleWatchStatusImpl value,
          $Res Function(_$AppleWatchStatusImpl) then) =
      __$$AppleWatchStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isConnected,
      bool isReachable,
      String? deviceModel,
      String? watchOSVersion,
      double? batteryLevel,
      DateTime? lastDataSync,
      DateTime? lastCommunication,
      List<WatchCapability> supportedCapabilities});
}

/// @nodoc
class __$$AppleWatchStatusImplCopyWithImpl<$Res>
    extends _$AppleWatchStatusCopyWithImpl<$Res, _$AppleWatchStatusImpl>
    implements _$$AppleWatchStatusImplCopyWith<$Res> {
  __$$AppleWatchStatusImplCopyWithImpl(_$AppleWatchStatusImpl _value,
      $Res Function(_$AppleWatchStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppleWatchStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? isReachable = null,
    Object? deviceModel = freezed,
    Object? watchOSVersion = freezed,
    Object? batteryLevel = freezed,
    Object? lastDataSync = freezed,
    Object? lastCommunication = freezed,
    Object? supportedCapabilities = null,
  }) {
    return _then(_$AppleWatchStatusImpl(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isReachable: null == isReachable
          ? _value.isReachable
          : isReachable // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceModel: freezed == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
      watchOSVersion: freezed == watchOSVersion
          ? _value.watchOSVersion
          : watchOSVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      batteryLevel: freezed == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      lastDataSync: freezed == lastDataSync
          ? _value.lastDataSync
          : lastDataSync // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastCommunication: freezed == lastCommunication
          ? _value.lastCommunication
          : lastCommunication // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      supportedCapabilities: null == supportedCapabilities
          ? _value._supportedCapabilities
          : supportedCapabilities // ignore: cast_nullable_to_non_nullable
              as List<WatchCapability>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppleWatchStatusImpl implements _AppleWatchStatus {
  const _$AppleWatchStatusImpl(
      {required this.isConnected,
      required this.isReachable,
      this.deviceModel,
      this.watchOSVersion,
      this.batteryLevel,
      this.lastDataSync,
      this.lastCommunication,
      required final List<WatchCapability> supportedCapabilities})
      : _supportedCapabilities = supportedCapabilities;

  factory _$AppleWatchStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppleWatchStatusImplFromJson(json);

  @override
  final bool isConnected;
  @override
  final bool isReachable;
  @override
  final String? deviceModel;
  @override
  final String? watchOSVersion;
  @override
  final double? batteryLevel;
  @override
  final DateTime? lastDataSync;
  @override
  final DateTime? lastCommunication;
  final List<WatchCapability> _supportedCapabilities;
  @override
  List<WatchCapability> get supportedCapabilities {
    if (_supportedCapabilities is EqualUnmodifiableListView)
      return _supportedCapabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedCapabilities);
  }

  @override
  String toString() {
    return 'AppleWatchStatus(isConnected: $isConnected, isReachable: $isReachable, deviceModel: $deviceModel, watchOSVersion: $watchOSVersion, batteryLevel: $batteryLevel, lastDataSync: $lastDataSync, lastCommunication: $lastCommunication, supportedCapabilities: $supportedCapabilities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppleWatchStatusImpl &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.isReachable, isReachable) ||
                other.isReachable == isReachable) &&
            (identical(other.deviceModel, deviceModel) ||
                other.deviceModel == deviceModel) &&
            (identical(other.watchOSVersion, watchOSVersion) ||
                other.watchOSVersion == watchOSVersion) &&
            (identical(other.batteryLevel, batteryLevel) ||
                other.batteryLevel == batteryLevel) &&
            (identical(other.lastDataSync, lastDataSync) ||
                other.lastDataSync == lastDataSync) &&
            (identical(other.lastCommunication, lastCommunication) ||
                other.lastCommunication == lastCommunication) &&
            const DeepCollectionEquality()
                .equals(other._supportedCapabilities, _supportedCapabilities));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isConnected,
      isReachable,
      deviceModel,
      watchOSVersion,
      batteryLevel,
      lastDataSync,
      lastCommunication,
      const DeepCollectionEquality().hash(_supportedCapabilities));

  /// Create a copy of AppleWatchStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppleWatchStatusImplCopyWith<_$AppleWatchStatusImpl> get copyWith =>
      __$$AppleWatchStatusImplCopyWithImpl<_$AppleWatchStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppleWatchStatusImplToJson(
      this,
    );
  }
}

abstract class _AppleWatchStatus implements AppleWatchStatus {
  const factory _AppleWatchStatus(
          {required final bool isConnected,
          required final bool isReachable,
          final String? deviceModel,
          final String? watchOSVersion,
          final double? batteryLevel,
          final DateTime? lastDataSync,
          final DateTime? lastCommunication,
          required final List<WatchCapability> supportedCapabilities}) =
      _$AppleWatchStatusImpl;

  factory _AppleWatchStatus.fromJson(Map<String, dynamic> json) =
      _$AppleWatchStatusImpl.fromJson;

  @override
  bool get isConnected;
  @override
  bool get isReachable;
  @override
  String? get deviceModel;
  @override
  String? get watchOSVersion;
  @override
  double? get batteryLevel;
  @override
  DateTime? get lastDataSync;
  @override
  DateTime? get lastCommunication;
  @override
  List<WatchCapability> get supportedCapabilities;

  /// Create a copy of AppleWatchStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppleWatchStatusImplCopyWith<_$AppleWatchStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppleWatchStreamData _$AppleWatchStreamDataFromJson(Map<String, dynamic> json) {
  return _AppleWatchStreamData.fromJson(json);
}

/// @nodoc
mixin _$AppleWatchStreamData {
  DateTime get timestamp => throw _privateConstructorUsedError;
  double? get instantHeartRate => throw _privateConstructorUsedError;
  List<double>? get rrIntervals =>
      throw _privateConstructorUsedError; // R-R intervals in milliseconds
  int? get currentSteps => throw _privateConstructorUsedError;
  bool? get isInWorkout => throw _privateConstructorUsedError;
  String? get workoutType => throw _privateConstructorUsedError;

  /// Serializes this AppleWatchStreamData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppleWatchStreamData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppleWatchStreamDataCopyWith<AppleWatchStreamData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppleWatchStreamDataCopyWith<$Res> {
  factory $AppleWatchStreamDataCopyWith(AppleWatchStreamData value,
          $Res Function(AppleWatchStreamData) then) =
      _$AppleWatchStreamDataCopyWithImpl<$Res, AppleWatchStreamData>;
  @useResult
  $Res call(
      {DateTime timestamp,
      double? instantHeartRate,
      List<double>? rrIntervals,
      int? currentSteps,
      bool? isInWorkout,
      String? workoutType});
}

/// @nodoc
class _$AppleWatchStreamDataCopyWithImpl<$Res,
        $Val extends AppleWatchStreamData>
    implements $AppleWatchStreamDataCopyWith<$Res> {
  _$AppleWatchStreamDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppleWatchStreamData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? instantHeartRate = freezed,
    Object? rrIntervals = freezed,
    Object? currentSteps = freezed,
    Object? isInWorkout = freezed,
    Object? workoutType = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      instantHeartRate: freezed == instantHeartRate
          ? _value.instantHeartRate
          : instantHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      rrIntervals: freezed == rrIntervals
          ? _value.rrIntervals
          : rrIntervals // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      currentSteps: freezed == currentSteps
          ? _value.currentSteps
          : currentSteps // ignore: cast_nullable_to_non_nullable
              as int?,
      isInWorkout: freezed == isInWorkout
          ? _value.isInWorkout
          : isInWorkout // ignore: cast_nullable_to_non_nullable
              as bool?,
      workoutType: freezed == workoutType
          ? _value.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppleWatchStreamDataImplCopyWith<$Res>
    implements $AppleWatchStreamDataCopyWith<$Res> {
  factory _$$AppleWatchStreamDataImplCopyWith(_$AppleWatchStreamDataImpl value,
          $Res Function(_$AppleWatchStreamDataImpl) then) =
      __$$AppleWatchStreamDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime timestamp,
      double? instantHeartRate,
      List<double>? rrIntervals,
      int? currentSteps,
      bool? isInWorkout,
      String? workoutType});
}

/// @nodoc
class __$$AppleWatchStreamDataImplCopyWithImpl<$Res>
    extends _$AppleWatchStreamDataCopyWithImpl<$Res, _$AppleWatchStreamDataImpl>
    implements _$$AppleWatchStreamDataImplCopyWith<$Res> {
  __$$AppleWatchStreamDataImplCopyWithImpl(_$AppleWatchStreamDataImpl _value,
      $Res Function(_$AppleWatchStreamDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppleWatchStreamData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? instantHeartRate = freezed,
    Object? rrIntervals = freezed,
    Object? currentSteps = freezed,
    Object? isInWorkout = freezed,
    Object? workoutType = freezed,
  }) {
    return _then(_$AppleWatchStreamDataImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      instantHeartRate: freezed == instantHeartRate
          ? _value.instantHeartRate
          : instantHeartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      rrIntervals: freezed == rrIntervals
          ? _value._rrIntervals
          : rrIntervals // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      currentSteps: freezed == currentSteps
          ? _value.currentSteps
          : currentSteps // ignore: cast_nullable_to_non_nullable
              as int?,
      isInWorkout: freezed == isInWorkout
          ? _value.isInWorkout
          : isInWorkout // ignore: cast_nullable_to_non_nullable
              as bool?,
      workoutType: freezed == workoutType
          ? _value.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppleWatchStreamDataImpl implements _AppleWatchStreamData {
  const _$AppleWatchStreamDataImpl(
      {required this.timestamp,
      this.instantHeartRate,
      final List<double>? rrIntervals,
      this.currentSteps,
      this.isInWorkout,
      this.workoutType})
      : _rrIntervals = rrIntervals;

  factory _$AppleWatchStreamDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppleWatchStreamDataImplFromJson(json);

  @override
  final DateTime timestamp;
  @override
  final double? instantHeartRate;
  final List<double>? _rrIntervals;
  @override
  List<double>? get rrIntervals {
    final value = _rrIntervals;
    if (value == null) return null;
    if (_rrIntervals is EqualUnmodifiableListView) return _rrIntervals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// R-R intervals in milliseconds
  @override
  final int? currentSteps;
  @override
  final bool? isInWorkout;
  @override
  final String? workoutType;

  @override
  String toString() {
    return 'AppleWatchStreamData(timestamp: $timestamp, instantHeartRate: $instantHeartRate, rrIntervals: $rrIntervals, currentSteps: $currentSteps, isInWorkout: $isInWorkout, workoutType: $workoutType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppleWatchStreamDataImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.instantHeartRate, instantHeartRate) ||
                other.instantHeartRate == instantHeartRate) &&
            const DeepCollectionEquality()
                .equals(other._rrIntervals, _rrIntervals) &&
            (identical(other.currentSteps, currentSteps) ||
                other.currentSteps == currentSteps) &&
            (identical(other.isInWorkout, isInWorkout) ||
                other.isInWorkout == isInWorkout) &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      timestamp,
      instantHeartRate,
      const DeepCollectionEquality().hash(_rrIntervals),
      currentSteps,
      isInWorkout,
      workoutType);

  /// Create a copy of AppleWatchStreamData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppleWatchStreamDataImplCopyWith<_$AppleWatchStreamDataImpl>
      get copyWith =>
          __$$AppleWatchStreamDataImplCopyWithImpl<_$AppleWatchStreamDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppleWatchStreamDataImplToJson(
      this,
    );
  }
}

abstract class _AppleWatchStreamData implements AppleWatchStreamData {
  const factory _AppleWatchStreamData(
      {required final DateTime timestamp,
      final double? instantHeartRate,
      final List<double>? rrIntervals,
      final int? currentSteps,
      final bool? isInWorkout,
      final String? workoutType}) = _$AppleWatchStreamDataImpl;

  factory _AppleWatchStreamData.fromJson(Map<String, dynamic> json) =
      _$AppleWatchStreamDataImpl.fromJson;

  @override
  DateTime get timestamp;
  @override
  double? get instantHeartRate;
  @override
  List<double>? get rrIntervals; // R-R intervals in milliseconds
  @override
  int? get currentSteps;
  @override
  bool? get isInWorkout;
  @override
  String? get workoutType;

  /// Create a copy of AppleWatchStreamData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppleWatchStreamDataImplCopyWith<_$AppleWatchStreamDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
