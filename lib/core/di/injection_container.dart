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
  // Simple HRV repository for demo (works on all platforms)
  sl.registerLazySingleton<SimpleHrvRepository>(
    () => SimpleHrvRepository()..addSampleData(),
  );
  
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepository(sl<SimpleHrvRepository>()),
  );
}

Future<void> _initSettings() async {
  // Settings feature dependencies will be registered here
}

Future<void> _initSync() async {
  // Sync feature dependencies will be registered here
}