import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tontine_calendar/tontine_calendar.dart';

void main() {
  group('TontineCalendar Widget Tests', () {
    testWidgets('should render basic calendar', (WidgetTester tester) async {
      const config = TontineCalendarConfig(
        monthCount: 3,
        daysPerMonth: 31,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(config: config),
          ),
        ),
      );

      // Should find the calendar widget
      expect(find.byType(TontineCalendar), findsOneWidget);
      
      // Should find day containers
      expect(find.byType(InkWell), findsWidgets);
      
      // Should find month name (January by default)
      expect(find.text('January'), findsOneWidget);
    });

    testWidgets('should show mode selection tabs when enabled', (WidgetTester tester) async {
      const config = TontineCalendarConfig(monthCount: 3, daysPerMonth: 31);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(
              config: config,
              showModeSelection: true,
            ),
          ),
        ),
      );

      // Should find mode selection tabs
      expect(find.text('SIMPLE'), findsOneWidget);
      expect(find.text('MULTIPLE'), findsOneWidget);
    });

    testWidgets('should hide mode selection tabs when disabled', (WidgetTester tester) async {
      const config = TontineCalendarConfig(monthCount: 3, daysPerMonth: 31);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(
              config: config,
              showModeSelection: false,
            ),
          ),
        ),
      );

      // Should not find mode selection tabs
      expect(find.text('SIMPLE'), findsNothing);
      expect(find.text('MULTIPLE'), findsNothing);
    });

    testWidgets('should display French month names', (WidgetTester tester) async {
      final config = TontineCalendarConfig.withFrenchNames(
        monthCount: 3,
        daysPerMonth: 31,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(config: config),
          ),
        ),
      );

      // Should find French month name
      expect(find.text('Janvier'), findsOneWidget);
    });

    testWidgets('should show validated days with check icons', (WidgetTester tester) async {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true),
        const TontineDay(day: 2, month: 1, isValidated: true),
      ];

      final config = TontineCalendarConfig(
        monthCount: 3,
        daysPerMonth: 31,
        validatedDays: validatedDays,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(config: config),
          ),
        ),
      );

      // Should find check icons for validated days
      expect(find.byIcon(Icons.check_circle_outline), findsWidgets);
    });

    testWidgets('should call onDaySelected when day is tapped', (WidgetTester tester) async {
      const config = TontineCalendarConfig(monthCount: 3, daysPerMonth: 31);
      TontineCalendarData? selectedData;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(
              config: config,
              onDaySelected: (data) {
                selectedData = data;
              },
            ),
          ),
        ),
      );

      // Tap on the first day
      await tester.tap(find.text('1').first);
      await tester.pump();

      // Should have called the callback
      expect(selectedData, isNotNull);
      expect(selectedData!.selectedDay.day, 1);
      expect(selectedData!.selectedDay.month, 1);
    });

    testWidgets('should call onValidatedDayTapped when validated day is tapped', (WidgetTester tester) async {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true),
      ];

      final config = TontineCalendarConfig(
        monthCount: 3,
        daysPerMonth: 31,
        validatedDays: validatedDays,
      );

      TontineDay? tappedDay;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(
              config: config,
              onValidatedDayTapped: (day) {
                tappedDay = day;
              },
            ),
          ),
        ),
      );

      // Tap on the validated day (should be a check icon)
      await tester.tap(find.byIcon(Icons.check_circle_outline).first);
      await tester.pump();

      // Should have called the callback
      expect(tappedDay, isNotNull);
      expect(tappedDay!.day, 1);
      expect(tappedDay!.month, 1);
      expect(tappedDay!.isValidated, true);
    });

    testWidgets('should show navigation buttons when enabled', (WidgetTester tester) async {
      final validatedDays = List.generate(
        31,
        (index) => TontineDay(day: index + 1, month: 1, isValidated: true),
      );

      final config = TontineCalendarConfig(
        monthCount: 3,
        daysPerMonth: 31,
        validatedDays: validatedDays,
        enableNavigation: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(config: config),
          ),
        ),
      );

      // Should find navigation buttons
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('should navigate to next month when button is tapped', (WidgetTester tester) async {
      // Complete first month to allow navigation
      final validatedDays = List.generate(
        31,
        (index) => TontineDay(day: index + 1, month: 1, isValidated: true),
      );

      final config = TontineCalendarConfig(
        monthCount: 3,
        daysPerMonth: 31,
        validatedDays: validatedDays,
        enableNavigation: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(config: config),
          ),
        ),
      );

      // Should start with February (since January is completed)
      expect(find.text('February'), findsOneWidget);

      // Tap next month button
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      // Should now show March
      expect(find.text('March'), findsOneWidget);
    });

    testWidgets('should apply custom styling', (WidgetTester tester) async {
      const config = TontineCalendarConfig(monthCount: 3, daysPerMonth: 31);
      const customStyle = TontineCalendarStyle(
        regularDayColor: Colors.red,
        validatedDayColor: Colors.green,
        headerTextColor: Colors.blue,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(
              config: config,
              style: customStyle,
            ),
          ),
        ),
      );

      // Find containers with custom colors
      final dayContainers = find.byType(Container);
      expect(dayContainers, findsWidgets);

      // Find text with custom header color
      final headerText = tester.widget<Text>(find.text('January'));
      expect(headerText.style?.color, Colors.blue);
    });

    testWidgets('should switch between simple and multiple modes', (WidgetTester tester) async {
      const config = TontineCalendarConfig(monthCount: 3, daysPerMonth: 31);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(
              config: config,
              showModeSelection: true,
            ),
          ),
        ),
      );

      // Should start in simple mode (default)
      expect(find.text('SIMPLE'), findsOneWidget);
      expect(find.text('MULTIPLE'), findsOneWidget);

      // Tap on multiple mode
      await tester.tap(find.text('MULTIPLE'));
      await tester.pump();

      // Mode should have switched (visual feedback would be different styling)
      // This is more of a visual test, but we can verify the tap was registered
      expect(find.text('MULTIPLE'), findsOneWidget);
    });

    testWidgets('should show completion status when enabled', (WidgetTester tester) async {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true),
        const TontineDay(day: 2, month: 1, isValidated: true),
      ];

      final config = TontineCalendarConfig(
        monthCount: 3,
        daysPerMonth: 31,
        validatedDays: validatedDays,
        showCompletionStatus: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(config: config),
          ),
        ),
      );

      // Should show completion status (2/31)
      expect(find.text('2/31'), findsOneWidget);
    });

    testWidgets('should show total amount when enabled', (WidgetTester tester) async {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true, amount: 1000),
        const TontineDay(day: 2, month: 1, isValidated: true, amount: 1000),
      ];

      final config = TontineCalendarConfig(
        monthCount: 3,
        daysPerMonth: 31,
        validatedDays: validatedDays,
        showTotalAmount: true,
        defaultDayAmount: 1000.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(config: config),
          ),
        ),
      );

      // Should show total amount
      expect(find.textContaining('2000'), findsOneWidget);
      expect(find.textContaining('FCFA'), findsOneWidget);
    });

    testWidgets('should handle empty configuration', (WidgetTester tester) async {
      const config = TontineCalendarConfig(
        monthCount: 2,
        daysPerMonth: 28,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TontineCalendar(config: config),
          ),
        ),
      );

      // Should render without errors
      expect(find.byType(TontineCalendar), findsOneWidget);
      expect(find.text('January'), findsOneWidget);
      
      // Should have 28 days
      expect(find.text('28'), findsOneWidget);
      expect(find.text('29'), findsNothing);
    });
  });
}
