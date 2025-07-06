import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection_container.dart';
import '../../../settings/presentation/providers/settings_providers.dart';
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

/// Provider that manages cloud sync state based on user preferences
final cloudSyncManagerProvider = StateNotifierProvider<CloudSyncManager, AsyncValue<void>>((ref) {
  return CloudSyncManager(ref);
});

/// State notifier that handles cloud sync coordination with settings
class CloudSyncManager extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;
  bool _isInitialized = false;

  CloudSyncManager(this._ref) : super(const AsyncValue.data(null)) {
    _initialize();
  }

  void _initialize() {
    if (_isInitialized) return;
    _isInitialized = true;

    // Watch for changes in cloud sync enabled setting
    _ref.listen(cloudSyncEnabledProvider, (previous, next) {
      if (previous != null && previous != next) {
        _handleSyncSettingChange(next);
      }
    });
  }

  /// Handle changes to the cloud sync setting
  Future<void> _handleSyncSettingChange(bool enabled) async {
    state = const AsyncValue.loading();
    
    try {
      final syncService = _ref.read(cloudSyncServiceProvider);
      if (syncService == null) {
        state = const AsyncValue.data(null);
        return;
      }

      if (enabled) {
        // User enabled cloud sync - trigger sync if authenticated
        await syncService.performSync(forceSync: true);
      } else {
        // User disabled cloud sync - stop background sync
        syncService.stopBackgroundSync();
      }
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Manually trigger sync if enabled in settings
  Future<void> triggerSync() async {
    final cloudSyncEnabled = _ref.read(cloudSyncEnabledProvider);
    if (!cloudSyncEnabled) return;

    state = const AsyncValue.loading();
    
    try {
      final syncService = _ref.read(cloudSyncServiceProvider);
      if (syncService != null) {
        await syncService.performSync(forceSync: true);
      }
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Get current sync status respecting user settings
  bool get isSyncEnabled {
    final cloudSyncEnabled = _ref.read(cloudSyncEnabledProvider);
    final syncAvailable = _ref.read(cloudSyncAvailableProvider);
    return cloudSyncEnabled && syncAvailable;
  }
}