abstract class AppException implements Exception {
  const AppException(this.message);
  
  final String message;
  
  @override
  String toString() => message;
}

// HRV-related exceptions
class HrvException extends AppException {
  const HrvException(super.message);
}

class PpgCaptureException extends HrvException {
  const PpgCaptureException(super.message);
}

class HrvCalculationException extends HrvException {
  const HrvCalculationException(super.message);
}

class InvalidHrvDataException extends HrvException {
  const InvalidHrvDataException(super.message);
}

// Device I/O exceptions
class CameraException extends AppException {
  const CameraException(super.message);
}

class BleException extends AppException {
  const BleException(super.message);
}

class HealthKitException extends AppException {
  const HealthKitException(super.message);
}

// Storage exceptions
class DatabaseException extends AppException {
  const DatabaseException(super.message);
}

class EncryptionException extends AppException {
  const EncryptionException(super.message);
}

class SecureStorageException extends AppException {
  const SecureStorageException(super.message);
}

// Cloud sync exceptions
class SyncException extends AppException {
  const SyncException(super.message);
}

class FirebaseException extends SyncException {
  const FirebaseException(super.message);
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

// Subscription exceptions
class SubscriptionException extends AppException {
  const SubscriptionException(super.message);
}

class PaymentException extends SubscriptionException {
  const PaymentException(super.message);
}