import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:watch_connectivity/watch_connectivity.dart';
import '../models/apple_watch_data.dart';
import '../../../../shared/models/hrv_reading.dart';

/// Service for direct communication with Apple Watch using WatchConnectivity framework
/// 
/// Provides:
/// - Real-time bidirectional communication with Apple Watch
/// - Sending HRV scores and insights to Watch
/// - Receiving real-time health data from Watch
/// - Background communication support
class WatchConnectivityService {
  static final WatchConnectivityService _instance = WatchConnectivityService._internal();
  factory WatchConnectivityService() => _instance;
  WatchConnectivityService._internal();

  WatchConnectivity? _watchConnectivity;
  bool _isInitialized = false;
  
  // Stream controllers for Watch communication
  final StreamController<AppleWatchStreamData> _dataController = 
      StreamController<AppleWatchStreamData>.broadcast();
  final StreamController<WatchConnectivityStatus> _statusController = 
      StreamController<WatchConnectivityStatus>.broadcast();
  final StreamController<Map<String, dynamic>> _messageController = 
      StreamController<Map<String, dynamic>>.broadcast();

  // Current connectivity status
  WatchConnectivityStatus _currentStatus = const WatchConnectivityStatus(
    isSupported: false,
    isPaired: false,
    isWatchAppInstalled: false,
    isReachable: false,
  );

  /// Stream of real-time data from Apple Watch
  Stream<AppleWatchStreamData> get dataStream => _dataController.stream;

  /// Stream of Watch connectivity status changes
  Stream<WatchConnectivityStatus> get statusStream => _statusController.stream;

  /// Stream of messages received from Apple Watch
  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;

  /// Current Watch connectivity status
  WatchConnectivityStatus get currentStatus => _currentStatus;

  /// Whether Watch communication is available
  bool get isWatchReachable => _currentStatus.isReachable && _currentStatus.isWatchAppInstalled;

  /// Initialize Watch Connectivity
  Future<bool> initialize() async {
    if (!Platform.isIOS) {
      if (kDebugMode) {
        debugPrint('WatchConnectivity only available on iOS');
      }
      return false;
    }

    try {
      _watchConnectivity = WatchConnectivity();
      
      // Check if WatchConnectivity is supported
      final isSupported = await _watchConnectivity!.isSupported;
      if (!isSupported) {
        if (kDebugMode) {
          debugPrint('WatchConnectivity not supported on this device');
        }
        return false;
      }

      // Setup listeners for Watch events
      await _setupWatchListeners();

      // Get initial status
      await _updateConnectivityStatus();

      // Note: No explicit session activation needed in this package version
      // Session is automatically activated when WatchConnectivity() is instantiated

      _isInitialized = true;

      if (kDebugMode) {
        debugPrint('✅ WatchConnectivityService initialized');
        debugPrint('Watch Status: ${_currentStatus}');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error initializing WatchConnectivityService: $e');
      }
      return false;
    }
  }

  /// Setup listeners for Watch connectivity events
  Future<void> _setupWatchListeners() async {
    if (_watchConnectivity == null) return;

    try {
      // Listen for session state changes
      _watchConnectivity!.messageStream.listen(
        _handleIncomingMessage,
        onError: (error) {
          if (kDebugMode) {
            debugPrint('Watch message stream error: $error');
          }
        },
      );

      // Listen for application context updates
      _watchConnectivity!.contextStream.listen(
        _handleApplicationContextUpdate,
        onError: (error) {
          if (kDebugMode) {
            debugPrint('Watch context stream error: $error');
          }
        },
      );

      if (kDebugMode) {
        debugPrint('✅ Watch listeners setup complete');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error setting up watch listeners: $e');
      }
    }
  }

  /// Update connectivity status
  Future<void> _updateConnectivityStatus() async {
    if (_watchConnectivity == null) return;

    try {
      final isSupported = await _watchConnectivity!.isSupported;
      final isPaired = await _watchConnectivity!.isPaired;
      // Note: isWatchAppInstalled not available in current package version
      final isWatchAppInstalled = false; // Default to false for compatibility
      final isReachable = await _watchConnectivity!.isReachable;

      final newStatus = WatchConnectivityStatus(
        isSupported: isSupported,
        isPaired: isPaired,
        isWatchAppInstalled: isWatchAppInstalled,
        isReachable: isReachable,
        lastStatusUpdate: DateTime.now(),
      );

      _currentStatus = newStatus;
      _statusController.add(newStatus);

      if (kDebugMode) {
        debugPrint('📊 Watch connectivity status updated: $newStatus');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error updating connectivity status: $e');
      }
    }
  }

  /// Handle incoming messages from Apple Watch
  void _handleIncomingMessage(Map<String, dynamic> message) {
    try {
      if (kDebugMode) {
        debugPrint('📨 Received message from Watch: $message');
      }

      _messageController.add(message);

      // Parse specific message types
      final messageType = message['type'] as String?;
      
      switch (messageType) {
        case 'realtime_data':
          _handleRealtimeData(message);
          break;
        case 'hrv_request':
          _handleHrvRequest(message);
          break;
        case 'status_update':
          _handleStatusUpdate(message);
          break;
        default:
          if (kDebugMode) {
            debugPrint('Unknown message type: $messageType');
          }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error handling incoming message: $e');
      }
    }
  }

  /// Handle real-time data from Apple Watch
  void _handleRealtimeData(Map<String, dynamic> message) {
    try {
      final data = message['data'] as Map<String, dynamic>?;
      if (data == null) return;

      final streamData = AppleWatchStreamData(
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          data['timestamp'] as int? ?? DateTime.now().millisecondsSinceEpoch,
        ),
        instantHeartRate: (data['heartRate'] as num?)?.toDouble(),
        rrIntervals: (data['rrIntervals'] as List<dynamic>?)
            ?.map((e) => (e as num).toDouble())
            .toList(),
        currentSteps: data['steps'] as int?,
        isInWorkout: data['isInWorkout'] as bool?,
        workoutType: data['workoutType'] as String?,
      );

      _dataController.add(streamData);

      if (kDebugMode) {
        debugPrint('📊 Real-time data received: HR=${streamData.instantHeartRate}, Steps=${streamData.currentSteps}');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error handling real-time data: $e');
      }
    }
  }

  /// Handle HRV data request from Apple Watch
  void _handleHrvRequest(Map<String, dynamic> message) {
    // Apple Watch is requesting latest HRV scores
    // This would integrate with the HRV service to send back latest scores
    if (kDebugMode) {
      debugPrint('📈 Apple Watch requesting HRV data');
    }
    
    // TODO: Integrate with HRV service to send current scores
  }

  /// Handle status updates from Apple Watch
  void _handleStatusUpdate(Map<String, dynamic> message) {
    final batteryLevel = (message['batteryLevel'] as num?)?.toDouble();
    final watchOSVersion = message['watchOSVersion'] as String?;
    
    if (kDebugMode) {
      debugPrint('🔋 Watch status update: Battery=$batteryLevel%, watchOS=$watchOSVersion');
    }
  }

  /// Handle application context updates
  void _handleApplicationContextUpdate(Map<String, dynamic> context) {
    try {
      if (kDebugMode) {
        debugPrint('📋 Application context updated: $context');
      }

      // Handle persistent data updates from Watch
      final lastSync = context['lastSync'] as String?;
      if (lastSync != null) {
        // Update last sync timestamp
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error handling context update: $e');
      }
    }
  }

  /// Send HRV reading to Apple Watch
  Future<bool> sendHrvReading(HrvReading reading) async {
    if (!isWatchReachable || _watchConnectivity == null) {
      if (kDebugMode) {
        debugPrint('⚠️ Cannot send HRV reading - Watch not reachable');
      }
      return false;
    }

    try {
      final message = {
        'type': 'hrv_reading',
        'data': {
          'timestamp': reading.timestamp.millisecondsSinceEpoch,
          'stress': reading.scores.stress,
          'recovery': reading.scores.recovery,
          'energy': reading.scores.energy,
          'rmssd': reading.metrics.rmssd,
          'heartRate': (60000 / reading.metrics.meanRr).round(),
        },
      };

      await _watchConnectivity!.sendMessage(message);

      if (kDebugMode) {
        debugPrint('📤 HRV reading sent to Watch: ${reading.scores.stress}% stress');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error sending HRV reading to Watch: $e');
      }
      return false;
    }
  }

  /// Send user preferences to Apple Watch
  Future<bool> sendUserPreferences(Map<String, dynamic> preferences) async {
    if (!isWatchReachable || _watchConnectivity == null) return false;

    try {
      await _watchConnectivity!.updateApplicationContext({
        'type': 'user_preferences',
        'data': preferences,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      if (kDebugMode) {
        debugPrint('📤 User preferences sent to Watch');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error sending preferences to Watch: $e');
      }
      return false;
    }
  }

  /// Request immediate data from Apple Watch
  Future<Map<String, dynamic>?> requestImmediateData() async {
    if (!isWatchReachable || _watchConnectivity == null) return null;

    try {
      final request = {
        'type': 'immediate_data_request',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      // Send message (returns void in current package version)
      _watchConnectivity!.sendMessage(request);
      
      if (kDebugMode) {
        debugPrint('📤 Immediate data request sent');
      }

      // Note: Current package version doesn't support response from sendMessage
      return null;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error requesting immediate data: $e');
      }
      return null;
    }
  }

  /// Transfer large data file to Apple Watch
  Future<bool> transferFile(String fileName, Map<String, dynamic> data) async {
    if (!isWatchReachable || _watchConnectivity == null) return false;

    try {
      // Convert data to JSON string for file transfer
      final jsonData = jsonEncode(data);
      
      // Create temporary file
      // Note: This would require proper file handling implementation
      
      if (kDebugMode) {
        debugPrint('📁 File transfer to Watch: $fileName (${jsonData.length} bytes)');
      }

      // Use updateApplicationContext for data transfer (transferUserInfo not available)
      await _watchConnectivity!.updateApplicationContext({
        'fileName': fileName,
        'data': data,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error transferring file to Watch: $e');
      }
      return false;
    }
  }

  /// Check connectivity and update status
  Future<void> checkConnectivity() async {
    await _updateConnectivityStatus();
  }

  /// Dispose resources
  void dispose() {
    _dataController.close();
    _statusController.close();
    _messageController.close();
    _watchConnectivity = null;
    _isInitialized = false;
  }
}

/// Watch connectivity status model
@immutable
class WatchConnectivityStatus {
  final bool isSupported;
  final bool isPaired;
  final bool isWatchAppInstalled;
  final bool isReachable;
  final DateTime? lastStatusUpdate;

  const WatchConnectivityStatus({
    required this.isSupported,
    required this.isPaired,
    required this.isWatchAppInstalled,
    required this.isReachable,
    this.lastStatusUpdate,
  });

  bool get isFullyConnected => isSupported && isPaired && isWatchAppInstalled && isReachable;

  WatchConnectivityStatus copyWith({
    bool? isSupported,
    bool? isPaired,
    bool? isWatchAppInstalled,
    bool? isReachable,
    DateTime? lastStatusUpdate,
  }) {
    return WatchConnectivityStatus(
      isSupported: isSupported ?? this.isSupported,
      isPaired: isPaired ?? this.isPaired,
      isWatchAppInstalled: isWatchAppInstalled ?? this.isWatchAppInstalled,
      isReachable: isReachable ?? this.isReachable,
      lastStatusUpdate: lastStatusUpdate ?? this.lastStatusUpdate,
    );
  }

  @override
  String toString() => 'WatchConnectivityStatus('
      'supported: $isSupported, '
      'paired: $isPaired, '
      'appInstalled: $isWatchAppInstalled, '
      'reachable: $isReachable)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WatchConnectivityStatus &&
        other.isSupported == isSupported &&
        other.isPaired == isPaired &&
        other.isWatchAppInstalled == isWatchAppInstalled &&
        other.isReachable == isReachable;
  }

  @override
  int get hashCode => Object.hash(
    isSupported,
    isPaired,
    isWatchAppInstalled,
    isReachable,
  );
}