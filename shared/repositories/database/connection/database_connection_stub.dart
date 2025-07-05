import 'package:drift/drift.dart';

/// Stub implementation for unsupported platforms
LazyDatabase createConnection([String? encryptionKey]) {
  throw UnsupportedError('Unsupported platform for database connection');
}