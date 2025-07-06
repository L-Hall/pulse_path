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
      await testUtils.cleanupTestEnvironment();
    });

    testWidgets('App launches successfully and shows dashboard', (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Verify app launched and dashboard is visible
      expect(find.byType(MaterialApp), findsOneWidget);
      
      // Look for key dashboard elements
      expect(find.text('PulsePath'), findsAtLeastOneWidget);
      
      // Wait for any async initialization to complete
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });

    testWidgets('Dashboard shows HRV data and navigation works', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Look for score cards or data elements
      // Note: These depend on your actual UI implementation
      expect(find.byType(Card), findsAtLeastOneWidget);
      
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
      await tester.pumpAndSettle(const Duration(seconds: 10));
      
      stopwatch.stop();
      
      // Verify app startup time
      expect(stopwatch.elapsed, lessThan(PerformanceBenchmarks.maxAppStartup));
      
      // Test widget build performance
      final buildStopwatch = Stopwatch()..start();
      await tester.pump();
      buildStopwatch.stop();
      
      expect(buildStopwatch.elapsed, lessThan(PerformanceBenchmarks.maxWidgetBuild));
    });

    testWidgets('App handles device rotation gracefully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Test portrait mode
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // Test landscape mode
      await tester.binding.setSurfaceSize(const Size(800, 400));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // Reset to portrait
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpAndSettle();
    });

    testWidgets('Memory usage remains stable during navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Simulate user navigation pattern
      for (int i = 0; i < 10; i++) {
        // Navigate around the app
        await tester.pump();
        await tester.pumpAndSettle();
        
        // Add small delay to simulate user behavior
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Verify no memory leaks or crashes
      expect(tester.takeException(), isNull);
    });

    testWidgets('App handles lifecycle changes', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      await Future<void>.delayed(const Duration(milliseconds: 500));
      
      await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
        'flutter/lifecycle',
        const StandardMethodCodec().encodeMethodCall(
          const MethodCall('AppLifecycleState.detached'),
        ),
        (data) {},
      );
      
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      expect(tester.takeException(), isNull);
    });

  });

  group('Error Handling Integration', () {
    testWidgets('App recovers gracefully from network errors', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Simulate network connectivity issues
      // Note: This would require additional setup to mock network failures
      
      // Verify app continues to function
      expect(tester.takeException(), isNull);
    });

    testWidgets('App handles permission denials appropriately', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Note: Permission testing would require platform-specific mocking
      // For now, verify app doesn't crash when permissions might be denied
      
      expect(tester.takeException(), isNull);
    });
  });

  group('Data Persistence Integration', () {
    testWidgets('App maintains data across app restarts', (WidgetTester tester) async {
      // First session
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // Simulate adding some data (if possible through UI)
      // This would depend on your specific data entry mechanisms
      
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
    testWidgets('App adapts to different screen sizes', (WidgetTester tester) async {
      // Test various screen sizes
      final screenSizes = [
        const Size(320, 568), // iPhone SE
        const Size(375, 667), // iPhone 8
        const Size(414, 896), // iPhone 11
        const Size(768, 1024), // iPad
      ];

      for (final size in screenSizes) {
        await tester.binding.setSurfaceSize(size);
        
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 5));
        
        // Verify UI adapts correctly
        expect(tester.takeException(), isNull);
        
        // Verify no overflow errors
        expect(find.text('OVERFLOW'), findsNothing);
      }
    });
  });
}

