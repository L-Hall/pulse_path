import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection_container.dart';
import '../../data/services/cloud_sync_service.dart';
import '../../domain/models/sync_status.dart';

/// Provider for the CloudSyncService
final cloudSyncServiceProvider = Provider<CloudSyncService?>((ref) {
  try {
    return sl<CloudSyncService>();
  } catch (e) {
    // Return null if service is not available (e.g., on web)
    return null;
  }
});

/// Provider for sync status stream
final syncStatusProvider = StreamProvider<AppSyncStatus>((ref) {
  final syncService = ref.watch(cloudSyncServiceProvider);
  
  if (syncService == null) {
    // Return offline status if sync service is not available
    return Stream.value(const AppSyncStatus(state: SyncState.offline));
  }
  
  return syncService.syncStatusStream;
});

/// Provider for network status stream
final networkStatusProvider = StreamProvider<NetworkStatus>((ref) {
  final syncService = ref.watch(cloudSyncServiceProvider);
  
  if (syncService == null) {
    // Return offline network status if sync service is not available
    return Stream.value(const NetworkStatus(isConnected: false));
  }
  
  return syncService.networkStatusStream;
});

/// Provider for sync statistics
final syncStatisticsProvider = FutureProvider<SyncStatistics>((ref) async {
  final syncService = ref.watch(cloudSyncServiceProvider);
  
  if (syncService == null) {
    return const SyncStatistics();
  }
  
  return syncService.getSyncStatistics();
});

/// Provider for manual sync trigger
final syncTriggerProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final syncService = ref.read(cloudSyncServiceProvider);
    if (syncService != null) {
      await syncService.performSync(forceSync: true);
    }
  };
});

/// Provider for sync service initialization
final syncServiceInitProvider = FutureProvider<void>((ref) async {
  final syncService = ref.watch(cloudSyncServiceProvider);
  if (syncService != null) {
    await syncService.initialize();
  }
});

/// Provider to check if cloud sync is available
final cloudSyncAvailableProvider = Provider<bool>((ref) {
  return ref.watch(cloudSyncServiceProvider) != null;
});