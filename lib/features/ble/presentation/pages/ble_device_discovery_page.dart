import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../providers/ble_providers.dart';
import '../widgets/device_list_tile.dart';
import '../widgets/connection_status_widget.dart';
import '../../domain/services/ble_heart_rate_service.dart';

/// BLE Device Discovery Page for finding and connecting to heart rate monitors
class BleDeviceDiscoveryPage extends ConsumerStatefulWidget {
  const BleDeviceDiscoveryPage({super.key});

  @override
  ConsumerState<BleDeviceDiscoveryPage> createState() => _BleDeviceDiscoveryPageState();
}

class _BleDeviceDiscoveryPageState extends ConsumerState<BleDeviceDiscoveryPage> {
  final List<BluetoothDevice> _discoveredDevices = [];
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _checkBluetoothAndStartScan();
  }

  Future<void> _checkBluetoothAndStartScan() async {
    final bleService = ref.read(bleHeartRateServiceProvider);
    final isAvailable = await bleService.isBluetoothAvailable();
    
    if (isAvailable) {
      _startScan();
    } else {
      if (mounted) {
        _showBluetoothUnavailableDialog();
      }
    }
  }

  void _startScan() {
    if (_isScanning) return;
    
    setState(() {
      _isScanning = true;
      _discoveredDevices.clear();
    });

    final bleService = ref.read(bleHeartRateServiceProvider);
    
    bleService.scanForHeartRateDevices(
      timeout: const Duration(seconds: 15),
    ).listen(
      (BluetoothDevice device) {
        if (!_discoveredDevices.any((d) => d.remoteId == device.remoteId)) {
          setState(() {
            _discoveredDevices.add(device);
          });
        }
      },
      onError: (Object error) {
        if (mounted) {
          _showErrorSnackBar('Scan error: $error');
        }
      },
      onDone: () {
        if (mounted) {
          setState(() {
            _isScanning = false;
          });
        }
      },
    );
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      final bleService = ref.read(bleHeartRateServiceProvider);
      final success = await bleService.connectToDevice(device);
      
      if (success && mounted) {
        _showSuccessSnackBar('Connected to ${device.platformName}');
        Navigator.of(context).pop(device);
      } else if (mounted) {
        _showErrorSnackBar('Failed to connect to ${device.platformName}');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Connection error: $e');
      }
    }
  }

  void _showBluetoothUnavailableDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bluetooth Unavailable'),
        content: const Text(
          'Bluetooth is not available or not enabled. Please enable Bluetooth and try again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final connectionState = ref.watch(bleConnectionStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Rate Monitors'),
        actions: [
          if (!_isScanning)
            IconButton(
              onPressed: _startScan,
              icon: const Icon(Icons.refresh),
              tooltip: 'Scan for devices',
            ),
        ],
      ),
      body: Column(
        children: [
          // Connection Status
          ConnectionStatusWidget(connectionState: connectionState),
          
          // Scanning indicator
          if (_isScanning)
            const LinearProgressIndicator()
          else
            const SizedBox(height: 4),
          
          // Instructions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'How to Connect',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Make sure your heart rate monitor is turned on\n'
                      '2. Put it in pairing mode (check device manual)\n'
                      '3. Tap "Scan for devices" if no devices appear\n'
                      '4. Tap on your device to connect',
                      style: TextStyle(height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Device List
          Expanded(
            child: _discoveredDevices.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _discoveredDevices.length,
                    itemBuilder: (context, index) {
                      final device = _discoveredDevices[index];
                      return DeviceListTile(
                        device: device,
                        onTap: () => _connectToDevice(device),
                        isConnecting: connectionState.valueOrNull == BleConnectionState.connecting,
                      );
                    },
                  ),
          ),
          
          // Supported Devices Info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Supported Devices',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Polar (H10, H9, H7) • Garmin (HRM-Pro, HRM-Dual) • Wahoo TICKR • Apple Watch • Suunto',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bluetooth_searching,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            _isScanning ? 'Scanning for heart rate monitors...' : 'No devices found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          if (!_isScanning)
            Text(
              'Tap the refresh button to scan again',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          if (!_isScanning)
            const SizedBox(height: 16),
          if (!_isScanning)
            ElevatedButton.icon(
              onPressed: _startScan,
              icon: const Icon(Icons.bluetooth_searching),
              label: const Text('Scan for Devices'),
            ),
        ],
      ),
    );
  }
}