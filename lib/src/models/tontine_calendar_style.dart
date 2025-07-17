import 'package:flutter/material.dart';

/// Style configuration for the TontineCalendar widget
class TontineCalendarStyle {
  /// Background color for regular (unvalidated) days
  final Color regularDayColor;
  
  /// Background color for validated days
  final Color validatedDayColor;
  
  /// Background color for selected days
  final Color selectedDayColor;
  
  /// Text color for regular days
  final Color regularDayTextColor;
  
  /// Text color for validated days
  final Color validatedDayTextColor;
  
  /// Text color for selected days
  final Color selectedDayTextColor;
  
  /// Border color for selected days
  final Color selectedDayBorderColor;
  
  /// Border width for selected days
  final double selectedDayBorderWidth;
  
  /// Border radius for day containers
  final BorderRadius dayBorderRadius;
  
  /// Text style for day numbers
  final TextStyle dayTextStyle;
  
  /// Icon for validated days (optional, if null shows check icon)
  final IconData? validatedDayIcon;
  
  /// Size of the validated day icon
  final double validatedDayIconSize;
  
  /// Header background color
  final Color headerBackgroundColor;
  
  /// Header text color
  final Color headerTextColor;
  
  /// Header text style
  final TextStyle headerTextStyle;
  
  /// Navigation button color
  final Color navigationButtonColor;
  
  /// Navigation button text color
  final Color navigationButtonTextColor;
  
  /// Grid spacing between days
  final double gridSpacing;
  
  /// Day container height
  final double dayHeight;
  
  /// Padding around the calendar
  final EdgeInsets calendarPadding;
  
  /// Padding around day containers
  final EdgeInsets dayPadding;

  const TontineCalendarStyle({
    this.regularDayColor = const Color(0xff273071),
    this.validatedDayColor = const Color(0xff0d7abc),
    this.selectedDayColor = const Color(0xff273071),
    this.regularDayTextColor = Colors.white,
    this.validatedDayTextColor = Colors.white,
    this.selectedDayTextColor = Colors.white,
    this.selectedDayBorderColor = const Color(0xff3bcc97),
    this.selectedDayBorderWidth = 3.0,
    this.dayBorderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.dayTextStyle = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    this.validatedDayIcon,
    this.validatedDayIconSize = 24.0,
    this.headerBackgroundColor = Colors.transparent,
    this.headerTextColor = const Color(0xff3bcc97),
    this.headerTextStyle = const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
    this.navigationButtonColor = const Color(0xff273071),
    this.navigationButtonTextColor = Colors.white,
    this.gridSpacing = 10.0,
    this.dayHeight = 50.0,
    this.calendarPadding = const EdgeInsets.all(8.0),
    this.dayPadding = EdgeInsets.zero,
  });

  /// Creates a default style
  factory TontineCalendarStyle.defaultStyle() {
    return const TontineCalendarStyle();
  }

  /// Creates a light theme style
  factory TontineCalendarStyle.lightTheme() {
    return const TontineCalendarStyle(
      regularDayColor: Color(0xffe3f2fd),
      validatedDayColor: Color(0xff2196f3),
      selectedDayColor: Color(0xffe3f2fd),
      regularDayTextColor: Color(0xff1976d2),
      validatedDayTextColor: Colors.white,
      selectedDayTextColor: Color(0xff1976d2),
      selectedDayBorderColor: Color(0xff4caf50),
      headerTextColor: Color(0xff1976d2),
      navigationButtonColor: Color(0xff2196f3),
    );
  }

  /// Creates a dark theme style
  factory TontineCalendarStyle.darkTheme() {
    return const TontineCalendarStyle(
      regularDayColor: Color(0xff424242),
      validatedDayColor: Color(0xff1976d2),
      selectedDayColor: Color(0xff424242),
      regularDayTextColor: Colors.white,
      validatedDayTextColor: Colors.white,
      selectedDayTextColor: Colors.white,
      selectedDayBorderColor: Color(0xff4caf50),
      headerTextColor: Colors.white,
      navigationButtonColor: Color(0xff1976d2),
    );
  }

  /// Creates a custom style with the original app colors
  factory TontineCalendarStyle.originalTheme() {
    return const TontineCalendarStyle(
      regularDayColor: Color(0xff273071),
      validatedDayColor: Color(0xff0d7abc),
      selectedDayColor: Color(0xff273071),
      regularDayTextColor: Colors.white,
      validatedDayTextColor: Colors.white,
      selectedDayTextColor: Colors.white,
      selectedDayBorderColor: Color(0xff3bcc97),
      headerTextColor: Color(0xff3bcc97),
      navigationButtonColor: Color(0xff273071),
    );
  }

  /// Creates a style from a primary color
  factory TontineCalendarStyle.fromPrimaryColor(Color primaryColor) {
    final lighterColor = Color.lerp(primaryColor, Colors.white, 0.8)!;
    final darkerColor = Color.lerp(primaryColor, Colors.black, 0.2)!;
    
    return TontineCalendarStyle(
      regularDayColor: lighterColor,
      validatedDayColor: primaryColor,
      selectedDayColor: lighterColor,
      regularDayTextColor: darkerColor,
      validatedDayTextColor: Colors.white,
      selectedDayTextColor: darkerColor,
      selectedDayBorderColor: darkerColor,
      headerTextColor: primaryColor,
      navigationButtonColor: primaryColor,
    );
  }

  /// Gets the effective validated day icon
  IconData get effectiveValidatedDayIcon => validatedDayIcon ?? Icons.check_circle_outline;

  /// Creates a copy of this TontineCalendarStyle with the given fields replaced
  TontineCalendarStyle copyWith({
    Color? regularDayColor,
    Color? validatedDayColor,
    Color? selectedDayColor,
    Color? regularDayTextColor,
    Color? validatedDayTextColor,
    Color? selectedDayTextColor,
    Color? selectedDayBorderColor,
    double? selectedDayBorderWidth,
    BorderRadius? dayBorderRadius,
    TextStyle? dayTextStyle,
    IconData? validatedDayIcon,
    double? validatedDayIconSize,
    Color? headerBackgroundColor,
    Color? headerTextColor,
    TextStyle? headerTextStyle,
    Color? navigationButtonColor,
    Color? navigationButtonTextColor,
    double? gridSpacing,
    double? dayHeight,
    EdgeInsets? calendarPadding,
    EdgeInsets? dayPadding,
  }) {
    return TontineCalendarStyle(
      regularDayColor: regularDayColor ?? this.regularDayColor,
      validatedDayColor: validatedDayColor ?? this.validatedDayColor,
      selectedDayColor: selectedDayColor ?? this.selectedDayColor,
      regularDayTextColor: regularDayTextColor ?? this.regularDayTextColor,
      validatedDayTextColor: validatedDayTextColor ?? this.validatedDayTextColor,
      selectedDayTextColor: selectedDayTextColor ?? this.selectedDayTextColor,
      selectedDayBorderColor: selectedDayBorderColor ?? this.selectedDayBorderColor,
      selectedDayBorderWidth: selectedDayBorderWidth ?? this.selectedDayBorderWidth,
      dayBorderRadius: dayBorderRadius ?? this.dayBorderRadius,
      dayTextStyle: dayTextStyle ?? this.dayTextStyle,
      validatedDayIcon: validatedDayIcon ?? this.validatedDayIcon,
      validatedDayIconSize: validatedDayIconSize ?? this.validatedDayIconSize,
      headerBackgroundColor: headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      navigationButtonColor: navigationButtonColor ?? this.navigationButtonColor,
      navigationButtonTextColor: navigationButtonTextColor ?? this.navigationButtonTextColor,
      gridSpacing: gridSpacing ?? this.gridSpacing,
      dayHeight: dayHeight ?? this.dayHeight,
      calendarPadding: calendarPadding ?? this.calendarPadding,
      dayPadding: dayPadding ?? this.dayPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TontineCalendarStyle &&
        other.regularDayColor == regularDayColor &&
        other.validatedDayColor == validatedDayColor &&
        other.selectedDayColor == selectedDayColor &&
        other.regularDayTextColor == regularDayTextColor &&
        other.validatedDayTextColor == validatedDayTextColor &&
        other.selectedDayTextColor == selectedDayTextColor &&
        other.selectedDayBorderColor == selectedDayBorderColor &&
        other.selectedDayBorderWidth == selectedDayBorderWidth &&
        other.dayBorderRadius == dayBorderRadius &&
        other.dayTextStyle == dayTextStyle &&
        other.validatedDayIcon == validatedDayIcon &&
        other.validatedDayIconSize == validatedDayIconSize &&
        other.headerBackgroundColor == headerBackgroundColor &&
        other.headerTextColor == headerTextColor &&
        other.headerTextStyle == headerTextStyle &&
        other.navigationButtonColor == navigationButtonColor &&
        other.navigationButtonTextColor == navigationButtonTextColor &&
        other.gridSpacing == gridSpacing &&
        other.dayHeight == dayHeight &&
        other.calendarPadding == calendarPadding &&
        other.dayPadding == dayPadding;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      regularDayColor,
      validatedDayColor,
      selectedDayColor,
      regularDayTextColor,
      validatedDayTextColor,
      selectedDayTextColor,
      selectedDayBorderColor,
      selectedDayBorderWidth,
      dayBorderRadius,
      dayTextStyle,
      validatedDayIcon,
      validatedDayIconSize,
      headerBackgroundColor,
      headerTextColor,
      headerTextStyle,
      navigationButtonColor,
      navigationButtonTextColor,
      gridSpacing,
      dayHeight,
      calendarPadding,
      dayPadding,
    ]);
  }

  @override
  String toString() {
    return 'TontineCalendarStyle(regularDayColor: $regularDayColor, validatedDayColor: $validatedDayColor, selectedDayColor: $selectedDayColor)';
  }
}
