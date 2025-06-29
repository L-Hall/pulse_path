import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/ble_hrv_integration_service.dart';
import '../../domain/services/ble_heart_rate_service.dart';
import '../../../hrv/domain/services/hrv_calculation_service.dart';
import '../../../hrv/domain/services/hrv_scoring_service.dart';
import '../../../dashboard/data/repositories/hrv_repository_interface.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/services/error_handling_service.dart';
import '../../../../core/services/logging_service.dart';

/// Provider for BLE HRV integration service
final bleHrvIntegrationProvider = Provider<BleHrvIntegrationService>((ref) {
  return BleHrvIntegrationService(
    bleService: sl<BleHeartRateService>(),
    calculationService: sl<HrvCalculationService>(),
    scoringService: sl<HrvScoringService>(),
    repository: sl<HrvRepositoryInterface>(),
    errorHandler: sl<ErrorHandlingService>(),
    logger: sl<LoggingService>(),
  );
});

/// Provider for BLE HRV capture progress stream
final bleHrvProgressProvider = StreamProvider<BleHrvCaptureProgress>((ref) {
  final service = ref.watch(bleHrvIntegrationProvider);
  return service.progressStream;
});

/// Provider for BLE HRV capture statistics
final bleHrvStatsProvider = Provider<BleHrvCaptureStats>((ref) {
  final service = ref.watch(bleHrvIntegrationProvider);
  return service.getStats();
});