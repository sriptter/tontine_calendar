import 'tontine_day.dart';
import 'tontine_month.dart';

/// Data structure emitted when a day is selected in the tontine calendar
class TontineCalendarData {
  /// The selected day
  final TontineDay selectedDay;
  
  /// The month of the selected day
  final TontineMonth selectedMonth;
  
  /// All unvalidated days from previous months up to and including the selected day,
  /// grouped by month
  final Map<int, List<TontineDay>> unvalidatedDaysByMonth;
  
  /// Total number of unvalidated days
  final int totalUnvalidatedDays;
  
  /// Total amount for all unvalidated days (if amounts are provided)
  final double totalAmount;

  const TontineCalendarData({
    required this.selectedDay,
    required this.selectedMonth,
    required this.unvalidatedDaysByMonth,
    required this.totalUnvalidatedDays,
    required this.totalAmount,
  });

  /// Creates TontineCalendarData from a selected day and calendar state
  factory TontineCalendarData.fromSelection({
    required TontineDay selectedDay,
    required List<TontineMonth> allMonths,
    double? defaultDayAmount,
  }) {
    final selectedMonth = allMonths.firstWhere(
      (month) => month.month == selectedDay.month,
    );

    final unvalidatedDaysByMonth = <int, List<TontineDay>>{};
    var totalUnvalidatedDays = 0;
    var totalAmount = 0.0;

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
        totalUnvalidatedDays += unvalidatedDays.length;
        
        // Calculate total amount
        for (final day in unvalidatedDays) {
          totalAmount += day.amount ?? defaultDayAmount ?? 0.0;
        }
      }
    }

    return TontineCalendarData(
      selectedDay: selectedDay,
      selectedMonth: selectedMonth,
      unvalidatedDaysByMonth: unvalidatedDaysByMonth,
      totalUnvalidatedDays: totalUnvalidatedDays,
      totalAmount: totalAmount,
    );
  }

  /// Gets all unvalidated days as a flat list
  List<TontineDay> get allUnvalidatedDays {
    final allDays = <TontineDay>[];
    for (final days in unvalidatedDaysByMonth.values) {
      allDays.addAll(days);
    }
    return allDays;
  }

  /// Gets the months that have unvalidated days
  List<int> get monthsWithUnvalidatedDays => unvalidatedDaysByMonth.keys.toList()..sort();

  /// Gets unvalidated days for a specific month
  List<TontineDay> getUnvalidatedDaysForMonth(int month) {
    return unvalidatedDaysByMonth[month] ?? [];
  }

  /// Checks if there are any unvalidated days
  bool get hasUnvalidatedDays => totalUnvalidatedDays > 0;

  /// Creates a copy of this TontineCalendarData with the given fields replaced
  TontineCalendarData copyWith({
    TontineDay? selectedDay,
    TontineMonth? selectedMonth,
    Map<int, List<TontineDay>>? unvalidatedDaysByMonth,
    int? totalUnvalidatedDays,
    double? totalAmount,
  }) {
    return TontineCalendarData(
      selectedDay: selectedDay ?? this.selectedDay,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      unvalidatedDaysByMonth: unvalidatedDaysByMonth ?? this.unvalidatedDaysByMonth,
      totalUnvalidatedDays: totalUnvalidatedDays ?? this.totalUnvalidatedDays,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  /// Creates a TontineCalendarData from a JSON map
  factory TontineCalendarData.fromJson(Map<String, dynamic> json) {
    final unvalidatedDaysByMonth = <int, List<TontineDay>>{};
    final unvalidatedDaysJson = json['unvalidatedDaysByMonth'] as Map<String, dynamic>;
    
    for (final entry in unvalidatedDaysJson.entries) {
      final month = int.parse(entry.key);
      final daysList = (entry.value as List<dynamic>)
          .map((dayJson) => TontineDay.fromJson(dayJson as Map<String, dynamic>))
          .toList();
      unvalidatedDaysByMonth[month] = daysList;
    }

    return TontineCalendarData(
      selectedDay: TontineDay.fromJson(json['selectedDay'] as Map<String, dynamic>),
      selectedMonth: TontineMonth.fromJson(json['selectedMonth'] as Map<String, dynamic>),
      unvalidatedDaysByMonth: unvalidatedDaysByMonth,
      totalUnvalidatedDays: json['totalUnvalidatedDays'] as int,
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );
  }

  /// Converts this TontineCalendarData to a JSON map
  Map<String, dynamic> toJson() {
    final unvalidatedDaysJson = <String, dynamic>{};
    for (final entry in unvalidatedDaysByMonth.entries) {
      unvalidatedDaysJson[entry.key.toString()] = 
          entry.value.map((day) => day.toJson()).toList();
    }

    return {
      'selectedDay': selectedDay.toJson(),
      'selectedMonth': selectedMonth.toJson(),
      'unvalidatedDaysByMonth': unvalidatedDaysJson,
      'totalUnvalidatedDays': totalUnvalidatedDays,
      'totalAmount': totalAmount,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TontineCalendarData &&
        other.selectedDay == selectedDay &&
        other.selectedMonth == selectedMonth &&
        other.totalUnvalidatedDays == totalUnvalidatedDays &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return Object.hash(selectedDay, selectedMonth, totalUnvalidatedDays, totalAmount);
  }

  @override
  String toString() {
    return 'TontineCalendarData(selectedDay: $selectedDay, totalUnvalidatedDays: $totalUnvalidatedDays, totalAmount: $totalAmount)';
  }
}
