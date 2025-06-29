import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/ble_heart_rate_service.dart';

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