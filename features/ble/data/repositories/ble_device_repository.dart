import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';
import '../../domain/services/ble_heart_rate_service.dart';

/// Repository for managing BLE device pairing and preferences
/// 
/// Provides persistent storage for:
/// - Previously paired devices
/// - Device preferences and settings
/// - Auto-reconnect behavior
/// - Device-specific configurations
class BleDeviceRepository {
  static const String _keyPairedDevices = 'ble_paired_devices';
  static const String _keyPreferredDevice = 'ble_preferred_device';
  static const String _keyAutoReconnect = 'ble_auto_reconnect';
  static const String _keyDeviceSettings = 'ble_device_settings_';

  final FlutterSecureStorage _secureStorage;
  final List<BleDeviceInfo> _pairedDevices = [];
  String? _preferredDeviceId;
  bool _autoReconnectEnabled = true;
  
  final StreamController<List<BleDeviceInfo>> _pairedDevicesController = 
      StreamController<List<BleDeviceInfo>>.broadcast();

  BleDeviceRepository({
    required FlutterSecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  /// Stream of paired devices list
  Stream<List<BleDeviceInfo>> get pairedDevicesStream => _pairedDevicesController.stream;

  /// Get list of paired devices
  List<BleDeviceInfo> get pairedDevices => List.unmodifiable(_pairedDevices);

  /// Get preferred device ID
  String? get preferredDeviceId => _preferredDeviceId;

  /// Check if auto-reconnect is enabled
  bool get autoReconnectEnabled => _autoReconnectEnabled;

  /// Initialize repository by loading saved data
  Future<void> initialize() async {
    try {
      await _loadPairedDevices();
      await _loadPreferences();
      
      if (kDebugMode) {
        debugPrint('✅ BleDeviceRepository initialized with ${_pairedDevices.length} paired devices');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Error initializing BleDeviceRepository: $e');
      }
    }
  }

  /// Add a device to paired devices list
  Future<void> addPairedDevice(BleDeviceInfo deviceInfo) async {
    try {
      // Remove if already exists (update scenario)
      _pairedDevices.removeWhere((device) => device.address == deviceInfo.address);
      
      // Add to list
      _pairedDevices.add(deviceInfo);
      
      // Save to storage
      await _savePairedDevices();
      
      // If this is the first device, make it preferred
      if (_preferredDeviceId == null) {
        await setPreferredDevice(deviceInfo.address);
      }
      
      _pairedDevicesController.add(List.from(_pairedDevices));
      
      if (kDebugMode) {
        debugPrint('✅ Added paired device: ${deviceInfo.name} (${deviceInfo.address})');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error adding paired device: $e');
      }
      rethrow;
    }
  }

  /// Remove a device from paired devices list
  Future<void> removePairedDevice(String deviceAddress) async {
    try {
      _pairedDevices.removeWhere((device) => device.address == deviceAddress);
      
      // If this was the preferred device, clear preference
      if (_preferredDeviceId == deviceAddress) {
        _preferredDeviceId = _pairedDevices.isNotEmpty ? _pairedDevices.first.address : null;
        await _savePreferences();
      }
      
      await _savePairedDevices();
      await _removeDeviceSettings(deviceAddress);
      
      _pairedDevicesController.add(List.from(_pairedDevices));
      
      if (kDebugMode) {
        debugPrint('✅ Removed paired device: $deviceAddress');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error removing paired device: $e');
      }
      rethrow;
    }
  }

  /// Set preferred device for auto-connect
  Future<void> setPreferredDevice(String deviceAddress) async {
    if (_pairedDevices.any((device) => device.address == deviceAddress)) {
      _preferredDeviceId = deviceAddress;
      await _savePreferences();
      
      if (kDebugMode) {
        debugPrint('✅ Set preferred device: $deviceAddress');
      }
    } else {
      throw ArgumentError('Device not in paired devices list: $deviceAddress');
    }
  }

  /// Get preferred device info
  BleDeviceInfo? getPreferredDevice() {
    if (_preferredDeviceId == null) return null;
    
    try {
      return _pairedDevices.firstWhere(
        (device) => device.address == _preferredDeviceId,
      );
    } catch (e) {
      return null;
    }
  }

  /// Set auto-reconnect preference
  Future<void> setAutoReconnect(bool enabled) async {
    _autoReconnectEnabled = enabled;
    await _savePreferences();
    
    if (kDebugMode) {
      debugPrint('✅ Auto-reconnect set to: $enabled');
    }
  }

  /// Check if device is paired
  bool isDevicePaired(String deviceAddress) {
    return _pairedDevices.any((device) => device.address == deviceAddress);
  }

  /// Get device settings for a specific device
  Future<BleDeviceSettings> getDeviceSettings(String deviceAddress) async {
    try {
      final settingsJson = await _secureStorage.read(key: '$_keyDeviceSettings$deviceAddress');
      
      if (settingsJson != null) {
        final settingsMap = json.decode(settingsJson) as Map<String, dynamic>;
        return BleDeviceSettings.fromJson(settingsMap);
      }
      
      // Return default settings
      return BleDeviceSettings.defaultSettings();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Error loading device settings for $deviceAddress: $e');
      }
      return BleDeviceSettings.defaultSettings();
    }
  }

  /// Save device settings for a specific device
  Future<void> saveDeviceSettings(String deviceAddress, BleDeviceSettings settings) async {
    try {
      final settingsJson = json.encode(settings.toJson());
      await _secureStorage.write(key: '$_keyDeviceSettings$deviceAddress', value: settingsJson);
      
      if (kDebugMode) {
        debugPrint('✅ Saved device settings for: $deviceAddress');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error saving device settings: $e');
      }
      rethrow;
    }
  }

  /// Clear all paired devices and preferences
  Future<void> clearAllData() async {
    try {
      _pairedDevices.clear();
      _preferredDeviceId = null;
      _autoReconnectEnabled = true;
      
      await _secureStorage.delete(key: _keyPairedDevices);
      await _secureStorage.delete(key: _keyPreferredDevice);
      await _secureStorage.delete(key: _keyAutoReconnect);
      
      // Clear all device settings
      final allKeys = await _secureStorage.readAll();
      for (final key in allKeys.keys) {
        if (key.startsWith(_keyDeviceSettings)) {
          await _secureStorage.delete(key: key);
        }
      }
      
      _pairedDevicesController.add(List.from(_pairedDevices));
      
      if (kDebugMode) {
        debugPrint('✅ Cleared all BLE device data');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error clearing BLE device data: $e');
      }
      rethrow;
    }
  }

  /// Load paired devices from storage
  Future<void> _loadPairedDevices() async {
    try {
      final devicesJson = await _secureStorage.read(key: _keyPairedDevices);
      
      if (devicesJson != null) {
        final devicesList = json.decode(devicesJson) as List<dynamic>;
        _pairedDevices.clear();
        
        for (final deviceMap in devicesList) {
          if (deviceMap is Map<String, dynamic>) {
            _pairedDevices.add(BleDeviceInfo(
              name: deviceMap['name'] as String,
              address: deviceMap['address'] as String,
              isConnected: false, // Connection status is determined at runtime
            ));
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Error loading paired devices: $e');
      }
    }
  }

  /// Save paired devices to storage
  Future<void> _savePairedDevices() async {
    try {
      final devicesList = _pairedDevices.map((device) => {
        'name': device.name,
        'address': device.address,
      }).toList();
      
      final devicesJson = json.encode(devicesList);
      await _secureStorage.write(key: _keyPairedDevices, value: devicesJson);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error saving paired devices: $e');
      }
      rethrow;
    }
  }

  /// Load preferences from storage
  Future<void> _loadPreferences() async {
    try {
      // Load preferred device
      _preferredDeviceId = await _secureStorage.read(key: _keyPreferredDevice);
      
      // Load auto-reconnect setting
      final autoReconnectStr = await _secureStorage.read(key: _keyAutoReconnect);
      if (autoReconnectStr != null) {
        _autoReconnectEnabled = autoReconnectStr.toLowerCase() == 'true';
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Error loading preferences: $e');
      }
    }
  }

  /// Save preferences to storage
  Future<void> _savePreferences() async {
    try {
      if (_preferredDeviceId != null) {
        await _secureStorage.write(key: _keyPreferredDevice, value: _preferredDeviceId!);
      } else {
        await _secureStorage.delete(key: _keyPreferredDevice);
      }
      
      await _secureStorage.write(key: _keyAutoReconnect, value: _autoReconnectEnabled.toString());
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error saving preferences: $e');
      }
      rethrow;
    }
  }

  /// Remove device settings for a specific device
  Future<void> _removeDeviceSettings(String deviceAddress) async {
    try {
      await _secureStorage.delete(key: '$_keyDeviceSettings$deviceAddress');
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Error removing device settings: $e');
      }
    }
  }

  /// Dispose resources
  void dispose() {
    _pairedDevicesController.close();
  }
}

/// Settings for a specific BLE device
class BleDeviceSettings {
  final bool enableBatteryMonitoring;
  final bool enableRawDataLogging;
  final Duration reconnectTimeout;
  final int reconnectRetries;
  final bool enableHeartRateAlerts;
  final int? minHeartRate;
  final int? maxHeartRate;

  const BleDeviceSettings({
    required this.enableBatteryMonitoring,
    required this.enableRawDataLogging,
    required this.reconnectTimeout,
    required this.reconnectRetries,
    required this.enableHeartRateAlerts,
    this.minHeartRate,
    this.maxHeartRate,
  });

  factory BleDeviceSettings.defaultSettings() {
    return const BleDeviceSettings(
      enableBatteryMonitoring: true,
      enableRawDataLogging: false,
      reconnectTimeout: Duration(seconds: 10),
      reconnectRetries: 3,
      enableHeartRateAlerts: false,
      minHeartRate: null,
      maxHeartRate: null,
    );
  }

  factory BleDeviceSettings.fromJson(Map<String, dynamic> json) {
    return BleDeviceSettings(
      enableBatteryMonitoring: json['enableBatteryMonitoring'] as bool? ?? true,
      enableRawDataLogging: json['enableRawDataLogging'] as bool? ?? false,
      reconnectTimeout: Duration(seconds: json['reconnectTimeoutSeconds'] as int? ?? 10),
      reconnectRetries: json['reconnectRetries'] as int? ?? 3,
      enableHeartRateAlerts: json['enableHeartRateAlerts'] as bool? ?? false,
      minHeartRate: json['minHeartRate'] as int?,
      maxHeartRate: json['maxHeartRate'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enableBatteryMonitoring': enableBatteryMonitoring,
      'enableRawDataLogging': enableRawDataLogging,
      'reconnectTimeoutSeconds': reconnectTimeout.inSeconds,
      'reconnectRetries': reconnectRetries,
      'enableHeartRateAlerts': enableHeartRateAlerts,
      'minHeartRate': minHeartRate,
      'maxHeartRate': maxHeartRate,
    };
  }

  BleDeviceSettings copyWith({
    bool? enableBatteryMonitoring,
    bool? enableRawDataLogging,
    Duration? reconnectTimeout,
    int? reconnectRetries,
    bool? enableHeartRateAlerts,
    int? minHeartRate,
    int? maxHeartRate,
  }) {
    return BleDeviceSettings(
      enableBatteryMonitoring: enableBatteryMonitoring ?? this.enableBatteryMonitoring,
      enableRawDataLogging: enableRawDataLogging ?? this.enableRawDataLogging,
      reconnectTimeout: reconnectTimeout ?? this.reconnectTimeout,
      reconnectRetries: reconnectRetries ?? this.reconnectRetries,
      enableHeartRateAlerts: enableHeartRateAlerts ?? this.enableHeartRateAlerts,
      minHeartRate: minHeartRate ?? this.minHeartRate,
      maxHeartRate: maxHeartRate ?? this.maxHeartRate,
    );
  }
}