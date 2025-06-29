import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';
import '../../features/hrv/domain/services/hrv_calculation_service.dart';
import '../../features/hrv/domain/services/hrv_scoring_service.dart';
import '../../features/hrv/domain/services/ppg_processing_service.dart';
import '../../features/hrv/data/datasources/camera_ppg_datasource.dart';
import '../../features/dashboard/data/repositories/dashboard_repository.dart';
import '../../features/dashboard/data/repositories/simple_hrv_repository.dart';
import '../../features/dashboard/data/repositories/database_hrv_repository.dart';
import '../../features/dashboard/data/repositories/hrv_repository_interface.dart';
import '../../shared/repositories/database/app_database.dart';
import '../security/database_key_manager.dart';
import '../services/data_migration_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External dependencies
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Core services
  await _initCore();
  
  // Features
  await _initHrv();
  await _initDashboard();
  await _initSettings();
  await _initSync();
}

Future<void> _initCore() async {
  // Initialize Hive for caching
  await Hive.initFlutter();
  
  // Database key manager for secure encryption
  sl.registerLazySingleton<DatabaseKeyManager>(
    () => DatabaseKeyManager(sl<FlutterSecureStorage>()),
  );
  
  // Database instance
  sl.registerLazySingleton<AppDatabase>(
    () => AppDatabase(),
  );
}

Future<void> _initHrv() async {
  // HRV calculation service - singleton since it's stateless
  sl.registerLazySingleton<HrvCalculationService>(
    () => HrvCalculationService(),
  );
  
  // HRV scoring service - singleton since it's stateless  
  sl.registerLazySingleton<HrvScoringService>(
    () => HrvScoringService(),
  );
  
  // PPG processing service - singleton for signal processing
  sl.registerLazySingleton<PpgProcessingService>(
    () => PpgProcessingService(),
  );
  
  // Camera PPG data source - singleton for camera management
  sl.registerLazySingleton<CameraPpgDataSource>(
    () => CameraPpgDataSource(),
  );
}

Future<void> _initDashboard() async {
  // Register data migration service
  sl.registerLazySingleton<DataMigrationService>(
    () => DataMigrationService(),
  );

  // Platform-specific repository selection
  if (kIsWeb) {
    // Use SimpleHrvRepository for web platform
    sl.registerLazySingleton<HrvRepositoryInterface>(
      () => SimpleHrvRepository()..addSampleData(),
    );
  } else {
    // Use DatabaseHrvRepository for mobile/desktop platforms
    final databaseRepository = DatabaseHrvRepository(sl<AppDatabase>());
    
    // Initialize with sample data if empty
    sl.registerLazySingleton<HrvRepositoryInterface>(
      () => databaseRepository,
    );
    
    // Initialize sample data asynchronously
    _initializeDatabaseWithSampleData(databaseRepository);
    
    // Keep SimpleHrvRepository for potential data migration
    sl.registerLazySingleton<SimpleHrvRepository>(
      () => SimpleHrvRepository(),
    );
  }
  
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepository(sl<HrvRepositoryInterface>()),
  );
}

/// Initialize database repository with sample data if empty
Future<void> _initializeDatabaseWithSampleData(DatabaseHrvRepository repository) async {
  try {
    // Use the migration service to initialize with sample data if needed
    final migrationService = DataMigrationService();
    await migrationService.initializeWithSampleDataIfEmpty(repository);
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing database with sample data: $e');
    }
  }
}

Future<void> _initSettings() async {
  // Settings feature dependencies will be registered here
}

Future<void> _initSync() async {
  // Sync feature dependencies will be registered here
}