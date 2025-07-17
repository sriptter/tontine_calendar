import 'tontine_day.dart';

/// Represents a month in the tontine calendar
class TontineMonth {
  /// The month number (1-12)
  final int month;
  
  /// The name of the month
  final String name;
  
  /// List of days in this month
  final List<TontineDay> days;
  
  /// Total number of days in this month
  final int totalDays;

  const TontineMonth({
    required this.month,
    required this.name,
    required this.days,
    required this.totalDays,
  }) : assert(month >= 1 && month <= 12, 'Month must be between 1 and 12'),
       assert(totalDays >= 28 && totalDays <= 31, 'Total days must be between 28 and 31');

  /// Gets the default month names in English
  static const List<String> defaultMonthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  /// Gets the default month names in French
  static const List<String> frenchMonthNames = [
    'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
    'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
  ];

  /// Creates a TontineMonth with the specified parameters
  factory TontineMonth.create({
    required int month,
    required int totalDays,
    String? customName,
    List<String>? monthNames,
    List<TontineDay>? validatedDays,
  }) {
    final names = monthNames ?? defaultMonthNames;
    final name = customName ?? names[month - 1];
    
    final days = List.generate(totalDays, (index) {
      final dayNumber = index + 1;
      final validatedDay = validatedDays?.firstWhere(
        (day) => day.day == dayNumber && day.month == month,
        orElse: () => TontineDay(day: dayNumber, month: month),
      );
      
      return validatedDay ?? TontineDay(day: dayNumber, month: month);
    });

    return TontineMonth(
      month: month,
      name: name,
      days: days,
      totalDays: totalDays,
    );
  }

  /// Gets all validated days in this month
  List<TontineDay> get validatedDays => days.where((day) => day.isValidated).toList();

  /// Gets all unvalidated days in this month
  List<TontineDay> get unvalidatedDays => days.where((day) => !day.isValidated).toList();

  /// Gets the number of validated days
  int get validatedCount => validatedDays.length;

  /// Gets the number of unvalidated days
  int get unvalidatedCount => unvalidatedDays.length;

  /// Checks if the month is completed (all days validated)
  bool get isCompleted => validatedCount == totalDays;

  /// Gets the completion percentage (0.0 to 1.0)
  double get completionPercentage => validatedCount / totalDays;

  /// Gets the total amount for validated days
  double get totalAmount => validatedDays.fold(0.0, (sum, day) => sum + (day.amount ?? 0.0));

  /// Gets a specific day by its number
  TontineDay? getDay(int dayNumber) {
    if (dayNumber < 1 || dayNumber > totalDays) return null;
    return days.firstWhere((day) => day.day == dayNumber);
  }

  /// Updates a specific day
  TontineMonth updateDay(TontineDay updatedDay) {
    final updatedDays = days.map((day) {
      return day.day == updatedDay.day ? updatedDay : day;
    }).toList();

    return TontineMonth(
      month: month,
      name: name,
      days: updatedDays,
      totalDays: totalDays,
    );
  }

  /// Creates a copy of this TontineMonth with the given fields replaced
  TontineMonth copyWith({
    int? month,
    String? name,
    List<TontineDay>? days,
    int? totalDays,
  }) {
    return TontineMonth(
      month: month ?? this.month,
      name: name ?? this.name,
      days: days ?? this.days,
      totalDays: totalDays ?? this.totalDays,
    );
  }

  /// Creates a TontineMonth from a JSON map
  factory TontineMonth.fromJson(Map<String, dynamic> json) {
    final daysList = (json['days'] as List<dynamic>)
        .map((dayJson) => TontineDay.fromJson(dayJson as Map<String, dynamic>))
        .toList();

    return TontineMonth(
      month: json['month'] as int,
      name: json['name'] as String,
      days: daysList,
      totalDays: json['totalDays'] as int,
    );
  }

  /// Converts this TontineMonth to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'name': name,
      'days': days.map((day) => day.toJson()).toList(),
      'totalDays': totalDays,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TontineMonth &&
        other.month == month &&
        other.name == name &&
        other.totalDays == totalDays;
  }

  @override
  int get hashCode {
    return Object.hash(month, name, totalDays);
  }

  @override
  String toString() {
    return 'TontineMonth(month: $month, name: $name, totalDays: $totalDays, validatedCount: $validatedCount)';
  }
}
