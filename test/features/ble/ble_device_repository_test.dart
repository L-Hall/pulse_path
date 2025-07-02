import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pulse_path/features/ble/data/repositories/ble_device_repository.dart';
import 'package:pulse_path/features/ble/domain/services/ble_heart_rate_service.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('BleDeviceRepository', () {
    late BleDeviceRepository repository;
    late MockFlutterSecureStorage mockStorage;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      repository = BleDeviceRepository(secureStorage: mockStorage);
    });

    tearDown(() {
      repository.dispose();
    });

    group('initialization', () {
      test('initializes with empty data when storage is empty', () async {
        when(() => mockStorage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
        when(() => mockStorage.readAll()).thenAnswer((_) async => <String, String>{});
        
        await repository.initialize();
        
        expect(repository.pairedDevices, isEmpty);
        expect(repository.preferredDeviceId, isNull);
        expect(repository.autoReconnectEnabled, isTrue);
      });

      test('loads existing paired devices from storage', () async {
        const devicesJson = '[{"name":"Polar H10","address":"12:34:56:78:90:AB"}]';
        
        when(() => mockStorage.read(key: 'ble_paired_devices')).thenAnswer((_) async => devicesJson);
        when(() => mockStorage.read(key: 'ble_preferred_device')).thenAnswer((_) async => '12:34:56:78:90:AB');
        when(() => mockStorage.read(key: 'ble_auto_reconnect')).thenAnswer((_) async => 'true');
        when(() => mockStorage.readAll()).thenAnswer((_) async => <String, String>{});
        
        await repository.initialize();
        
        expect(repository.pairedDevices, hasLength(1));
        expect(repository.pairedDevices.first.name, 'Polar H10');
        expect(repository.pairedDevices.first.address, '12:34:56:78:90:AB');
        expect(repository.preferredDeviceId, '12:34:56:78:90:AB');
      });
    });

    group('device management', () {
      setUp(() async {
        when(() => mockStorage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
        when(() => mockStorage.readAll()).thenAnswer((_) async => <String, String>{});
        when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) async {});
        when(() => mockStorage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
        
        await repository.initialize();
      });

      test('adds paired device successfully', () async {
        const deviceInfo = BleDeviceInfo(
          name: 'Polar H10',
          address: '12:34:56:78:90:AB',
          isConnected: false,
        );
        
        await repository.addPairedDevice(deviceInfo);
        
        expect(repository.pairedDevices, hasLength(1));
        expect(repository.pairedDevices.first.name, 'Polar H10');
        expect(repository.preferredDeviceId, '12:34:56:78:90:AB'); // First device becomes preferred
        
        verify(() => mockStorage.write(key: 'ble_paired_devices', value: any(named: 'value'))).called(1);
        verify(() => mockStorage.write(key: 'ble_preferred_device', value: '12:34:56:78:90:AB')).called(1);
      });

      test('removes paired device successfully', () async {
        const deviceInfo = BleDeviceInfo(
          name: 'Polar H10',
          address: '12:34:56:78:90:AB',
          isConnected: false,
        );
        
        await repository.addPairedDevice(deviceInfo);
        await repository.removePairedDevice('12:34:56:78:90:AB');
        
        expect(repository.pairedDevices, isEmpty);
        expect(repository.preferredDeviceId, isNull);
        
        verify(() => mockStorage.write(key: 'ble_paired_devices', value: any(named: 'value'))).called(2);
      });

      test('updates existing device when adding duplicate', () async {
        const deviceInfo1 = BleDeviceInfo(
          name: 'Polar H10',
          address: '12:34:56:78:90:AB',
          isConnected: false,
        );
        
        const deviceInfo2 = BleDeviceInfo(
          name: 'Polar H10 Updated',
          address: '12:34:56:78:90:AB',
          isConnected: false,
        );
        
        await repository.addPairedDevice(deviceInfo1);
        await repository.addPairedDevice(deviceInfo2);
        
        expect(repository.pairedDevices, hasLength(1));
        expect(repository.pairedDevices.first.name, 'Polar H10 Updated');
      });

      test('checks if device is paired correctly', () async {
        const deviceInfo = BleDeviceInfo(
          name: 'Polar H10',
          address: '12:34:56:78:90:AB',
          isConnected: false,
        );
        
        expect(repository.isDevicePaired('12:34:56:78:90:AB'), isFalse);
        
        await repository.addPairedDevice(deviceInfo);
        
        expect(repository.isDevicePaired('12:34:56:78:90:AB'), isTrue);
        expect(repository.isDevicePaired('different_address'), isFalse);
      });
    });

    group('preferred device management', () {
      setUp(() async {
        when(() => mockStorage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
        when(() => mockStorage.readAll()).thenAnswer((_) async => <String, String>{});
        when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) async {});
        
        await repository.initialize();
      });

      test('sets preferred device successfully', () async {
        const deviceInfo = BleDeviceInfo(
          name: 'Polar H10',
          address: '12:34:56:78:90:AB',
          isConnected: false,
        );
        
        await repository.addPairedDevice(deviceInfo);
        await repository.setPreferredDevice('12:34:56:78:90:AB');
        
        expect(repository.preferredDeviceId, '12:34:56:78:90:AB');
        expect(repository.getPreferredDevice()?.name, 'Polar H10');
      });

      test('throws error when setting non-paired device as preferred', () async {
        expect(
          () => repository.setPreferredDevice('non_existent_device'),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('returns null when no preferred device is set', () {
        expect(repository.getPreferredDevice(), isNull);
      });
    });

    group('auto-reconnect settings', () {
      setUp(() async {
        when(() => mockStorage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
        when(() => mockStorage.readAll()).thenAnswer((_) async => <String, String>{});
        when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) async {});
        
        await repository.initialize();
      });

      test('sets auto-reconnect preference', () async {
        expect(repository.autoReconnectEnabled, isTrue); // Default
        
        await repository.setAutoReconnect(false);
        
        expect(repository.autoReconnectEnabled, isFalse);
        verify(() => mockStorage.write(key: 'ble_auto_reconnect', value: 'false')).called(1);
      });
    });

    group('device settings', () {
      setUp(() async {
        when(() => mockStorage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
        when(() => mockStorage.readAll()).thenAnswer((_) async => <String, String>{});
        when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) async {});
        
        await repository.initialize();
      });

      test('returns default settings for new device', () async {
        final settings = await repository.getDeviceSettings('new_device');
        
        expect(settings.enableBatteryMonitoring, isTrue);
        expect(settings.enableRawDataLogging, isFalse);
        expect(settings.reconnectTimeout.inSeconds, 10);
        expect(settings.reconnectRetries, 3);
      });

      test('saves and loads device settings', () async {
        const deviceAddress = '12:34:56:78:90:AB';
        final customSettings = BleDeviceSettings(
          enableBatteryMonitoring: false,
          enableRawDataLogging: true,
          reconnectTimeout: Duration(seconds: 15),
          reconnectRetries: 5,
          enableHeartRateAlerts: true,
          minHeartRate: 50,
          maxHeartRate: 180,
        );
        
        // Mock the storage read to return our custom settings
        const settingsJson = '{"enableBatteryMonitoring":false,"enableRawDataLogging":true,"reconnectTimeoutSeconds":15,"reconnectRetries":5,"enableHeartRateAlerts":true,"minHeartRate":50,"maxHeartRate":180}';
        when(() => mockStorage.read(key: 'ble_device_settings_$deviceAddress')).thenAnswer((_) async => settingsJson);
        
        await repository.saveDeviceSettings(deviceAddress, customSettings);
        final loadedSettings = await repository.getDeviceSettings(deviceAddress);
        
        expect(loadedSettings.enableBatteryMonitoring, isFalse);
        expect(loadedSettings.enableRawDataLogging, isTrue);
        expect(loadedSettings.reconnectTimeout.inSeconds, 15);
        expect(loadedSettings.reconnectRetries, 5);
        expect(loadedSettings.minHeartRate, 50);
        expect(loadedSettings.maxHeartRate, 180);
      });
    });

    group('data clearing', () {
      setUp(() async {
        when(() => mockStorage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
        when(() => mockStorage.readAll()).thenAnswer((_) async => <String, String>{});
        when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) async {});
        when(() => mockStorage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
        
        await repository.initialize();
      });

      test('clears all data successfully', () async {
        // Add some data first
        const deviceInfo = BleDeviceInfo(
          name: 'Polar H10',
          address: '12:34:56:78:90:AB',
          isConnected: false,
        );
        
        await repository.addPairedDevice(deviceInfo);
        await repository.setAutoReconnect(false);
        
        expect(repository.pairedDevices, hasLength(1));
        expect(repository.autoReconnectEnabled, isFalse);
        
        // Clear all data
        when(() => mockStorage.readAll()).thenAnswer((_) async => {
          'ble_device_settings_device1': 'some_settings',
          'ble_device_settings_device2': 'some_settings',
          'other_key': 'other_value',
        });
        
        await repository.clearAllData();
        
        expect(repository.pairedDevices, isEmpty);
        expect(repository.preferredDeviceId, isNull);
        expect(repository.autoReconnectEnabled, isTrue); // Reset to default
        
        verify(() => mockStorage.delete(key: 'ble_paired_devices')).called(1);
        verify(() => mockStorage.delete(key: 'ble_preferred_device')).called(1);
        verify(() => mockStorage.delete(key: 'ble_auto_reconnect')).called(1);
        verify(() => mockStorage.delete(key: 'ble_device_settings_device1')).called(1);
        verify(() => mockStorage.delete(key: 'ble_device_settings_device2')).called(1);
      });
    });

    group('BleDeviceSettings', () {
      test('creates default settings correctly', () {
        final settings = BleDeviceSettings.defaultSettings();
        
        expect(settings.enableBatteryMonitoring, isTrue);
        expect(settings.enableRawDataLogging, isFalse);
        expect(settings.reconnectTimeout, Duration(seconds: 10));
        expect(settings.reconnectRetries, 3);
        expect(settings.enableHeartRateAlerts, isFalse);
        expect(settings.minHeartRate, isNull);
        expect(settings.maxHeartRate, isNull);
      });

      test('serializes to and from JSON correctly', () {
        final settings = BleDeviceSettings(
          enableBatteryMonitoring: false,
          enableRawDataLogging: true,
          reconnectTimeout: Duration(seconds: 15),
          reconnectRetries: 5,
          enableHeartRateAlerts: true,
          minHeartRate: 50,
          maxHeartRate: 180,
        );
        
        final json = settings.toJson();
        final recreated = BleDeviceSettings.fromJson(json);
        
        expect(recreated.enableBatteryMonitoring, settings.enableBatteryMonitoring);
        expect(recreated.enableRawDataLogging, settings.enableRawDataLogging);
        expect(recreated.reconnectTimeout, settings.reconnectTimeout);
        expect(recreated.reconnectRetries, settings.reconnectRetries);
        expect(recreated.enableHeartRateAlerts, settings.enableHeartRateAlerts);
        expect(recreated.minHeartRate, settings.minHeartRate);
        expect(recreated.maxHeartRate, settings.maxHeartRate);
      });

      test('copyWith creates modified copy correctly', () {
        final original = BleDeviceSettings.defaultSettings();
        final modified = original.copyWith(
          enableBatteryMonitoring: false,
          reconnectRetries: 5,
        );
        
        expect(modified.enableBatteryMonitoring, isFalse);
        expect(modified.reconnectRetries, 5);
        expect(modified.enableRawDataLogging, original.enableRawDataLogging); // Unchanged
        expect(modified.reconnectTimeout.inSeconds, original.reconnectTimeout.inSeconds); // Compare seconds
      });
    });
  });
}