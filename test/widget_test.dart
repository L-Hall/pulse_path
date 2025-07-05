import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('PulsePath app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PulsePathApp());
    await tester.pumpAndSettle();

    // Verify the app loads successfully
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // Look for any text content rather than specific text
    final textWidgets = find.byType(Text);
    expect(textWidgets, findsAtLeastNWidgets(1));
    
    // Verify no exceptions occurred during load
    expect(tester.takeException(), isNull);
  });
}
