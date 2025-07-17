import 'tontine_day.dart';
import 'tontine_month.dart';

/// Configuration class for the TontineCalendar widget
class TontineCalendarConfig {
  /// Number of months in the calendar (2-12)
  final int monthCount;

  /// Number of days per month (28-31)
  final int daysPerMonth;

  /// Custom month names (optional, defaults to English month names)
  final List<String>? monthNames;

  /// Default amount per day (optional)
  final double? defaultDayAmount;

  /// List of validated days (optional)
  final List<TontineDay>? validatedDays;

  /// Whether to enable navigation between months
  final bool enableNavigation;

  /// Whether to show month completion status
  final bool showCompletionStatus;

  /// Whether to show total amount
  final bool showTotalAmount;

  /// Initial month to display (1-based, defaults to 1)
  final int initialMonth;

  /// Whether to allow selection of validated days
  final bool allowValidatedDaySelection;

  /// Whether to show day numbers
  final bool showDayNumbers;

  /// Whether navigation is restricted (requires month completion to proceed)
  final bool restrictiveNavigation;

  /// Whether to highlight selected days with border
  final bool highlightSelectedDays;

  const TontineCalendarConfig({
    this.monthCount = 12,
    this.daysPerMonth = 31,
    this.monthNames,
    this.defaultDayAmount,
    this.validatedDays,
    this.enableNavigation = true,
    this.showCompletionStatus = true,
    this.showTotalAmount = true,
    this.initialMonth = 1,
    this.allowValidatedDaySelection = true,
    this.showDayNumbers = true,
    this.restrictiveNavigation = true,
    this.highlightSelectedDays = true,
  })  : assert(monthCount >= 2 && monthCount <= 12,
            'Month count must be between 2 and 12'),
        assert(daysPerMonth >= 28 && daysPerMonth <= 31,
            'Days per month must be between 28 and 31'),
        assert(initialMonth >= 1 && initialMonth <= monthCount,
            'Initial month must be between 1 and monthCount'),
        assert(monthNames == null || monthNames.length >= monthCount,
            'Month names list must contain at least monthCount names');

  /// Creates a default configuration
  factory TontineCalendarConfig.defaultConfig() {
    return const TontineCalendarConfig();
  }

  /// Creates a configuration for a 6-month tontine with 31 days each
  factory TontineCalendarConfig.sixMonths() {
    return const TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
    );
  }

  /// Creates a configuration with French month names
  factory TontineCalendarConfig.withFrenchNames({
    int monthCount = 12,
    int daysPerMonth = 31,
    double? defaultDayAmount,
    List<TontineDay>? validatedDays,
  }) {
    return TontineCalendarConfig(
      monthCount: monthCount,
      daysPerMonth: daysPerMonth,
      monthNames: TontineMonth.frenchMonthNames,
      defaultDayAmount: defaultDayAmount,
      validatedDays: validatedDays,
    );
  }

  /// Creates a configuration with custom settings
  factory TontineCalendarConfig.custom({
    required int monthCount,
    required int daysPerMonth,
    List<String>? monthNames,
    double? defaultDayAmount,
    List<TontineDay>? validatedDays,
    bool enableNavigation = true,
    bool showCompletionStatus = true,
    bool showTotalAmount = true,
    int initialMonth = 1,
    bool allowValidatedDaySelection = true,
    bool showDayNumbers = true,
    bool restrictiveNavigation = true,
    bool highlightSelectedDays = true,
  }) {
    return TontineCalendarConfig(
      monthCount: monthCount,
      daysPerMonth: daysPerMonth,
      monthNames: monthNames,
      defaultDayAmount: defaultDayAmount,
      validatedDays: validatedDays,
      enableNavigation: enableNavigation,
      showCompletionStatus: showCompletionStatus,
      showTotalAmount: showTotalAmount,
      initialMonth: initialMonth,
      allowValidatedDaySelection: allowValidatedDaySelection,
      showDayNumbers: showDayNumbers,
      restrictiveNavigation: restrictiveNavigation,
      highlightSelectedDays: highlightSelectedDays,
    );
  }

  /// Gets the effective month names to use
  List<String> get effectiveMonthNames {
    return monthNames ?? TontineMonth.defaultMonthNames;
  }

  /// Gets the total number of days across all months
  int get totalDays => monthCount * daysPerMonth;

  /// Gets the total validated days count
  int get validatedDaysCount => validatedDays?.length ?? 0;

  /// Gets the total unvalidated days count
  int get unvalidatedDaysCount => totalDays - validatedDaysCount;

  /// Gets the completion percentage (0.0 to 1.0)
  double get completionPercentage => validatedDaysCount / totalDays;

  /// Gets the total amount for validated days
  double get totalValidatedAmount {
    if (validatedDays == null) return 0.0;
    return validatedDays!
        .fold(0.0, (sum, day) => sum + (day.amount ?? defaultDayAmount ?? 0.0));
  }

  /// Gets validated days for a specific month
  List<TontineDay> getValidatedDaysForMonth(int month) {
    if (validatedDays == null) return [];
    return validatedDays!.where((day) => day.month == month).toList();
  }

  /// Checks if a specific day is validated
  bool isDayValidated(int month, int day) {
    if (validatedDays == null) return false;
    return validatedDays!.any((d) => d.month == month && d.day == day);
  }

  /// Creates a copy of this TontineCalendarConfig with the given fields replaced
  TontineCalendarConfig copyWith({
    int? monthCount,
    int? daysPerMonth,
    List<String>? monthNames,
    double? defaultDayAmount,
    List<TontineDay>? validatedDays,
    bool? enableNavigation,
    bool? showCompletionStatus,
    bool? showTotalAmount,
    int? initialMonth,
    bool? allowValidatedDaySelection,
    bool? showDayNumbers,
    bool? restrictiveNavigation,
    bool? highlightSelectedDays,
  }) {
    return TontineCalendarConfig(
      monthCount: monthCount ?? this.monthCount,
      daysPerMonth: daysPerMonth ?? this.daysPerMonth,
      monthNames: monthNames ?? this.monthNames,
      defaultDayAmount: defaultDayAmount ?? this.defaultDayAmount,
      validatedDays: validatedDays ?? this.validatedDays,
      enableNavigation: enableNavigation ?? this.enableNavigation,
      showCompletionStatus: showCompletionStatus ?? this.showCompletionStatus,
      showTotalAmount: showTotalAmount ?? this.showTotalAmount,
      initialMonth: initialMonth ?? this.initialMonth,
      allowValidatedDaySelection:
          allowValidatedDaySelection ?? this.allowValidatedDaySelection,
      showDayNumbers: showDayNumbers ?? this.showDayNumbers,
      restrictiveNavigation:
          restrictiveNavigation ?? this.restrictiveNavigation,
      highlightSelectedDays:
          highlightSelectedDays ?? this.highlightSelectedDays,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TontineCalendarConfig &&
        other.monthCount == monthCount &&
        other.daysPerMonth == daysPerMonth &&
        other.defaultDayAmount == defaultDayAmount &&
        other.enableNavigation == enableNavigation &&
        other.showCompletionStatus == showCompletionStatus &&
        other.showTotalAmount == showTotalAmount &&
        other.initialMonth == initialMonth &&
        other.allowValidatedDaySelection == allowValidatedDaySelection &&
        other.showDayNumbers == showDayNumbers;
  }

  @override
  int get hashCode {
    return Object.hash(
      monthCount,
      daysPerMonth,
      defaultDayAmount,
      enableNavigation,
      showCompletionStatus,
      showTotalAmount,
      initialMonth,
      allowValidatedDaySelection,
      showDayNumbers,
    );
  }

  @override
  String toString() {
    return 'TontineCalendarConfig(monthCount: $monthCount, daysPerMonth: $daysPerMonth, validatedDaysCount: $validatedDaysCount)';
  }
}
