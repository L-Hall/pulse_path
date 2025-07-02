import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'ble_heart_rate_service.dart';
import '../../data/repositories/ble_device_repository.dart';

/// Advanced BLE connection manager with auto-reconnect and stability features
/// 
/// Provides:
/// - Automatic reconnection to preferred devices
/// - Connection stability monitoring
/// - Background connection maintenance
/// - Smart retry logic with exponential backoff
class BleConnectionManager {
  final BleHeartRateService _bleService;
  final BleDeviceRepository _deviceRepository;
  
  Timer? _reconnectTimer;
  Timer? _connectionMonitorTimer;
  Timer? _backgroundMaintenanceTimer;
  
  bool _isReconnecting = false;
  int _reconnectAttempts = 0;
  DateTime? _lastConnectionLoss;
  
  final StreamController<BleConnectionEvent> _eventController = 
      StreamController<BleConnectionEvent>.broadcast();

  BleConnectionManager({
    required BleHeartRateService bleService,
    required BleDeviceRepository deviceRepository,
  })  : _bleService = bleService,
        _deviceRepository = deviceRepository;

  /// Stream of connection events
  Stream<BleConnectionEvent> get eventStream => _eventController.stream;

  /// Initialize connection manager
  Future<void> initialize() async {
    try {
      await _deviceRepository.initialize();
      
      // Listen to connection state changes
      _bleService.connectionStream.listen(_handleConnectionStateChange);
      
      // Start background maintenance
      _startBackgroundMaintenance();
      
      // Auto-connect to preferred device if enabled
      if (_deviceRepository.autoReconnectEnabled) {
        _scheduleAutoConnect();
      }
      
      if (kDebugMode) {
        debugPrint('✅ BleConnectionManager initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error initializing BleConnectionManager: $e');
      }
    }
  }

  /// Attempt to connect to preferred device
  Future<bool> connectToPreferredDevice() async {
    final preferredDevice = _deviceRepository.getPreferredDevice();
    
    if (preferredDevice == null) {
      _eventController.add(BleConnectionEvent.noPreferredDevice());
      return false;
    }

    return await _connectToDeviceByAddress(preferredDevice.address);
  }

  /// Connect to device by address with retry logic
  Future<bool> _connectToDeviceByAddress(String deviceAddress) async {
    if (_isReconnecting) {
      if (kDebugMode) {
        debugPrint('🔄 Already reconnecting, skipping...');
      }
      return false;
    }

    try {
      _isReconnecting = true;
      _eventController.add(BleConnectionEvent.connecting(deviceAddress));
      
      // Get device settings for connection parameters
      final settings = await _deviceRepository.getDeviceSettings(deviceAddress);
      
      // Find the device
      BluetoothDevice? targetDevice;
      
      // First try to find in scan results
      if (await FlutterBluePlus.isSupported && !kIsWeb) {
        await FlutterBluePlus.startScan(
          timeout: Duration(seconds: settings.reconnectTimeout.inSeconds ~/ 2),
        );
        
        await for (final scanResults in FlutterBluePlus.scanResults) {
          for (final result in scanResults) {
            if (result.device.remoteId.toString() == deviceAddress) {
              targetDevice = result.device;
              await FlutterBluePlus.stopScan();
              break;
            }
          }
          if (targetDevice != null) break;
        }
      }
      
      if (targetDevice == null) {
        throw Exception('Device not found: $deviceAddress');
      }

      // Attempt connection with retries
      bool connected = false;
      for (int attempt = 1; attempt <= settings.reconnectRetries; attempt++) {
        try {
          if (kDebugMode) {
            debugPrint('🔄 Connection attempt $attempt/${settings.reconnectRetries} to $deviceAddress');
          }
          
          connected = await _bleService.connectToDevice(targetDevice);
          
          if (connected) {
            _reconnectAttempts = 0;
            _eventController.add(BleConnectionEvent.connected(deviceAddress));
            
            // Start connection monitoring
            _startConnectionMonitoring();
            
            if (kDebugMode) {
              debugPrint('✅ Successfully connected to $deviceAddress');
            }
            break;
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('⚠️ Connection attempt $attempt failed: $e');
          }
          
          if (attempt < settings.reconnectRetries) {
            // Exponential backoff
            final delay = Duration(seconds: (2 * attempt).clamp(1, 10));
            await Future.delayed(delay);
          }
        }
      }
      
      if (!connected) {
        _reconnectAttempts++;
        _eventController.add(BleConnectionEvent.failed(deviceAddress, _reconnectAttempts));
        
        // Schedule retry with exponential backoff
        if (_deviceRepository.autoReconnectEnabled) {
          _scheduleReconnect();
        }
      }
      
      return connected;
      
    } catch (e) {
      _reconnectAttempts++;
      _eventController.add(BleConnectionEvent.error(deviceAddress, e.toString()));
      
      if (kDebugMode) {
        debugPrint('❌ Connection error: $e');
      }
      
      // Schedule retry if auto-reconnect is enabled
      if (_deviceRepository.autoReconnectEnabled) {
        _scheduleReconnect();
      }
      
      return false;
    } finally {
      _isReconnecting = false;
    }
  }

  /// Handle connection state changes
  void _handleConnectionStateChange(BleConnectionState state) {
    switch (state) {
      case BleConnectionState.connected:
        _reconnectAttempts = 0;
        _lastConnectionLoss = null;
        break;
        
      case BleConnectionState.disconnected:
        _lastConnectionLoss = DateTime.now();
        _stopConnectionMonitoring();
        
        // Trigger auto-reconnect if enabled
        if (_deviceRepository.autoReconnectEnabled && !_isReconnecting) {
          _scheduleReconnect();
        }
        break;
        
      case BleConnectionState.error:
        _lastConnectionLoss = DateTime.now();
        _stopConnectionMonitoring();
        
        // Trigger auto-reconnect with delay
        if (_deviceRepository.autoReconnectEnabled) {
          _scheduleReconnect();
        }
        break;
        
      default:
        break;
    }
  }

  /// Schedule auto-connect attempt
  void _scheduleAutoConnect() {
    // Small delay to allow for proper initialization
    _reconnectTimer = Timer(const Duration(seconds: 2), () {
      connectToPreferredDevice();
    });
  }

  /// Schedule reconnection with exponential backoff
  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    
    // Calculate delay with exponential backoff (max 60 seconds)
    final baseDelay = Duration(seconds: (2 * _reconnectAttempts).clamp(5, 60));
    
    if (kDebugMode) {
      debugPrint('📅 Scheduling reconnect in ${baseDelay.inSeconds}s (attempt ${_reconnectAttempts + 1})');
    }
    
    _reconnectTimer = Timer(baseDelay, () {
      connectToPreferredDevice();
    });
    
    _eventController.add(BleConnectionEvent.retryScheduled(baseDelay));
  }

  /// Start connection monitoring
  void _startConnectionMonitoring() {
    _connectionMonitorTimer?.cancel();
    
    // Monitor connection every 30 seconds
    _connectionMonitorTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkConnectionHealth();
    });
  }

  /// Stop connection monitoring
  void _stopConnectionMonitoring() {
    _connectionMonitorTimer?.cancel();
    _connectionMonitorTimer = null;
  }

  /// Check connection health
  void _checkConnectionHealth() {
    final isConnected = _bleService.connectionState == BleConnectionState.connected;
    
    if (!isConnected) {
      if (kDebugMode) {
        debugPrint('⚠️ Connection health check failed - device disconnected');
      }
      
      _stopConnectionMonitoring();
      
      // Trigger reconnect if auto-reconnect is enabled
      if (_deviceRepository.autoReconnectEnabled) {
        _scheduleReconnect();
      }
    } else {
      _eventController.add(BleConnectionEvent.healthCheck(true));
    }
  }

  /// Start background maintenance tasks
  void _startBackgroundMaintenance() {
    // Run maintenance every 5 minutes
    _backgroundMaintenanceTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _performMaintenanceTasks();
    });
  }

  /// Perform background maintenance tasks
  void _performMaintenanceTasks() {
    if (kDebugMode) {
      debugPrint('🔧 Performing background maintenance...');
    }
    
    // Check if we should attempt reconnection to preferred device
    if (_deviceRepository.autoReconnectEnabled &&
        _bleService.connectionState == BleConnectionState.disconnected &&
        !_isReconnecting) {
      
      final preferredDevice = _deviceRepository.getPreferredDevice();
      if (preferredDevice != null) {
        connectToPreferredDevice();
      }
    }
    
    // Cleanup old connection events
    // (Events are automatically cleaned up by stream controller)
  }

  /// Force disconnect and stop all reconnection attempts
  void forceDisconnect() {
    _stopAllTimers();
    _isReconnecting = false;
    _bleService.disconnect();
    
    _eventController.add(BleConnectionEvent.manualDisconnect());
    
    if (kDebugMode) {
      debugPrint('🛑 Forced disconnect - all reconnection attempts stopped');
    }
  }

  /// Enable/disable auto-reconnect
  Future<void> setAutoReconnect(bool enabled) async {
    await _deviceRepository.setAutoReconnect(enabled);
    
    if (enabled && _bleService.connectionState == BleConnectionState.disconnected) {
      _scheduleAutoConnect();
    } else if (!enabled) {
      _stopAllTimers();
    }
    
    _eventController.add(BleConnectionEvent.autoReconnectChanged(enabled));
  }

  /// Get connection statistics
  BleConnectionStats getConnectionStats() {
    return BleConnectionStats(
      isConnected: _bleService.connectionState == BleConnectionState.connected,
      isReconnecting: _isReconnecting,
      reconnectAttempts: _reconnectAttempts,
      lastConnectionLoss: _lastConnectionLoss,
      autoReconnectEnabled: _deviceRepository.autoReconnectEnabled,
      preferredDevice: _deviceRepository.getPreferredDevice(),
    );
  }

  /// Stop all timers
  void _stopAllTimers() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    
    _connectionMonitorTimer?.cancel();
    _connectionMonitorTimer = null;
  }

  /// Dispose resources
  void dispose() {
    _stopAllTimers();
    
    _backgroundMaintenanceTimer?.cancel();
    _backgroundMaintenanceTimer = null;
    
    _eventController.close();
    
    if (kDebugMode) {
      debugPrint('🗑️ BleConnectionManager disposed');
    }
  }
}

/// Connection event types
class BleConnectionEvent {
  final BleConnectionEventType type;
  final String? deviceAddress;
  final String? message;
  final Duration? delay;
  final int? attemptCount;
  final bool? enabled;
  final DateTime timestamp;

  BleConnectionEvent._({
    required this.type,
    this.deviceAddress,
    this.message,
    this.delay,
    this.attemptCount,
    this.enabled,
  }) : timestamp = DateTime.now();

  factory BleConnectionEvent.connecting(String deviceAddress) =>
      BleConnectionEvent._(type: BleConnectionEventType.connecting, deviceAddress: deviceAddress);

  factory BleConnectionEvent.connected(String deviceAddress) =>
      BleConnectionEvent._(type: BleConnectionEventType.connected, deviceAddress: deviceAddress);

  factory BleConnectionEvent.failed(String deviceAddress, int attempts) =>
      BleConnectionEvent._(type: BleConnectionEventType.failed, deviceAddress: deviceAddress, attemptCount: attempts);

  factory BleConnectionEvent.error(String deviceAddress, String error) =>
      BleConnectionEvent._(type: BleConnectionEventType.error, deviceAddress: deviceAddress, message: error);

  factory BleConnectionEvent.retryScheduled(Duration delay) =>
      BleConnectionEvent._(type: BleConnectionEventType.retryScheduled, delay: delay);

  factory BleConnectionEvent.healthCheck(bool isHealthy) =>
      BleConnectionEvent._(type: BleConnectionEventType.healthCheck, enabled: isHealthy);

  factory BleConnectionEvent.manualDisconnect() =>
      BleConnectionEvent._(type: BleConnectionEventType.manualDisconnect);

  factory BleConnectionEvent.autoReconnectChanged(bool enabled) =>
      BleConnectionEvent._(type: BleConnectionEventType.autoReconnectChanged, enabled: enabled);

  factory BleConnectionEvent.noPreferredDevice() =>
      BleConnectionEvent._(type: BleConnectionEventType.noPreferredDevice);

  @override
  String toString() => 'BleConnectionEvent($type, device: $deviceAddress, message: $message)';
}

/// Types of connection events
enum BleConnectionEventType {
  connecting,
  connected,
  failed,
  error,
  retryScheduled,
  healthCheck,
  manualDisconnect,
  autoReconnectChanged,
  noPreferredDevice,
}

/// Connection statistics
class BleConnectionStats {
  final bool isConnected;
  final bool isReconnecting;
  final int reconnectAttempts;
  final DateTime? lastConnectionLoss;
  final bool autoReconnectEnabled;
  final BleDeviceInfo? preferredDevice;

  const BleConnectionStats({
    required this.isConnected,
    required this.isReconnecting,
    required this.reconnectAttempts,
    required this.lastConnectionLoss,
    required this.autoReconnectEnabled,
    required this.preferredDevice,
  });

  Duration? get timeSinceLastLoss {
    if (lastConnectionLoss == null) return null;
    return DateTime.now().difference(lastConnectionLoss!);
  }

  @override
  String toString() => 'BleConnectionStats(connected: $isConnected, reconnecting: $isReconnecting, attempts: $reconnectAttempts)';
}