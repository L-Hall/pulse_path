// This is a basic Flutter widget test for PulsePath app.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pulse_path/main.dart';

void main() {
  testWidgets('PulsePath app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: PulsePathApp()));

    // Verify that our app shows the welcome message.
    expect(find.text('Welcome to PulsePath'), findsOneWidget);
    expect(find.text('HRV-based wellbeing tracking'), findsOneWidget);
    expect(find.text('Coming Soon'), findsOneWidget);
    expect(find.text('PulsePath'), findsOneWidget);
  });
}
