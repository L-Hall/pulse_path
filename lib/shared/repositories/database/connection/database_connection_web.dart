import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:drift/web.dart';

/// Web platform database connection using WASM and IndexedDB
/// 
/// Note: encryptionKey parameter is ignored on web platform as browser
/// security handles data protection. For web privacy, data is session-scoped.
LazyDatabase createConnection([String? encryptionKey]) {
  return LazyDatabase(() async {
    // Use WASM-based database for web platform (modern approach)
    // Falls back to IndexedDB if WASM is not supported
    final result = await WasmDatabase.open(
      databaseName: 'pulse_path_db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );
    
    if (result.missingFeatures.isNotEmpty) {
      // Fallback to IndexedDB if WASM features are missing
      return DatabaseConnection(
        await DriftWebStorage.indexedDbIfSupported('pulse_path_db')
            .then((storage) => WebDatabase.withStorage(storage)),
      );
    }
    
    return result.resolvedExecutor;
  });
}