// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cloud_hrv_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CloudHrvDocument _$CloudHrvDocumentFromJson(Map<String, dynamic> json) {
  return _CloudHrvDocument.fromJson(json);
}

/// @nodoc
mixin _$CloudHrvDocument {
  String get id => throw _privateConstructorUsedError;
  EncryptedData get encryptedHrvData => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get timestamp => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this CloudHrvDocument to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CloudHrvDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CloudHrvDocumentCopyWith<CloudHrvDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloudHrvDocumentCopyWith<$Res> {
  factory $CloudHrvDocumentCopyWith(
          CloudHrvDocument value, $Res Function(CloudHrvDocument) then) =
      _$CloudHrvDocumentCopyWithImpl<$Res, CloudHrvDocument>;
  @useResult
  $Res call(
      {String id,
      EncryptedData encryptedHrvData,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime timestamp,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime updatedAt,
      String userId,
      int version,
      String? deviceId,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$CloudHrvDocumentCopyWithImpl<$Res, $Val extends CloudHrvDocument>
    implements $CloudHrvDocumentCopyWith<$Res> {
  _$CloudHrvDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CloudHrvDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? encryptedHrvData = null,
    Object? timestamp = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
    Object? version = null,
    Object? deviceId = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      encryptedHrvData: null == encryptedHrvData
          ? _value.encryptedHrvData
          : encryptedHrvData // ignore: cast_nullable_to_non_nullable
              as EncryptedData,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CloudHrvDocumentImplCopyWith<$Res>
    implements $CloudHrvDocumentCopyWith<$Res> {
  factory _$$CloudHrvDocumentImplCopyWith(_$CloudHrvDocumentImpl value,
          $Res Function(_$CloudHrvDocumentImpl) then) =
      __$$CloudHrvDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      EncryptedData encryptedHrvData,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime timestamp,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime updatedAt,
      String userId,
      int version,
      String? deviceId,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$CloudHrvDocumentImplCopyWithImpl<$Res>
    extends _$CloudHrvDocumentCopyWithImpl<$Res, _$CloudHrvDocumentImpl>
    implements _$$CloudHrvDocumentImplCopyWith<$Res> {
  __$$CloudHrvDocumentImplCopyWithImpl(_$CloudHrvDocumentImpl _value,
      $Res Function(_$CloudHrvDocumentImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudHrvDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? encryptedHrvData = null,
    Object? timestamp = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
    Object? version = null,
    Object? deviceId = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$CloudHrvDocumentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      encryptedHrvData: null == encryptedHrvData
          ? _value.encryptedHrvData
          : encryptedHrvData // ignore: cast_nullable_to_non_nullable
              as EncryptedData,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CloudHrvDocumentImpl implements _CloudHrvDocument {
  const _$CloudHrvDocumentImpl(
      {required this.id,
      required this.encryptedHrvData,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.timestamp,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.updatedAt,
      required this.userId,
      this.version = 1,
      this.deviceId,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$CloudHrvDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CloudHrvDocumentImplFromJson(json);

  @override
  final String id;
  @override
  final EncryptedData encryptedHrvData;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime timestamp;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime updatedAt;
  @override
  final String userId;
  @override
  @JsonKey()
  final int version;
  @override
  final String? deviceId;
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
    return 'CloudHrvDocument(id: $id, encryptedHrvData: $encryptedHrvData, timestamp: $timestamp, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId, version: $version, deviceId: $deviceId, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CloudHrvDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.encryptedHrvData, encryptedHrvData) ||
                other.encryptedHrvData == encryptedHrvData) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      encryptedHrvData,
      timestamp,
      createdAt,
      updatedAt,
      userId,
      version,
      deviceId,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of CloudHrvDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CloudHrvDocumentImplCopyWith<_$CloudHrvDocumentImpl> get copyWith =>
      __$$CloudHrvDocumentImplCopyWithImpl<_$CloudHrvDocumentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CloudHrvDocumentImplToJson(
      this,
    );
  }
}

abstract class _CloudHrvDocument implements CloudHrvDocument {
  const factory _CloudHrvDocument(
      {required final String id,
      required final EncryptedData encryptedHrvData,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime timestamp,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime updatedAt,
      required final String userId,
      final int version,
      final String? deviceId,
      final Map<String, dynamic>? metadata}) = _$CloudHrvDocumentImpl;

  factory _CloudHrvDocument.fromJson(Map<String, dynamic> json) =
      _$CloudHrvDocumentImpl.fromJson;

  @override
  String get id;
  @override
  EncryptedData get encryptedHrvData;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get timestamp;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get updatedAt;
  @override
  String get userId;
  @override
  int get version;
  @override
  String? get deviceId;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of CloudHrvDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CloudHrvDocumentImplCopyWith<_$CloudHrvDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncConflict _$SyncConflictFromJson(Map<String, dynamic> json) {
  return _SyncConflict.fromJson(json);
}

/// @nodoc
mixin _$SyncConflict {
  String get entityId => throw _privateConstructorUsedError;
  String get entityType => throw _privateConstructorUsedError;
  DateTime get localTimestamp => throw _privateConstructorUsedError;
  DateTime get cloudTimestamp => throw _privateConstructorUsedError;
  Map<String, dynamic> get localData => throw _privateConstructorUsedError;
  Map<String, dynamic> get cloudData => throw _privateConstructorUsedError;
  ConflictResolutionStrategy get suggestedResolution =>
      throw _privateConstructorUsedError;
  String? get userChoice => throw _privateConstructorUsedError;

  /// Serializes this SyncConflict to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncConflictCopyWith<SyncConflict> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncConflictCopyWith<$Res> {
  factory $SyncConflictCopyWith(
          SyncConflict value, $Res Function(SyncConflict) then) =
      _$SyncConflictCopyWithImpl<$Res, SyncConflict>;
  @useResult
  $Res call(
      {String entityId,
      String entityType,
      DateTime localTimestamp,
      DateTime cloudTimestamp,
      Map<String, dynamic> localData,
      Map<String, dynamic> cloudData,
      ConflictResolutionStrategy suggestedResolution,
      String? userChoice});
}

/// @nodoc
class _$SyncConflictCopyWithImpl<$Res, $Val extends SyncConflict>
    implements $SyncConflictCopyWith<$Res> {
  _$SyncConflictCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entityId = null,
    Object? entityType = null,
    Object? localTimestamp = null,
    Object? cloudTimestamp = null,
    Object? localData = null,
    Object? cloudData = null,
    Object? suggestedResolution = null,
    Object? userChoice = freezed,
  }) {
    return _then(_value.copyWith(
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      localTimestamp: null == localTimestamp
          ? _value.localTimestamp
          : localTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cloudTimestamp: null == cloudTimestamp
          ? _value.cloudTimestamp
          : cloudTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      localData: null == localData
          ? _value.localData
          : localData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      cloudData: null == cloudData
          ? _value.cloudData
          : cloudData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      suggestedResolution: null == suggestedResolution
          ? _value.suggestedResolution
          : suggestedResolution // ignore: cast_nullable_to_non_nullable
              as ConflictResolutionStrategy,
      userChoice: freezed == userChoice
          ? _value.userChoice
          : userChoice // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncConflictImplCopyWith<$Res>
    implements $SyncConflictCopyWith<$Res> {
  factory _$$SyncConflictImplCopyWith(
          _$SyncConflictImpl value, $Res Function(_$SyncConflictImpl) then) =
      __$$SyncConflictImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String entityId,
      String entityType,
      DateTime localTimestamp,
      DateTime cloudTimestamp,
      Map<String, dynamic> localData,
      Map<String, dynamic> cloudData,
      ConflictResolutionStrategy suggestedResolution,
      String? userChoice});
}

/// @nodoc
class __$$SyncConflictImplCopyWithImpl<$Res>
    extends _$SyncConflictCopyWithImpl<$Res, _$SyncConflictImpl>
    implements _$$SyncConflictImplCopyWith<$Res> {
  __$$SyncConflictImplCopyWithImpl(
      _$SyncConflictImpl _value, $Res Function(_$SyncConflictImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entityId = null,
    Object? entityType = null,
    Object? localTimestamp = null,
    Object? cloudTimestamp = null,
    Object? localData = null,
    Object? cloudData = null,
    Object? suggestedResolution = null,
    Object? userChoice = freezed,
  }) {
    return _then(_$SyncConflictImpl(
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      localTimestamp: null == localTimestamp
          ? _value.localTimestamp
          : localTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cloudTimestamp: null == cloudTimestamp
          ? _value.cloudTimestamp
          : cloudTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      localData: null == localData
          ? _value._localData
          : localData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      cloudData: null == cloudData
          ? _value._cloudData
          : cloudData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      suggestedResolution: null == suggestedResolution
          ? _value.suggestedResolution
          : suggestedResolution // ignore: cast_nullable_to_non_nullable
              as ConflictResolutionStrategy,
      userChoice: freezed == userChoice
          ? _value.userChoice
          : userChoice // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncConflictImpl implements _SyncConflict {
  const _$SyncConflictImpl(
      {required this.entityId,
      required this.entityType,
      required this.localTimestamp,
      required this.cloudTimestamp,
      required final Map<String, dynamic> localData,
      required final Map<String, dynamic> cloudData,
      required this.suggestedResolution,
      this.userChoice})
      : _localData = localData,
        _cloudData = cloudData;

  factory _$SyncConflictImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncConflictImplFromJson(json);

  @override
  final String entityId;
  @override
  final String entityType;
  @override
  final DateTime localTimestamp;
  @override
  final DateTime cloudTimestamp;
  final Map<String, dynamic> _localData;
  @override
  Map<String, dynamic> get localData {
    if (_localData is EqualUnmodifiableMapView) return _localData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_localData);
  }

  final Map<String, dynamic> _cloudData;
  @override
  Map<String, dynamic> get cloudData {
    if (_cloudData is EqualUnmodifiableMapView) return _cloudData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cloudData);
  }

  @override
  final ConflictResolutionStrategy suggestedResolution;
  @override
  final String? userChoice;

  @override
  String toString() {
    return 'SyncConflict(entityId: $entityId, entityType: $entityType, localTimestamp: $localTimestamp, cloudTimestamp: $cloudTimestamp, localData: $localData, cloudData: $cloudData, suggestedResolution: $suggestedResolution, userChoice: $userChoice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncConflictImpl &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.localTimestamp, localTimestamp) ||
                other.localTimestamp == localTimestamp) &&
            (identical(other.cloudTimestamp, cloudTimestamp) ||
                other.cloudTimestamp == cloudTimestamp) &&
            const DeepCollectionEquality()
                .equals(other._localData, _localData) &&
            const DeepCollectionEquality()
                .equals(other._cloudData, _cloudData) &&
            (identical(other.suggestedResolution, suggestedResolution) ||
                other.suggestedResolution == suggestedResolution) &&
            (identical(other.userChoice, userChoice) ||
                other.userChoice == userChoice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      entityId,
      entityType,
      localTimestamp,
      cloudTimestamp,
      const DeepCollectionEquality().hash(_localData),
      const DeepCollectionEquality().hash(_cloudData),
      suggestedResolution,
      userChoice);

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncConflictImplCopyWith<_$SyncConflictImpl> get copyWith =>
      __$$SyncConflictImplCopyWithImpl<_$SyncConflictImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncConflictImplToJson(
      this,
    );
  }
}

abstract class _SyncConflict implements SyncConflict {
  const factory _SyncConflict(
      {required final String entityId,
      required final String entityType,
      required final DateTime localTimestamp,
      required final DateTime cloudTimestamp,
      required final Map<String, dynamic> localData,
      required final Map<String, dynamic> cloudData,
      required final ConflictResolutionStrategy suggestedResolution,
      final String? userChoice}) = _$SyncConflictImpl;

  factory _SyncConflict.fromJson(Map<String, dynamic> json) =
      _$SyncConflictImpl.fromJson;

  @override
  String get entityId;
  @override
  String get entityType;
  @override
  DateTime get localTimestamp;
  @override
  DateTime get cloudTimestamp;
  @override
  Map<String, dynamic> get localData;
  @override
  Map<String, dynamic> get cloudData;
  @override
  ConflictResolutionStrategy get suggestedResolution;
  @override
  String? get userChoice;

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncConflictImplCopyWith<_$SyncConflictImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncOperation _$SyncOperationFromJson(Map<String, dynamic> json) {
  return _SyncOperation.fromJson(json);
}

/// @nodoc
mixin _$SyncOperation {
  String get id => throw _privateConstructorUsedError;
  String get entityType => throw _privateConstructorUsedError;
  String get entityId => throw _privateConstructorUsedError;
  SyncAction get action => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  SyncStatus get status => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this SyncOperation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncOperationCopyWith<SyncOperation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncOperationCopyWith<$Res> {
  factory $SyncOperationCopyWith(
          SyncOperation value, $Res Function(SyncOperation) then) =
      _$SyncOperationCopyWithImpl<$Res, SyncOperation>;
  @useResult
  $Res call(
      {String id,
      String entityType,
      String entityId,
      SyncAction action,
      Map<String, dynamic> data,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime createdAt,
      int retryCount,
      SyncStatus status,
      String? error});
}

/// @nodoc
class _$SyncOperationCopyWithImpl<$Res, $Val extends SyncOperation>
    implements $SyncOperationCopyWith<$Res> {
  _$SyncOperationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? action = null,
    Object? data = null,
    Object? createdAt = null,
    Object? retryCount = null,
    Object? status = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as SyncAction,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncOperationImplCopyWith<$Res>
    implements $SyncOperationCopyWith<$Res> {
  factory _$$SyncOperationImplCopyWith(
          _$SyncOperationImpl value, $Res Function(_$SyncOperationImpl) then) =
      __$$SyncOperationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String entityType,
      String entityId,
      SyncAction action,
      Map<String, dynamic> data,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime createdAt,
      int retryCount,
      SyncStatus status,
      String? error});
}

/// @nodoc
class __$$SyncOperationImplCopyWithImpl<$Res>
    extends _$SyncOperationCopyWithImpl<$Res, _$SyncOperationImpl>
    implements _$$SyncOperationImplCopyWith<$Res> {
  __$$SyncOperationImplCopyWithImpl(
      _$SyncOperationImpl _value, $Res Function(_$SyncOperationImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? action = null,
    Object? data = null,
    Object? createdAt = null,
    Object? retryCount = null,
    Object? status = null,
    Object? error = freezed,
  }) {
    return _then(_$SyncOperationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as SyncAction,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncOperationImpl implements _SyncOperation {
  const _$SyncOperationImpl(
      {required this.id,
      required this.entityType,
      required this.entityId,
      required this.action,
      required final Map<String, dynamic> data,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.createdAt,
      this.retryCount = 0,
      this.status = SyncStatus.pending,
      this.error})
      : _data = data;

  factory _$SyncOperationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncOperationImplFromJson(json);

  @override
  final String id;
  @override
  final String entityType;
  @override
  final String entityId;
  @override
  final SyncAction action;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;
  @override
  @JsonKey()
  final int retryCount;
  @override
  @JsonKey()
  final SyncStatus status;
  @override
  final String? error;

  @override
  String toString() {
    return 'SyncOperation(id: $id, entityType: $entityType, entityId: $entityId, action: $action, data: $data, createdAt: $createdAt, retryCount: $retryCount, status: $status, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncOperationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.action, action) || other.action == action) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      entityType,
      entityId,
      action,
      const DeepCollectionEquality().hash(_data),
      createdAt,
      retryCount,
      status,
      error);

  /// Create a copy of SyncOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncOperationImplCopyWith<_$SyncOperationImpl> get copyWith =>
      __$$SyncOperationImplCopyWithImpl<_$SyncOperationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncOperationImplToJson(
      this,
    );
  }
}

abstract class _SyncOperation implements SyncOperation {
  const factory _SyncOperation(
      {required final String id,
      required final String entityType,
      required final String entityId,
      required final SyncAction action,
      required final Map<String, dynamic> data,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime createdAt,
      final int retryCount,
      final SyncStatus status,
      final String? error}) = _$SyncOperationImpl;

  factory _SyncOperation.fromJson(Map<String, dynamic> json) =
      _$SyncOperationImpl.fromJson;

  @override
  String get id;
  @override
  String get entityType;
  @override
  String get entityId;
  @override
  SyncAction get action;
  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get createdAt;
  @override
  int get retryCount;
  @override
  SyncStatus get status;
  @override
  String? get error;

  /// Create a copy of SyncOperation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncOperationImplCopyWith<_$SyncOperationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CloudUserProfile _$CloudUserProfileFromJson(Map<String, dynamic> json) {
  return _CloudUserProfile.fromJson(json);
}

/// @nodoc
mixin _$CloudUserProfile {
  String get userId => throw _privateConstructorUsedError;
  EncryptedData? get encryptedSettings => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get lastSyncAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get syncEnabled => throw _privateConstructorUsedError;
  List<String>? get deviceIds => throw _privateConstructorUsedError;
  Map<String, dynamic>? get preferences => throw _privateConstructorUsedError;

  /// Serializes this CloudUserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CloudUserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CloudUserProfileCopyWith<CloudUserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloudUserProfileCopyWith<$Res> {
  factory $CloudUserProfileCopyWith(
          CloudUserProfile value, $Res Function(CloudUserProfile) then) =
      _$CloudUserProfileCopyWithImpl<$Res, CloudUserProfile>;
  @useResult
  $Res call(
      {String userId,
      EncryptedData? encryptedSettings,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime lastSyncAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime updatedAt,
      bool syncEnabled,
      List<String>? deviceIds,
      Map<String, dynamic>? preferences});
}

/// @nodoc
class _$CloudUserProfileCopyWithImpl<$Res, $Val extends CloudUserProfile>
    implements $CloudUserProfileCopyWith<$Res> {
  _$CloudUserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CloudUserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? encryptedSettings = freezed,
    Object? lastSyncAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncEnabled = null,
    Object? deviceIds = freezed,
    Object? preferences = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      encryptedSettings: freezed == encryptedSettings
          ? _value.encryptedSettings
          : encryptedSettings // ignore: cast_nullable_to_non_nullable
              as EncryptedData?,
      lastSyncAt: null == lastSyncAt
          ? _value.lastSyncAt
          : lastSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncEnabled: null == syncEnabled
          ? _value.syncEnabled
          : syncEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceIds: freezed == deviceIds
          ? _value.deviceIds
          : deviceIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CloudUserProfileImplCopyWith<$Res>
    implements $CloudUserProfileCopyWith<$Res> {
  factory _$$CloudUserProfileImplCopyWith(_$CloudUserProfileImpl value,
          $Res Function(_$CloudUserProfileImpl) then) =
      __$$CloudUserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      EncryptedData? encryptedSettings,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime lastSyncAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime updatedAt,
      bool syncEnabled,
      List<String>? deviceIds,
      Map<String, dynamic>? preferences});
}

/// @nodoc
class __$$CloudUserProfileImplCopyWithImpl<$Res>
    extends _$CloudUserProfileCopyWithImpl<$Res, _$CloudUserProfileImpl>
    implements _$$CloudUserProfileImplCopyWith<$Res> {
  __$$CloudUserProfileImplCopyWithImpl(_$CloudUserProfileImpl _value,
      $Res Function(_$CloudUserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudUserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? encryptedSettings = freezed,
    Object? lastSyncAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncEnabled = null,
    Object? deviceIds = freezed,
    Object? preferences = freezed,
  }) {
    return _then(_$CloudUserProfileImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      encryptedSettings: freezed == encryptedSettings
          ? _value.encryptedSettings
          : encryptedSettings // ignore: cast_nullable_to_non_nullable
              as EncryptedData?,
      lastSyncAt: null == lastSyncAt
          ? _value.lastSyncAt
          : lastSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncEnabled: null == syncEnabled
          ? _value.syncEnabled
          : syncEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceIds: freezed == deviceIds
          ? _value._deviceIds
          : deviceIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      preferences: freezed == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CloudUserProfileImpl implements _CloudUserProfile {
  const _$CloudUserProfileImpl(
      {required this.userId,
      this.encryptedSettings,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.lastSyncAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.updatedAt,
      this.syncEnabled = true,
      final List<String>? deviceIds,
      final Map<String, dynamic>? preferences})
      : _deviceIds = deviceIds,
        _preferences = preferences;

  factory _$CloudUserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$CloudUserProfileImplFromJson(json);

  @override
  final String userId;
  @override
  final EncryptedData? encryptedSettings;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime lastSyncAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool syncEnabled;
  final List<String>? _deviceIds;
  @override
  List<String>? get deviceIds {
    final value = _deviceIds;
    if (value == null) return null;
    if (_deviceIds is EqualUnmodifiableListView) return _deviceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _preferences;
  @override
  Map<String, dynamic>? get preferences {
    final value = _preferences;
    if (value == null) return null;
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CloudUserProfile(userId: $userId, encryptedSettings: $encryptedSettings, lastSyncAt: $lastSyncAt, createdAt: $createdAt, updatedAt: $updatedAt, syncEnabled: $syncEnabled, deviceIds: $deviceIds, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CloudUserProfileImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.encryptedSettings, encryptedSettings) ||
                other.encryptedSettings == encryptedSettings) &&
            (identical(other.lastSyncAt, lastSyncAt) ||
                other.lastSyncAt == lastSyncAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncEnabled, syncEnabled) ||
                other.syncEnabled == syncEnabled) &&
            const DeepCollectionEquality()
                .equals(other._deviceIds, _deviceIds) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      encryptedSettings,
      lastSyncAt,
      createdAt,
      updatedAt,
      syncEnabled,
      const DeepCollectionEquality().hash(_deviceIds),
      const DeepCollectionEquality().hash(_preferences));

  /// Create a copy of CloudUserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CloudUserProfileImplCopyWith<_$CloudUserProfileImpl> get copyWith =>
      __$$CloudUserProfileImplCopyWithImpl<_$CloudUserProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CloudUserProfileImplToJson(
      this,
    );
  }
}

abstract class _CloudUserProfile implements CloudUserProfile {
  const factory _CloudUserProfile(
      {required final String userId,
      final EncryptedData? encryptedSettings,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime lastSyncAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime updatedAt,
      final bool syncEnabled,
      final List<String>? deviceIds,
      final Map<String, dynamic>? preferences}) = _$CloudUserProfileImpl;

  factory _CloudUserProfile.fromJson(Map<String, dynamic> json) =
      _$CloudUserProfileImpl.fromJson;

  @override
  String get userId;
  @override
  EncryptedData? get encryptedSettings;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get lastSyncAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get updatedAt;
  @override
  bool get syncEnabled;
  @override
  List<String>? get deviceIds;
  @override
  Map<String, dynamic>? get preferences;

  /// Create a copy of CloudUserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CloudUserProfileImplCopyWith<_$CloudUserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
