import 'package:flutter_test/flutter_test.dart';
import 'package:pulse_path/features/cloud_sync/data/services/cloud_encryption_service.dart';

void main() {
  group('CloudEncryptionService', () {
    late CloudEncryptionService service;

    setUp(() {
      service = CloudEncryptionService();
    });

    test('should encrypt and decrypt data correctly', () {
      const plaintext = 'Test data for encryption';
      const userKey = 'test-user-key-123';

      // Encrypt data
      final encryptedData = service.encrypt(plaintext, userKey);

      // Verify encrypted data structure
      expect(encryptedData.encryptedData, isNotEmpty);
      expect(encryptedData.iv, isNotEmpty);
      expect(encryptedData.salt, isNotEmpty);

      // Decrypt data
      final decryptedText = service.decrypt(encryptedData, userKey);

      // Verify decryption
      expect(decryptedText, equals(plaintext));
    });

    test('should generate deterministic user keys', () {
      const uid = 'test-uid-123';
      const email = 'test@example.com';

      final key1 = service.generateUserKey(uid, email);
      final key2 = service.generateUserKey(uid, email);

      expect(key1, equals(key2));
      expect(key1, isNotEmpty);
    });

    test('should throw exception for invalid decryption', () {
      const plaintext = 'Test data';
      const correctKey = 'correct-key';
      const wrongKey = 'wrong-key';

      final encryptedData = service.encrypt(plaintext, correctKey);

      expect(
        () => service.decrypt(encryptedData, wrongKey),
        throwsA(isA<EncryptionException>()),
      );
    });

    test('should handle JSON serialization correctly', () {
      const plaintext = '{"test": "data", "number": 123}';
      const userKey = 'test-key';

      final encryptedData = service.encrypt(plaintext, userKey);
      final json = encryptedData.toJson();
      final reconstructed = EncryptedData.fromJson(json);

      final decryptedText = service.decrypt(reconstructed, userKey);
      expect(decryptedText, equals(plaintext));
    });
  });
}