import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

/// Web platform database connection using WASM SQLite

/// 
/// Note: encryptionKey parameter is ignored on web platform as browser
/// security handles data protection. For web privacy, data is session-scoped.
LazyDatabase createConnection([String? encryptionKey]) {
  return LazyDatabase(() async {
    // Use WASM SQLite for better performance and compatibility

    final result = await WasmDatabase.open(
      databaseName: 'pulse_path_db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );
    
    if (result.missingFeatures.isNotEmpty) {
      // Fall back to in-memory database if features are missing
      print('Missing features for WASM database: ${result.missingFeatures}');

    }
    
    return result.resolvedExecutor;
  });
}