import 'package:flutter/material.dart';
import '../models/tontine_calendar_style.dart';

/// Theme provider for TontineCalendar
class TontineCalendarTheme {
  /// Creates a theme based on Material Design colors
  static TontineCalendarStyle materialTheme({
    ColorScheme? colorScheme,
    bool isDark = false,
  }) {
    final scheme = colorScheme ?? (isDark 
        ? const ColorScheme.dark() 
        : const ColorScheme.light());

    return TontineCalendarStyle(
      regularDayColor: scheme.surfaceContainerHighest,
      validatedDayColor: scheme.primary,
      selectedDayColor: scheme.surfaceContainerHighest,
      regularDayTextColor: scheme.onSurface,
      validatedDayTextColor: scheme.onPrimary,
      selectedDayTextColor: scheme.onSurface,
      selectedDayBorderColor: scheme.secondary,
      headerTextColor: scheme.primary,
      navigationButtonColor: scheme.primary,
      navigationButtonTextColor: scheme.onPrimary,
    );
  }

  /// Creates a theme with custom brand colors
  static TontineCalendarStyle brandTheme({
    required Color primaryColor,
    required Color secondaryColor,
    Color? backgroundColor,
    bool isDark = false,
  }) {
    final bgColor = backgroundColor ?? (isDark ? Colors.grey[900]! : Colors.grey[100]!);
    final textColor = isDark ? Colors.white : Colors.black87;
    
    return TontineCalendarStyle(
      regularDayColor: bgColor,
      validatedDayColor: primaryColor,
      selectedDayColor: bgColor,
      regularDayTextColor: textColor,
      validatedDayTextColor: Colors.white,
      selectedDayTextColor: textColor,
      selectedDayBorderColor: secondaryColor,
      headerTextColor: primaryColor,
      navigationButtonColor: primaryColor,
      navigationButtonTextColor: Colors.white,
    );
  }

  /// Creates a minimalist theme
  static TontineCalendarStyle minimalistTheme({bool isDark = false}) {
    if (isDark) {
      return const TontineCalendarStyle(
        regularDayColor: Color(0xff2d2d2d),
        validatedDayColor: Color(0xff4a4a4a),
        selectedDayColor: Color(0xff2d2d2d),
        regularDayTextColor: Colors.white70,
        validatedDayTextColor: Colors.white,
        selectedDayTextColor: Colors.white,
        selectedDayBorderColor: Colors.white54,
        headerTextColor: Colors.white,
        navigationButtonColor: Color(0xff4a4a4a),
        navigationButtonTextColor: Colors.white,
        dayBorderRadius: BorderRadius.all(Radius.circular(4.0)),
        gridSpacing: 8.0,
      );
    } else {
      return const TontineCalendarStyle(
        regularDayColor: Color(0xfff5f5f5),
        validatedDayColor: Color(0xffe0e0e0),
        selectedDayColor: Color(0xfff5f5f5),
        regularDayTextColor: Colors.black87,
        validatedDayTextColor: Colors.black87,
        selectedDayTextColor: Colors.black87,
        selectedDayBorderColor: Colors.black54,
        headerTextColor: Colors.black87,
        navigationButtonColor: Color(0xffe0e0e0),
        navigationButtonTextColor: Colors.black87,
        dayBorderRadius: BorderRadius.all(Radius.circular(4.0)),
        gridSpacing: 8.0,
      );
    }
  }

  /// Creates a colorful theme
  static TontineCalendarStyle colorfulTheme() {
    return const TontineCalendarStyle(
      regularDayColor: Color(0xffe3f2fd),
      validatedDayColor: Color(0xff2196f3),
      selectedDayColor: Color(0xffe3f2fd),
      regularDayTextColor: Color(0xff1976d2),
      validatedDayTextColor: Colors.white,
      selectedDayTextColor: Color(0xff1976d2),
      selectedDayBorderColor: Color(0xffff9800),
      headerTextColor: Color(0xff1976d2),
      navigationButtonColor: Color(0xff4caf50),
      navigationButtonTextColor: Colors.white,
      dayBorderRadius: BorderRadius.all(Radius.circular(12.0)),
      selectedDayBorderWidth: 2.0,
    );
  }

  /// Creates a professional theme
  static TontineCalendarStyle professionalTheme() {
    return const TontineCalendarStyle(
      regularDayColor: Color(0xfff8f9fa),
      validatedDayColor: Color(0xff495057),
      selectedDayColor: Color(0xfff8f9fa),
      regularDayTextColor: Color(0xff495057),
      validatedDayTextColor: Colors.white,
      selectedDayTextColor: Color(0xff495057),
      selectedDayBorderColor: Color(0xff007bff),
      headerTextColor: Color(0xff495057),
      navigationButtonColor: Color(0xff6c757d),
      navigationButtonTextColor: Colors.white,
      dayBorderRadius: BorderRadius.all(Radius.circular(6.0)),
      dayTextStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      headerTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Creates a theme from a single color
  static TontineCalendarStyle monochromeTheme(Color baseColor) {
    final lightColor = Color.lerp(baseColor, Colors.white, 0.9)!;
    final mediumColor = Color.lerp(baseColor, Colors.white, 0.3)!;
    final darkColor = Color.lerp(baseColor, Colors.black, 0.2)!;
    
    return TontineCalendarStyle(
      regularDayColor: lightColor,
      validatedDayColor: baseColor,
      selectedDayColor: lightColor,
      regularDayTextColor: darkColor,
      validatedDayTextColor: Colors.white,
      selectedDayTextColor: darkColor,
      selectedDayBorderColor: mediumColor,
      headerTextColor: baseColor,
      navigationButtonColor: baseColor,
      navigationButtonTextColor: Colors.white,
    );
  }

  /// Creates a high contrast theme for accessibility
  static TontineCalendarStyle highContrastTheme({bool isDark = false}) {
    if (isDark) {
      return const TontineCalendarStyle(
        regularDayColor: Colors.black,
        validatedDayColor: Colors.white,
        selectedDayColor: Colors.black,
        regularDayTextColor: Colors.white,
        validatedDayTextColor: Colors.black,
        selectedDayTextColor: Colors.white,
        selectedDayBorderColor: Colors.yellow,
        selectedDayBorderWidth: 4.0,
        headerTextColor: Colors.white,
        navigationButtonColor: Colors.white,
        navigationButtonTextColor: Colors.black,
        dayTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        headerTextStyle: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return const TontineCalendarStyle(
        regularDayColor: Colors.white,
        validatedDayColor: Colors.black,
        selectedDayColor: Colors.white,
        regularDayTextColor: Colors.black,
        validatedDayTextColor: Colors.white,
        selectedDayTextColor: Colors.black,
        selectedDayBorderColor: Color(0xffff6600),
        selectedDayBorderWidth: 4.0,
        headerTextColor: Colors.black,
        navigationButtonColor: Colors.black,
        navigationButtonTextColor: Colors.white,
        dayTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        headerTextStyle: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  /// Creates a theme that adapts to system theme
  static TontineCalendarStyle adaptiveTheme(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final colorScheme = Theme.of(context).colorScheme;
    
    return materialTheme(
      colorScheme: colorScheme,
      isDark: brightness == Brightness.dark,
    );
  }

  /// Gets predefined theme names
  static List<String> get availableThemes => [
    'Default',
    'Light',
    'Dark',
    'Material Light',
    'Material Dark',
    'Minimalist Light',
    'Minimalist Dark',
    'Colorful',
    'Professional',
    'High Contrast Light',
    'High Contrast Dark',
  ];

  /// Gets a theme by name
  static TontineCalendarStyle getThemeByName(String themeName, {BuildContext? context}) {
    switch (themeName.toLowerCase()) {
      case 'default':
        return TontineCalendarStyle.defaultStyle();
      case 'light':
        return TontineCalendarStyle.lightTheme();
      case 'dark':
        return TontineCalendarStyle.darkTheme();
      case 'material light':
        return materialTheme(isDark: false);
      case 'material dark':
        return materialTheme(isDark: true);
      case 'minimalist light':
        return minimalistTheme(isDark: false);
      case 'minimalist dark':
        return minimalistTheme(isDark: true);
      case 'colorful':
        return colorfulTheme();
      case 'professional':
        return professionalTheme();
      case 'high contrast light':
        return highContrastTheme(isDark: false);
      case 'high contrast dark':
        return highContrastTheme(isDark: true);
      case 'adaptive':
        if (context != null) return adaptiveTheme(context);
        return TontineCalendarStyle.defaultStyle();
      default:
        return TontineCalendarStyle.defaultStyle();
    }
  }
}
