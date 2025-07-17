import 'package:flutter_test/flutter_test.dart';
import 'package:tontine_calendar/tontine_calendar.dart';

void main() {
  group('TontineDay', () {
    test('should create a valid TontineDay', () {
      const day = TontineDay(
        day: 15,
        month: 6,
        isValidated: true,
        amount: 1000.0,
      );

      expect(day.day, 15);
      expect(day.month, 6);
      expect(day.isValidated, true);
      expect(day.amount, 1000.0);
    });

    test('should throw assertion error for invalid day', () {
      expect(
        () => TontineDay(day: 0, month: 1),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => TontineDay(day: 32, month: 1),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should throw assertion error for invalid month', () {
      expect(
        () => TontineDay(day: 1, month: 0),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => TontineDay(day: 1, month: 13),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should create copy with updated values', () {
      const original = TontineDay(day: 1, month: 1);
      final copy = original.copyWith(isValidated: true, amount: 500.0);

      expect(copy.day, 1);
      expect(copy.month, 1);
      expect(copy.isValidated, true);
      expect(copy.amount, 500.0);
    });

    test('should serialize to and from JSON', () {
      final original = TontineDay(
        day: 10,
        month: 5,
        isValidated: true,
        amount: 750.0,
        validatedDate: DateTime(2025, 1, 15),
      );

      final json = original.toJson();
      final restored = TontineDay.fromJson(json);

      expect(restored.day, original.day);
      expect(restored.month, original.month);
      expect(restored.isValidated, original.isValidated);
      expect(restored.amount, original.amount);
      expect(restored.validatedDate, original.validatedDate);
    });

    test('should handle equality correctly', () {
      const day1 = TontineDay(day: 1, month: 1, isValidated: true);
      const day2 = TontineDay(day: 1, month: 1, isValidated: true);
      const day3 = TontineDay(day: 2, month: 1, isValidated: true);

      expect(day1, equals(day2));
      expect(day1, isNot(equals(day3)));
    });
  });

  group('TontineMonth', () {
    test('should create a month with correct properties', () {
      final month = TontineMonth.create(month: 1, totalDays: 31);

      expect(month.month, 1);
      expect(month.name, 'January');
      expect(month.totalDays, 31);
      expect(month.days.length, 31);
      expect(month.validatedCount, 0);
      expect(month.unvalidatedCount, 31);
      expect(month.isCompleted, false);
    });

    test('should create month with validated days', () {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true),
        const TontineDay(day: 2, month: 1, isValidated: true),
      ];

      final month = TontineMonth.create(
        month: 1,
        totalDays: 31,
        validatedDays: validatedDays,
      );

      expect(month.validatedCount, 2);
      expect(month.unvalidatedCount, 29);
      expect(month.completionPercentage, 2 / 31);
    });

    test('should use French month names', () {
      final month = TontineMonth.create(
        month: 1,
        totalDays: 31,
        monthNames: TontineMonth.frenchMonthNames,
      );

      expect(month.name, 'Janvier');
    });

    test('should calculate total amount correctly', () {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true, amount: 100),
        const TontineDay(day: 2, month: 1, isValidated: true, amount: 200),
      ];

      final month = TontineMonth.create(
        month: 1,
        totalDays: 31,
        validatedDays: validatedDays,
      );

      expect(month.totalAmount, 300.0);
    });

    test('should get specific day by number', () {
      final month = TontineMonth.create(month: 1, totalDays: 31);
      final day = month.getDay(15);

      expect(day, isNotNull);
      expect(day!.day, 15);
      expect(day.month, 1);
    });

    test('should return null for invalid day number', () {
      final month = TontineMonth.create(month: 1, totalDays: 31);
      expect(month.getDay(0), isNull);
      expect(month.getDay(32), isNull);
    });

    test('should update a specific day', () {
      final month = TontineMonth.create(month: 1, totalDays: 31);
      final updatedDay = const TontineDay(
        day: 15,
        month: 1,
        isValidated: true,
        amount: 500,
      );

      final updatedMonth = month.updateDay(updatedDay);
      final retrievedDay = updatedMonth.getDay(15);

      expect(retrievedDay!.isValidated, true);
      expect(retrievedDay.amount, 500);
    });
  });

  group('TontineCalendarConfig', () {
    test('should create default configuration', () {
      const config = TontineCalendarConfig();

      expect(config.monthCount, 12);
      expect(config.daysPerMonth, 31);
      expect(config.enableNavigation, true);
      expect(config.showCompletionStatus, true);
      expect(config.showTotalAmount, true);
      expect(config.initialMonth, 1);
    });

    test('should create six months configuration', () {
      final config = TontineCalendarConfig.sixMonths();

      expect(config.monthCount, 6);
      expect(config.daysPerMonth, 31);
    });

    test('should create configuration with French names', () {
      final config = TontineCalendarConfig.withFrenchNames();

      expect(config.effectiveMonthNames, TontineMonth.frenchMonthNames);
    });

    test('should throw assertion error for invalid month count', () {
      expect(
        () => TontineCalendarConfig(monthCount: 1),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => TontineCalendarConfig(monthCount: 13),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should throw assertion error for invalid days per month', () {
      expect(
        () => TontineCalendarConfig(daysPerMonth: 27),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => TontineCalendarConfig(daysPerMonth: 32),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should calculate total days correctly', () {
      const config = TontineCalendarConfig(monthCount: 6, daysPerMonth: 30);
      expect(config.totalDays, 180);
    });

    test('should check if day is validated', () {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true),
      ];
      final config = TontineCalendarConfig(validatedDays: validatedDays);

      expect(config.isDayValidated(1, 1), true);
      expect(config.isDayValidated(1, 2), false);
    });

    test('should get validated days for specific month', () {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true),
        const TontineDay(day: 2, month: 1, isValidated: true),
        const TontineDay(day: 1, month: 2, isValidated: true),
      ];
      final config = TontineCalendarConfig(validatedDays: validatedDays);

      final month1Days = config.getValidatedDaysForMonth(1);
      final month2Days = config.getValidatedDaysForMonth(2);

      expect(month1Days.length, 2);
      expect(month2Days.length, 1);
    });
  });

  group('TontineCalendarData', () {
    test('should create calendar data from selection', () {
      final months = [
        TontineMonth.create(month: 1, totalDays: 31),
        TontineMonth.create(month: 2, totalDays: 31),
      ];

      const selectedDay = TontineDay(day: 15, month: 2);
      final data = TontineCalendarData.fromSelection(
        selectedDay: selectedDay,
        allMonths: months,
        defaultDayAmount: 100.0,
      );

      expect(data.selectedDay, selectedDay);
      expect(
        data.totalUnvalidatedDays,
        46,
      ); // 31 from month 1 + 15 from month 2
      expect(data.totalAmount, 4600.0); // 46 * 100
    });

    test('should group unvalidated days by month', () {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true),
        const TontineDay(day: 2, month: 1, isValidated: true),
      ];

      final months = [
        TontineMonth.create(
          month: 1,
          totalDays: 31,
          validatedDays: validatedDays,
        ),
        TontineMonth.create(month: 2, totalDays: 31),
      ];

      const selectedDay = TontineDay(day: 5, month: 2);
      final data = TontineCalendarData.fromSelection(
        selectedDay: selectedDay,
        allMonths: months,
      );

      expect(data.unvalidatedDaysByMonth[1]?.length, 29); // 31 - 2 validated
      expect(data.unvalidatedDaysByMonth[2]?.length, 5); // Days 1-5
    });

    test('should handle selection in first month', () {
      final months = [TontineMonth.create(month: 1, totalDays: 31)];

      const selectedDay = TontineDay(day: 10, month: 1);
      final data = TontineCalendarData.fromSelection(
        selectedDay: selectedDay,
        allMonths: months,
      );

      expect(data.totalUnvalidatedDays, 10);
      expect(data.unvalidatedDaysByMonth.length, 1);
      expect(data.unvalidatedDaysByMonth[1]?.length, 10);
    });

    test('should serialize to and from JSON', () {
      final months = [TontineMonth.create(month: 1, totalDays: 31)];

      const selectedDay = TontineDay(day: 5, month: 1);
      final original = TontineCalendarData.fromSelection(
        selectedDay: selectedDay,
        allMonths: months,
        defaultDayAmount: 200.0,
      );

      final json = original.toJson();
      final restored = TontineCalendarData.fromJson(json);

      expect(restored.selectedDay.day, original.selectedDay.day);
      expect(restored.totalUnvalidatedDays, original.totalUnvalidatedDays);
      expect(restored.totalAmount, original.totalAmount);
    });
  });

  group('TontineCalendarUtils', () {
    test('should calculate unvalidated days correctly', () {
      final months = [
        TontineMonth.create(month: 1, totalDays: 31),
        TontineMonth.create(month: 2, totalDays: 31),
      ];

      const selectedDay = TontineDay(day: 10, month: 2);
      final unvalidatedDays = TontineCalendarUtils.calculateUnvalidatedDays(
        selectedDay: selectedDay,
        allMonths: months,
      );

      expect(unvalidatedDays[1]?.length, 31);
      expect(unvalidatedDays[2]?.length, 10);
    });

    test('should calculate total amount for days', () {
      final days = [
        const TontineDay(day: 1, month: 1, amount: 100),
        const TontineDay(day: 2, month: 1, amount: 200),
        const TontineDay(day: 3, month: 1), // No amount
      ];

      final total = TontineCalendarUtils.calculateTotalAmount(
        days: days,
        defaultDayAmount: 150.0,
      );

      expect(total, 450.0); // 100 + 200 + 150
    });

    test('should find next day to select', () {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true),
        const TontineDay(day: 2, month: 1, isValidated: true),
      ];

      final month = TontineMonth.create(
        month: 1,
        totalDays: 31,
        validatedDays: validatedDays,
      );

      final nextDay = TontineCalendarUtils.findNextDayToSelect(
        month: month,
        totalDaysInMonth: 31,
      );

      expect(nextDay, 3);
    });

    test('should return null when month is completed', () {
      final validatedDays = List.generate(
        31,
        (index) => TontineDay(day: index + 1, month: 1, isValidated: true),
      );

      final month = TontineMonth.create(
        month: 1,
        totalDays: 31,
        validatedDays: validatedDays,
      );

      final nextDay = TontineCalendarUtils.findNextDayToSelect(
        month: month,
        totalDaysInMonth: 31,
      );

      expect(nextDay, isNull);
    });

    test('should validate configuration correctly', () {
      expect(
        TontineCalendarUtils.validateConfiguration(
          monthCount: 6,
          daysPerMonth: 31,
          initialMonth: 1,
        ),
        true,
      );

      expect(
        TontineCalendarUtils.validateConfiguration(
          monthCount: 1, // Invalid
          daysPerMonth: 31,
          initialMonth: 1,
        ),
        false,
      );

      expect(
        TontineCalendarUtils.validateConfiguration(
          monthCount: 6,
          daysPerMonth: 27, // Invalid
          initialMonth: 1,
        ),
        false,
      );
    });

    test('should generate day range correctly', () {
      final range1 = TontineCalendarUtils.generateDayRange(
        startDay: 5,
        endDay: 10,
      );
      expect(range1, [5, 6, 7, 8, 9, 10]);

      final range2 = TontineCalendarUtils.generateDayRange(
        startDay: 10,
        endDay: 5,
      );
      expect(range2, [5, 6, 7, 8, 9, 10]);

      final range3 = TontineCalendarUtils.generateDayRange(
        startDay: 7,
        endDay: 7,
      );
      expect(range3, [7]);
    });

    test('should get calendar summary', () {
      final validatedDays = [
        const TontineDay(day: 1, month: 1, isValidated: true, amount: 100),
        const TontineDay(day: 2, month: 1, isValidated: true, amount: 100),
      ];

      final months = [
        TontineMonth.create(
          month: 1,
          totalDays: 31,
          validatedDays: validatedDays,
        ),
        TontineMonth.create(month: 2, totalDays: 31),
      ];

      final summary = TontineCalendarUtils.getCalendarSummary(months: months);

      expect(summary['totalDays'], 62);
      expect(summary['totalValidatedDays'], 2);
      expect(summary['totalUnvalidatedDays'], 60);
      expect(summary['completedMonths'], 0);
      expect(summary['totalMonths'], 2);
      expect(summary['completionPercentage'], 2 / 62);
    });

    test('should format amount correctly', () {
      expect(TontineCalendarUtils.formatAmount(1500.0), '1500 FCFA');

      expect(
        TontineCalendarUtils.formatAmount(2500.0, currency: 'USD'),
        '2500 USD',
      );
    });

    test('should format completion percentage', () {
      expect(TontineCalendarUtils.formatCompletionPercentage(0.75), '75.0%');

      expect(TontineCalendarUtils.formatCompletionPercentage(0.333), '33.3%');
    });
  });
}
