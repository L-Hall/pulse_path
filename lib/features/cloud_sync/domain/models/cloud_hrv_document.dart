import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/services/cloud_encryption_service.dart';

part 'cloud_hrv_document.freezed.dart';
part 'cloud_hrv_document.g.dart';

/// Firestore document structure for encrypted HRV readings
/// 
/// This model represents how HRV data is stored in Firestore with
/// client-side encryption ensuring zero-knowledge cloud storage
@freezed
class CloudHrvDocument with _$CloudHrvDocument {
  const factory CloudHrvDocument({
    required String id,
    required EncryptedData encryptedHrvData,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    required DateTime timestamp,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    required DateTime createdAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    required DateTime updatedAt,
    required String userId,
    @Default(1) int version,
    String? deviceId,
    Map<String, dynamic>? metadata,
  }) = _CloudHrvDocument;

  factory CloudHrvDocument.fromJson(Map<String, dynamic> json) =>
      _$CloudHrvDocumentFromJson(json);
}

/// Sync status enumeration for tracking sync state
enum SyncStatus {
  pending,
  syncing,
  synced,
  error,
  conflict,
}

/// Represents a sync conflict that needs resolution
@freezed
class SyncConflict with _$SyncConflict {
  const factory SyncConflict({
    required String entityId,
    required String entityType,
    required DateTime localTimestamp,
    required DateTime cloudTimestamp,
    required Map<String, dynamic> localData,
    required Map<String, dynamic> cloudData,
    required ConflictResolutionStrategy suggestedResolution,
    String? userChoice,
  }) = _SyncConflict;

  factory SyncConflict.fromJson(Map<String, dynamic> json) =>
      _$SyncConflictFromJson(json);
}

/// Strategies for resolving sync conflicts
enum ConflictResolutionStrategy {
  useLocal,
  useCloud,
  merge,
  askUser,
}

/// Sync operation metadata for tracking sync queue
@freezed
class SyncOperation with _$SyncOperation {
  const factory SyncOperation({
    required String id,
    required String entityType,
    required String entityId,
    required SyncAction action,
    required Map<String, dynamic> data,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    required DateTime createdAt,
    @Default(0) int retryCount,
    @Default(SyncStatus.pending) SyncStatus status,
    String? error,
  }) = _SyncOperation;

  factory SyncOperation.fromJson(Map<String, dynamic> json) =>
      _$SyncOperationFromJson(json);
}

/// Types of sync actions
enum SyncAction {
  create,
  update,
  delete,
}

/// Cloud user profile for sync preferences and settings
@freezed
class CloudUserProfile with _$CloudUserProfile {
  const factory CloudUserProfile({
    required String userId,
    EncryptedData? encryptedSettings,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    required DateTime lastSyncAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    required DateTime createdAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    required DateTime updatedAt,
    @Default(true) bool syncEnabled,
    List<String>? deviceIds,
    Map<String, dynamic>? preferences,
  }) = _CloudUserProfile;

  factory CloudUserProfile.fromJson(Map<String, dynamic> json) =>
      _$CloudUserProfileFromJson(json);
}

/// Helper functions for Firestore Timestamp conversion
DateTime _timestampFromJson(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  } else if (timestamp is String) {
    return DateTime.parse(timestamp);
  } else if (timestamp is int) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
  throw ArgumentError('Invalid timestamp format: $timestamp');
}

dynamic _timestampToJson(DateTime dateTime) => Timestamp.fromDate(dateTime);