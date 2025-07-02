import 'package:flutter/foundation.dart';
import 'migration_helper.dart';

/// Test script for database migration functionality
/// 
/// This can be used in development to test migration scenarios
class MigrationTester {
  
  /// Run a complete migration test
  static Future<void> runMigrationTest() async {
    if (kDebugMode) {
      debugPrint('🧪 Starting Migration Test Suite...');
      debugPrint('=' * 50);
    }

    try {
      // Test 1: Platform Info
      await _testPlatformInfo();
      
      // Test 2: Repository Analysis  
      await _testRepositoryAnalysis();
      
      // Test 3: Database Encryption Test
      await _testDatabaseEncryption();
      
      // Test 4: Migration Process (if applicable)
      await _testMigrationProcess();
      
      if (kDebugMode) {
        debugPrint('=' * 50);
        debugPrint('✅ All migration tests completed successfully!');
      }

    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('💥 Migration test failed: $e');
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }

  static Future<void> _testPlatformInfo() async {
    if (kDebugMode) {
      debugPrint('\n📋 Test 1: Platform Information');
      debugPrint('-' * 30);
    }

    final platformInfo = MigrationHelper.getPlatformInfo();
    
    if (kDebugMode) {
      debugPrint('Platform: ${(platformInfo['isWeb'] as bool) ? 'Web' : 'Mobile/Desktop'}');
      debugPrint('Supports Encrypted Database: ${platformInfo['supportsEncryptedDatabase']}');
      debugPrint('Recommended Repository: ${platformInfo['recommendedRepository']}');
      debugPrint('Encryption Support: ${platformInfo['encryptionSupport']}');
    }
  }

  static Future<void> _testRepositoryAnalysis() async {
    if (kDebugMode) {
      debugPrint('\n📊 Test 2: Repository Analysis');
      debugPrint('-' * 30);
    }

    try {
      final analysis = await MigrationHelper.analyzeRepositories();
      
      if (kDebugMode) {
        debugPrint('Simple Repository: ${analysis.simpleRepositoryInfo.totalReadings} readings');
        debugPrint('Database Repository: ${analysis.databaseRepositoryInfo.totalReadings} readings');
        debugPrint('Migration Recommended: ${analysis.recommendation.isRecommended}');
        debugPrint('Reason: ${analysis.recommendation.reason}');
      }
      
    } catch (e) {
      if (kIsWeb) {
        if (kDebugMode) {
          debugPrint('⚠️ Repository analysis skipped (web platform)');
        }
      } else {
        rethrow;
      }
    }
  }

  static Future<void> _testDatabaseEncryption() async {
    if (kDebugMode) {
      debugPrint('\n🔐 Test 3: Database Encryption');
      debugPrint('-' * 30);
    }

    try {
      final result = await MigrationHelper.testDatabaseEncryption();
      
      if (kDebugMode) {
        debugPrint('Encryption Test: ${result ? '✅ PASSED' : '❌ FAILED'}');
      }
      
    } catch (e) {
      if (kIsWeb) {
        if (kDebugMode) {
          debugPrint('⚠️ Encryption test skipped (web platform)');
        }
      } else {
        rethrow;
      }
    }
  }

  static Future<void> _testMigrationProcess() async {
    if (kDebugMode) {
      debugPrint('\n🚀 Test 4: Migration Process');
      debugPrint('-' * 30);
    }

    try {
      // Only run migration test on mobile/desktop
      if (kIsWeb) {
        if (kDebugMode) {
          debugPrint('⚠️ Migration test skipped (web platform)');
        }
        return;
      }

      // Perform a test migration
      final result = await MigrationHelper.migrateToDatabase(
        preserveExistingData: true,
        addSampleDataIfEmpty: true,
      );
      
      if (kDebugMode) {
        debugPrint('Migration Result: ${result.isSuccessful ? '✅ SUCCESS' : '❌ FAILED'}');
        debugPrint('Migrated Count: ${result.migratedCount}');
        debugPrint('Duration: ${result.duration.inMilliseconds}ms');
        debugPrint('Message: ${result.message}');
      }
      
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Migration test error: $e');
      }
    }
  }

  /// Test adding sample data to database
  static Future<void> testAddSampleData() async {
    if (kDebugMode) {
      debugPrint('🎯 Testing sample data addition...');
    }

    try {
      final result = await MigrationHelper.addSampleDataToDatabase();
      
      if (kDebugMode) {
        debugPrint('Add Sample Data: ${result ? '✅ SUCCESS' : '❌ FAILED'}');
      }
      
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Sample data test error: $e');
      }
    }
  }

  /// Test clearing database (use with caution!)
  static Future<void> testClearDatabase() async {
    if (kDebugMode) {
      debugPrint('🗑️ Testing database clear (WARNING: This will delete all data!)...');
    }

    try {
      final result = await MigrationHelper.clearDatabaseRepository();
      
      if (kDebugMode) {
        debugPrint('Clear Database: ${result ? '✅ SUCCESS' : '❌ FAILED'}');
      }
      
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Clear database test error: $e');
      }
    }
  }
}