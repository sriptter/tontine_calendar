import 'dart:convert';
import '../models/tontine_calendar_data.dart';
import '../models/tontine_day.dart';
import '../models/tontine_month.dart';

/// Utilities for exporting tontine calendar data
/// 
/// Note: For PDF export, you need to add the 'pdf' package to your dependencies.
/// For CSV export, you need to add the 'csv' package to your dependencies.
class TontineExportUtils {
  /// Exports calendar data to JSON format
  static String exportToJson(TontineCalendarData data) {
    return jsonEncode(data.toJson());
  }

  /// Exports validated days to JSON format
  static String exportValidatedDaysToJson(List<TontineDay> days) {
    return jsonEncode(days.map((day) => day.toJson()).toList());
  }

  /// Exports months data to JSON format
  static String exportMonthsToJson(List<TontineMonth> months) {
    return jsonEncode(months.map((month) => month.toJson()).toList());
  }

  /// Exports calendar data to CSV format (simple implementation)
  /// For advanced CSV features, use the 'csv' package
  static String exportToCsv(TontineCalendarData data) {
    final buffer = StringBuffer();
    
    // Header
    buffer.writeln('Month,Day,Validated,Amount,ValidatedDate');
    
    // Write all unvalidated days grouped by month
    data.unvalidatedDaysByMonth.forEach((month, days) {
      for (final day in days) {
        buffer.writeln(
          '$month,${day.day},${day.isValidated},${day.amount ?? 0},'
          '${day.validatedDate?.toIso8601String() ?? ""}',
        );
      }
    });
    
    return buffer.toString();
  }

  /// Exports validated days to CSV format
  static String exportValidatedDaysToCsv(List<TontineDay> days) {
    final buffer = StringBuffer();
    
    // Header
    buffer.writeln('Month,Day,Amount,ValidatedDate');
    
    // Write validated days
    for (final day in days) {
      if (day.isValidated) {
        buffer.writeln(
          '${day.month},${day.day},${day.amount ?? 0},'
          '${day.validatedDate?.toIso8601String() ?? ""}',
        );
      }
    }
    
    return buffer.toString();
  }

  /// Generates a summary report as text
  static String generateSummaryReport(TontineCalendarData data) {
    final buffer = StringBuffer();
    
    buffer.writeln('=== TONTINE CALENDAR SUMMARY ===');
    buffer.writeln('');
    buffer.writeln('Selected Day: ${data.selectedDay.day}/${data.selectedDay.month}');
    buffer.writeln('Selected Month: ${data.selectedMonth.name}');
    buffer.writeln('');
    buffer.writeln('Total Unvalidated Days: ${data.totalUnvalidatedDays}');
    buffer.writeln('Total Amount: ${data.totalAmount}');
    buffer.writeln('');
    buffer.writeln('Details by Month:');
    
    data.unvalidatedDaysByMonth.forEach((month, days) {
      buffer.writeln('  Month $month: ${days.length} days');
    });
    
    return buffer.toString();
  }

  /// Generates a detailed report as text
  static String generateDetailedReport(TontineCalendarData data) {
    final buffer = StringBuffer();
    
    buffer.writeln('=== TONTINE CALENDAR DETAILED REPORT ===');
    buffer.writeln('');
    buffer.writeln('Selected Day: ${data.selectedDay.day}/${data.selectedDay.month}');
    buffer.writeln('Selected Month: ${data.selectedMonth.name}');
    buffer.writeln('');
    buffer.writeln('Total Unvalidated Days: ${data.totalUnvalidatedDays}');
    buffer.writeln('Total Amount: ${data.totalAmount}');
    buffer.writeln('');
    
    data.unvalidatedDaysByMonth.forEach((month, days) {
      buffer.writeln('--- Month $month (${days.length} days) ---');
      for (final day in days) {
        buffer.writeln(
          '  Day ${day.day}: Amount=${day.amount ?? 0}, '
          'Validated=${day.isValidated}',
        );
      }
      buffer.writeln('');
    });
    
    return buffer.toString();
  }
}


