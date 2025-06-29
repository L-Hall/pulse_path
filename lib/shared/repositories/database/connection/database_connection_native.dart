import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';

/// Native platform database connection using SQLCipher
LazyDatabase createConnection() {
  return LazyDatabase(() async {
    // Initialize SQLCipher for encrypted database on mobile/desktop
    try {
      await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
    } catch (e) {
      // Fallback to unencrypted if SQLCipher fails
      print('SQLCipher initialization failed, using unencrypted database: $e');
    }
    
    final dbFolder = await getDatabasesPath();
    final file = File(path.join(dbFolder, 'pulse_path_encrypted.db'));
    
    // Get encryption key from DatabaseKeyManager (will be injected later)
    // For now, use a temporary key - this will be replaced with proper key management
    const password = 'temporary_key_replace_with_secure_key';
    
    return DatabaseConnection(
      NativeDatabase(
        file,
        setup: (Database database) {
          try {
            database.execute("PRAGMA key = '$password'");
            database.execute('PRAGMA cipher_page_size = 4096');
            database.execute('PRAGMA kdf_iter = 64000');
            database.execute('PRAGMA cipher_hmac_algorithm = HMAC_SHA1');
            database.execute('PRAGMA cipher_kdf_algorithm = PBKDF2_HMAC_SHA1');
          } catch (e) {
            // SQLCipher not available, continue with unencrypted
            print('SQLCipher not available, using unencrypted database: $e');
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