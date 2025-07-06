import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';

import '../../lib/core/services/error_handling_service.dart';
import '../../lib/core/services/logging_service.dart';
import '../../lib/core/services/performance_monitoring_service.dart';
import '../../lib/features/dashboard/data/repositories/hrv_repository_interface.dart';
import '../../lib/features/dashboard/data/repositories/simple_hrv_repository.dart';
import '../../lib/features/ble/domain/services/ble_heart_rate_service.dart';
import '../../lib/shared/models/hrv_reading.dart';

import 'mock_data_service.dart';

/// TimeoutException for async operations
class TimeoutException implements Exception {
  final String message;
  final Duration timeout;
  
  TimeoutException(this.message, this.timeout);
  
  @override
  String toString() => 'TimeoutException: $message after ${timeout.inMilliseconds}ms';
}

/// Mock classes for testing
class MockHrvRepository extends Mock implements HrvRepositoryInterface {}
class MockBleHeartRateService extends Mock implements BleHeartRateService {}
class MockErrorHandlingService extends Mock implements ErrorHandlingService {}
class MockLoggingService extends Mock implements LoggingService {}
class MockPerformanceMonitoringService extends Mock implements PerformanceMonitoringService {}

/// Comprehensive test utilities for PulsePath testing infrastructure
class TestUtils {
  static final TestUtils _instance = TestUtils._internal();
  factory TestUtils() => _instance;
  TestUtils._internal();

  final MockDataService _mockDataService = MockDataService();
  late GetIt _testServiceLocator;

  /// Initialize test environment with mock services
  Future<void> initializeTestEnvironment({
    bool useMockServices = true,
    bool enableLogging = false,
  }) async {
    // Reset GetIt for testing
    _testServiceLocator = GetIt.asNewInstance();
    
    if (useMockServices) {
      await _registerMockServices();
    } else {
      await _registerRealServices(enableLogging: enableLogging);
    }
    
    // Register mock data service
    _testServiceLocator.registerSingleton<MockDataService>(_mockDataService);
  }

  /// Clean up test environment
  Future<void> cleanupTestEnvironment() async {
    await _testServiceLocator.reset();
  }

  /// Get the test service locator
  GetIt get serviceLocator => _testServiceLocator;

  /// Create a test app widget with proper providers
  Widget createTestApp({
    required Widget child,
    List<Override> providerOverrides = const [],
  }) {
    return ProviderScope(
      overrides: providerOverrides,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  /// Create a test widget with minimal Material app wrapper
  Widget createTestWidget(Widget widget) {
    return MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    );
  }

  /// Pump a widget and wait for async operations to complete
  Future<void> pumpAndSettle(WidgetTester tester, Widget widget, {Duration timeout = const Duration(seconds: 10)}) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle(timeout);
  }

  /// Wait for a specific condition to be true
  Future<void> waitForCondition(
    bool Function() condition, {
    Duration timeout = const Duration(seconds: 5),
    Duration pollInterval = const Duration(milliseconds: 100),
  }) async {
    final stopwatch = Stopwatch()..start();
    
    while (!condition() && stopwatch.elapsed < timeout) {
      await Future<void>.delayed(pollInterval);

    }
    
    if (!condition()) {
      throw TimeoutException('Condition not met within timeout', timeout);
    }
  }

  /// Verify that a widget exists in the widget tree
  void verifyWidgetExists(WidgetTester tester, Type widgetType) {
    expect(find.byType(widgetType), findsOneWidget);
  }

  /// Verify that text appears in the widget tree
  void verifyTextExists(WidgetTester tester, String text) {
    expect(find.text(text), findsOneWidget);
  }

  /// Verify that multiple texts appear in the widget tree
  void verifyTextsExist(WidgetTester tester, List<String> texts) {
    for (final text in texts) {
      expect(find.text(text), findsOneWidget);
    }
  }

  /// Simulate a tap on a widget and wait for settlement
  Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  /// Simulate entering text and wait for settlement
  Future<void> enterTextAndSettle(WidgetTester tester, Finder finder, String text) async {
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }

  /// Create mock HRV repository with pre-configured behavior
  MockHrvRepository createMockHrvRepository({
    bool shouldSucceed = true,
    bool hasData = true,
  }) {
    final mock = MockHrvRepository();
    
    if (shouldSucceed) {
      if (hasData) {
        final mockReadings = _mockDataService.generateHrvTimeSeries(
          startDate: DateTime.now().subtract(const Duration(days: 30)),
          endDate: DateTime.now(),
        );
        final mockStats = _mockDataService.generateMockStatistics();
        
        when(() => mock.getTrendReadings(days: any(named: 'days'))).thenAnswer((_) async => mockReadings);
        when(() => mock.getLatestReading()).thenAnswer((_) async => mockReadings.isNotEmpty ? mockReadings.last : null);
        when(() => mock.saveReading(any())).thenAnswer((_) async => {});
        when(() => mock.getStatistics(days: any(named: 'days'))).thenAnswer((_) async => mockStats);
        when(() => mock.addSampleData()).thenAnswer((_) async => {});
      } else {
        final mockStats = _mockDataService.generateMockStatistics();
        when(() => mock.getTrendReadings(days: any(named: 'days'))).thenAnswer((_) async => []);
        when(() => mock.getLatestReading()).thenAnswer((_) async => null);
        when(() => mock.saveReading(any())).thenAnswer((_) async => {});
        when(() => mock.getStatistics(days: any(named: 'days'))).thenAnswer((_) async => mockStats);
        when(() => mock.addSampleData()).thenAnswer((_) async => {});
      }
    } else {
      when(() => mock.getTrendReadings(days: any(named: 'days'))).thenThrow(Exception('Database error'));
      when(() => mock.getLatestReading()).thenThrow(Exception('Database error'));
      when(() => mock.saveReading(any())).thenThrow(Exception('Database error'));
      when(() => mock.getStatistics(days: any(named: 'days'))).thenThrow(Exception('Database error'));
      when(() => mock.addSampleData()).thenThrow(Exception('Database error'));

    }
    
    return mock;
  }

  /// Create mock BLE service with pre-configured behavior
  MockBleHeartRateService createMockBleService({
    bool connectionSucceeds = true,
    bool hasDevices = true,
  }) {
    final mock = MockBleHeartRateService();
    
    // Mock isBluetoothAvailable
    when(() => mock.isBluetoothAvailable()).thenAnswer((_) async => true);
    
    if (hasDevices) {
      // Create a stream that yields nothing but doesn't error - we'll test the mock behavior separately
      when(() => mock.scanForHeartRateDevices(timeout: any(named: 'timeout'))).thenAnswer((_) => Stream.fromIterable([]));
    } else {
      when(() => mock.scanForHeartRateDevices(timeout: any(named: 'timeout'))).thenAnswer((_) => const Stream.empty());

    }
    
    if (connectionSucceeds) {
      when(() => mock.connectToDevice(any())).thenAnswer((_) async => true);
      when(() => mock.disconnect()).thenAnswer((_) async => {});
      when(() => mock.heartRateStream).thenAnswer((_) => Stream.periodic(
        const Duration(milliseconds: 800),
        (index) => HeartRateReading(
          heartRate: 60 + (index % 40),
          rrIntervals: [800.0 + (index % 100)],
          timestamp: DateTime.now(),
          hasRrIntervals: true,
        ),
      ));
      when(() => mock.connectionStream).thenAnswer((_) => Stream.value(BleConnectionState.connected));
      when(() => mock.batteryStream).thenAnswer((_) => Stream.value(85));
    } else {
      when(() => mock.connectToDevice(any())).thenThrow(Exception('Connection failed'));
      when(() => mock.disconnect()).thenThrow(Exception('Disconnect failed'));
      when(() => mock.heartRateStream).thenAnswer((_) => Stream.error(Exception('Stream error')));
      when(() => mock.connectionStream).thenAnswer((_) => Stream.value(BleConnectionState.error));
      when(() => mock.batteryStream).thenAnswer((_) => Stream.error(Exception('Battery error')));
    }
    
    // Mock connectionState getter
    when(() => mock.connectionState).thenReturn(connectionSucceeds ? BleConnectionState.connected : BleConnectionState.disconnected);
    
    // Mock connectedDeviceInfo getter
    if (connectionSucceeds) {
      when(() => mock.connectedDeviceInfo).thenReturn(const BleDeviceInfo(
        name: 'Mock HR Device',
        address: '00:11:22:33:44:55',
        isConnected: true,
      ));
    } else {
      when(() => mock.connectedDeviceInfo).thenReturn(null);

    }
    
    return mock;
  }

  /// Setup realistic test scenarios
  void setupTestScenario(String scenario) {
    switch (scenario) {
      case 'first_time_user':
        final emptyRepo = createMockHrvRepository(hasData: false);
        _testServiceLocator.registerSingleton<HrvRepositoryInterface>(emptyRepo);
        break;
        
      case 'experienced_user':
        final fullRepo = createMockHrvRepository(hasData: true);
        _testServiceLocator.registerSingleton<HrvRepositoryInterface>(fullRepo);
        break;
        
      case 'ble_connection_success':
        final successfulBle = createMockBleService(connectionSucceeds: true);
        _testServiceLocator.registerSingleton<BleHeartRateService>(successfulBle);
        break;
        
      case 'ble_connection_failure':
        final failingBle = createMockBleService(connectionSucceeds: false);
        _testServiceLocator.registerSingleton<BleHeartRateService>(failingBle);
        break;
        
      case 'database_error':
        final errorRepo = createMockHrvRepository(shouldSucceed: false);
        _testServiceLocator.registerSingleton<HrvRepositoryInterface>(errorRepo);
        break;
    }
  }

  /// Generate test data for specific use cases
  Map<String, dynamic> generateTestData(String dataType) {
    switch (dataType) {
      case 'hrv_reading':
        return {
          'reading': _mockDataService.generateMockHrvReading(),
          'edge_cases': _mockDataService.generateEdgeCaseReadings(),
        };
        
      case 'dashboard_data':
        return {
          'full_data': _mockDataService.generateMockDashboardData(),
          'empty_data': _mockDataService.generateMockDashboardData(trendDays: 0),
        };
        
      case 'performance_metrics':
        return {
          'metrics': _mockDataService.generateMockPerformanceMetrics(),
          'error_scenarios': _mockDataService.generateMockErrorScenarios(),
        };
        
      case 'user_profiles':
        return {
          'profiles': _mockDataService.generateMockUserProfiles(),
        };
        
      default:
        throw ArgumentError('Unknown data type: $dataType');
    }
  }

  /// Verify error handling behavior
  Future<void> verifyErrorHandling<T>(
    Future<void> Function() operation,
    Type expectedErrorType,
  ) async {
    try {
      await operation();
      fail('Expected error of type $expectedErrorType but operation succeeded');
    } catch (error) {
      expect(error.runtimeType, expectedErrorType);
    }
  }

  /// Measure performance of an operation
  Future<Duration> measurePerformance(Future<void> Function() operation) async {
    final stopwatch = Stopwatch()..start();
    await operation();
    stopwatch.stop();
    return stopwatch.elapsed;
  }

  /// Verify performance meets expectations
  Future<void> verifyPerformance(
    Future<void> Function() operation,
    Duration maxDuration, {
    String? operationName,
  }) async {
    final duration = await measurePerformance(operation);
    expect(
      duration,
      lessThan(maxDuration),
      reason: '${operationName ?? 'Operation'} took ${duration.inMilliseconds}ms, expected < ${maxDuration.inMilliseconds}ms',
    );
  }

  /// Private: Register mock services
  Future<void> _registerMockServices() async {
    _testServiceLocator.registerSingleton<ErrorHandlingService>(MockErrorHandlingService());
    _testServiceLocator.registerSingleton<LoggingService>(MockLoggingService());
    _testServiceLocator.registerSingleton<PerformanceMonitoringService>(MockPerformanceMonitoringService());
    _testServiceLocator.registerSingleton<HrvRepositoryInterface>(createMockHrvRepository());
    _testServiceLocator.registerSingleton<BleHeartRateService>(createMockBleService());
  }

  /// Private: Register real services for integration testing
  Future<void> _registerRealServices({bool enableLogging = false}) async {
    final errorService = ErrorHandlingService();
    errorService.initialize();
    _testServiceLocator.registerSingleton<ErrorHandlingService>(errorService);
    
    if (enableLogging) {
      final loggingService = LoggingService();
      await loggingService.initialize(enableFileLogging: false); // No file logging in tests
      _testServiceLocator.registerSingleton<LoggingService>(loggingService);
      
      final perfService = PerformanceMonitoringService();
      await perfService.initialize(logger: loggingService);
      _testServiceLocator.registerSingleton<PerformanceMonitoringService>(perfService);
    } else {
      _testServiceLocator.registerSingleton<LoggingService>(MockLoggingService());
      _testServiceLocator.registerSingleton<PerformanceMonitoringService>(MockPerformanceMonitoringService());
    }
    
    // Use SimpleHrvRepository for real but fast testing
    final repo = SimpleHrvRepository();
    repo.addSampleData();
    _testServiceLocator.registerSingleton<HrvRepositoryInterface>(repo);
  }
}

/// Base test class for integration tests
abstract class BaseIntegrationTest {
  late TestUtils testUtils;
  

  void setUpBase() async {
    testUtils = TestUtils();
    await testUtils.initializeTestEnvironment();
  }
  

  void tearDownBase() async {
    await testUtils.cleanupTestEnvironment();
  }
}

/// Base test class for widget tests
abstract class BaseWidgetTest {
  late TestUtils testUtils;
  

  void setUpWidgetTest() async {
    testUtils = TestUtils();
    await testUtils.initializeTestEnvironment(useMockServices: true);
  }
  

  void tearDownWidgetTest() async {
    await testUtils.cleanupTestEnvironment();
  }
  
  /// Create and pump a test widget
  Future<void> pumpTestWidget(WidgetTester tester, Widget widget) async {
    await testUtils.pumpAndSettle(tester, testUtils.createTestWidget(widget));
  }
}

/// Base test class for unit tests
abstract class BaseUnitTest {
  late MockDataService mockDataService;
  

  void setUpUnitTest() {
    mockDataService = MockDataService();
  }
}

/// Test performance benchmarks
class PerformanceBenchmarks {
  static const Duration maxAppStartup = Duration(seconds: 3);
  static const Duration maxWidgetBuild = Duration(milliseconds: 16);
  static const Duration maxDatabaseQuery = Duration(milliseconds: 100);
  static const Duration maxHrvCalculation = Duration(milliseconds: 500);
  static const Duration maxBleConnection = Duration(seconds: 10);
}

/// Custom matchers for testing
Matcher throwsHrvException() => throwsA(isA<Exception>());
Matcher isValidHrvReading() => predicate<HrvReading>((reading) {
  return reading.metrics.rmssd > 0 &&
         reading.rrIntervals.isNotEmpty &&
         reading.durationSeconds > 0;

}, 'is a valid HRV reading');

Matcher isHealthyPerformanceMetric({required double threshold}) => predicate<double>((value) {
  return value <= threshold;
}, 'is within performance threshold');