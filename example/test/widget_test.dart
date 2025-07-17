// Tontine Calendar Example App Tests

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tontine_calendar_example/main.dart';

void main() {
  testWidgets('Tontine Calendar Example App smoke test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TontineCalendarExampleApp());

    // Verify that the app loads with the expected title
    expect(find.text('Tontine Calendar'), findsOneWidget);

    // Verify that we have the bottom navigation tabs
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Verify that we can find the basic example tab
    expect(find.text('Basic'), findsOneWidget);
  });
}
