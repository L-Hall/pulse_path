// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSyncStatusImpl _$$AppSyncStatusImplFromJson(Map<String, dynamic> json) =>
    _$AppSyncStatusImpl(
      state: $enumDecodeNullable(_$SyncStateEnumMap, json['state']) ??
          SyncState.offline,
      pendingOperations: (json['pendingOperations'] as num?)?.toInt() ?? 0,
      conflictCount: (json['conflictCount'] as num?)?.toInt() ?? 0,
      lastSyncAttempt: json['lastSyncAttempt'] == null
          ? null
          : DateTime.parse(json['lastSyncAttempt'] as String),
      lastSuccessfulSync: json['lastSuccessfulSync'] == null
          ? null
          : DateTime.parse(json['lastSuccessfulSync'] as String),
      error: json['error'] as String?,
      syncProgress: (json['syncProgress'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$AppSyncStatusImplToJson(_$AppSyncStatusImpl instance) =>
    <String, dynamic>{
      'state': _$SyncStateEnumMap[instance.state]!,
      'pendingOperations': instance.pendingOperations,
      'conflictCount': instance.conflictCount,
      'lastSyncAttempt': instance.lastSyncAttempt?.toIso8601String(),
      'lastSuccessfulSync': instance.lastSuccessfulSync?.toIso8601String(),
      'error': instance.error,
      'syncProgress': instance.syncProgress,
    };

const _$SyncStateEnumMap = {
  SyncState.offline: 'offline',
  SyncState.connecting: 'connecting',
  SyncState.syncing: 'syncing',
  SyncState.synced: 'synced',
  SyncState.error: 'error',
  SyncState.paused: 'paused',
};

_$SyncStatisticsImpl _$$SyncStatisticsImplFromJson(Map<String, dynamic> json) =>
    _$SyncStatisticsImpl(
      totalOperations: (json['totalOperations'] as num?)?.toInt() ?? 0,
      successfulOperations:
          (json['successfulOperations'] as num?)?.toInt() ?? 0,
      failedOperations: (json['failedOperations'] as num?)?.toInt() ?? 0,
      conflictOperations: (json['conflictOperations'] as num?)?.toInt() ?? 0,
      bytesUploaded: (json['bytesUploaded'] as num?)?.toInt() ?? 0,
      bytesDownloaded: (json['bytesDownloaded'] as num?)?.toInt() ?? 0,
      averageSyncTime: json['averageSyncTime'] == null
          ? null
          : Duration(microseconds: (json['averageSyncTime'] as num).toInt()),
      firstSyncAt: json['firstSyncAt'] == null
          ? null
          : DateTime.parse(json['firstSyncAt'] as String),
      lastSyncAt: json['lastSyncAt'] == null
          ? null
          : DateTime.parse(json['lastSyncAt'] as String),
    );

Map<String, dynamic> _$$SyncStatisticsImplToJson(
        _$SyncStatisticsImpl instance) =>
    <String, dynamic>{
      'totalOperations': instance.totalOperations,
      'successfulOperations': instance.successfulOperations,
      'failedOperations': instance.failedOperations,
      'conflictOperations': instance.conflictOperations,
      'bytesUploaded': instance.bytesUploaded,
      'bytesDownloaded': instance.bytesDownloaded,
      'averageSyncTime': instance.averageSyncTime?.inMicroseconds,
      'firstSyncAt': instance.firstSyncAt?.toIso8601String(),
      'lastSyncAt': instance.lastSyncAt?.toIso8601String(),
    };

_$NetworkStatusImpl _$$NetworkStatusImplFromJson(Map<String, dynamic> json) =>
    _$NetworkStatusImpl(
      isConnected: json['isConnected'] as bool? ?? false,
      type: $enumDecodeNullable(_$NetworkTypeEnumMap, json['type']) ??
          NetworkType.unknown,
      isWiFi: json['isWiFi'] as bool? ?? false,
      isMetered: json['isMetered'] as bool? ?? false,
      connectionQuality: json['connectionQuality'] as String?,
    );

Map<String, dynamic> _$$NetworkStatusImplToJson(_$NetworkStatusImpl instance) =>
    <String, dynamic>{
      'isConnected': instance.isConnected,
      'type': _$NetworkTypeEnumMap[instance.type]!,
      'isWiFi': instance.isWiFi,
      'isMetered': instance.isMetered,
      'connectionQuality': instance.connectionQuality,
    };

const _$NetworkTypeEnumMap = {
  NetworkType.wifi: 'wifi',
  NetworkType.cellular: 'cellular',
  NetworkType.ethernet: 'ethernet',
  NetworkType.unknown: 'unknown',
};
