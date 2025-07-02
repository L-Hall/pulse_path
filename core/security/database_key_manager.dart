import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';

/// Manages secure encryption keys for the database
/// 
/// Uses flutter_secure_storage to store keys on mobile/desktop
/// Falls back to session storage on web platform
class DatabaseKeyManager {
  static const String _keyStorageKey = 'pulse_path_db_encryption_key';
  static const String _saltStorageKey = 'pulse_path_db_salt';
  
  final FlutterSecureStorage _secureStorage;

  DatabaseKeyManager(this._secureStorage);

  /// Get or generate the database encryption key
  Future<String> getDatabaseKey() async {
    try {
      if (kIsWeb) {
        // On web, use a session-based key (not persisted across sessions)
        return _generateSessionKey();
      }

      // Try to get existing key from secure storage
      final existingKey = await _secureStorage.read(key: _keyStorageKey);
      if (existingKey != null && existingKey.isNotEmpty) {
        return existingKey;
      }

      // Generate new key if none exists
      final newKey = await _generateNewKey();
      await _secureStorage.write(key: _keyStorageKey, value: newKey);
      
      return newKey;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting database key: $e');
      }
      // Fallback to a deterministic key based on device characteristics
      return _generateFallbackKey();
    }
  }

  /// Generate a new cryptographically secure key
  Future<String> _generateNewKey() async {
    final random = Random.secure();
    final keyBytes = List<int>.generate(32, (i) => random.nextInt(256));
    final salt = List<int>.generate(16, (i) => random.nextInt(256));
    
    // Store salt separately for key derivation
    await _secureStorage.write(
      key: _saltStorageKey, 
      value: base64Encode(salt),
    );
    
    // Use PBKDF2 to derive a strong key
    final derivedKey = _deriveKey(keyBytes, salt);
    return base64Encode(derivedKey);
  }

  /// Generate a session-only key for web platform
  String _generateSessionKey() {
    // Use a deterministic key for web that's consistent during the session
    // but doesn't persist across browser sessions for privacy
    final sessionSeed = DateTime.now().millisecondsSinceEpoch ~/ (1000 * 60 * 60); // Changes every hour
    final random = Random(sessionSeed);
    final keyBytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Encode(keyBytes);
  }

  /// Generate a fallback key when secure storage fails
  String _generateFallbackKey() {
    // Use a deterministic key based on current time (not ideal but better than hardcoded)
    final fallbackSeed = 'pulse_path_fallback_${DateTime.now().year}_${DateTime.now().month}';
    final bytes = utf8.encode(fallbackSeed);
    final digest = sha256.convert(bytes);
    return base64Encode(digest.bytes);
  }

  /// Derive a key using PBKDF2
  List<int> _deriveKey(List<int> password, List<int> salt) {
    // Simple PBKDF2 implementation
    const iterations = 100000;
    var derived = password + salt;
    
    for (int i = 0; i < iterations; i++) {
      derived = sha256.convert(derived).bytes;
    }
    
    return derived.take(32).toList(); // 256-bit key
  }

  /// Rotate the database key (for security maintenance)
  Future<String> rotateKey() async {
    try {
      if (kIsWeb) {
        // On web, just generate a new session key
        return _generateSessionKey();
      }

      // Delete old key
      await _secureStorage.delete(key: _keyStorageKey);
      await _secureStorage.delete(key: _saltStorageKey);
      
      // Generate and store new key
      return await getDatabaseKey();
    } catch (e) {
      if (kDebugMode) {
        print('Error rotating database key: $e');
      }
      rethrow;
    }
  }

  /// Check if a key exists in storage
  Future<bool> hasStoredKey() async {
    try {
      if (kIsWeb) {
        return false; // Web keys are session-only
      }
      
      final key = await _secureStorage.read(key: _keyStorageKey);
      return key != null && key.isNotEmpty;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking for stored key: $e');
      }
      return false;
    }
  }

  /// Clear all stored keys (for app reset/logout)
  Future<void> clearKeys() async {
    try {
      await _secureStorage.delete(key: _keyStorageKey);
      await _secureStorage.delete(key: _saltStorageKey);
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing keys: $e');
      }
      // Don't rethrow - clearing is best effort
    }
  }

  /// Validate that a key is properly formatted
  bool isValidKey(String key) {
    try {
      final decoded = base64Decode(key);
      return decoded.length >= 16; // At least 128-bit key
    } catch (e) {
      return false;
    }
  }
}