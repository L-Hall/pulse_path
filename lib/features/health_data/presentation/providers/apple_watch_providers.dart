import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/apple_watch_service.dart';
import '../../services/watch_connectivity_service.dart';
import '../../models/apple_watch_data.dart';
import '../../../../core/di/injection_container.dart';

/// Provider for AppleWatchService
final appleWatchServiceProvider = Provider<AppleWatchService>((ref) {
  return sl<AppleWatchService>();
});

/// Provider for WatchConnectivityService
final watchConnectivityServiceProvider = Provider<WatchConnectivityService>((ref) {
  return sl<WatchConnectivityService>();
});

/// Provider for Apple Watch connectivity status
final appleWatchStatusProvider = StreamProvider<AppleWatchStatus>((ref) {
  final service = ref.watch(appleWatchServiceProvider);
  return service.statusStream;
});

/// Provider for Watch Connectivity status
final watchConnectivityStatusProvider = StreamProvider<WatchConnectivityStatus>((ref) {
  final service = ref.watch(watchConnectivityServiceProvider);
  return service.statusStream;
});

/// Provider for real-time Apple Watch data stream
final appleWatchStreamDataProvider = StreamProvider<AppleWatchStreamData>((ref) {
  final service = ref.watch(appleWatchServiceProvider);
  return service.streamingDataStream;
});

/// Provider for Apple Watch readings stream
final appleWatchReadingsProvider = StreamProvider<AppleWatchReading>((ref) {
  final service = ref.watch(appleWatchServiceProvider);
  return service.readingStream;
});

/// Provider for Watch Connectivity messages
final watchConnectivityMessagesProvider = StreamProvider<Map<String, dynamic>>((ref) {
  final service = ref.watch(watchConnectivityServiceProvider);
  return service.messageStream;
});

/// Provider for checking if Apple Watch is connected and reachable
final isAppleWatchConnectedProvider = Provider<bool>((ref) {
  final statusAsync = ref.watch(appleWatchStatusProvider);
  return statusAsync.when(
    data: (status) => status.isConnected && status.isReachable,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// Provider for checking if Watch Connectivity is available
final isWatchConnectivityAvailableProvider = Provider<bool>((ref) {
  final statusAsync = ref.watch(watchConnectivityStatusProvider);
  return statusAsync.when(
    data: (status) => status.isFullyConnected,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// Provider for current Apple Watch reading
final currentAppleWatchReadingProvider = FutureProvider<AppleWatchReading?>((ref) async {
  final service = ref.watch(appleWatchServiceProvider);
  return await service.getAppleWatchReading();
});

/// Provider for manual Apple Watch sync
final manualAppleWatchSyncProvider = FutureProvider<AppleWatchReading?>((ref) async {
  final service = ref.watch(appleWatchServiceProvider);
  return await service.triggerManualSync();
});

/// Provider for Apple Watch current stream data
final currentAppleWatchStreamProvider = FutureProvider<AppleWatchStreamData?>((ref) async {
  final service = ref.watch(appleWatchServiceProvider);
  return await service.getCurrentStreamData();
});

/// Provider for Apple Watch supported capabilities
final appleWatchCapabilitiesProvider = Provider<List<WatchCapability>>((ref) {
  final statusAsync = ref.watch(appleWatchStatusProvider);
  return statusAsync.when(
    data: (status) => status.supportedCapabilities,
    loading: () => [],
    error: (_, __) => [],
  );
});

/// Provider for checking specific Apple Watch capability
final appleWatchCapabilityProvider = Provider.family<bool, WatchCapability>((ref, capability) {
  final capabilities = ref.watch(appleWatchCapabilitiesProvider);
  return capabilities.contains(capability);
});

/// Provider for Apple Watch battery level
final appleWatchBatteryProvider = FutureProvider<double?>((ref) async {
  final service = ref.watch(appleWatchServiceProvider);
  return await service.getWatchBatteryLevel();
});

/// Provider for Apple Watch connection statistics
final appleWatchConnectionStatsProvider = Provider<AppleWatchConnectionStats>((ref) {
  final watchStatusAsync = ref.watch(appleWatchStatusProvider);
  final connectivityStatusAsync = ref.watch(watchConnectivityStatusProvider);
  
  return watchStatusAsync.when(
    data: (watchStatus) => connectivityStatusAsync.when(
      data: (connectivityStatus) => AppleWatchConnectionStats(
        isWatchConnected: watchStatus.isConnected && watchStatus.isReachable,
        isConnectivityAvailable: connectivityStatus.isFullyConnected,
        deviceModel: watchStatus.deviceModel,
        watchOSVersion: watchStatus.watchOSVersion,
        batteryLevel: watchStatus.batteryLevel,
        lastDataSync: watchStatus.lastDataSync,
        lastCommunication: watchStatus.lastCommunication,
        supportedCapabilities: watchStatus.supportedCapabilities,
      ),
      loading: () => AppleWatchConnectionStats.loading(),
      error: (_, __) => AppleWatchConnectionStats.error(),
    ),
    loading: () => AppleWatchConnectionStats.loading(),
    error: (_, __) => AppleWatchConnectionStats.error(),
  );
});

/// Provider for device priority selection
final devicePriorityProvider = StateProvider<DevicePriority>((ref) {
  return DevicePriority.auto; // Default to automatic selection
});

/// Provider for preferred HRV data source based on availability and priority
final preferredHrvDataSourceProvider = Provider<HrvDataSource>((ref) {
  final devicePriority = ref.watch(devicePriorityProvider);
  final isWatchConnected = ref.watch(isAppleWatchConnectedProvider);
  final isConnectivityAvailable = ref.watch(isWatchConnectivityAvailableProvider);
  
  switch (devicePriority) {
    case DevicePriority.appleWatchOnly:
      return isWatchConnected ? HrvDataSource.appleWatch : HrvDataSource.none;
    
    case DevicePriority.bleOnly:
      // Would check BLE connection status here
      return HrvDataSource.ble;
    
    case DevicePriority.cameraOnly:
      return HrvDataSource.camera;
    
    case DevicePriority.auto:
    default:
      // Automatic priority: Apple Watch > BLE > Camera
      if (isWatchConnected && isConnectivityAvailable) {
        return HrvDataSource.appleWatch;
      }
      // Could add BLE check here
      return HrvDataSource.camera;
  }
});

/// Provider for real-time HRV monitoring status
final realTimeHrvMonitoringProvider = StateProvider<bool>((ref) {
  return false; // Default to disabled
});

/// Provider for Apple Watch real-time monitoring
final appleWatchRealtimeMonitoringProvider = Provider<Stream<AppleWatchStreamData>?>((ref) {
  final isMonitoring = ref.watch(realTimeHrvMonitoringProvider);
  final isWatchConnected = ref.watch(isAppleWatchConnectedProvider);
  
  if (isMonitoring && isWatchConnected) {
    final service = ref.watch(appleWatchServiceProvider);
    return service.streamingDataStream;
  }
  
  return null;
});

/// Connection statistics model
class AppleWatchConnectionStats {
  final bool isWatchConnected;
  final bool isConnectivityAvailable;
  final String? deviceModel;
  final String? watchOSVersion;
  final double? batteryLevel;
  final DateTime? lastDataSync;
  final DateTime? lastCommunication;
  final List<WatchCapability> supportedCapabilities;
  final bool isLoading;
  final bool hasError;

  const AppleWatchConnectionStats({
    required this.isWatchConnected,
    required this.isConnectivityAvailable,
    this.deviceModel,
    this.watchOSVersion,
    this.batteryLevel,
    this.lastDataSync,
    this.lastCommunication,
    this.supportedCapabilities = const [],
    this.isLoading = false,
    this.hasError = false,
  });

  factory AppleWatchConnectionStats.loading() => const AppleWatchConnectionStats(
    isWatchConnected: false,
    isConnectivityAvailable: false,
    isLoading: true,
  );

  factory AppleWatchConnectionStats.error() => const AppleWatchConnectionStats(
    isWatchConnected: false,
    isConnectivityAvailable: false,
    hasError: true,
  );

  bool get isFullyConnected => isWatchConnected && isConnectivityAvailable;
  
  String get connectionStatusText {
    if (isLoading) return 'Checking connection...';
    if (hasError) return 'Connection error';
    if (!isWatchConnected) return 'Apple Watch not connected';
    if (!isConnectivityAvailable) return 'Watch app not available';
    return 'Connected';
  }

  Duration? get timeSinceLastSync {
    if (lastDataSync == null) return null;
    return DateTime.now().difference(lastDataSync!);
  }

  Duration? get timeSinceLastCommunication {
    if (lastCommunication == null) return null;
    return DateTime.now().difference(lastCommunication!);
  }
}

/// Device priority options
enum DevicePriority {
  auto,           // Automatic selection based on availability
  appleWatchOnly, // Apple Watch only
  bleOnly,        // BLE devices only
  cameraOnly,     // Camera PPG only
}

/// HRV data sources
enum HrvDataSource {
  none,
  appleWatch,
  ble,
  camera,
}

/// Extensions for device priority
extension DevicePriorityExtension on DevicePriority {
  String get displayName {
    switch (this) {
      case DevicePriority.auto:
        return 'Automatic';
      case DevicePriority.appleWatchOnly:
        return 'Apple Watch Only';
      case DevicePriority.bleOnly:
        return 'BLE Device Only';
      case DevicePriority.cameraOnly:
        return 'Camera PPG Only';
    }
  }

  String get description {
    switch (this) {
      case DevicePriority.auto:
        return 'Automatically select the best available device';
      case DevicePriority.appleWatchOnly:
        return 'Use only Apple Watch for HRV measurements';
      case DevicePriority.bleOnly:
        return 'Use only Bluetooth heart rate monitors';
      case DevicePriority.cameraOnly:
        return 'Use only camera-based PPG measurements';
    }
  }
}

/// Extensions for HRV data sources
extension HrvDataSourceExtension on HrvDataSource {
  String get displayName {
    switch (this) {
      case HrvDataSource.none:
        return 'No Source';
      case HrvDataSource.appleWatch:
        return 'Apple Watch';
      case HrvDataSource.ble:
        return 'BLE Device';
      case HrvDataSource.camera:
        return 'Camera PPG';
    }
  }

  String get description {
    switch (this) {
      case HrvDataSource.none:
        return 'No HRV data source available';
      case HrvDataSource.appleWatch:
        return 'Real-time data from Apple Watch';
      case HrvDataSource.ble:
        return 'Data from Bluetooth heart rate monitor';
      case HrvDataSource.camera:
        return 'Camera-based photoplethysmography';
    }
  }
}