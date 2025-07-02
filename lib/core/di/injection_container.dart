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
import '../../features/ble/domain/services/ble_connection_manager.dart';
import '../../features/ble/domain/services/hrv_quality_service.dart';
import '../../features/ble/data/repositories/ble_device_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/firebase_auth_repository.dart';
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
import '../services/performance_monitoring_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  try {
    // External dependencies
    sl.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    );

    // Core services
    await _initCore();
    
    // HRV must be initialized before Dashboard to resolve circular dependencies
    await _initHrv();
    
    // Dashboard features (depends on HRV repository)
    await _initDashboard();
    await _initSettings();
    await _initSync();
    
    // Let async singletons initialize lazily (don't block startup)
    
    debugPrint('✅ Dependencies initialized successfully');
  } catch (e) {
    debugPrint('❌ Dependency initialization failed: $e');
    // Use fallback initialization
    await _initFallbackDependencies();
  }
}

Future<void> _initFallbackDependencies() async {
  debugPrint('🔄 Initializing fallback dependencies...');
  
  // Initialize minimal dependencies for development
  if (!sl.isRegistered<HrvRepositoryInterface>()) {
    sl.registerLazySingleton<HrvRepositoryInterface>(
      () => SimpleHrvRepository()..addSampleData(),
    );
  }
  
  if (!sl.isRegistered<DashboardRepository>()) {
    sl.registerLazySingleton<DashboardRepository>(
      () => DashboardRepository(sl<HrvRepositoryInterface>()),
    );
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
    () {
      final service = ErrorHandlingService();
      service.initialize(); // Initialize with crash reporting
      return service;
    },
  );
  
  sl.registerLazySingletonAsync<LoggingService>(
    () async {
      final service = LoggingService();
      await service.initialize(
        minimumLogLevel: kDebugMode ? LogLevel.debug : LogLevel.info,
        enableFileLogging: true,
      );
      return service;
    },
  );
  
  sl.registerLazySingletonAsync<PerformanceMonitoringService>(
    () async {
      final service = PerformanceMonitoringService();
      final logger = await sl.getAsync<LoggingService>();
      await service.initialize(logger: logger);
      return service;
    },
  );
}

Future<void> _initHrv() async {
  debugPrint('🔄 Initializing HRV dependencies...');
  
  // Register data migration services first
  sl.registerLazySingleton<DataMigrationService>(
    () => DataMigrationService(),
  );
  
  sl.registerLazySingleton<EnhancedDataMigrationService>(
    () => EnhancedDataMigrationService(sl<DatabaseKeyManager>()),
  );
  
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
  
  // BLE Device Repository - singleton for device pairing management
  sl.registerLazySingleton<BleDeviceRepository>(
    () => BleDeviceRepository(secureStorage: sl<FlutterSecureStorage>()),
  );
  
  // HRV Quality Service - singleton for data validation
  sl.registerLazySingleton<HrvQualityService>(
    () => HrvQualityService(),
  );
  
  // BLE Connection Manager - singleton for connection stability
  sl.registerLazySingleton<BleConnectionManager>(
    () => BleConnectionManager(
      bleService: sl<BleHeartRateService>(),
      deviceRepository: sl<BleDeviceRepository>(),
    ),
  );
  
  // Platform-specific repository selection (MOVED HERE to break circular dependency)
  if (kIsWeb) {
    debugPrint('📱 Web platform - registering SimpleHrvRepository');
    // Use SimpleHrvRepository for web platform
    sl.registerLazySingleton<HrvRepositoryInterface>(
      () {
        debugPrint('🔄 Creating SimpleHrvRepository with sample data...');
        final repo = SimpleHrvRepository();
        repo.addSampleData();
        debugPrint('✅ SimpleHrvRepository created and sample data added');
        return repo;
      },
    );
    
    // BLE HRV Integration service for web
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
  } else {
    debugPrint('📱 Mobile/Desktop platform - registering DatabaseHrvRepository');
    // Use DatabaseHrvRepository for mobile/desktop platforms
    // Register as async since database is async
    sl.registerLazySingletonAsync<HrvRepositoryInterface>(
      () async {
        debugPrint('🔄 Getting database for HrvRepository...');
        final database = await sl.getAsync<AppDatabase>();
        debugPrint('✅ Database obtained, creating DatabaseHrvRepository...');
        final databaseRepository = DatabaseHrvRepository(database);
        
        // Initialize with sample data if empty using enhanced migration service
        debugPrint('🔄 Initializing sample data...');
        final migrationService = sl<EnhancedDataMigrationService>();
        await migrationService.initializeWithSampleDataIfEmpty(databaseRepository);
        debugPrint('✅ Sample data initialization complete');
        
        return databaseRepository;
      },
    );
    
    // Keep SimpleHrvRepository for potential data migration
    sl.registerLazySingleton<SimpleHrvRepository>(
      () => SimpleHrvRepository(),
    );
    
    // BLE HRV Integration service for mobile/desktop - register as async
    sl.registerLazySingletonAsync<BleHrvIntegrationService>(
      () async => BleHrvIntegrationService(
        bleService: sl<BleHeartRateService>(),
        calculationService: sl<HrvCalculationService>(),
        scoringService: sl<HrvScoringService>(),
        repository: await sl.getAsync<HrvRepositoryInterface>(),
        errorHandler: sl<ErrorHandlingService>(),
        logger: sl<LoggingService>(),
      ),
    );
  }
}

Future<void> _initDashboard() async {
  debugPrint('🔄 Initializing dashboard dependencies...');
  
  // HRV Repository is already registered in _initHrv()
  
  // Dashboard repository - also async on mobile/desktop
  if (kIsWeb) {
    debugPrint('📱 Web platform - registering sync DashboardRepository');
    sl.registerLazySingleton<DashboardRepository>(
      () {
        debugPrint('🔄 Creating sync DashboardRepository...');
        final repo = DashboardRepository(sl<HrvRepositoryInterface>());
        debugPrint('✅ Sync DashboardRepository created');
        return repo;
      },
    );
  } else {
    debugPrint('📱 Mobile/Desktop platform - registering async DashboardRepository');
    sl.registerLazySingletonAsync<DashboardRepository>(
      () async {
        debugPrint('🔄 Getting HrvRepository for DashboardRepository...');
        final repository = await sl.getAsync<HrvRepositoryInterface>();
        debugPrint('✅ HrvRepository obtained, creating DashboardRepository...');
        final dashRepo = DashboardRepository(repository);
        debugPrint('✅ Async DashboardRepository created');
        return dashRepo;
      },
    );
  }
  
  debugPrint('✅ Dashboard dependencies initialized');
}


Future<void> _initAuth() async {
  // Authentication repository
  sl.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(),
  );
}

Future<void> _initSettings() async {
  // Settings feature dependencies will be registered here
}

Future<void> _initSync() async {
  // Sync feature dependencies will be registered here
}