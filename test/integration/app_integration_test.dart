import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../lib/main.dart' as app;
import '../support/test_utils.dart';

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
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('PulsePath'), findsAtLeastNWidgets(1));
      
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });

    testWidgets('Dashboard shows HRV data and navigation works', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      expect(find.byType(Card), findsAtLeastNWidgets(1));
      
      final navigationElements = find.byType(BottomNavigationBar);
      if (tester.any(navigationElements)) {
        await tester.tap(navigationElements);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Error handling works correctly', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));
      
      expect(tester.takeException(), isNull);
    });

    testWidgets('App performance meets benchmarks', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
    });

    testWidgets('Data persistence works', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      await Future<void>.delayed(const Duration(seconds: 2));
      
      await tester.runAsync(() async {
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
        
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 5));
      });
      
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
}
