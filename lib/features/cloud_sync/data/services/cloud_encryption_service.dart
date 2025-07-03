import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

/// Service for client-side encryption of HRV data before cloud storage
/// 
/// Implements AES-GCM encryption with PBKDF2 key derivation to ensure
/// zero-knowledge cloud storage where Firebase never sees plaintext data
class CloudEncryptionService {
  static const int _keyLength = 32; // AES-256
  static const int _ivLength = 12; // GCM recommended IV length
  static const int _saltLength = 16;
  static const int _tagLength = 16;
  static const int _pbkdf2Iterations = 100000; // OWASP recommended minimum

  /// Encrypts data using AES-GCM with user-derived key
  /// 
  /// Returns base64 encoded encrypted data with embedded IV and salt
  EncryptedData encrypt(String plaintext, String userKey) {
    try {
      // Generate random salt and IV
      final salt = _generateRandomBytes(_saltLength);
      final iv = _generateRandomBytes(_ivLength);
      
      // Derive encryption key from user key using PBKDF2
      final derivedKey = _deriveKey(userKey, salt);
      
      // Initialize AES-GCM cipher
      final cipher = GCMBlockCipher(AESEngine());
      final params = AEADParameters(
        KeyParameter(derivedKey),
        _tagLength * 8, // tag length in bits
        iv,
        Uint8List(0), // empty additional data
      );
      
      cipher.init(true, params);
      
      // Encrypt the plaintext
      final plaintextBytes = utf8.encode(plaintext);
      final encryptedBytes = cipher.process(plaintextBytes);
      
      return EncryptedData(
        encryptedData: base64Encode(encryptedBytes),
        iv: base64Encode(iv),
        salt: base64Encode(salt),
      );
    } catch (e) {
      throw EncryptionException('Failed to encrypt data: $e');
    }
  }

  /// Decrypts AES-GCM encrypted data using user-derived key
  String decrypt(EncryptedData encryptedData, String userKey) {
    try {
      // Decode the encrypted components
      final encryptedBytes = base64Decode(encryptedData.encryptedData);
      final iv = base64Decode(encryptedData.iv);
      final salt = base64Decode(encryptedData.salt);
      
      // Derive the same encryption key
      final derivedKey = _deriveKey(userKey, salt);
      
      // Initialize AES-GCM cipher for decryption
      final cipher = GCMBlockCipher(AESEngine());
      final params = AEADParameters(
        KeyParameter(derivedKey),
        _tagLength * 8,
        iv,
        Uint8List(0), // empty additional data
      );
      
      cipher.init(false, params);
      
      // Decrypt and return as string
      final decryptedBytes = cipher.process(encryptedBytes);
      return utf8.decode(decryptedBytes);
    } catch (e) {
      throw EncryptionException('Failed to decrypt data: $e');
    }
  }

  /// Derives encryption key from user key using PBKDF2
  Uint8List _deriveKey(String userKey, Uint8List salt) {
    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
    pbkdf2.init(Pbkdf2Parameters(salt, _pbkdf2Iterations, _keyLength));
    
    return pbkdf2.process(utf8.encode(userKey));
  }

  /// Generates cryptographically secure random bytes
  Uint8List _generateRandomBytes(int length) {
    final random = Random.secure();
    final bytes = Uint8List(length);
    for (int i = 0; i < length; i++) {
      bytes[i] = random.nextInt(256);
    }
    return bytes;
  }

  /// Generates a user-specific encryption key from user credentials
  /// 
  /// This combines the user's UID with their email to create a deterministic
  /// but secure key that can be recreated on any device after sign-in
  String generateUserKey(String uid, String email) {
    final combined = '$uid:$email';
    final bytes = sha256.convert(utf8.encode(combined)).bytes;
    return base64Encode(bytes);
  }
}

/// Represents encrypted data with all necessary components for decryption
class EncryptedData {
  final String encryptedData;
  final String iv;
  final String salt;

  const EncryptedData({
    required this.encryptedData,
    required this.iv,
    required this.salt,
  });

  /// Convert to JSON for Firestore storage
  Map<String, dynamic> toJson() => {
    'encryptedData': encryptedData,
    'iv': iv,
    'salt': salt,
  };

  /// Create from JSON retrieved from Firestore
  factory EncryptedData.fromJson(Map<String, dynamic> json) => EncryptedData(
    encryptedData: json['encryptedData'] as String,
    iv: json['iv'] as String,
    salt: json['salt'] as String,
  );
}

/// Exception thrown when encryption operations fail
class EncryptionException implements Exception {
  final String message;
  const EncryptionException(this.message);
  
  @override
  String toString() => 'EncryptionException: $message';
}