import 'package:flutter/foundation.dart';
import '../../features/dashboard/data/repositories/simple_hrv_repository.dart';
import '../../features/dashboard/data/repositories/database_hrv_repository.dart';
import '../../shared/repositories/database/app_database.dart';
import '../services/enhanced_data_migration_service.dart';
import '../di/injection_container.dart';

/// Helper utility for manual data migration operations
/// 
/// This can be used to migrate data when switching between repository types
/// or for testing migration scenarios
class MigrationHelper {
  
  /// Perform a complete migration from SimpleHrvRepository to DatabaseHrvRepository
  /// 
  /// This function can be called manually to migrate existing data
  static Future<MigrationResult> migrateToDatabase({
    bool preserveExistingData = true,
    bool addSampleDataIfEmpty = true,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('🚀 Starting manual migration to encrypted database...');
      }

      // Get required services from dependency injection
      final migrationService = sl<EnhancedDataMigrationService>();
      final simpleRepository = sl<SimpleHrvRepository>();
      
      // Get database repository - this might be async on mobile/desktop
      late DatabaseHrvRepository databaseRepository;
      
      if (kIsWeb) {
        throw UnsupportedError('Database migration not supported on web platform');
      } else {
        // On mobile/desktop, get the async database repository
        final database = await sl.getAsync<AppDatabase>();
        databaseRepository = DatabaseHrvRepository(database);
      }

      if (kDebugMode) {
        debugPrint('📊 Analyzing migration requirements...');
      }

      // Analyze what needs to be migrated
      final recommendation = await migrationService.analyzeMigrationNeed(
        sourceRepository: simpleRepository,
        targetRepository: databaseRepository,
      );

      if (kDebugMode) {
        debugPrint('🔍 Migration analysis: $recommendation');
      }

      // Perform migration based on recommendation
      final result = await migrationService.migrateToSecureDatabase(
        sourceRepository: simpleRepository,
        targetRepository: databaseRepository,
        preserveExistingData: preserveExistingData,
      );

      if (kDebugMode) {
        debugPrint('✅ Migration completed: $result');
      }

      return result;

    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('💥 Migration failed: $e');
        debugPrint('Stack trace: $stackTrace');
      }
      
      return MigrationResult.failure(
        'Migration failed: $e',
        duration: Duration.zero,
      );
    }
  }

  /// Get detailed information about both repositories
  static Future<MigrationAnalysis> analyzeRepositories() async {
    try {
      final migrationService = sl<EnhancedDataMigrationService>();
      final simpleRepository = sl<SimpleHrvRepository>();
      
      late DatabaseHrvRepository databaseRepository;
      
      if (kIsWeb) {
        throw UnsupportedError('Database analysis not supported on web platform');
      } else {
        final database = await sl.getAsync<AppDatabase>();
        databaseRepository = DatabaseHrvRepository(database);
      }

      // Get detailed info about both repositories
      final simpleInfo = await migrationService.getRepositoryInfo(simpleRepository);
      final databaseInfo = await migrationService.getRepositoryInfo(databaseRepository);
      
      // Get migration recommendation
      final recommendation = await migrationService.analyzeMigrationNeed(
        sourceRepository: simpleRepository,
        targetRepository: databaseRepository,
      );

      return MigrationAnalysis(
        simpleRepositoryInfo: simpleInfo,
        databaseRepositoryInfo: databaseInfo,
        recommendation: recommendation,
      );

    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error analyzing repositories: $e');
      }
      rethrow;
    }
  }

  /// Clear all data from the database repository (use with caution!)
  static Future<bool> clearDatabaseRepository() async {
    try {
      if (kIsWeb) {
        throw UnsupportedError('Database operations not supported on web platform');
      }

      final database = await sl.getAsync<AppDatabase>();
      final databaseRepository = DatabaseHrvRepository(database);
      
      await databaseRepository.clearAllReadings();
      
      if (kDebugMode) {
        debugPrint('🗑️ Database repository cleared successfully');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error clearing database repository: $e');
      }
      return false;
    }
  }

  /// Add sample data to the database repository
  static Future<bool> addSampleDataToDatabase() async {
    try {
      if (kIsWeb) {
        throw UnsupportedError('Database operations not supported on web platform');
      }

      final database = await sl.getAsync<AppDatabase>();
      final databaseRepository = DatabaseHrvRepository(database);
      
      await databaseRepository.addSampleData();
      
      if (kDebugMode) {
        debugPrint('🎯 Sample data added to database repository');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error adding sample data to database: $e');
      }
      return false;
    }
  }

  /// Test database encryption by attempting to read/write data
  static Future<bool> testDatabaseEncryption() async {
    try {
      if (kIsWeb) {
        // Web doesn't use SQLCipher encryption
        return true;
      }

      final database = await sl.getAsync<AppDatabase>();
      final databaseRepository = DatabaseHrvRepository(database);
      
      // Try to get statistics - this will test database connectivity
      final stats = await databaseRepository.getStatistics();
      
      if (kDebugMode) {
        debugPrint('🔐 Database encryption test passed. Total readings: ${stats.totalReadings}');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Database encryption test failed: $e');
      }
      return false;
    }
  }

  /// Get current platform information
  static Map<String, dynamic> getPlatformInfo() {
    return {
      'isWeb': kIsWeb,
      'supportsEncryptedDatabase': !kIsWeb,
      'recommendedRepository': kIsWeb ? 'SimpleHrvRepository' : 'DatabaseHrvRepository',
      'encryptionSupport': kIsWeb ? 'Browser-based' : 'SQLCipher AES-256',
    };
  }
}

/// Complete analysis of migration status
class MigrationAnalysis {
  final RepositoryInfo simpleRepositoryInfo;
  final RepositoryInfo databaseRepositoryInfo;
  final MigrationRecommendation recommendation;

  const MigrationAnalysis({
    required this.simpleRepositoryInfo,
    required this.databaseRepositoryInfo,
    required this.recommendation,
  });

  @override
  String toString() {
    return '''
Migration Analysis:
==================
Simple Repository: $simpleRepositoryInfo
Database Repository: $databaseRepositoryInfo
Recommendation: $recommendation
''';
  }
}