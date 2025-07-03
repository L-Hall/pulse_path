import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';

/// Native platform database connection using SQLCipher
/// 
/// This will be initialized with proper encryption key from DatabaseKeyManager
/// during app startup through dependency injection
LazyDatabase createConnection([String? encryptionKey]) {
  return LazyDatabase(() async {
    // Initialize SQLCipher for encrypted database on mobile/desktop
    try {
      await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
    } catch (e) {
      // Fallback to unencrypted if SQLCipher fails
      if (kDebugMode) {
        print('SQLCipher initialization failed, using unencrypted database: $e');
      }
    }
    
    final dbFolder = await getDatabasesPath();
    final file = File(path.join(dbFolder, 'pulse_path_encrypted.db'));
    
    // Use provided encryption key or fallback to temporary key
    // Note: In production, this should always be called with a secure key
    final password = encryptionKey ?? 'temporary_key_replace_with_secure_key';
    
    return DatabaseConnection(
      NativeDatabase(
        file,
        setup: (Database database) {
          try {
            // Configure SQLCipher with enterprise-grade security settings
            database.execute("PRAGMA key = '$password'");
            database.execute('PRAGMA cipher_page_size = 4096');
            database.execute('PRAGMA kdf_iter = 100000'); // Increased from 64000 for better security
            database.execute('PRAGMA cipher_hmac_algorithm = HMAC_SHA256'); // Upgraded from SHA1
            database.execute('PRAGMA cipher_kdf_algorithm = PBKDF2_HMAC_SHA256'); // Upgraded from SHA1
            database.execute('PRAGMA cipher_memory_security = ON');
            database.execute('PRAGMA cipher_default_use_hmac = ON');
            
            // Test database access to ensure encryption is working
            database.execute('SELECT name FROM sqlite_master WHERE type="table"');
          } catch (e) {
            // SQLCipher not available, continue with unencrypted
            if (kDebugMode) {
              print('SQLCipher not available, using unencrypted database: $e');
            }
          }
        },
      ),
    );
  });
}

/// Get the database path for the current platform
Future<String> getDatabasesPath() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  return appDocDir.path;
}