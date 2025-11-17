import 'package:flutter/material.dart';
import '../models/tontine_calendar_style.dart';

/// Material 3 themes for TontineCalendar
/// These themes follow Material Design 3 guidelines with modern gradients and shadows
class Material3Themes {
  /// Creates a Material 3 light theme with gradients and elevation
  static TontineCalendarStyle material3Light({
    ColorScheme? colorScheme,
  }) {
    final scheme = colorScheme ?? ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    );

    return TontineCalendarStyle(
      // Colors
      regularDayColor: scheme.surfaceContainerHighest,
      validatedDayColor: scheme.primary,
      selectedDayColor: scheme.surfaceContainerHighest,
      regularDayTextColor: scheme.onSurface,
      validatedDayTextColor: scheme.onPrimary,
      selectedDayTextColor: scheme.onSurface,
      selectedDayBorderColor: scheme.secondary,
      headerTextColor: scheme.primary,
      navigationButtonColor: scheme.primaryContainer,
      navigationButtonTextColor: scheme.onPrimaryContainer,
      
      // Gradients for premium look
      regularDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scheme.surfaceContainerHighest,
          scheme.surfaceContainerHighest.withValues(alpha: 0.8),
        ],
      ),
      validatedDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scheme.primary,
          scheme.primary.withValues(alpha: 0.8),
        ],
      ),
      selectedDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scheme.secondaryContainer,
          scheme.secondaryContainer.withValues(alpha: 0.8),
        ],
      ),
      
      // Shadows for depth
      dayBoxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      validatedDayBoxShadow: [
        BoxShadow(
          color: scheme.primary.withValues(alpha: 0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
      selectedDayBoxShadow: [
        BoxShadow(
          color: scheme.secondary.withValues(alpha: 0.4),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
      
      // Styling
      dayBorderRadius: const BorderRadius.all(Radius.circular(12.0)),
      dayTextStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      headerTextStyle: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
        color: scheme.primary,
      ),
      gridSpacing: 12.0,
      dayHeight: 56.0,
      
      // Animations
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOutCubic,
      selectionAnimationDuration: const Duration(milliseconds: 200),
      selectionAnimationCurve: Curves.easeOutCubic,
      
      // Elevation
      enableElevation: true,
      regularDayElevation: 1.0,
      validatedDayElevation: 4.0,
      selectedDayElevation: 8.0,
    );
  }

  /// Creates a Material 3 dark theme with gradients and elevation
  static TontineCalendarStyle material3Dark({
    ColorScheme? colorScheme,
  }) {
    final scheme = colorScheme ?? ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    );

    return TontineCalendarStyle(
      // Colors
      regularDayColor: scheme.surfaceContainerHighest,
      validatedDayColor: scheme.primary,
      selectedDayColor: scheme.surfaceContainerHighest,
      regularDayTextColor: scheme.onSurface,
      validatedDayTextColor: scheme.onPrimary,
      selectedDayTextColor: scheme.onSurface,
      selectedDayBorderColor: scheme.secondary,
      headerTextColor: scheme.primary,
      navigationButtonColor: scheme.primaryContainer,
      navigationButtonTextColor: scheme.onPrimaryContainer,
      
      // Gradients
      regularDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scheme.surfaceContainerHighest,
          scheme.surfaceContainerHighest.withValues(alpha: 0.7),
        ],
      ),
      validatedDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scheme.primary,
          scheme.primary.withValues(alpha: 0.8),
        ],
      ),
      selectedDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scheme.secondaryContainer,
          scheme.secondaryContainer.withValues(alpha: 0.8),
        ],
      ),
      
      // Shadows
      dayBoxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
      validatedDayBoxShadow: [
        BoxShadow(
          color: scheme.primary.withValues(alpha: 0.5),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
      selectedDayBoxShadow: [
        BoxShadow(
          color: scheme.secondary.withValues(alpha: 0.6),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
      
      // Styling
      dayBorderRadius: const BorderRadius.all(Radius.circular(12.0)),
      dayTextStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      headerTextStyle: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
        color: scheme.primary,
      ),
      gridSpacing: 12.0,
      dayHeight: 56.0,
      
      // Animations
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOutCubic,
      selectionAnimationDuration: const Duration(milliseconds: 200),
      selectionAnimationCurve: Curves.easeOutCubic,
      
      // Elevation
      enableElevation: true,
      regularDayElevation: 2.0,
      validatedDayElevation: 6.0,
      selectedDayElevation: 10.0,
    );
  }

  /// Creates an adaptive Material 3 theme based on system brightness
  static TontineCalendarStyle material3Adaptive(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final colorScheme = Theme.of(context).colorScheme;
    
    return brightness == Brightness.dark
        ? material3Dark(colorScheme: colorScheme)
        : material3Light(colorScheme: colorScheme);
  }

  /// Creates a Material 3 theme with custom seed color
  static TontineCalendarStyle material3FromSeed(
    Color seedColor, {
    bool isDark = false,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
    
    return isDark
        ? material3Dark(colorScheme: scheme)
        : material3Light(colorScheme: scheme);
  }

  /// Creates a premium Material 3 theme with enhanced gradients
  static TontineCalendarStyle material3Premium({
    ColorScheme? colorScheme,
    bool isDark = false,
  }) {
    final scheme = colorScheme ?? ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4), // Material 3 default purple
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return TontineCalendarStyle(
      // Colors
      regularDayColor: scheme.surfaceContainerHighest,
      validatedDayColor: scheme.primary,
      selectedDayColor: scheme.surfaceContainerHighest,
      regularDayTextColor: scheme.onSurface,
      validatedDayTextColor: scheme.onPrimary,
      selectedDayTextColor: scheme.onSurface,
      selectedDayBorderColor: scheme.tertiary,
      headerTextColor: scheme.primary,
      navigationButtonColor: scheme.primaryContainer,
      navigationButtonTextColor: scheme.onPrimaryContainer,
      
      // Enhanced gradients
      regularDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scheme.surfaceContainerHighest,
          scheme.surfaceContainerHighest.withValues(alpha: 0.6),
          scheme.surfaceContainerHighest,
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
      validatedDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scheme.primary,
          scheme.primaryContainer,
          scheme.primary,
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
      selectedDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scheme.tertiaryContainer,
          scheme.secondaryContainer,
          scheme.tertiaryContainer,
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
      
      // Enhanced shadows
      dayBoxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
          blurRadius: isDark ? 8 : 6,
          offset: Offset(0, isDark ? 4 : 3),
          spreadRadius: isDark ? 1 : 0,
        ),
      ],
      validatedDayBoxShadow: [
        BoxShadow(
          color: scheme.primary.withValues(alpha: isDark ? 0.6 : 0.4),
          blurRadius: isDark ? 16 : 12,
          offset: const Offset(0, 8),
          spreadRadius: isDark ? 2 : 1,
        ),
        BoxShadow(
          color: scheme.primary.withValues(alpha: 0.2),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
      selectedDayBoxShadow: [
        BoxShadow(
          color: scheme.tertiary.withValues(alpha: isDark ? 0.7 : 0.5),
          blurRadius: isDark ? 20 : 16,
          offset: const Offset(0, 10),
          spreadRadius: isDark ? 3 : 2,
        ),
        BoxShadow(
          color: scheme.tertiary.withValues(alpha: 0.3),
          blurRadius: 32,
          offset: const Offset(0, 16),
        ),
      ],
      
      // Styling
      dayBorderRadius: const BorderRadius.all(Radius.circular(16.0)),
      dayTextStyle: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
        letterSpacing: 0.5,
      ),
      headerTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w800,
        color: scheme.primary,
        letterSpacing: 0.5,
      ),
      gridSpacing: 14.0,
      dayHeight: 60.0,
      calendarPadding: const EdgeInsets.all(16.0),
      dayPadding: const EdgeInsets.all(4.0),
      
      // Smooth animations
      transitionDuration: const Duration(milliseconds: 400),
      transitionCurve: Curves.easeInOutCubic,
      selectionAnimationDuration: const Duration(milliseconds: 250),
      selectionAnimationCurve: Curves.easeOutCubic,
      
      // Enhanced elevation
      enableElevation: true,
      regularDayElevation: isDark ? 2.0 : 1.0,
      validatedDayElevation: isDark ? 8.0 : 6.0,
      selectedDayElevation: isDark ? 12.0 : 10.0,
    );
  }
}

