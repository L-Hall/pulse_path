import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../dashboard/data/repositories/hrv_repository_interface.dart';
import '../../../dashboard/data/repositories/simple_hrv_repository.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../../shared/models/hrv_reading.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../services/cloud_encryption_service.dart';
import '../../domain/models/cloud_hrv_document.dart';
import '../../domain/models/sync_status.dart';

/// Exception for repository operations
class RepositoryException implements Exception {
  final String message;
  const RepositoryException(this.message);
  
  @override
  String toString() => 'RepositoryException: $message';
}

/// Cloud-enabled HRV repository with client-side encryption
/// 
/// Implements HrvRepositoryInterface while providing encrypted cloud sync
/// capabilities with fallback to offline-only mode when needed
class CloudSyncHrvRepository implements HrvRepositoryInterface {
  final FirebaseFirestore _firestore;
  final CloudEncryptionService _encryptionService;
  final AuthRepository _authRepository;
  final HrvRepositoryInterface _localRepository;
  
  CloudSyncHrvRepository({
    required FirebaseFirestore firestore,
    required CloudEncryptionService encryptionService,
    required AuthRepository authRepository,
    required HrvRepositoryInterface localRepository,
  })  : _firestore = firestore,
        _encryptionService = encryptionService,
        _authRepository = authRepository,
        _localRepository = localRepository;

  /// Collection reference for current user's HRV readings
  CollectionReference<Map<String, dynamic>> get _userHrvCollection {
    final user = _authRepository.currentUser;
    if (user == null) {
      throw const AuthException('User not authenticated');
    }
    return _firestore.collection('users').doc(user.uid).collection('hrv_readings');
  }

  @override
  Future<void> saveReading(HrvReading reading) async {
    try {
      // Always save to local repository first for offline-first approach
      await _localRepository.saveReading(reading);
      
      // Attempt cloud sync if user is authenticated
      final user = _authRepository.currentUser;
      if (user != null && !user.isAnonymous) {
        await _syncReadingToCloud(reading, user.uid, user.email ?? '');
      }
    } catch (e) {
      // If cloud sync fails, ensure local save succeeded
      throw RepositoryException('Failed to save HRV reading: $e');
    }
  }

  @override
  Future<HrvReading?> getLatestReading() async {
    try {
      final user = _authRepository.currentUser;
      
      // If user is authenticated and not anonymous, try cloud first
      if (user != null && !user.isAnonymous) {
        try {
          final cloudReading = await _getLatestFromCloud(user.uid, user.email ?? '');
          if (cloudReading != null) {
            return cloudReading;
          }
        } catch (e) {
          // Fall back to local if cloud fails
        }
      }
      
      // Fall back to local repository
      return await _localRepository.getLatestReading();
    } catch (e) {
      throw RepositoryException('Failed to get latest reading: $e');
    }
  }

  @override
  Future<List<HrvReading>> getTrendReadings({int days = 7}) async {
    try {
      final user = _authRepository.currentUser;
      
      // If user is authenticated, try to sync recent data from cloud
      if (user != null && !user.isAnonymous) {
        try {
          await _syncRecentFromCloud(user.uid, user.email ?? '', days);
        } catch (e) {
          // Continue with local data if cloud sync fails
        }
      }
      
      // Return from local repository (which now has synced data)
      return await _localRepository.getTrendReadings(days: days);
    } catch (e) {
      throw RepositoryException('Failed to get trend readings: $e');
    }
  }

  @override
  Future<DashboardStatistics> getStatistics({int days = 30}) async {
    try {
      final user = _authRepository.currentUser;
      
      // If user is authenticated, try to sync statistics period data
      if (user != null && !user.isAnonymous) {
        try {
          await _syncRecentFromCloud(user.uid, user.email ?? '', days);
        } catch (e) {
          // Continue with local data if cloud sync fails
        }
      }
      
      // Return statistics from local repository
      return await _localRepository.getStatistics(days: days);
    } catch (e) {
      throw RepositoryException('Failed to get statistics: $e');
    }
  }

  @override
  Future<void> addSampleData() async {
    // Sample data is only added locally, not synced to cloud
    await _localRepository.addSampleData();
  }

  /// Syncs a single HRV reading to the cloud with encryption
  Future<void> _syncReadingToCloud(HrvReading reading, String userId, String email) async {
    try {
      // Generate user-specific encryption key
      final userKey = _encryptionService.generateUserKey(userId, email);
      
      // Encrypt the HRV reading data
      final encryptedData = _encryptionService.encrypt(
        jsonEncode(reading.toJson()),
        userKey,
      );
      
      // Create cloud document
      final cloudDoc = CloudHrvDocument(
        id: reading.id,
        encryptedHrvData: encryptedData,
        timestamp: reading.timestamp,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: userId,
        version: 1,
      );
      
      // Save to Firestore
      await _userHrvCollection.doc(reading.id).set(cloudDoc.toJson());
      
      // Mark as synced in local repository
      final syncedReading = reading.copyWith(isSynced: true);
      await _localRepository.saveReading(syncedReading);
      
    } catch (e) {
      throw RepositoryException('Failed to sync reading to cloud: $e');
    }
  }

  /// Gets the latest reading from cloud with decryption
  Future<HrvReading?> _getLatestFromCloud(String userId, String email) async {
    try {
      final userKey = _encryptionService.generateUserKey(userId, email);
      
      final querySnapshot = await _userHrvCollection
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isEmpty) {
        return null;
      }
      
      final cloudDoc = CloudHrvDocument.fromJson(querySnapshot.docs.first.data());
      
      // Decrypt the HRV data
      final decryptedJson = _encryptionService.decrypt(
        cloudDoc.encryptedHrvData,
        userKey,
      );
      
      return HrvReading.fromJson(jsonDecode(decryptedJson));
    } catch (e) {
      throw RepositoryException('Failed to get latest reading from cloud: $e');
    }
  }

  /// Syncs recent readings from cloud to local storage
  Future<void> _syncRecentFromCloud(String userId, String email, int days) async {
    try {
      final userKey = _encryptionService.generateUserKey(userId, email);
      final cutoffDate = DateTime.now().subtract(Duration(days: days));
      
      final querySnapshot = await _userHrvCollection
          .where('timestamp', isGreaterThan: Timestamp.fromDate(cutoffDate))
          .orderBy('timestamp', descending: true)
          .get();
      
      // Decrypt and save each reading to local storage
      for (final doc in querySnapshot.docs) {
        try {
          final cloudDoc = CloudHrvDocument.fromJson(doc.data());
          
          // Decrypt the HRV data
          final decryptedJson = _encryptionService.decrypt(
            cloudDoc.encryptedHrvData,
            userKey,
          );
          
          final reading = HrvReading.fromJson(jsonDecode(decryptedJson));
          final syncedReading = reading.copyWith(isSynced: true);
          
          // Save to local repository
          await _localRepository.saveReading(syncedReading);
        } catch (e) {
          // Skip individual readings that fail to decrypt
          continue;
        }
      }
    } catch (e) {
      throw RepositoryException('Failed to sync recent readings from cloud: $e');
    }
  }

  /// Performs full bidirectional sync between local and cloud
  Future<AppSyncStatus> performFullSync() async {
    try {
      final user = _authRepository.currentUser;
      if (user == null || user.isAnonymous) {
        return const AppSyncStatus(
          state: SyncState.offline,
          error: 'User not authenticated for cloud sync',
        );
      }

      final userKey = _encryptionService.generateUserKey(user.uid, user.email ?? '');
      int pendingOperations = 0;
      int conflictCount = 0;

      // Get all unsynced local readings
      final localReadings = await _getUnsyncedLocalReadings();
      pendingOperations += localReadings.length;

      // Upload unsynced readings to cloud
      for (final reading in localReadings) {
        try {
          await _syncReadingToCloud(reading, user.uid, user.email ?? '');
          pendingOperations--;
        } catch (e) {
          // Count as conflict if upload fails
          conflictCount++;
        }
      }

      // Download recent cloud readings
      await _syncRecentFromCloud(user.uid, user.email ?? '', 30);

      return AppSyncStatus(
        state: conflictCount > 0 ? SyncState.error : SyncState.synced,
        pendingOperations: pendingOperations,
        conflictCount: conflictCount,
        lastSuccessfulSync: DateTime.now(),
        syncProgress: 1.0,
      );
    } catch (e) {
      return AppSyncStatus(
        state: SyncState.error,
        error: 'Sync failed: $e',
        lastSyncAttempt: DateTime.now(),
      );
    }
  }

  /// Gets all unsynced readings from local repository
  Future<List<HrvReading>> _getUnsyncedLocalReadings() async {
    // This would need to be implemented in the local repository interface
    // For now, return empty list
    return [];
  }

  /// Migrates anonymous user data to authenticated cloud storage
  Future<void> migrateAnonymousData(String newUserId, String email) async {
    try {
      // Get all local readings
      final localReadings = await _localRepository.getTrendReadings(days: 365);
      
      // Upload each reading to cloud
      for (final reading in localReadings) {
        await _syncReadingToCloud(reading, newUserId, email);
      }
    } catch (e) {
      throw RepositoryException('Failed to migrate anonymous data: $e');
    }
  }
}