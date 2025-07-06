import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/ble_heart_rate_service.dart';
import '../../domain/services/ble_connection_manager.dart';
import '../../data/repositories/ble_device_repository.dart';
import '../../../../core/di/injection_container.dart';

/// Provider for the BLE Heart Rate Service
final bleHeartRateServiceProvider = Provider<BleHeartRateService>((ref) {
  return BleHeartRateService();
});

/// Provider for BLE connection state
final bleConnectionStateProvider = StreamProvider<BleConnectionState>((ref) {
  final service = ref.watch(bleHeartRateServiceProvider);
  return service.connectionStream;
});

/// Provider for heart rate readings
final heartRateStreamProvider = StreamProvider<HeartRateReading>((ref) {
  final service = ref.watch(bleHeartRateServiceProvider);
  return service.heartRateStream;
});

/// Provider for battery level
final batteryLevelProvider = StreamProvider<int>((ref) {
  final service = ref.watch(bleHeartRateServiceProvider);
  return service.batteryStream;
});

/// Provider for connected device info
final connectedDeviceProvider = Provider<BleDeviceInfo?>((ref) {
  final service = ref.watch(bleHeartRateServiceProvider);
  return service.connectedDeviceInfo;
});

/// Provider for BLE device repository
final bleDeviceRepositoryProvider = Provider<BleDeviceRepository>((ref) {
  return sl<BleDeviceRepository>();
});

/// Provider for paired devices stream
final pairedDevicesProvider = StreamProvider<List<BleDeviceInfo>>((ref) {
  final repository = ref.watch(bleDeviceRepositoryProvider);
  return repository.pairedDevicesStream;
});

/// Provider for BLE connection manager
final bleConnectionManagerProvider = Provider<BleConnectionManager>((ref) {
  return sl<BleConnectionManager>();
});

/// Provider for connection events
final bleConnectionEventsProvider = StreamProvider<BleConnectionEvent>((ref) {
  final manager = ref.watch(bleConnectionManagerProvider);
  return manager.eventStream;
});