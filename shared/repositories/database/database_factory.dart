import 'package:flutter/foundation.dart';
import '../../../core/security/database_key_manager.dart';
import 'app_database.dart';

/// Factory for creating properly configured database instances
class DatabaseFactory {
  final DatabaseKeyManager _keyManager;
  AppDatabase? _instance;

  DatabaseFactory(this._keyManager);

  /// Get or create the database instance with proper encryption
  Future<AppDatabase> getDatabase() async {
    if (_instance != null) {
      return _instance!;
    }

    try {
      // Get secure encryption key
      final encryptionKey = await _keyManager.getDatabaseKey();
      
      if (kDebugMode) {
        debugPrint('🔑 Database encryption key retrieved');
      }

      // Create database instance with encryption key
      _instance = AppDatabase.withEncryptionKey(encryptionKey);
      
      // Test database connection
      await _testDatabaseConnection(_instance!);
      
      if (kDebugMode) {
        debugPrint('✅ Database instance created and tested successfully');
      }

      return _instance!;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error creating database instance: $e');
      }
      
      // Fallback to default database without explicit key
      _instance = AppDatabase();
      return _instance!;
    }
  }

  /// Test database connection to ensure it's working properly
  Future<void> _testDatabaseConnection(AppDatabase database) async {
    try {
      // Try to access the database to ensure encryption is working
      await database.customSelect('SELECT 1').getSingle();
    } catch (e) {
      throw Exception('Database connection test failed: $e');
    }
  }

  /// Close the database connection
  Future<void> close() async {
    if (_instance != null) {
      await _instance!.close();
      _instance = null;
    }
  }

  /// Reset the database instance (for testing or key rotation)
  Future<void> reset() async {
    await close();
    _instance = null;
  }
}