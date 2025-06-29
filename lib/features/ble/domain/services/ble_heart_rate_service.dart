import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// BLE Heart Rate Service for connecting to heart rate monitors
/// 
/// Supports standard Heart Rate Service (0x180D) devices like:
/// - Polar H10, H9, H7
/// - Garmin HRM-Pro, HRM-Dual  
/// - Apple Watch (when paired)
/// - Wahoo TICKR series
class BleHeartRateService {
  static const String heartRateServiceUuid = '0000180d-0000-1000-8000-00805f9b34fb';
  static const String heartRateMeasurementUuid = '00002a37-0000-1000-8000-00805f9b34fb';
  static const String batteryServiceUuid = '0000180f-0000-1000-8000-00805f9b34fb';
  static const String batteryLevelUuid = '00002a19-0000-1000-8000-00805f9b34fb';

  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _heartRateCharacteristic;
  // TODO: Implement battery level monitoring
  // BluetoothCharacteristic? _batteryCharacteristic;
  
  StreamSubscription<List<int>>? _heartRateSubscription;
  final StreamController<HeartRateReading> _heartRateController = 
      StreamController<HeartRateReading>.broadcast();
  
  final StreamController<BleConnectionState> _connectionController = 
      StreamController<BleConnectionState>.broadcast();
      
  final StreamController<int> _batteryController = 
      StreamController<int>.broadcast();

  /// Stream of heart rate readings with RR intervals
  Stream<HeartRateReading> get heartRateStream => _heartRateController.stream;
  
  /// Stream of connection state changes
  Stream<BleConnectionState> get connectionStream => _connectionController.stream;
  
  /// Stream of battery level updates
  Stream<int> get batteryStream => _batteryController.stream;

  /// Check if Bluetooth is available and enabled
  Future<bool> isBluetoothAvailable() async {
    try {
      if (kIsWeb) {
        // Web Bluetooth API support is limited
        return false;
      }
      
      final isSupported = await FlutterBluePlus.isSupported;
      if (!isSupported) return false;
      
      final adapterState = await FlutterBluePlus.adapterState.first;
      return adapterState == BluetoothAdapterState.on;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error checking Bluetooth availability: $e');
      }
      return false;
    }
  }

  /// Start scanning for heart rate devices
  Stream<BluetoothDevice> scanForHeartRateDevices({
    Duration timeout = const Duration(seconds: 10),
  }) async* {
    try {
      if (kIsWeb) {
        throw UnsupportedError('BLE scanning not supported on web platform');
      }

      _connectionController.add(BleConnectionState.scanning);
      
      // Start scanning for devices with Heart Rate Service
      await FlutterBluePlus.startScan(
        withServices: [Guid(heartRateServiceUuid)],
        timeout: timeout,
      );

      // Listen to scan results
      await for (final scanResult in FlutterBluePlus.scanResults) {
        for (final result in scanResult) {
          final device = result.device;
          
          // Filter for heart rate devices
          if (_isHeartRateDevice(result)) {
            yield device;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error scanning for devices: $e');
      }
      _connectionController.add(BleConnectionState.error);
    } finally {
      await FlutterBluePlus.stopScan();
      _connectionController.add(BleConnectionState.disconnected);
    }
  }

  /// Connect to a heart rate device
  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      _connectionController.add(BleConnectionState.connecting);
      
      // Connect to the device
      await device.connect(timeout: const Duration(seconds: 15));
      _connectedDevice = device;
      
      // Discover services
      final services = await device.discoverServices();
      
      // Find Heart Rate Service
      BluetoothService? heartRateService;
      for (final service in services) {
        if (service.uuid.toString().toLowerCase() == heartRateServiceUuid) {
          heartRateService = service;
          break;
        }
      }
      
      if (heartRateService == null) {
        throw Exception('Heart Rate Service not found on device');
      }

      // Find Heart Rate Measurement characteristic
      for (final characteristic in heartRateService.characteristics) {
        if (characteristic.uuid.toString().toLowerCase() == heartRateMeasurementUuid) {
          _heartRateCharacteristic = characteristic;
          break;
        }
      }

      if (_heartRateCharacteristic == null) {
        throw Exception('Heart Rate Measurement characteristic not found');
      }

      // Find Battery Service (optional)
      await _setupBatteryService(services);

      // Enable notifications for heart rate measurements
      await _heartRateCharacteristic!.setNotifyValue(true);
      
      // Subscribe to heart rate notifications
      _heartRateSubscription = _heartRateCharacteristic!.onValueReceived.listen(
        _processHeartRateData,
        onError: (Object error) {
          if (kDebugMode) {
            debugPrint('Heart rate subscription error: $error');
          }
          _connectionController.add(BleConnectionState.error);
        },
      );

      _connectionController.add(BleConnectionState.connected);
      
      if (kDebugMode) {
        debugPrint('Successfully connected to heart rate device: ${device.platformName}');
      }
      
      return true;

    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to connect to device: $e');
      }
      
      _connectionController.add(BleConnectionState.error);
      await disconnect();
      return false;
    }
  }

  /// Disconnect from the current device
  Future<void> disconnect() async {
    try {
      await _heartRateSubscription?.cancel();
      _heartRateSubscription = null;
      
      await _connectedDevice?.disconnect();
      _connectedDevice = null;
      _heartRateCharacteristic = null;
      // _batteryCharacteristic = null;
      
      _connectionController.add(BleConnectionState.disconnected);
      
      if (kDebugMode) {
        debugPrint('Disconnected from heart rate device');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error during disconnect: $e');
      }
    }
  }

  /// Get current connection state
  BleConnectionState get connectionState {
    if (_connectedDevice?.isConnected == true) {
      return BleConnectionState.connected;
    }
    return BleConnectionState.disconnected;
  }

  /// Get connected device info
  BleDeviceInfo? get connectedDeviceInfo {
    if (_connectedDevice == null) return null;
    
    return BleDeviceInfo(
      name: _connectedDevice!.platformName.isNotEmpty 
          ? _connectedDevice!.platformName 
          : 'Unknown Device',
      address: _connectedDevice!.remoteId.toString(),
      isConnected: _connectedDevice!.isConnected,
    );
  }

  /// Setup battery service if available
  Future<void> _setupBatteryService(List<BluetoothService> services) async {
    try {
      for (final service in services) {
        if (service.uuid.toString().toLowerCase() == batteryServiceUuid) {
          for (final characteristic in service.characteristics) {
            if (characteristic.uuid.toString().toLowerCase() == batteryLevelUuid) {
              // _batteryCharacteristic = characteristic;
              
              // Read initial battery level
              final batteryData = await characteristic.read();
              if (batteryData.isNotEmpty) {
                _batteryController.add(batteryData[0]);
              }
              
              // Enable battery level notifications if supported
              if (characteristic.properties.notify) {
                await characteristic.setNotifyValue(true);
                characteristic.onValueReceived.listen((data) {
                  if (data.isNotEmpty) {
                    _batteryController.add(data[0]);
                  }
                });
              }
              
              break;
            }
          }
          break;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error setting up battery service: $e');
      }
    }
  }

  /// Check if scan result is a heart rate device
  bool _isHeartRateDevice(ScanResult result) {
    // Check service UUIDs
    final serviceUuids = result.advertisementData.serviceUuids;
    for (final uuid in serviceUuids) {
      if (uuid.toString().toLowerCase() == heartRateServiceUuid) {
        return true;
      }
    }
    
    // Check device name patterns for common heart rate monitors
    final deviceName = result.device.platformName.toLowerCase();
    const heartRateDevicePatterns = [
      'polar h',
      'garmin hrm',
      'wahoo tickr',
      'suunto',
      'heart rate',
      'hrm',
    ];
    
    for (final pattern in heartRateDevicePatterns) {
      if (deviceName.contains(pattern)) {
        return true;
      }
    }
    
    return false;
  }

  /// Process incoming heart rate data
  void _processHeartRateData(List<int> data) {
    try {
      if (data.isEmpty) return;

      final buffer = Uint8List.fromList(data);
      final flags = buffer[0];
      
      // Determine heart rate value format (8-bit or 16-bit)
      final is16Bit = (flags & 0x01) != 0;
      
      int heartRate;
      int offset = 1;
      
      if (is16Bit) {
        heartRate = buffer[1] | (buffer[2] << 8);
        offset = 3;
      } else {
        heartRate = buffer[1];
        offset = 2;
      }

      // Extract RR intervals if present
      final List<double> rrIntervals = [];
      final hasRrIntervals = (flags & 0x10) != 0;
      
      if (hasRrIntervals && buffer.length > offset) {
        for (int i = offset; i < buffer.length; i += 2) {
          if (i + 1 < buffer.length) {
            final rrValue = buffer[i] | (buffer[i + 1] << 8);
            // RR intervals are in 1/1024 seconds, convert to milliseconds
            final rrMs = (rrValue / 1024.0) * 1000.0;
            rrIntervals.add(rrMs);
          }
        }
      }

      final reading = HeartRateReading(
        heartRate: heartRate,
        rrIntervals: rrIntervals,
        timestamp: DateTime.now(),
        hasRrIntervals: hasRrIntervals,
      );

      _heartRateController.add(reading);

      if (kDebugMode && rrIntervals.isNotEmpty) {
        debugPrint('HR: $heartRate BPM, RR: ${rrIntervals.length} intervals');
      }

    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error processing heart rate data: $e');
      }
    }
  }

  /// Dispose resources
  void dispose() {
    _heartRateSubscription?.cancel();
    _heartRateController.close();
    _connectionController.close();
    _batteryController.close();
  }
}

/// Heart rate reading with RR intervals
class HeartRateReading {
  final int heartRate;
  final List<double> rrIntervals;
  final DateTime timestamp;
  final bool hasRrIntervals;

  const HeartRateReading({
    required this.heartRate,
    required this.rrIntervals,
    required this.timestamp,
    required this.hasRrIntervals,
  });

  @override
  String toString() => 'HeartRateReading(HR: $heartRate, RR: ${rrIntervals.length})';
}

/// BLE connection states
enum BleConnectionState {
  disconnected,
  scanning,
  connecting,
  connected,
  error,
}

/// BLE device information
class BleDeviceInfo {
  final String name;
  final String address;
  final bool isConnected;

  const BleDeviceInfo({
    required this.name,
    required this.address,
    required this.isConnected,
  });

  @override
  String toString() => 'BleDeviceInfo($name, connected: $isConnected)';
}