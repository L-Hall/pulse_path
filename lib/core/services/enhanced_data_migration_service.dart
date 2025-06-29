import 'package:flutter/foundation.dart';
import '../../features/dashboard/data/repositories/hrv_repository_interface.dart';
import '../../features/dashboard/data/repositories/simple_hrv_repository.dart';
import '../../features/dashboard/data/repositories/database_hrv_repository.dart';
import '../security/database_key_manager.dart';

/// Enhanced data migration service with secure key management
/// 
/// Handles migration between repositories with proper encryption key setup
class EnhancedDataMigrationService {
  final DatabaseKeyManager _keyManager;
  
  EnhancedDataMigrationService(this._keyManager);

  /// Migrate data from SimpleHrvRepository to DatabaseHrvRepository with secure key setup
  Future<MigrationResult> migrateToSecureDatabase({
    required SimpleHrvRepository sourceRepository,
    required DatabaseHrvRepository targetRepository,
    bool preserveExistingData = true,
  }) async {
    final startTime = DateTime.now();
    
    try {
      if (kDebugMode) {
        print('🔄 Starting secure database migration...');
      }

      // Step 1: Ensure database encryption key is set up
      final encryptionKey = await _keyManager.getDatabaseKey();
      if (!_keyManager.isValidKey(encryptionKey)) {
        return MigrationResult.failure(
          'Invalid encryption key generated',
          duration: DateTime.now().difference(startTime),
        );
      }

      if (kDebugMode) {
        print('✅ Database encryption key validated');
      }

      // Step 2: Check existing data in target
      final targetStats = await targetRepository.getStatistics(days: 365);
      final hasTargetData = targetStats.totalReadings > 0;

      if (hasTargetData && !preserveExistingData) {
        await targetRepository.clearAllReadings();
        if (kDebugMode) {
          print('🗑️ Cleared existing target data');
        }
      }

      // Step 3: Get source data
      final sourceReadings = await sourceRepository.getTrendReadings(days: 365);
      final sourceStats = await sourceRepository.getStatistics(days: 365);

      if (kDebugMode) {
        print('📊 Source data: ${sourceStats.totalReadings} readings');
        print('📊 Target data: ${targetStats.totalReadings} readings');
      }

      // Step 4: Determine migration strategy
      if (sourceReadings.isEmpty) {
        // No source data, ensure target has sample data
        if (!hasTargetData) {
          await targetRepository.addSampleData();
          if (kDebugMode) {
            print('🎯 Added sample data to empty target database');
          }
        }
        
        return MigrationResult.success(
          migratedCount: 0,
          hadExistingData: hasTargetData,
          duration: DateTime.now().difference(startTime),
          message: 'No source data to migrate, target ready',
        );
      }

      // Step 5: Migrate readings
      int migratedCount = 0;
      int skippedCount = 0;
      final errors = <String>[];

      for (final reading in sourceReadings) {
        try {
          // Check if reading already exists in target (by ID)
          if (preserveExistingData) {
            final existingReadings = await targetRepository.getTrendReadings(days: 1);
            final alreadyExists = existingReadings.any((r) => r.id == reading.id);
            
            if (alreadyExists) {
              skippedCount++;
              continue;
            }
          }

          await targetRepository.saveReading(reading);
          migratedCount++;
          
          if (kDebugMode && migratedCount % 10 == 0) {
            print('📈 Migrated $migratedCount readings...');
          }
        } catch (e) {
          errors.add('Reading ${reading.id}: $e');
          if (kDebugMode) {
            print('❌ Error migrating reading ${reading.id}: $e');
          }
        }
      }

      // Step 6: Verify migration
      final finalTargetStats = await targetRepository.getStatistics(days: 365);
      final expectedTotal = preserveExistingData 
          ? targetStats.totalReadings + migratedCount
          : migratedCount;

      if (finalTargetStats.totalReadings != expectedTotal) {
        return MigrationResult.partial(
          migratedCount: migratedCount,
          skippedCount: skippedCount,
          errors: errors,
          duration: DateTime.now().difference(startTime),
          message: 'Migration completed but counts don\'t match expected',
        );
      }

      if (kDebugMode) {
        print('✅ Migration completed successfully!');
        print('📊 Final stats: ${finalTargetStats.totalReadings} total readings');
        print('⏱️ Duration: ${DateTime.now().difference(startTime).inMilliseconds}ms');
      }

      return MigrationResult.success(
        migratedCount: migratedCount,
        skippedCount: skippedCount,
        hadExistingData: hasTargetData,
        duration: DateTime.now().difference(startTime),
        message: 'Migration completed successfully',
      );

    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('💥 Migration failed: $e');
        print('Stack trace: $stackTrace');
      }
      
      return MigrationResult.failure(
        'Migration failed: $e',
        duration: DateTime.now().difference(startTime),
      );
    }
  }

  /// Check if migration is recommended
  Future<MigrationRecommendation> analyzeMigrationNeed({
    required HrvRepositoryInterface sourceRepository,
    required HrvRepositoryInterface targetRepository,
  }) async {
    try {
      final sourceStats = await sourceRepository.getStatistics(days: 365);
      final targetStats = await targetRepository.getStatistics(days: 365);
      
      // Get latest readings for comparison
      final sourceLatest = await sourceRepository.getLatestReading();
      final targetLatest = await targetRepository.getLatestReading();

      if (sourceStats.totalReadings == 0 && targetStats.totalReadings == 0) {
        return MigrationRecommendation(
          isRecommended: false,
          reason: 'Both repositories are empty',
          sourceStats: sourceStats,
          targetStats: targetStats,
          priority: MigrationPriority.none,
        );
      }

      if (sourceStats.totalReadings > 0 && targetStats.totalReadings == 0) {
        return MigrationRecommendation(
          isRecommended: true,
          reason: 'Source has data, target is empty - migration needed',
          sourceStats: sourceStats,
          targetStats: targetStats,
          priority: MigrationPriority.high,
        );
      }

      if (sourceStats.totalReadings == 0 && targetStats.totalReadings > 0) {
        return MigrationRecommendation(
          isRecommended: false,
          reason: 'Target already has data, source is empty',
          sourceStats: sourceStats,
          targetStats: targetStats,
          priority: MigrationPriority.none,
        );
      }

      // Both have data - check if source is newer
      if (sourceLatest != null && targetLatest != null) {
        if (sourceLatest.timestamp.isAfter(targetLatest.timestamp)) {
          return MigrationRecommendation(
            isRecommended: true,
            reason: 'Source has newer data than target',
            sourceStats: sourceStats,
            targetStats: targetStats,
            priority: MigrationPriority.medium,
          );
        }
      }

      return MigrationRecommendation(
        isRecommended: false,
        reason: 'Both repositories have data, no migration needed',
        sourceStats: sourceStats,
        targetStats: targetStats,
        priority: MigrationPriority.low,
      );

    } catch (e) {
      if (kDebugMode) {
        print('Error analyzing migration need: $e');
      }
      
      return MigrationRecommendation(
        isRecommended: false,
        reason: 'Error analyzing repositories: $e',
        sourceStats: const DashboardStatistics(
          totalReadings: 0,
          averageStress: 0,
          averageRecovery: 0,
          averageEnergy: 0,
          averageRmssd: 0.0,
          averageHeartRate: 0.0,
          streakDays: 0,
        ),
        targetStats: const DashboardStatistics(
          totalReadings: 0,
          averageStress: 0,
          averageRecovery: 0,
          averageEnergy: 0,
          averageRmssd: 0.0,
          averageHeartRate: 0.0,
          streakDays: 0,
        ),
        priority: MigrationPriority.none,
        error: e.toString(),
      );
    }
  }

  /// Initialize repository with sample data if empty
  Future<bool> initializeWithSampleDataIfEmpty(HrvRepositoryInterface repository) async {
    try {
      final stats = await repository.getStatistics(days: 1);
      if (stats.totalReadings == 0) {
        await repository.addSampleData();
        if (kDebugMode) {
          print('✅ Added sample data to empty repository');
        }
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error initializing repository with sample data: $e');
      }
      return false;
    }
  }

  /// Get detailed repository information for debugging
  Future<RepositoryInfo> getRepositoryInfo(HrvRepositoryInterface repository) async {
    try {
      final stats = await repository.getStatistics(days: 365);
      final latestReading = await repository.getLatestReading();
      final weekReadings = await repository.getTrendReadings(days: 7);
      
      return RepositoryInfo(
        type: repository.runtimeType.toString(),
        totalReadings: stats.totalReadings,
        averageStress: stats.averageStress,
        averageRecovery: stats.averageRecovery,
        averageEnergy: stats.averageEnergy,
        streakDays: stats.streakDays,
        hasLatestReading: latestReading != null,
        latestReadingDate: latestReading?.timestamp,
        weeklyReadingsCount: weekReadings.length,
        isHealthy: _isRepositoryHealthy(stats, latestReading),
      );
    } catch (e) {
      return RepositoryInfo(
        type: repository.runtimeType.toString(),
        totalReadings: 0,
        averageStress: 0,
        averageRecovery: 0,
        averageEnergy: 0,
        streakDays: 0,
        hasLatestReading: false,
        latestReadingDate: null,
        weeklyReadingsCount: 0,
        isHealthy: false,
        error: e.toString(),
      );
    }
  }

  bool _isRepositoryHealthy(DashboardStatistics stats, dynamic latestReading) {
    // Repository is healthy if it has data and reasonable values
    return stats.totalReadings > 0 &&
           stats.averageStress >= 0 && stats.averageStress <= 100 &&
           stats.averageRecovery >= 0 && stats.averageRecovery <= 100 &&
           stats.averageEnergy >= 0 && stats.averageEnergy <= 100 &&
           latestReading != null;
  }
}

/// Result of a migration operation
class MigrationResult {
  final bool isSuccessful;
  final bool isPartial;
  final int migratedCount;
  final int skippedCount;
  final bool hadExistingData;
  final Duration duration;
  final String message;
  final List<String> errors;

  const MigrationResult._({
    required this.isSuccessful,
    required this.isPartial,
    required this.migratedCount,
    required this.skippedCount,
    required this.hadExistingData,
    required this.duration,
    required this.message,
    required this.errors,
  });

  factory MigrationResult.success({
    required int migratedCount,
    int skippedCount = 0,
    bool hadExistingData = false,
    required Duration duration,
    required String message,
  }) {
    return MigrationResult._(
      isSuccessful: true,
      isPartial: false,
      migratedCount: migratedCount,
      skippedCount: skippedCount,
      hadExistingData: hadExistingData,
      duration: duration,
      message: message,
      errors: [],
    );
  }

  factory MigrationResult.partial({
    required int migratedCount,
    int skippedCount = 0,
    bool hadExistingData = false,
    required Duration duration,
    required String message,
    List<String> errors = const [],
  }) {
    return MigrationResult._(
      isSuccessful: false,
      isPartial: true,
      migratedCount: migratedCount,
      skippedCount: skippedCount,
      hadExistingData: hadExistingData,
      duration: duration,
      message: message,
      errors: errors,
    );
  }

  factory MigrationResult.failure(
    String message, {
    required Duration duration,
  }) {
    return MigrationResult._(
      isSuccessful: false,
      isPartial: false,
      migratedCount: 0,
      skippedCount: 0,
      hadExistingData: false,
      duration: duration,
      message: message,
      errors: [],
    );
  }

  @override
  String toString() {
    if (isSuccessful) {
      return 'MigrationResult.success(migrated: $migratedCount, skipped: $skippedCount, duration: ${duration.inMilliseconds}ms)';
    } else if (isPartial) {
      return 'MigrationResult.partial(migrated: $migratedCount, errors: ${errors.length}, duration: ${duration.inMilliseconds}ms)';
    } else {
      return 'MigrationResult.failure($message, duration: ${duration.inMilliseconds}ms)';
    }
  }
}

/// Migration recommendation analysis
class MigrationRecommendation {
  final bool isRecommended;
  final String reason;
  final DashboardStatistics sourceStats;
  final DashboardStatistics targetStats;
  final MigrationPriority priority;
  final String? error;

  const MigrationRecommendation({
    required this.isRecommended,
    required this.reason,
    required this.sourceStats,
    required this.targetStats,
    required this.priority,
    this.error,
  });

  @override
  String toString() {
    return 'MigrationRecommendation(recommended: $isRecommended, priority: $priority, reason: $reason)';
  }
}

enum MigrationPriority { none, low, medium, high }

/// Repository information for analysis
class RepositoryInfo {
  final String type;
  final int totalReadings;
  final int averageStress;
  final int averageRecovery;
  final int averageEnergy;
  final int streakDays;
  final bool hasLatestReading;
  final DateTime? latestReadingDate;
  final int weeklyReadingsCount;
  final bool isHealthy;
  final String? error;

  const RepositoryInfo({
    required this.type,
    required this.totalReadings,
    required this.averageStress,
    required this.averageRecovery,
    required this.averageEnergy,
    required this.streakDays,
    required this.hasLatestReading,
    required this.latestReadingDate,
    required this.weeklyReadingsCount,
    required this.isHealthy,
    this.error,
  });

  @override
  String toString() {
    return 'RepositoryInfo($type: ${totalReadings} readings, healthy: $isHealthy, latest: $latestReadingDate)';
  }
}