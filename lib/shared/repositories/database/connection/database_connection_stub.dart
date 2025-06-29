import 'package:drift/drift.dart';

/// Stub implementation for unsupported platforms
LazyDatabase createConnection() {
  throw UnsupportedError('Unsupported platform for database connection');
}