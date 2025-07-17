import '../models/tontine_day.dart';
import '../models/tontine_month.dart';
import '../models/tontine_calendar_data.dart';

/// Utility class for TontineCalendar operations
class TontineCalendarUtils {
  /// Calculates all unvalidated days from the beginning up to and including the selected day
  static Map<int, List<TontineDay>> calculateUnvalidatedDays({
    required TontineDay selectedDay,
    required List<TontineMonth> allMonths,
  }) {
    final unvalidatedDaysByMonth = <int, List<TontineDay>>{};

    // Process all months up to and including the selected month
    for (final month in allMonths) {
      if (month.month > selectedDay.month) break;

      final unvalidatedDays = <TontineDay>[];

      if (month.month < selectedDay.month) {
        // For previous months, include all unvalidated days
        unvalidatedDays.addAll(month.unvalidatedDays);
      } else if (month.month == selectedDay.month) {
        // For the selected month, include unvalidated days up to and including the selected day
        for (final day in month.days) {
          if (day.day <= selectedDay.day && !day.isValidated) {
            unvalidatedDays.add(day);
          }
        }
      }

      if (unvalidatedDays.isNotEmpty) {
        unvalidatedDaysByMonth[month.month] = unvalidatedDays;
      }
    }

    return unvalidatedDaysByMonth;
  }

  /// Calculates the total amount for a list of days
  static double calculateTotalAmount({
    required List<TontineDay> days,
    double? defaultDayAmount,
  }) {
    return days.fold(0.0, (sum, day) => sum + (day.amount ?? defaultDayAmount ?? 0.0));
  }

  /// Calculates the total amount for unvalidated days by month
  static double calculateTotalAmountByMonth({
    required Map<int, List<TontineDay>> unvalidatedDaysByMonth,
    double? defaultDayAmount,
  }) {
    var totalAmount = 0.0;
    for (final days in unvalidatedDaysByMonth.values) {
      totalAmount += calculateTotalAmount(
        days: days,
        defaultDayAmount: defaultDayAmount,
      );
    }
    return totalAmount;
  }

  /// Finds the next day that should be selected based on validated days
  static int? findNextDayToSelect({
    required TontineMonth month,
    required int totalDaysInMonth,
  }) {
    if (month.validatedDays.isEmpty) {
      return 1;
    }

    final validatedDays = month.validatedDays.toList()
      ..sort((a, b) => a.day.compareTo(b.day));
    
    final lastValidatedDay = validatedDays.last.day;
    
    if (lastValidatedDay < totalDaysInMonth) {
      return lastValidatedDay + 1;
    }
    
    return null; // Month is completed
  }

  /// Finds the current month index based on the latest validated day
  static int findCurrentMonthIndex({
    required List<TontineMonth> months,
    required int initialMonth,
    required int daysPerMonth,
  }) {
    // Find all validated days across all months
    final allValidatedDays = <TontineDay>[];
    for (final month in months) {
      allValidatedDays.addAll(month.validatedDays);
    }

    if (allValidatedDays.isEmpty) {
      return initialMonth - 1;
    }

    // Sort by month, then by day
    allValidatedDays.sort((a, b) {
      final monthComparison = a.month.compareTo(b.month);
      if (monthComparison != 0) return monthComparison;
      return a.day.compareTo(b.day);
    });

    final latestDay = allValidatedDays.last;
    final monthIndex = latestDay.month - 1;
    final month = months[monthIndex];
    
    // If the month is not completed, stay on it
    // If completed, move to next month
    if (month.validatedCount < daysPerMonth) {
      return monthIndex;
    } else if (monthIndex < months.length - 1) {
      return monthIndex + 1;
    } else {
      return monthIndex; // Last month
    }
  }

  /// Validates if a day can be selected in simple mode
  static bool canSelectDayInSimpleMode({
    required int dayNumber,
    required int? nextDayToSelect,
  }) {
    return dayNumber == nextDayToSelect;
  }

  /// Generates a range of days for multiple mode selection
  static List<int> generateDayRange({
    required int startDay,
    required int endDay,
  }) {
    if (startDay == endDay) {
      return [startDay];
    }

    final minDay = startDay < endDay ? startDay : endDay;
    final maxDay = startDay > endDay ? startDay : endDay;
    
    return List.generate(maxDay - minDay + 1, (index) => minDay + index);
  }

  /// Creates TontineCalendarData from a selection
  static TontineCalendarData createCalendarData({
    required TontineDay selectedDay,
    required List<TontineMonth> allMonths,
    double? defaultDayAmount,
  }) {
    return TontineCalendarData.fromSelection(
      selectedDay: selectedDay,
      allMonths: allMonths,
      defaultDayAmount: defaultDayAmount,
    );
  }

  /// Validates calendar configuration
  static bool validateConfiguration({
    required int monthCount,
    required int daysPerMonth,
    required int initialMonth,
    List<String>? monthNames,
  }) {
    if (monthCount < 2 || monthCount > 12) return false;
    if (daysPerMonth < 28 || daysPerMonth > 31) return false;
    if (initialMonth < 1 || initialMonth > monthCount) return false;
    if (monthNames != null && monthNames.length < monthCount) return false;
    
    return true;
  }

  /// Gets a summary of calendar state
  static Map<String, dynamic> getCalendarSummary({
    required List<TontineMonth> months,
    double? defaultDayAmount,
  }) {
    var totalDays = 0;
    var totalValidatedDays = 0;
    var totalAmount = 0.0;
    var completedMonths = 0;

    for (final month in months) {
      totalDays += month.totalDays;
      totalValidatedDays += month.validatedCount;
      totalAmount += month.totalAmount;
      if (month.isCompleted) completedMonths++;
    }

    final completionPercentage = totalDays > 0 ? totalValidatedDays / totalDays : 0.0;

    return {
      'totalDays': totalDays,
      'totalValidatedDays': totalValidatedDays,
      'totalUnvalidatedDays': totalDays - totalValidatedDays,
      'totalAmount': totalAmount,
      'completedMonths': completedMonths,
      'totalMonths': months.length,
      'completionPercentage': completionPercentage,
    };
  }

  /// Formats amount with currency
  static String formatAmount(double amount, {String currency = 'FCFA'}) {
    return '${amount.toStringAsFixed(0)} $currency';
  }

  /// Formats completion percentage
  static String formatCompletionPercentage(double percentage) {
    return '${(percentage * 100).toStringAsFixed(1)}%';
  }

  /// Gets month name by index
  static String getMonthName(int monthIndex, List<String> monthNames) {
    if (monthIndex < 0 || monthIndex >= monthNames.length) {
      return 'Unknown';
    }
    return monthNames[monthIndex];
  }
}
