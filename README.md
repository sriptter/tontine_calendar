# Tontine Calendar

A customizable Flutter calendar widget designed specifically for tontine applications with paginated months, configurable days, and contribution tracking.

## Features

- **Configurable Structure**: Support for 2-12 months with 28-31 days each
- **Tontine-Specific Logic**: Tracks validated/unvalidated days and calculates contributions
- **Data Emission**: Emits comprehensive data when days are selected, including all preceding unvalidated days grouped by month
- **Dual Selection Modes**: Simple mode (sequential selection) and Multiple mode (range selection)
- **Customizable Styling**: Multiple built-in themes and full customization support
- **Navigation**: Month-to-month navigation with completion validation
- **Accessibility**: High contrast themes and proper semantic labels

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tontine_calendar: ^1.0.0
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

### French Month Names

```dart
final config = TontineCalendarConfig.withFrenchNames(
  monthCount: 12,
  daysPerMonth: 31,
);
```

## Styling and Themes

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

## API Reference

### TontineCalendarConfig

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `monthCount` | `int` | `12` | Number of months (2-12) |
| `daysPerMonth` | `int` | `31` | Days per month (28-31) |
| `monthNames` | `List<String>?` | `null` | Custom month names |
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
- Theme customization
- Interactive examples

To run the example:

```bash
cd example
flutter run
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
