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

// Daily health metrics table
class DailyHealthMetricsTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()(); // Date for the metrics
  
  // Step and movement data
  IntColumn get stepCount => integer().withDefault(const Constant(0))();
  RealColumn get distanceKm => real().withDefault(const Constant(0.0))();
  IntColumn get activeMinutes => integer().withDefault(const Constant(0))();
  IntColumn get flightsClimbed => integer().withDefault(const Constant(0))();
  
  // Sleep data (JSON encoded SleepData object)
  TextColumn get sleepDataJson => text().nullable()();
  
  // Workout sessions (JSON encoded List<WorkoutSession>)
  TextColumn get workoutsJson => text().withDefault(const Constant('[]'))();
  
  // Menstrual cycle data (JSON encoded MenstrualCycleData object)
  TextColumn get menstrualDataJson => text().nullable()();
  
  // Energy and symptoms (user-reported)
  IntColumn get energyLevel => integer().nullable()(); // 1-10 scale
  IntColumn get stressLevel => integer().nullable()(); // 1-10 scale
  TextColumn get symptomsJson => text().withDefault(const Constant('[]'))(); // JSON array
  TextColumn get notes => text().withDefault(const Constant(''))();
  
  // Data quality indicators
  BoolColumn get isComplete => boolean().withDefault(const Constant(true))();
  TextColumn get dataSourcesJson => text().withDefault(const Constant('[]'))(); // JSON array
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
  
  @override
  String get tableName => 'daily_health_metrics';
}

// Adaptive pacing assessments table
class AdaptivePacingAssessmentsTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  
  // Current state assessment (JSON encoded PacingState)
  TextColumn get currentStateJson => text()();
  TextColumn get pemRisk => text()(); // PemRiskLevel enum as string
  IntColumn get energyEnvelopePercentage => integer()(); // 0-100%
  
  // Contributing factors (JSON encoded objects)
  TextColumn get hrvContributionJson => text()();
  TextColumn get activityContributionJson => text()();
  TextColumn get sleepContributionJson => text()();
  TextColumn get menstrualContributionJson => text().nullable()();
  
  // Recommendations (JSON encoded arrays)
  TextColumn get recommendationsJson => text()();
  TextColumn get activityGuidanceJson => text()();
  
  // Trend analysis
  TextColumn get trendWarningsJson => text().withDefault(const Constant('[]'))();
  IntColumn get consecutiveHighRiskDays => integer().withDefault(const Constant(0))();
  RealColumn get sevenDayEnergyTrend => real().withDefault(const Constant(0.0))(); // -1.0 to 1.0
  
  // Personalization factors (JSON encoded ChronicConditionProfile)
  TextColumn get conditionProfileJson => text()();
  RealColumn get personalSensitivity => real().withDefault(const Constant(1.0))(); // 0.5-2.0 multiplier
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
  
  @override
  String get tableName => 'adaptive_pacing_assessments';
}

// Workout sessions table (normalized from daily metrics for better querying)
class WorkoutSessionsTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  TextColumn get workoutType => text()(); // WorkoutType enum as string
  IntColumn get durationMinutes => integer()();
  
  // Intensity and effort
  IntColumn get perceivedExertion => integer().nullable()(); // RPE 1-10 scale
  RealColumn get averageHeartRate => real().nullable()();
  RealColumn get maxHeartRate => real().nullable()();
  IntColumn get caloriesBurned => integer().nullable()();
  
  // Activity-specific metrics
  RealColumn get distanceKm => real().nullable()();
  IntColumn get steps => integer().nullable()();
  RealColumn get avgSpeed => real().nullable()(); // km/h
  RealColumn get elevationGain => real().nullable()(); // meters
  
  // Recovery metrics
  IntColumn get recoveryHeartRate => integer().nullable()(); // BPM after 1 minute
  IntColumn get recoveryTimeMinutes => integer().nullable()(); // Time to return to resting HR
  
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get source => text().withDefault(const Constant('unknown'))();
  
  // Foreign key to daily metrics
  TextColumn get dailyMetricsId => text().nullable()();
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
  
  @override  
  String get tableName => 'workout_sessions';
}

@DriftDatabase(tables: [
  HrvReadings, 
  Settings, 
  SyncQueue, 
  DailyHealthMetricsTable, 
  AdaptivePacingAssessmentsTable, 
  WorkoutSessionsTable
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([String? encryptionKey]) : super(connection.createConnection(encryptionKey));

  /// Factory constructor for creating database with specific encryption key
  AppDatabase.withEncryptionKey(String encryptionKey) : super(connection.createConnection(encryptionKey));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Handle database migrations here
          if (from < 2) {
            // Add new tables for health data and adaptive pacing
            await m.createTable(dailyHealthMetricsTable);
            await m.createTable(adaptivePacingAssessmentsTable);
            await m.createTable(workoutSessionsTable);
          }
        },
      );
}