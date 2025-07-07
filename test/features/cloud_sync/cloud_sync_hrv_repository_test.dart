import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse_path/features/cloud_sync/data/repositories/cloud_sync_hrv_repository.dart';
import 'package:pulse_path/features/cloud_sync/data/services/cloud_encryption_service.dart';
import 'package:pulse_path/features/auth/domain/repositories/auth_repository.dart';
import 'package:pulse_path/features/dashboard/data/repositories/hrv_repository_interface.dart';
import 'package:pulse_path/features/auth/domain/models/app_user.dart';
import 'package:pulse_path/shared/models/hrv_reading.dart';
import '../../support/test_utils.dart';

// Mock classes
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCloudEncryptionService extends Mock implements CloudEncryptionService {}
class MockAuthRepository extends Mock implements AuthRepository {}
class MockHrvRepositoryInterface extends Mock implements HrvRepositoryInterface {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}

void main() {
  group('CloudSyncHrvRepository', () {
    late CloudSyncHrvRepository repository;
    late MockFirebaseFirestore mockFirestore;
    late MockCloudEncryptionService mockEncryptionService;
    late MockAuthRepository mockAuthRepository;
    late MockHrvRepositoryInterface mockLocalRepository;
    late TestUtils testUtils;

    setUpAll(() {
      testUtils = TestUtils();
      // Register fallback values for mocktail
      registerFallbackValue(const EncryptedData(
        encryptedData: 'test',
        iv: 'test',
        salt: 'test',
      ));
    });

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      mockEncryptionService = MockCloudEncryptionService();
      mockAuthRepository = MockAuthRepository();
      mockLocalRepository = MockHrvRepositoryInterface();

      repository = CloudSyncHrvRepository(
        firestore: mockFirestore,
        encryptionService: mockEncryptionService,
        authRepository: mockAuthRepository,
        localRepository: mockLocalRepository,
      );
    });

    group('saveReading', () {
      test('should save to local repository when user is anonymous', () async {
        final reading = testUtils.mockDataService.generateMockHrvReading();
        
        // Mock anonymous user
        when(() => mockAuthRepository.currentUser).thenReturn(
          const AppUser(
            uid: 'anonymous-uid',
            email: 'anonymous@example.com',
            isAnonymous: true,
            isEmailVerified: false,
          ),
        );

        await repository.saveReading(reading);

        // Verify only local save was called
        verify(() => mockLocalRepository.saveReading(reading)).called(1);
        verifyNever(() => mockEncryptionService.encrypt(any(), any()));
      });

      test('should save to both local and cloud when user is authenticated', () async {
        final reading = testUtils.mockDataService.generateMockHrvReading();
        
        // Mock authenticated user
        when(() => mockAuthRepository.currentUser).thenReturn(
          const AppUser(
            uid: 'test-uid',
            email: 'test@example.com',
            isAnonymous: false,
            isEmailVerified: true,
          ),
        );

        // Mock encryption
        when(() => mockEncryptionService.generateUserKey(any(), any())).thenReturn('user-key');
        when(() => mockEncryptionService.encrypt(any(), any())).thenReturn(
          const EncryptedData(
            encryptedData: 'encrypted',
            iv: 'iv',
            salt: 'salt',
          ),
        );

        // Mock Firestore calls
        final mockCollection = MockCollectionReference();
        final mockDoc = MockDocumentReference();
        when(() => mockFirestore.collection('users')).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
        when(() => mockCollection.doc(any())).thenReturn(mockDoc as DocumentReference<Map<String, dynamic>>);
        when(() => mockDoc.collection('hrv_readings')).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
        when(() => mockCollection.doc(reading.id)).thenReturn(mockDoc);
        when(() => mockDoc.set(any())).thenAnswer((_) async {});

        // Mock local repository save
        when(() => mockLocalRepository.saveReading(any())).thenAnswer((_) async {});

        await repository.saveReading(reading);

        // Verify both local and cloud saves
        verify(() => mockLocalRepository.saveReading(reading)).called(1);
        verify(() => mockEncryptionService.encrypt(any(), 'user-key')).called(1);
        verify(() => mockDoc.set(any())).called(1);
      });
    });

    group('getLatestReading', () {
      test('should return from local repository when user is anonymous', () async {
        final expectedReading = testUtils.mockDataService.generateMockHrvReading();
        
        // Mock anonymous user
        when(() => mockAuthRepository.currentUser).thenReturn(
          const AppUser(
            uid: 'anonymous-uid',
            email: 'anonymous@example.com',
            isAnonymous: true,
            isEmailVerified: false,
          ),
        );

        when(() => mockLocalRepository.getLatestReading()).thenAnswer((_) async => expectedReading);

        final result = await repository.getLatestReading();

        expect(result, equals(expectedReading));
        verify(() => mockLocalRepository.getLatestReading()).called(1);
      });
    });

    group('error handling', () {
      test('should throw RepositoryException when cloud sync fails', () async {
        final reading = testUtils.mockDataService.generateMockHrvReading();
        
        // Mock authenticated user
        when(() => mockAuthRepository.currentUser).thenReturn(
          const AppUser(
            uid: 'test-uid',
            email: 'test@example.com',
            isAnonymous: false,
            isEmailVerified: true,
          ),
        );

        // Mock local save success
        when(() => mockLocalRepository.saveReading(any())).thenAnswer((_) async {});

        // Mock encryption failure
        when(() => mockEncryptionService.generateUserKey(any(), any())).thenThrow(Exception('Encryption failed'));

        expect(
          () => repository.saveReading(reading),
          throwsA(isA<RepositoryException>()),
        );
      });
    });
  });
}