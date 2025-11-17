# Tontine Calendar

A customizable Flutter calendar widget designed specifically for tontine applications with paginated months, configurable days, and contribution tracking.

## Features

- **Configurable Structure**: Support for 2-12 months with 28-31 days each
- **Tontine-Specific Logic**: Tracks validated/unvalidated days and calculates contributions
- **Data Emission**: Emits comprehensive data when days are selected, including all preceding unvalidated days grouped by month
- **Dual Selection Modes**: Simple mode (sequential selection) and Multiple mode (range selection)
- **Customizable Styling**: Multiple built-in themes and full customization support
- **Material 3 Themes**: Modern Material 3 themes with gradients, shadows, and elevation
- **Localization**: Support for multiple languages (English, French, Spanish) via Intl package
- **Animations**: Configurable smooth transitions and selection animations
- **Data Export**: Export calendar data to JSON, CSV, and text reports
- **Navigation**: Month-to-month navigation with completion validation
- **Accessibility**: High contrast themes and proper semantic labels

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tontine_calendar: ^1.2.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:tontine_calendar/tontine_calendar.dart';

class MyTontineCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 1000.0,
    );

    return TontineCalendar(
      config: config,
      onDaySelected: (data) {
        print('Selected ${data.totalUnvalidatedDays} days');
        print('Total amount: ${data.totalAmount}');
      },
    );
  }
}
```

## Configuration

### Basic Configuration

```dart
final config = TontineCalendarConfig(
  monthCount: 12,           // 2-12 months
  daysPerMonth: 31,         // 28-31 days per month
  defaultDayAmount: 500.0,  // Default amount per day
  initialMonth: 1,          // Starting month (1-based)
);
```

### With Validated Days

```dart
final validatedDays = [
  TontineDay(day: 1, month: 1, isValidated: true, amount: 1000),
  TontineDay(day: 2, month: 1, isValidated: true, amount: 1000),
  // ... more validated days
];

final config = TontineCalendarConfig(
  monthCount: 6,
  daysPerMonth: 31,
  validatedDays: validatedDays,
  defaultDayAmount: 1000.0,
);
```

### Localization

#### French Month Names

```dart
final config = TontineCalendarConfig.withFrenchNames(
  monthCount: 12,
  daysPerMonth: 31,
);
```

#### Spanish Month Names

```dart
final config = TontineCalendarConfig.withSpanishNames(
  monthCount: 6,
  daysPerMonth: 31,
);
```

#### Custom Locale (using Intl package)

```dart
final config = TontineCalendarConfig.withLocale(
  locale: 'fr',  // or 'es', 'en', etc.
  monthCount: 12,
  daysPerMonth: 31,
);
```

## Styling and Themes

### Material 3 Themes (NEW in v1.2.0)

The package now includes modern Material 3 themes with gradients, shadows, and elevation:

```dart
// Material 3 Light Theme
TontineCalendar(
  config: config,
  style: Material3Themes.material3Light(),
);

// Material 3 Dark Theme
TontineCalendar(
  config: config,
  style: Material3Themes.material3Dark(),
);

// Adaptive Material 3 Theme (automatically adapts to system theme)
TontineCalendar(
  config: config,
  style: Material3Themes.material3Adaptive(context),
);

// Premium Material 3 Theme with enhanced gradients
TontineCalendar(
  config: config,
  style: Material3Themes.material3Premium(),
);

// Material 3 Theme from seed color
TontineCalendar(
  config: config,
  style: Material3Themes.material3FromSeed(
    Colors.purple,
    isDark: false,
  ),
);
```

### Built-in Themes

```dart
// Default theme
TontineCalendar(
  config: config,
  style: TontineCalendarStyle.defaultStyle(),
);

// Light theme
TontineCalendar(
  config: config,
  style: TontineCalendarStyle.lightTheme(),
);

// Dark theme
TontineCalendar(
  config: config,
  style: TontineCalendarStyle.darkTheme(),
);

// Material Design theme
TontineCalendar(
  config: config,
  style: TontineCalendarTheme.materialTheme(
    colorScheme: Theme.of(context).colorScheme,
  ),
);
```

### Custom Styling

#### Basic Custom Styling

```dart
final customStyle = TontineCalendarStyle(
  regularDayColor: Colors.blue[100]!,
  validatedDayColor: Colors.green,
  selectedDayBorderColor: Colors.orange,
  headerTextColor: Colors.blue[800]!,
  dayBorderRadius: BorderRadius.circular(12.0),
);

TontineCalendar(
  config: config,
  style: customStyle,
);
```

#### Advanced Styling with Gradients and Shadows (NEW in v1.2.0)

```dart
final premiumStyle = TontineCalendarStyle(
  // Use gradients instead of solid colors
  regularDayGradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.blue[100]!, Colors.blue[50]!],
  ),
  validatedDayGradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.green[400]!, Colors.green[600]!],
  ),
  
  // Add shadows for depth
  dayBoxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ],
  validatedDayBoxShadow: [
    BoxShadow(
      color: Colors.green.withValues(alpha: 0.3),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ],
  
  // Enable elevation
  enableElevation: true,
  validatedDayElevation: 4.0,
  selectedDayElevation: 6.0,
  
  // Customize animations
  transitionDuration: Duration(milliseconds: 400),
  transitionCurve: Curves.easeInOutCubic,
  selectionAnimationDuration: Duration(milliseconds: 250),
  selectionAnimationCurve: Curves.easeOutCubic,
);

TontineCalendar(
  config: config,
  style: premiumStyle,
);
```

## Data Emission

When a day is selected, the calendar emits a `TontineCalendarData` object containing:

```dart
onDaySelected: (TontineCalendarData data) {
  // Selected day information
  print('Selected day: ${data.selectedDay.day}');
  print('Selected month: ${data.selectedMonth.name}');

  // All unvalidated days from previous months + current selection
  print('Total unvalidated days: ${data.totalUnvalidatedDays}');
  print('Total amount: ${data.totalAmount}');

  // Grouped by month
  data.unvalidatedDaysByMonth.forEach((month, days) {
    print('Month $month: ${days.length} days');
  });
}
```

## Selection Modes

### Simple Mode
Only the next sequential day can be selected:

```dart
TontineCalendar(
  config: config,
  simpleMode: true,
  showModeSelection: false,
);
```

### Multiple Mode
Allows range selection from next day to any future day:

```dart
TontineCalendar(
  config: config,
  simpleMode: false,
  showModeSelection: true, // Shows mode toggle tabs
);
```

## Advanced Usage

### Handling Validated Day Taps

```dart
TontineCalendar(
  config: config,
  onValidatedDayTapped: (TontineDay day) {
    // Show day details dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Day ${day.day} Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Amount: ${day.amount}'),
            Text('Date: ${day.validatedDate}'),
          ],
        ),
      ),
    );
  },
);
```

### Custom Month Names

```dart
final config = TontineCalendarConfig(
  monthCount: 4,
  daysPerMonth: 30,
  monthNames: ['Spring', 'Summer', 'Autumn', 'Winter'],
);
```

### Disable Features

```dart
final config = TontineCalendarConfig(
  monthCount: 6,
  daysPerMonth: 31,
  enableNavigation: false,      // Disable month navigation
  showCompletionStatus: false,  // Hide completion indicators
  showTotalAmount: false,       // Hide amount display
  showDayNumbers: false,        // Hide day numbers
);
```

## Data Export (NEW in v1.2.0)

Export calendar data in various formats:

```dart
import 'package:tontine_calendar/tontine_calendar.dart';

TontineCalendar(
  config: config,
  onDaySelected: (TontineCalendarData data) {
    // Export to JSON
    final json = TontineExportUtils.exportToJson(data);
    print(json);
    
    // Export to CSV
    final csv = TontineExportUtils.exportToCsv(data);
    print(csv);
    
    // Generate summary report
    final summary = TontineExportUtils.generateSummaryReport(data);
    print(summary);
    
    // Generate detailed report
    final detailed = TontineExportUtils.generateDetailedReport(data);
    print(detailed);
    
    // Export validated days only
    final validatedDays = config.validatedDays ?? [];
    final validatedJson = TontineExportUtils.exportValidatedDaysToJson(validatedDays);
    final validatedCsv = TontineExportUtils.exportValidatedDaysToCsv(validatedDays);
  },
);
```

## API Reference

### TontineCalendarConfig

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `monthCount` | `int` | `12` | Number of months (2-12) |
| `daysPerMonth` | `int` | `31` | Days per month (28-31) |
| `monthNames` | `List<String>?` | `null` | Custom month names |
| `locale` | `String?` | `null` | Locale for month names (e.g., 'en', 'fr', 'es') |
| `defaultDayAmount` | `double?` | `null` | Default amount per day |
| `validatedDays` | `List<TontineDay>?` | `null` | Pre-validated days |
| `enableNavigation` | `bool` | `true` | Enable month navigation |
| `showCompletionStatus` | `bool` | `true` | Show completion status |
| `showTotalAmount` | `bool` | `true` | Show total amounts |
| `initialMonth` | `int` | `1` | Initial month to display |

### TontineCalendarStyle

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `regularDayColor` | `Color` | `Color(0xff273071)` | Regular day background |
| `validatedDayColor` | `Color` | `Color(0xff0d7abc)` | Validated day background |
| `selectedDayBorderColor` | `Color` | `Color(0xff3bcc97)` | Selected day border |
| `dayBorderRadius` | `BorderRadius` | `BorderRadius.circular(8.0)` | Day container radius |
| `gridSpacing` | `double` | `10.0` | Spacing between days |
| `dayHeight` | `double` | `50.0` | Height of day containers |
| `regularDayGradient` | `Gradient?` | `null` | Gradient for regular days (NEW) |
| `validatedDayGradient` | `Gradient?` | `null` | Gradient for validated days (NEW) |
| `selectedDayGradient` | `Gradient?` | `null` | Gradient for selected days (NEW) |
| `dayBoxShadow` | `List<BoxShadow>?` | `null` | Shadows for day containers (NEW) |
| `validatedDayBoxShadow` | `List<BoxShadow>?` | `null` | Shadows for validated days (NEW) |
| `enableElevation` | `bool` | `false` | Enable Material elevation (NEW) |
| `transitionDuration` | `Duration` | `300ms` | Page transition duration (NEW) |
| `selectionAnimationDuration` | `Duration` | `200ms` | Selection animation duration (NEW) |

### TontineDay

| Property | Type | Description |
|----------|------|-------------|
| `day` | `int` | Day number (1-31) |
| `month` | `int` | Month number (1-12) |
| `isValidated` | `bool` | Whether day is validated |
| `amount` | `double?` | Amount for this day |
| `validatedDate` | `DateTime?` | When day was validated |
| `metadata` | `Map<String, dynamic>?` | Additional data |

### TontineCalendarData

| Property | Type | Description |
|----------|------|-------------|
| `selectedDay` | `TontineDay` | The selected day |
| `selectedMonth` | `TontineMonth` | The selected month |
| `unvalidatedDaysByMonth` | `Map<int, List<TontineDay>>` | Unvalidated days by month |
| `totalUnvalidatedDays` | `int` | Total unvalidated days |
| `totalAmount` | `double` | Total amount for unvalidated days |

## Examples

Check out the `/example` folder for comprehensive examples including:

- Basic usage
- Configuration options
- Theme customization (including Material 3 themes)
- Localization examples
- Data export examples
- Interactive examples

To run the example:

```bash
cd example
flutter run
```

### Complete Example with Material 3 Theme and Localization

```dart
import 'package:flutter/material.dart';
import 'package:tontine_calendar/tontine_calendar.dart';

class MyTontineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Configuration with French localization
    final config = TontineCalendarConfig.withLocale(
      locale: 'fr',
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 2000.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Tontine Calendar'),
      ),
      body: TontineCalendar(
        config: config,
        // Use Material 3 premium theme
        style: Material3Themes.material3Premium(),
        onDaySelected: (data) {
          // Export data
          final json = TontineExportUtils.exportToJson(data);
          final summary = TontineExportUtils.generateSummaryReport(data);
          
          print('Selected: ${data.totalUnvalidatedDays} days');
          print('Total: ${data.totalAmount} FCFA');
          print(summary);
        },
        onValidatedDayTapped: (day) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Jour ${day.day}'),
              content: Text('Montant: ${day.amount} FCFA'),
            ),
          );
        },
      ),
    );
  }
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
