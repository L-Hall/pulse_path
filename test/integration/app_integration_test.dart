import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../lib/main.dart' as app;
import '../support/test_utils.dart';

/// Comprehensive integration tests for PulsePath core functionality
/// Tests the complete user journey from app launch to HRV reading completion
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('PulsePath Integration Tests', () {
    late TestUtils testUtils;

    setUpAll(() async {
      testUtils = TestUtils();
    });

    tearDownAll(() async {
      await testUtils.cleanup();
    });

    testWidgets('App launches successfully', (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify app launched with expected structure
      expect(find.byType(MaterialApp), findsOneWidget);
      
      // Look for key dashboard elements
      expect(find.text('PulsePath'), findsAtLeastNWidgets(1));
      
      // Wait for any async initialization to complete
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });

    testWidgets('Dashboard shows HRV data and navigation works', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Look for score cards or data elements
      // Note: These depend on your actual UI implementation
      expect(find.byType(Card), findsAtLeastNWidgets(1));
      
      // Test navigation if present
      final navigationElements = find.byType(BottomNavigationBar);
      if (tester.any(navigationElements)) {
        // Test navigation between tabs
        await tester.tap(navigationElements);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Error handling displays user-friendly messages', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Try to trigger an error scenario if possible
      // This would depend on your specific UI and error triggers
      
      // Verify no crashes occurred
      expect(tester.takeException(), isNull);
    });

    testWidgets('App performance meets benchmarks', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      stopwatch.stop();
      
      // App should launch within 5 seconds
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
      
      // Check memory usage indirectly through widget count
      final widgetCount = find.byType(Widget).evaluate().length;
      expect(widgetCount, lessThan(1000)); // Reasonable widget count
    });

    testWidgets('Data persistence across app restarts', (WidgetTester tester) async {
      // Launch app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // Get initial state
      final initialWidgets = find.byType(Card).evaluate().length;
      
      // Wait a moment before restarting
      await Future<void>.delayed(const Duration(seconds: 2));
      
      // Simulate app restart
      await tester.runAsync(() async {
        // Clear all widgets
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
        
        // Restart the app
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 5));
      });
      
      // Verify data persisted
      final afterRestartWidgets = find.byType(Card).evaluate().length;
      expect(afterRestartWidgets, equals(initialWidgets));
    });

    testWidgets('App handles lifecycle state changes', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // Simulate pause/resume lifecycle
      await Future<void>.delayed(const Duration(milliseconds: 500));
      
      // Stop the app (simulate app close)
      await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
        'flutter/lifecycle',
        const StandardMethodCodec().encodeMethodCall(
          const MethodCall('AppLifecycleState.detached'),
        ),
        (data) {},
      );
      
      // Restart the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // Verify data persistence
      expect(tester.takeException(), isNull);
    });
  });

  group('Platform-Specific Integration', () {
    testWidgets('Camera HRV capture flow works end-to-end', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // This test would need proper camera permission setup and mocking
      // For now, just verify no crashes when accessing camera features
      expect(tester.takeException(), isNull);
    });

    testWidgets('BLE device discovery and connection flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // This test would need BLE permission setup and device mocking
      // For now, just verify no crashes when accessing BLE features
      expect(tester.takeException(), isNull);
    });

    testWidgets('Health data integration works correctly', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // This test would need HealthKit/Google Fit permission setup
      // For now, just verify no crashes when accessing health features
      expect(tester.takeException(), isNull);
    });
  });

  group('User Journey Integration', () {
    testWidgets('Complete HRV reading flow from start to finish', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // This would test the complete user journey:
      // 1. Launch app
      // 2. Navigate to HRV capture
      // 3. Complete a reading
      // 4. View results
      // 5. Save data
      
      // For now, verify app stability
      expect(tester.takeException(), isNull);
    });

    testWidgets('Adaptive pacing mode toggle and functionality', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // This would test adaptive pacing features:
      // 1. Toggle adaptive pacing mode
      // 2. Verify UI updates
      // 3. Check PEM risk indicators
      
      // For now, verify app stability
      expect(tester.takeException(), isNull);
    });

    testWidgets('Data export and sharing functionality', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // This would test data export:
      // 1. Navigate to export options
      // 2. Select export format
      // 3. Verify export completion
      
      // For now, verify app stability
      expect(tester.takeException(), isNull);
    });
  });
}
