// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSyncStatus _$AppSyncStatusFromJson(Map<String, dynamic> json) {
  return _AppSyncStatus.fromJson(json);
}

/// @nodoc
mixin _$AppSyncStatus {
  SyncState get state => throw _privateConstructorUsedError;
  int get pendingOperations => throw _privateConstructorUsedError;
  int get conflictCount => throw _privateConstructorUsedError;
  DateTime? get lastSyncAttempt => throw _privateConstructorUsedError;
  DateTime? get lastSuccessfulSync => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  double get syncProgress => throw _privateConstructorUsedError;

  /// Serializes this AppSyncStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppSyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppSyncStatusCopyWith<AppSyncStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSyncStatusCopyWith<$Res> {
  factory $AppSyncStatusCopyWith(
          AppSyncStatus value, $Res Function(AppSyncStatus) then) =
      _$AppSyncStatusCopyWithImpl<$Res, AppSyncStatus>;
  @useResult
  $Res call(
      {SyncState state,
      int pendingOperations,
      int conflictCount,
      DateTime? lastSyncAttempt,
      DateTime? lastSuccessfulSync,
      String? error,
      double syncProgress});
}

/// @nodoc
class _$AppSyncStatusCopyWithImpl<$Res, $Val extends AppSyncStatus>
    implements $AppSyncStatusCopyWith<$Res> {
  _$AppSyncStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? pendingOperations = null,
    Object? conflictCount = null,
    Object? lastSyncAttempt = freezed,
    Object? lastSuccessfulSync = freezed,
    Object? error = freezed,
    Object? syncProgress = null,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as SyncState,
      pendingOperations: null == pendingOperations
          ? _value.pendingOperations
          : pendingOperations // ignore: cast_nullable_to_non_nullable
              as int,
      conflictCount: null == conflictCount
          ? _value.conflictCount
          : conflictCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastSyncAttempt: freezed == lastSyncAttempt
          ? _value.lastSyncAttempt
          : lastSyncAttempt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSuccessfulSync: freezed == lastSuccessfulSync
          ? _value.lastSuccessfulSync
          : lastSuccessfulSync // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      syncProgress: null == syncProgress
          ? _value.syncProgress
          : syncProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSyncStatusImplCopyWith<$Res>
    implements $AppSyncStatusCopyWith<$Res> {
  factory _$$AppSyncStatusImplCopyWith(
          _$AppSyncStatusImpl value, $Res Function(_$AppSyncStatusImpl) then) =
      __$$AppSyncStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SyncState state,
      int pendingOperations,
      int conflictCount,
      DateTime? lastSyncAttempt,
      DateTime? lastSuccessfulSync,
      String? error,
      double syncProgress});
}

/// @nodoc
class __$$AppSyncStatusImplCopyWithImpl<$Res>
    extends _$AppSyncStatusCopyWithImpl<$Res, _$AppSyncStatusImpl>
    implements _$$AppSyncStatusImplCopyWith<$Res> {
  __$$AppSyncStatusImplCopyWithImpl(
      _$AppSyncStatusImpl _value, $Res Function(_$AppSyncStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppSyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? pendingOperations = null,
    Object? conflictCount = null,
    Object? lastSyncAttempt = freezed,
    Object? lastSuccessfulSync = freezed,
    Object? error = freezed,
    Object? syncProgress = null,
  }) {
    return _then(_$AppSyncStatusImpl(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as SyncState,
      pendingOperations: null == pendingOperations
          ? _value.pendingOperations
          : pendingOperations // ignore: cast_nullable_to_non_nullable
              as int,
      conflictCount: null == conflictCount
          ? _value.conflictCount
          : conflictCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastSyncAttempt: freezed == lastSyncAttempt
          ? _value.lastSyncAttempt
          : lastSyncAttempt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSuccessfulSync: freezed == lastSuccessfulSync
          ? _value.lastSuccessfulSync
          : lastSuccessfulSync // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      syncProgress: null == syncProgress
          ? _value.syncProgress
          : syncProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSyncStatusImpl implements _AppSyncStatus {
  const _$AppSyncStatusImpl(
      {this.state = SyncState.offline,
      this.pendingOperations = 0,
      this.conflictCount = 0,
      this.lastSyncAttempt,
      this.lastSuccessfulSync,
      this.error,
      this.syncProgress = 0});

  factory _$AppSyncStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSyncStatusImplFromJson(json);

  @override
  @JsonKey()
  final SyncState state;
  @override
  @JsonKey()
  final int pendingOperations;
  @override
  @JsonKey()
  final int conflictCount;
  @override
  final DateTime? lastSyncAttempt;
  @override
  final DateTime? lastSuccessfulSync;
  @override
  final String? error;
  @override
  @JsonKey()
  final double syncProgress;

  @override
  String toString() {
    return 'AppSyncStatus(state: $state, pendingOperations: $pendingOperations, conflictCount: $conflictCount, lastSyncAttempt: $lastSyncAttempt, lastSuccessfulSync: $lastSuccessfulSync, error: $error, syncProgress: $syncProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSyncStatusImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.pendingOperations, pendingOperations) ||
                other.pendingOperations == pendingOperations) &&
            (identical(other.conflictCount, conflictCount) ||
                other.conflictCount == conflictCount) &&
            (identical(other.lastSyncAttempt, lastSyncAttempt) ||
                other.lastSyncAttempt == lastSyncAttempt) &&
            (identical(other.lastSuccessfulSync, lastSuccessfulSync) ||
                other.lastSuccessfulSync == lastSuccessfulSync) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.syncProgress, syncProgress) ||
                other.syncProgress == syncProgress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, state, pendingOperations,
      conflictCount, lastSyncAttempt, lastSuccessfulSync, error, syncProgress);

  /// Create a copy of AppSyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSyncStatusImplCopyWith<_$AppSyncStatusImpl> get copyWith =>
      __$$AppSyncStatusImplCopyWithImpl<_$AppSyncStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSyncStatusImplToJson(
      this,
    );
  }
}

abstract class _AppSyncStatus implements AppSyncStatus {
  const factory _AppSyncStatus(
      {final SyncState state,
      final int pendingOperations,
      final int conflictCount,
      final DateTime? lastSyncAttempt,
      final DateTime? lastSuccessfulSync,
      final String? error,
      final double syncProgress}) = _$AppSyncStatusImpl;

  factory _AppSyncStatus.fromJson(Map<String, dynamic> json) =
      _$AppSyncStatusImpl.fromJson;

  @override
  SyncState get state;
  @override
  int get pendingOperations;
  @override
  int get conflictCount;
  @override
  DateTime? get lastSyncAttempt;
  @override
  DateTime? get lastSuccessfulSync;
  @override
  String? get error;
  @override
  double get syncProgress;

  /// Create a copy of AppSyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSyncStatusImplCopyWith<_$AppSyncStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncStatistics _$SyncStatisticsFromJson(Map<String, dynamic> json) {
  return _SyncStatistics.fromJson(json);
}

/// @nodoc
mixin _$SyncStatistics {
  int get totalOperations => throw _privateConstructorUsedError;
  int get successfulOperations => throw _privateConstructorUsedError;
  int get failedOperations => throw _privateConstructorUsedError;
  int get conflictOperations => throw _privateConstructorUsedError;
  int get bytesUploaded => throw _privateConstructorUsedError;
  int get bytesDownloaded => throw _privateConstructorUsedError;
  Duration? get averageSyncTime => throw _privateConstructorUsedError;
  DateTime? get firstSyncAt => throw _privateConstructorUsedError;
  DateTime? get lastSyncAt => throw _privateConstructorUsedError;

  /// Serializes this SyncStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncStatisticsCopyWith<SyncStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStatisticsCopyWith<$Res> {
  factory $SyncStatisticsCopyWith(
          SyncStatistics value, $Res Function(SyncStatistics) then) =
      _$SyncStatisticsCopyWithImpl<$Res, SyncStatistics>;
  @useResult
  $Res call(
      {int totalOperations,
      int successfulOperations,
      int failedOperations,
      int conflictOperations,
      int bytesUploaded,
      int bytesDownloaded,
      Duration? averageSyncTime,
      DateTime? firstSyncAt,
      DateTime? lastSyncAt});
}

/// @nodoc
class _$SyncStatisticsCopyWithImpl<$Res, $Val extends SyncStatistics>
    implements $SyncStatisticsCopyWith<$Res> {
  _$SyncStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOperations = null,
    Object? successfulOperations = null,
    Object? failedOperations = null,
    Object? conflictOperations = null,
    Object? bytesUploaded = null,
    Object? bytesDownloaded = null,
    Object? averageSyncTime = freezed,
    Object? firstSyncAt = freezed,
    Object? lastSyncAt = freezed,
  }) {
    return _then(_value.copyWith(
      totalOperations: null == totalOperations
          ? _value.totalOperations
          : totalOperations // ignore: cast_nullable_to_non_nullable
              as int,
      successfulOperations: null == successfulOperations
          ? _value.successfulOperations
          : successfulOperations // ignore: cast_nullable_to_non_nullable
              as int,
      failedOperations: null == failedOperations
          ? _value.failedOperations
          : failedOperations // ignore: cast_nullable_to_non_nullable
              as int,
      conflictOperations: null == conflictOperations
          ? _value.conflictOperations
          : conflictOperations // ignore: cast_nullable_to_non_nullable
              as int,
      bytesUploaded: null == bytesUploaded
          ? _value.bytesUploaded
          : bytesUploaded // ignore: cast_nullable_to_non_nullable
              as int,
      bytesDownloaded: null == bytesDownloaded
          ? _value.bytesDownloaded
          : bytesDownloaded // ignore: cast_nullable_to_non_nullable
              as int,
      averageSyncTime: freezed == averageSyncTime
          ? _value.averageSyncTime
          : averageSyncTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      firstSyncAt: freezed == firstSyncAt
          ? _value.firstSyncAt
          : firstSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSyncAt: freezed == lastSyncAt
          ? _value.lastSyncAt
          : lastSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncStatisticsImplCopyWith<$Res>
    implements $SyncStatisticsCopyWith<$Res> {
  factory _$$SyncStatisticsImplCopyWith(_$SyncStatisticsImpl value,
          $Res Function(_$SyncStatisticsImpl) then) =
      __$$SyncStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalOperations,
      int successfulOperations,
      int failedOperations,
      int conflictOperations,
      int bytesUploaded,
      int bytesDownloaded,
      Duration? averageSyncTime,
      DateTime? firstSyncAt,
      DateTime? lastSyncAt});
}

/// @nodoc
class __$$SyncStatisticsImplCopyWithImpl<$Res>
    extends _$SyncStatisticsCopyWithImpl<$Res, _$SyncStatisticsImpl>
    implements _$$SyncStatisticsImplCopyWith<$Res> {
  __$$SyncStatisticsImplCopyWithImpl(
      _$SyncStatisticsImpl _value, $Res Function(_$SyncStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOperations = null,
    Object? successfulOperations = null,
    Object? failedOperations = null,
    Object? conflictOperations = null,
    Object? bytesUploaded = null,
    Object? bytesDownloaded = null,
    Object? averageSyncTime = freezed,
    Object? firstSyncAt = freezed,
    Object? lastSyncAt = freezed,
  }) {
    return _then(_$SyncStatisticsImpl(
      totalOperations: null == totalOperations
          ? _value.totalOperations
          : totalOperations // ignore: cast_nullable_to_non_nullable
              as int,
      successfulOperations: null == successfulOperations
          ? _value.successfulOperations
          : successfulOperations // ignore: cast_nullable_to_non_nullable
              as int,
      failedOperations: null == failedOperations
          ? _value.failedOperations
          : failedOperations // ignore: cast_nullable_to_non_nullable
              as int,
      conflictOperations: null == conflictOperations
          ? _value.conflictOperations
          : conflictOperations // ignore: cast_nullable_to_non_nullable
              as int,
      bytesUploaded: null == bytesUploaded
          ? _value.bytesUploaded
          : bytesUploaded // ignore: cast_nullable_to_non_nullable
              as int,
      bytesDownloaded: null == bytesDownloaded
          ? _value.bytesDownloaded
          : bytesDownloaded // ignore: cast_nullable_to_non_nullable
              as int,
      averageSyncTime: freezed == averageSyncTime
          ? _value.averageSyncTime
          : averageSyncTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      firstSyncAt: freezed == firstSyncAt
          ? _value.firstSyncAt
          : firstSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSyncAt: freezed == lastSyncAt
          ? _value.lastSyncAt
          : lastSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncStatisticsImpl implements _SyncStatistics {
  const _$SyncStatisticsImpl(
      {this.totalOperations = 0,
      this.successfulOperations = 0,
      this.failedOperations = 0,
      this.conflictOperations = 0,
      this.bytesUploaded = 0,
      this.bytesDownloaded = 0,
      this.averageSyncTime,
      this.firstSyncAt,
      this.lastSyncAt});

  factory _$SyncStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncStatisticsImplFromJson(json);

  @override
  @JsonKey()
  final int totalOperations;
  @override
  @JsonKey()
  final int successfulOperations;
  @override
  @JsonKey()
  final int failedOperations;
  @override
  @JsonKey()
  final int conflictOperations;
  @override
  @JsonKey()
  final int bytesUploaded;
  @override
  @JsonKey()
  final int bytesDownloaded;
  @override
  final Duration? averageSyncTime;
  @override
  final DateTime? firstSyncAt;
  @override
  final DateTime? lastSyncAt;

  @override
  String toString() {
    return 'SyncStatistics(totalOperations: $totalOperations, successfulOperations: $successfulOperations, failedOperations: $failedOperations, conflictOperations: $conflictOperations, bytesUploaded: $bytesUploaded, bytesDownloaded: $bytesDownloaded, averageSyncTime: $averageSyncTime, firstSyncAt: $firstSyncAt, lastSyncAt: $lastSyncAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStatisticsImpl &&
            (identical(other.totalOperations, totalOperations) ||
                other.totalOperations == totalOperations) &&
            (identical(other.successfulOperations, successfulOperations) ||
                other.successfulOperations == successfulOperations) &&
            (identical(other.failedOperations, failedOperations) ||
                other.failedOperations == failedOperations) &&
            (identical(other.conflictOperations, conflictOperations) ||
                other.conflictOperations == conflictOperations) &&
            (identical(other.bytesUploaded, bytesUploaded) ||
                other.bytesUploaded == bytesUploaded) &&
            (identical(other.bytesDownloaded, bytesDownloaded) ||
                other.bytesDownloaded == bytesDownloaded) &&
            (identical(other.averageSyncTime, averageSyncTime) ||
                other.averageSyncTime == averageSyncTime) &&
            (identical(other.firstSyncAt, firstSyncAt) ||
                other.firstSyncAt == firstSyncAt) &&
            (identical(other.lastSyncAt, lastSyncAt) ||
                other.lastSyncAt == lastSyncAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalOperations,
      successfulOperations,
      failedOperations,
      conflictOperations,
      bytesUploaded,
      bytesDownloaded,
      averageSyncTime,
      firstSyncAt,
      lastSyncAt);

  /// Create a copy of SyncStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStatisticsImplCopyWith<_$SyncStatisticsImpl> get copyWith =>
      __$$SyncStatisticsImplCopyWithImpl<_$SyncStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncStatisticsImplToJson(
      this,
    );
  }
}

abstract class _SyncStatistics implements SyncStatistics {
  const factory _SyncStatistics(
      {final int totalOperations,
      final int successfulOperations,
      final int failedOperations,
      final int conflictOperations,
      final int bytesUploaded,
      final int bytesDownloaded,
      final Duration? averageSyncTime,
      final DateTime? firstSyncAt,
      final DateTime? lastSyncAt}) = _$SyncStatisticsImpl;

  factory _SyncStatistics.fromJson(Map<String, dynamic> json) =
      _$SyncStatisticsImpl.fromJson;

  @override
  int get totalOperations;
  @override
  int get successfulOperations;
  @override
  int get failedOperations;
  @override
  int get conflictOperations;
  @override
  int get bytesUploaded;
  @override
  int get bytesDownloaded;
  @override
  Duration? get averageSyncTime;
  @override
  DateTime? get firstSyncAt;
  @override
  DateTime? get lastSyncAt;

  /// Create a copy of SyncStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncStatisticsImplCopyWith<_$SyncStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NetworkStatus _$NetworkStatusFromJson(Map<String, dynamic> json) {
  return _NetworkStatus.fromJson(json);
}

/// @nodoc
mixin _$NetworkStatus {
  bool get isConnected => throw _privateConstructorUsedError;
  NetworkType get type => throw _privateConstructorUsedError;
  bool get isWiFi => throw _privateConstructorUsedError;
  bool get isMetered => throw _privateConstructorUsedError;
  String? get connectionQuality => throw _privateConstructorUsedError;

  /// Serializes this NetworkStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NetworkStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NetworkStatusCopyWith<NetworkStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkStatusCopyWith<$Res> {
  factory $NetworkStatusCopyWith(
          NetworkStatus value, $Res Function(NetworkStatus) then) =
      _$NetworkStatusCopyWithImpl<$Res, NetworkStatus>;
  @useResult
  $Res call(
      {bool isConnected,
      NetworkType type,
      bool isWiFi,
      bool isMetered,
      String? connectionQuality});
}

/// @nodoc
class _$NetworkStatusCopyWithImpl<$Res, $Val extends NetworkStatus>
    implements $NetworkStatusCopyWith<$Res> {
  _$NetworkStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NetworkStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? type = null,
    Object? isWiFi = null,
    Object? isMetered = null,
    Object? connectionQuality = freezed,
  }) {
    return _then(_value.copyWith(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      isWiFi: null == isWiFi
          ? _value.isWiFi
          : isWiFi // ignore: cast_nullable_to_non_nullable
              as bool,
      isMetered: null == isMetered
          ? _value.isMetered
          : isMetered // ignore: cast_nullable_to_non_nullable
              as bool,
      connectionQuality: freezed == connectionQuality
          ? _value.connectionQuality
          : connectionQuality // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkStatusImplCopyWith<$Res>
    implements $NetworkStatusCopyWith<$Res> {
  factory _$$NetworkStatusImplCopyWith(
          _$NetworkStatusImpl value, $Res Function(_$NetworkStatusImpl) then) =
      __$$NetworkStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isConnected,
      NetworkType type,
      bool isWiFi,
      bool isMetered,
      String? connectionQuality});
}

/// @nodoc
class __$$NetworkStatusImplCopyWithImpl<$Res>
    extends _$NetworkStatusCopyWithImpl<$Res, _$NetworkStatusImpl>
    implements _$$NetworkStatusImplCopyWith<$Res> {
  __$$NetworkStatusImplCopyWithImpl(
      _$NetworkStatusImpl _value, $Res Function(_$NetworkStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of NetworkStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? type = null,
    Object? isWiFi = null,
    Object? isMetered = null,
    Object? connectionQuality = freezed,
  }) {
    return _then(_$NetworkStatusImpl(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      isWiFi: null == isWiFi
          ? _value.isWiFi
          : isWiFi // ignore: cast_nullable_to_non_nullable
              as bool,
      isMetered: null == isMetered
          ? _value.isMetered
          : isMetered // ignore: cast_nullable_to_non_nullable
              as bool,
      connectionQuality: freezed == connectionQuality
          ? _value.connectionQuality
          : connectionQuality // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NetworkStatusImpl implements _NetworkStatus {
  const _$NetworkStatusImpl(
      {this.isConnected = false,
      this.type = NetworkType.unknown,
      this.isWiFi = false,
      this.isMetered = false,
      this.connectionQuality});

  factory _$NetworkStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$NetworkStatusImplFromJson(json);

  @override
  @JsonKey()
  final bool isConnected;
  @override
  @JsonKey()
  final NetworkType type;
  @override
  @JsonKey()
  final bool isWiFi;
  @override
  @JsonKey()
  final bool isMetered;
  @override
  final String? connectionQuality;

  @override
  String toString() {
    return 'NetworkStatus(isConnected: $isConnected, type: $type, isWiFi: $isWiFi, isMetered: $isMetered, connectionQuality: $connectionQuality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkStatusImpl &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isWiFi, isWiFi) || other.isWiFi == isWiFi) &&
            (identical(other.isMetered, isMetered) ||
                other.isMetered == isMetered) &&
            (identical(other.connectionQuality, connectionQuality) ||
                other.connectionQuality == connectionQuality));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, isConnected, type, isWiFi, isMetered, connectionQuality);

  /// Create a copy of NetworkStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkStatusImplCopyWith<_$NetworkStatusImpl> get copyWith =>
      __$$NetworkStatusImplCopyWithImpl<_$NetworkStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NetworkStatusImplToJson(
      this,
    );
  }
}

abstract class _NetworkStatus implements NetworkStatus {
  const factory _NetworkStatus(
      {final bool isConnected,
      final NetworkType type,
      final bool isWiFi,
      final bool isMetered,
      final String? connectionQuality}) = _$NetworkStatusImpl;

  factory _NetworkStatus.fromJson(Map<String, dynamic> json) =
      _$NetworkStatusImpl.fromJson;

  @override
  bool get isConnected;
  @override
  NetworkType get type;
  @override
  bool get isWiFi;
  @override
  bool get isMetered;
  @override
  String? get connectionQuality;

  /// Create a copy of NetworkStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkStatusImplCopyWith<_$NetworkStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
