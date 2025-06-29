import 'package:drift/drift.dart';
import 'package:drift/web.dart';

/// Web platform database connection using IndexedDB
LazyDatabase createConnection() {
  return LazyDatabase(() async {
    // Use IndexedDB for web platform
    return DatabaseConnection(
      WebDatabase.withStorage(
        await DriftWebStorage.indexedDbIfSupported('pulse_path_db'),
      ),
    );
  });
}