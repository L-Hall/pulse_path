import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_status.freezed.dart';
part 'sync_status.g.dart';

/// Represents the overall sync status of the application
@freezed
class AppSyncStatus with _$AppSyncStatus {
  const factory AppSyncStatus({
    @Default(SyncState.offline) SyncState state,
    @Default(0) int pendingOperations,
    @Default(0) int conflictCount,
    DateTime? lastSyncAttempt,
    DateTime? lastSuccessfulSync,
    String? error,
    @Default(0) double syncProgress,
  }) = _AppSyncStatus;

  factory AppSyncStatus.fromJson(Map<String, dynamic> json) =>
      _$AppSyncStatusFromJson(json);
}

/// Possible sync states
enum SyncState {
  offline,
  connecting,
  syncing,
  synced,
  error,
  paused,
}

/// Sync statistics for monitoring and debugging
@freezed
class SyncStatistics with _$SyncStatistics {
  const factory SyncStatistics({
    @Default(0) int totalOperations,
    @Default(0) int successfulOperations,
    @Default(0) int failedOperations,
    @Default(0) int conflictOperations,
    @Default(0) int bytesUploaded,
    @Default(0) int bytesDownloaded,
    Duration? averageSyncTime,
    DateTime? firstSyncAt,
    DateTime? lastSyncAt,
  }) = _SyncStatistics;

  factory SyncStatistics.fromJson(Map<String, dynamic> json) =>
      _$SyncStatisticsFromJson(json);
}

/// Network status for sync decision making
@freezed
class NetworkStatus with _$NetworkStatus {
  const factory NetworkStatus({
    @Default(false) bool isConnected,
    @Default(NetworkType.unknown) NetworkType type,
    @Default(false) bool isWiFi,
    @Default(false) bool isMetered,
    String? connectionQuality,
  }) = _NetworkStatus;

  factory NetworkStatus.fromJson(Map<String, dynamic> json) =>
      _$NetworkStatusFromJson(json);
}

/// Network connection types
enum NetworkType {
  wifi,
  cellular,
  ethernet,
  unknown,
}