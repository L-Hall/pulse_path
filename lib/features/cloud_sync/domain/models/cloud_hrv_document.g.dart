// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_hrv_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CloudHrvDocumentImpl _$$CloudHrvDocumentImplFromJson(
        Map<String, dynamic> json) =>
    _$CloudHrvDocumentImpl(
      id: json['id'] as String,
      encryptedHrvData: EncryptedData.fromJson(
          json['encryptedHrvData'] as Map<String, dynamic>),
      timestamp: _timestampFromJson(json['timestamp']),
      createdAt: _timestampFromJson(json['createdAt']),
      updatedAt: _timestampFromJson(json['updatedAt']),
      userId: json['userId'] as String,
      version: (json['version'] as num?)?.toInt() ?? 1,
      deviceId: json['deviceId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CloudHrvDocumentImplToJson(
        _$CloudHrvDocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'encryptedHrvData': instance.encryptedHrvData,
      'timestamp': _timestampToJson(instance.timestamp),
      'createdAt': _timestampToJson(instance.createdAt),
      'updatedAt': _timestampToJson(instance.updatedAt),
      'userId': instance.userId,
      'version': instance.version,
      'deviceId': instance.deviceId,
      'metadata': instance.metadata,
    };

_$SyncConflictImpl _$$SyncConflictImplFromJson(Map<String, dynamic> json) =>
    _$SyncConflictImpl(
      entityId: json['entityId'] as String,
      entityType: json['entityType'] as String,
      localTimestamp: DateTime.parse(json['localTimestamp'] as String),
      cloudTimestamp: DateTime.parse(json['cloudTimestamp'] as String),
      localData: json['localData'] as Map<String, dynamic>,
      cloudData: json['cloudData'] as Map<String, dynamic>,
      suggestedResolution: $enumDecode(
          _$ConflictResolutionStrategyEnumMap, json['suggestedResolution']),
      userChoice: json['userChoice'] as String?,
    );

Map<String, dynamic> _$$SyncConflictImplToJson(_$SyncConflictImpl instance) =>
    <String, dynamic>{
      'entityId': instance.entityId,
      'entityType': instance.entityType,
      'localTimestamp': instance.localTimestamp.toIso8601String(),
      'cloudTimestamp': instance.cloudTimestamp.toIso8601String(),
      'localData': instance.localData,
      'cloudData': instance.cloudData,
      'suggestedResolution':
          _$ConflictResolutionStrategyEnumMap[instance.suggestedResolution]!,
      'userChoice': instance.userChoice,
    };

const _$ConflictResolutionStrategyEnumMap = {
  ConflictResolutionStrategy.useLocal: 'useLocal',
  ConflictResolutionStrategy.useCloud: 'useCloud',
  ConflictResolutionStrategy.merge: 'merge',
  ConflictResolutionStrategy.askUser: 'askUser',
};

_$SyncOperationImpl _$$SyncOperationImplFromJson(Map<String, dynamic> json) =>
    _$SyncOperationImpl(
      id: json['id'] as String,
      entityType: json['entityType'] as String,
      entityId: json['entityId'] as String,
      action: $enumDecode(_$SyncActionEnumMap, json['action']),
      data: json['data'] as Map<String, dynamic>,
      createdAt: _timestampFromJson(json['createdAt']),
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      status: $enumDecodeNullable(_$SyncStatusEnumMap, json['status']) ??
          SyncStatus.pending,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$SyncOperationImplToJson(_$SyncOperationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entityType': instance.entityType,
      'entityId': instance.entityId,
      'action': _$SyncActionEnumMap[instance.action]!,
      'data': instance.data,
      'createdAt': _timestampToJson(instance.createdAt),
      'retryCount': instance.retryCount,
      'status': _$SyncStatusEnumMap[instance.status]!,
      'error': instance.error,
    };

const _$SyncActionEnumMap = {
  SyncAction.create: 'create',
  SyncAction.update: 'update',
  SyncAction.delete: 'delete',
};

const _$SyncStatusEnumMap = {
  SyncStatus.pending: 'pending',
  SyncStatus.syncing: 'syncing',
  SyncStatus.synced: 'synced',
  SyncStatus.error: 'error',
  SyncStatus.conflict: 'conflict',
};

_$CloudUserProfileImpl _$$CloudUserProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$CloudUserProfileImpl(
      userId: json['userId'] as String,
      encryptedSettings: json['encryptedSettings'] == null
          ? null
          : EncryptedData.fromJson(
              json['encryptedSettings'] as Map<String, dynamic>),
      lastSyncAt: _timestampFromJson(json['lastSyncAt']),
      createdAt: _timestampFromJson(json['createdAt']),
      updatedAt: _timestampFromJson(json['updatedAt']),
      syncEnabled: json['syncEnabled'] as bool? ?? true,
      deviceIds: (json['deviceIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferences: json['preferences'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CloudUserProfileImplToJson(
        _$CloudUserProfileImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'encryptedSettings': instance.encryptedSettings,
      'lastSyncAt': _timestampToJson(instance.lastSyncAt),
      'createdAt': _timestampToJson(instance.createdAt),
      'updatedAt': _timestampToJson(instance.updatedAt),
      'syncEnabled': instance.syncEnabled,
      'deviceIds': instance.deviceIds,
      'preferences': instance.preferences,
    };
