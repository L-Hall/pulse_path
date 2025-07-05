import 'package:drift/drift.dart';

// Platform-specific database connections
import 'connection/database_connection_stub.dart'
    if (dart.library.html) 'connection/database_connection_web.dart'
    if (dart.library.io) 'connection/database_connection_native.dart'
    as connection;

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
  AppDatabase([String? encryptionKey]) : super(connection.createConnection(encryptionKey));

  /// Factory constructor for creating database with specific encryption key
  AppDatabase.withEncryptionKey(String encryptionKey) : super(connection.createConnection(encryptionKey));

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