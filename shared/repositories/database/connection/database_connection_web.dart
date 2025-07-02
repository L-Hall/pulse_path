import 'package:drift/drift.dart';
import 'package:drift/web.dart';

/// Web platform database connection using IndexedDB
/// 
/// Note: encryptionKey parameter is ignored on web platform as IndexedDB
/// uses browser-based security. For web privacy, data is session-scoped.
LazyDatabase createConnection([String? encryptionKey]) {
  return LazyDatabase(() async {
    // Use IndexedDB for web platform
    // Note: Web databases are inherently encrypted by the browser
    return DatabaseConnection(
      WebDatabase.withStorage(
        await DriftWebStorage.indexedDbIfSupported('pulse_path_db'),
      ),
    );
  });
}