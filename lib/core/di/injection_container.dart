import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';
import '../../features/hrv/domain/services/hrv_calculation_service.dart';
import '../../features/hrv/domain/services/hrv_scoring_service.dart';
import '../../features/hrv/domain/services/ppg_processing_service.dart';
import '../../features/hrv/data/datasources/camera_ppg_datasource.dart';
import '../../features/ble/domain/services/ble_heart_rate_service.dart';
import '../../features/ble/domain/services/ble_hrv_integration_service.dart';
import '../../features/dashboard/data/repositories/dashboard_repository.dart';
import '../../features/dashboard/data/repositories/simple_hrv_repository.dart';
import '../../features/dashboard/data/repositories/database_hrv_repository.dart';
import '../../features/dashboard/data/repositories/hrv_repository_interface.dart';
import '../../shared/repositories/database/app_database.dart';
import '../../shared/repositories/database/database_factory.dart';
import '../security/database_key_manager.dart';
import '../services/data_migration_service.dart';
import '../services/enhanced_data_migration_service.dart';
import '../services/error_handling_service.dart';
import '../services/logging_service.dart';

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
  
  // Ensure all async singletons are ready on mobile/desktop
  if (!kIsWeb) {
    // Pre-initialize async dependencies
    await sl.allReady();
  }
}

Future<void> _initCore() async {
  // Initialize Hive for caching
  await Hive.initFlutter();
  
  // Database key manager for secure encryption
  sl.registerLazySingleton<DatabaseKeyManager>(
    () => DatabaseKeyManager(sl<FlutterSecureStorage>()),
  );
  
  // Database factory for secure database creation
  sl.registerLazySingleton<DatabaseFactory>(
    () => DatabaseFactory(sl<DatabaseKeyManager>()),
  );
  
  // Database instance with proper encryption
  sl.registerLazySingletonAsync<AppDatabase>(
    () async {
      final factory = sl<DatabaseFactory>();
      return await factory.getDatabase();
    },
  );
  
  // Error handling and logging services
  sl.registerLazySingleton<ErrorHandlingService>(
    () => ErrorHandlingService(),
  );
  
  sl.registerLazySingleton<LoggingService>(
    () => LoggingService(),
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
  
  // BLE Heart Rate service - singleton for BLE management
  sl.registerLazySingleton<BleHeartRateService>(
    () => BleHeartRateService(),
  );
  
  // BLE HRV Integration service - singleton for BLE-HRV pipeline
  sl.registerLazySingleton<BleHrvIntegrationService>(
    () => BleHrvIntegrationService(
      bleService: sl<BleHeartRateService>(),
      calculationService: sl<HrvCalculationService>(),
      scoringService: sl<HrvScoringService>(),
      repository: sl<HrvRepositoryInterface>(),
      errorHandler: sl<ErrorHandlingService>(),
      logger: sl<LoggingService>(),
    ),
  );
}

Future<void> _initDashboard() async {
  // Register data migration services
  sl.registerLazySingleton<DataMigrationService>(
    () => DataMigrationService(),
  );
  
  sl.registerLazySingleton<EnhancedDataMigrationService>(
    () => EnhancedDataMigrationService(sl<DatabaseKeyManager>()),
  );

  // Platform-specific repository selection
  if (kIsWeb) {
    // Use SimpleHrvRepository for web platform
    sl.registerLazySingleton<HrvRepositoryInterface>(
      () => SimpleHrvRepository()..addSampleData(),
    );
  } else {
    // Use DatabaseHrvRepository for mobile/desktop platforms
    // Register as async since database is async
    sl.registerLazySingletonAsync<HrvRepositoryInterface>(
      () async {
        final database = await sl.getAsync<AppDatabase>();
        final databaseRepository = DatabaseHrvRepository(database);
        
        // Initialize with sample data if empty using enhanced migration service
        final migrationService = sl<EnhancedDataMigrationService>();
        await migrationService.initializeWithSampleDataIfEmpty(databaseRepository);
        
        return databaseRepository;
      },
    );
    
    // Keep SimpleHrvRepository for potential data migration
    sl.registerLazySingleton<SimpleHrvRepository>(
      () => SimpleHrvRepository(),
    );
  }
  
  // Dashboard repository - also async on mobile/desktop
  if (kIsWeb) {
    sl.registerLazySingleton<DashboardRepository>(
      () => DashboardRepository(sl<HrvRepositoryInterface>()),
    );
  } else {
    sl.registerLazySingletonAsync<DashboardRepository>(
      () async {
        final repository = await sl.getAsync<HrvRepositoryInterface>();
        return DashboardRepository(repository);
      },
    );
  }
}


Future<void> _initSettings() async {
  // Settings feature dependencies will be registered here
}

Future<void> _initSync() async {
  // Sync feature dependencies will be registered here
}