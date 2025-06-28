import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';

part 'app_database.g.dart';

// HRV Readings table
class HrvReadings extends Table {
  TextColumn get id => text()();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get durationSeconds => integer()();
  TextColumn get rrIntervalsJson => text()(); // JSON encoded List<double>
  TextColumn get metricsJson => text()(); // JSON encoded HrvMetrics
  TextColumn get scoresJson => text()(); // JSON encoded HrvScores
  TextColumn get notes => text().nullable()();
  TextColumn get tagsJson => text().nullable()(); // JSON encoded List<String>
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Settings table for local app configuration
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {key};
}

// Sync queue for offline-first sync
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()(); // 'hrv_reading', 'setting', etc.
  TextColumn get entityId => text()();
  TextColumn get action => text()(); // 'create', 'update', 'delete'
  TextColumn get dataJson => text()(); // JSON encoded entity data
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
}

@DriftDatabase(tables: [HrvReadings, Settings, SyncQueue])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Handle database migrations here
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    if (kIsWeb) {
      // Use in-memory database for web
      return DatabaseConnection(
        NativeDatabase.memory(),
      );
    }

    // Initialize SQLCipher for encrypted database
    await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
    
    final dbFolder = await getDatabasesPath();
    final file = File(path.join(dbFolder, 'pulse_path_encrypted.db'));
    
    // Get encryption key from secure storage
    // This will be implemented with proper key management
    const password = 'temporary_key_replace_with_secure_key';
    
    return DatabaseConnection(
      NativeDatabase(
        file,
        setup: (Database database) {
          database.execute("PRAGMA key = '$password'");
          database.execute('PRAGMA cipher_page_size = 4096');
          database.execute('PRAGMA kdf_iter = 64000');
          database.execute('PRAGMA cipher_hmac_algorithm = HMAC_SHA1');
          database.execute('PRAGMA cipher_kdf_algorithm = PBKDF2_HMAC_SHA1');
        },
      ),
    );
  });
}

// TODO: Implement proper key management
Future<String> getDatabasesPath() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  return appDocDir.path;
}