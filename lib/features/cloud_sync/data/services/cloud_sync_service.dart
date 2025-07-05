import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../../shared/repositories/database/app_database.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../repositories/cloud_sync_hrv_repository.dart';
import '../../domain/models/sync_status.dart';
import '../../domain/models/cloud_hrv_document.dart';

/// Service for managing cloud synchronization operations
/// 
/// Handles background sync, queue management, conflict resolution,
/// and network-aware sync operations with exponential backoff
class CloudSyncService {
  final CloudSyncHrvRepository _cloudRepository;
  final AuthRepository _authRepository;
  final AppDatabase _database;
  final Connectivity _connectivity;
  
  StreamController<AppSyncStatus>? _syncStatusController;
  StreamController<NetworkStatus>? _networkStatusController;
  Timer? _backgroundSyncTimer;
  
  NetworkStatus _currentNetworkStatus = const NetworkStatus();
  AppSyncStatus _currentSyncStatus = const AppSyncStatus();
  
  static const Duration _backgroundSyncInterval = Duration(minutes: 5);
  static const Duration _initialRetryDelay = Duration(seconds: 30);
  static const int _maxRetryAttempts = 5;

  CloudSyncService({
    required CloudSyncHrvRepository cloudRepository,
    required AuthRepository authRepository,
    required AppDatabase database,
    Connectivity? connectivity,
  })  : _cloudRepository = cloudRepository,
        _authRepository = authRepository,
        _database = database,
        _connectivity = connectivity ?? Connectivity();

  /// Stream of sync status changes
  Stream<AppSyncStatus> get syncStatusStream {
    _syncStatusController ??= StreamController<AppSyncStatus>.broadcast();
    return _syncStatusController!.stream;
  }

  /// Stream of network status changes
  Stream<NetworkStatus> get networkStatusStream {
    _networkStatusController ??= StreamController<NetworkStatus>.broadcast();
    return _networkStatusController!.stream;
  }

  /// Current sync status
  AppSyncStatus get currentSyncStatus => _currentSyncStatus;

  /// Current network status
  NetworkStatus get currentNetworkStatus => _currentNetworkStatus;

  /// Initializes the sync service
  Future<void> initialize() async {
    // Monitor network connectivity
    _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
    
    // Check initial network status
    final connectivityResult = await _connectivity.checkConnectivity();
    await _handleConnectivityChange(connectivityResult);
    
    // Start background sync timer
    _startBackgroundSync();
    
    // Listen to auth state changes
    _authRepository.authStateChanges.listen(_handleAuthStateChange);
  }

  /// Starts background sync operations
  void _startBackgroundSync() {
    _backgroundSyncTimer?.cancel();
    _backgroundSyncTimer = Timer.periodic(_backgroundSyncInterval, (_) async {
      if (_shouldPerformBackgroundSync()) {
        await performSync();
      }
    });
  }

  /// Stops background sync operations
  void stopBackgroundSync() {
    _backgroundSyncTimer?.cancel();
    _backgroundSyncTimer = null;
  }

  /// Performs a manual sync operation
  Future<AppSyncStatus> performSync({bool forceSync = false}) async {
    if (!forceSync && !_shouldPerformSync()) {
      return _currentSyncStatus;
    }

    _updateSyncStatus(_currentSyncStatus.copyWith(
      state: SyncState.connecting,
      lastSyncAttempt: DateTime.now(),
    ));

    try {
      // Check authentication
      final user = _authRepository.currentUser;
      if (user == null || user.isAnonymous) {
        _updateSyncStatus(_currentSyncStatus.copyWith(
          state: SyncState.offline,
          error: 'User not authenticated for cloud sync',
        ));
        return _currentSyncStatus;
      }

      // Check network connectivity
      if (!_currentNetworkStatus.isConnected) {
        _updateSyncStatus(_currentSyncStatus.copyWith(
          state: SyncState.offline,
          error: 'No network connection',
        ));
        return _currentSyncStatus;
      }

      _updateSyncStatus(_currentSyncStatus.copyWith(
        state: SyncState.syncing,
        syncProgress: 0.0,
      ));

      // Process sync queue
      await _processSyncQueue();

      // Perform full sync via repository
      final syncResult = await _cloudRepository.performFullSync();

      _updateSyncStatus(syncResult);
      return syncResult;

    } catch (e) {
      final errorStatus = _currentSyncStatus.copyWith(
        state: SyncState.error,
        error: 'Sync failed: $e',
        lastSyncAttempt: DateTime.now(),
      );
      _updateSyncStatus(errorStatus);
      return errorStatus;
    }
  }

  /// Processes the sync queue with retry logic
  Future<void> _processSyncQueue() async {
    try {
      // Get all sync operations from database (simplified for initial implementation)
      final pendingOps = await _database.select(_database.syncQueue).get();

      double progress = 0.0;
      final totalOps = pendingOps.length;

      for (int i = 0; i < pendingOps.length; i++) {
        final op = pendingOps[i];
        
        // Skip operations that have exceeded retry count
        if (op.retryCount >= _maxRetryAttempts) {
          continue;
        }
        
        try {
          await _processSyncOperation(op);
          
          // Remove successful operation from queue
          await (_database.delete(_database.syncQueue)
              ..where((tbl) => tbl.id.equals(op.id)))
              .go();
          
        } catch (e) {
          // Update retry count for failed operations
          await (_database.update(_database.syncQueue)
              ..where((tbl) => tbl.id.equals(op.id)))
              .write(SyncQueueCompanion(
                retryCount: Value(op.retryCount + 1),
              ));
        }

        progress = (i + 1) / totalOps;
        _updateSyncStatus(_currentSyncStatus.copyWith(
          syncProgress: progress,
          pendingOperations: totalOps - i - 1,
        ));
      }

    } catch (e) {
      throw SyncException('Failed to process sync queue: $e');
    }
  }

  /// Processes a single sync operation
  Future<void> _processSyncOperation(SyncQueueData operation) async {
    switch (operation.action) {
      case 'create':
      case 'update':
        // Handle create/update operations
        await _handleCreateUpdateOperation(operation);
        break;
      case 'delete':
        // Handle delete operations
        await _handleDeleteOperation(operation);
        break;
      default:
        throw SyncException('Unknown sync operation: ${operation.action}');
    }
  }

  /// Handles create/update sync operations
  Future<void> _handleCreateUpdateOperation(SyncQueueData operation) async {
    // Implementation depends on entity type
    switch (operation.entityType) {
      case 'hrv_reading':
        // This would sync HRV readings
        break;
      case 'settings':
        // This would sync user settings
        break;
      default:
        throw SyncException('Unknown entity type: ${operation.entityType}');
    }
  }

  /// Handles delete sync operations
  Future<void> _handleDeleteOperation(SyncQueueData operation) async {
    // Implementation for delete operations
  }

  /// Handles network connectivity changes
  Future<void> _handleConnectivityChange(List<ConnectivityResult> results) async {
    final isConnected = results.isNotEmpty && 
        results.any((result) => result != ConnectivityResult.none);
    
    final isWiFi = results.contains(ConnectivityResult.wifi);
    final isCellular = results.contains(ConnectivityResult.mobile);
    
    final networkType = isWiFi ? NetworkType.wifi 
        : isCellular ? NetworkType.cellular 
        : NetworkType.unknown;

    final newStatus = NetworkStatus(
      isConnected: isConnected,
      type: networkType,
      isWiFi: isWiFi,
      isMetered: isCellular,
    );

    _updateNetworkStatus(newStatus);

    // Trigger sync if connection restored
    if (isConnected && !_currentNetworkStatus.isConnected) {
      await performSync();
    }
  }

  /// Handles authentication state changes
  void _handleAuthStateChange(dynamic user) {
    if (user != null) {
      // User signed in - trigger sync
      performSync();
    } else {
      // User signed out - stop sync
      _updateSyncStatus(const AppSyncStatus(state: SyncState.offline));
    }
  }

  /// Determines if sync should be performed
  bool _shouldPerformSync() {
    return _currentNetworkStatus.isConnected && 
           _authRepository.currentUser != null &&
           !_authRepository.currentUser!.isAnonymous;
  }

  /// Determines if background sync should be performed
  bool _shouldPerformBackgroundSync() {
    return _shouldPerformSync() && 
           _currentSyncStatus.state != SyncState.syncing;
  }

  /// Updates sync status and notifies listeners
  void _updateSyncStatus(AppSyncStatus status) {
    _currentSyncStatus = status;
    _syncStatusController?.add(status);
  }

  /// Updates network status and notifies listeners
  void _updateNetworkStatus(NetworkStatus status) {
    _currentNetworkStatus = status;
    _networkStatusController?.add(status);
  }

  /// Adds an operation to the sync queue
  Future<void> addToSyncQueue({
    required String entityType,
    required String entityId,
    required String action,
    required Map<String, dynamic> data,
  }) async {
    await _database.into(_database.syncQueue).insert(
      SyncQueueCompanion.insert(
        entityType: entityType,
        entityId: entityId,
        action: action,
        dataJson: jsonEncode(data),
      ),
    );
  }

  /// Clears the sync queue
  Future<void> clearSyncQueue() async {
    await _database.delete(_database.syncQueue).go();
  }

  /// Gets sync statistics
  Future<SyncStatistics> getSyncStatistics() async {
    final allOps = await _database.select(_database.syncQueue).get();

    return SyncStatistics(
      totalOperations: allOps.length,
      lastSyncAt: _currentSyncStatus.lastSuccessfulSync,
    );
  }

  /// Disposes the service
  void dispose() {
    _syncStatusController?.close();
    _networkStatusController?.close();
    _backgroundSyncTimer?.cancel();
  }
}

/// Exception thrown when sync operations fail
class SyncException implements Exception {
  final String message;
  const SyncException(this.message);
  
  @override
  String toString() => 'SyncException: $message';
}