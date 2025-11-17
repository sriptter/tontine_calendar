## 1.2.0

### Major Theme and Style Revision

* **NEW**: Material 3 themes with modern design
  - `Material3Themes.material3Light()` - Light theme with Material 3 colors
  - `Material3Themes.material3Dark()` - Dark theme with Material 3 colors
  - `Material3Themes.material3Adaptive()` - Automatically adapts to system theme
  - `Material3Themes.material3Premium()` - Premium theme with enhanced gradients
  - `Material3Themes.material3FromSeed()` - Create theme from seed color

* **NEW**: Enhanced styling capabilities
  - Gradient support for day containers (regularDayGradient, validatedDayGradient, selectedDayGradient)
  - Box shadows for depth and premium look (dayBoxShadow, validatedDayBoxShadow, selectedDayBoxShadow)
  - Elevation support with configurable elevation values
  - Configurable animation durations and curves for transitions and selections

* **NEW**: Localization support
  - Added `locale` parameter to `TontineCalendarConfig`
  - Support for multiple languages via `intl` package
  - Factory methods: `withSpanishNames()`, `withLocale()`
  - Automatic month name localization based on locale

* **NEW**: Export utilities
  - `TontineExportUtils` class for data export
  - Export to JSON format
  - Export to CSV format (simple implementation)
  - Generate summary and detailed text reports

* **IMPROVED**: Animation system
  - Configurable transition durations and curves
  - Smooth page transitions between months
  - Animated day selection with customizable curves
  - Better visual feedback

* **IMPROVED**: Responsive design
  - Better support for different screen sizes
  - Enhanced visual hierarchy with gradients and shadows
  - Premium look and feel

### Dependencies

* Added `intl: ^0.19.0` for localization support
* Optional dependencies documented for extended features:
  - `shared_preferences` for state persistence
  - `pdf` for PDF export
  - `csv` for advanced CSV export
  - `flutter_local_notifications` for payment reminders
  - `fl_chart` for statistics charts

### Breaking Changes

None - All changes are backward compatible. Existing code will continue to work.

### Migration Guide

To use the new Material 3 themes:

```dart
// Before
TontineCalendar(
  config: config,
  style: TontineCalendarStyle.lightTheme(),
)

// After (optional - old themes still work)
TontineCalendar(
  config: config,
  style: Material3Themes.material3Light(),
)
```

To use localization:

```dart
// New way with locale
final config = TontineCalendarConfig.withLocale(
  locale: 'fr',
  monthCount: 6,
);

// Or with specific language
final config = TontineCalendarConfig.withSpanishNames(
  monthCount: 6,
);
```

## 1.1.0

### Enhanced Controller and Callback Support

* **NEW**: Added `TontineCalendarController` for programmatic access
  - Navigate to specific months programmatically
  - Get current calendar state (month, mode, selected days)
  - Set mode programmatically (simple/multiple)
  - Clear current selection

* **NEW**: Added `onInitializationComplete` callback
  - Notifies when calendar initialization is complete
  - Useful for state synchronization in parent widgets

* **NEW**: Added `onModeChanged` callback
  - Triggered when user switches between simple/multiple modes
  - Provides current mode state to parent widgets

* **IMPROVED**: Better state synchronization and callback support
* **IMPROVED**: Enhanced controller pattern for external state management

## 1.0.0

### Initial Release

* **Core Features**
  - Configurable tontine calendar with 2-12 months and 28-31 days per month
  - Support for validated and unvalidated days tracking
  - Data emission with comprehensive selection information
  - Dual selection modes: Simple (sequential) and Multiple (range)

* **Styling & Theming**
  - Multiple built-in themes (Default, Light, Dark, Material, etc.)
  - Full customization support for colors, borders, spacing
  - High contrast themes for accessibility
  - Adaptive theming based on system preferences

* **Navigation & Interaction**
  - Month-to-month navigation with completion validation
  - Tap handling for both validated and unvalidated days
  - Mode selection tabs (Simple/Multiple)
  - Configurable navigation controls

* **Data Models**
  - `TontineDay`: Represents individual days with validation status
  - `TontineMonth`: Represents months with day collections
  - `TontineCalendarData`: Comprehensive selection data
  - `TontineCalendarConfig`: Configuration options
  - `TontineCalendarStyle`: Styling customization

* **Utilities**
  - `TontineCalendarUtils`: Helper functions for calculations
  - `TontineCalendarTheme`: Pre-built theme configurations
  - Validation and data processing utilities

* **Examples & Documentation**
  - Comprehensive example application with 4 demo pages
  - Detailed API documentation
  - Usage examples for all major features
  - Configuration guides and best practices

### Features in Detail

#### Tontine-Specific Logic
- Calculates all unvalidated days from previous months up to selected day
- Groups unvalidated days by month for easy processing
- Supports custom amounts per day with fallback to default
- Tracks validation dates and metadata

#### Selection Behavior
- **Simple Mode**: Only allows selection of the next sequential day
- **Multiple Mode**: Allows range selection from next day to any future day
- Emits comprehensive data including all preceding unvalidated days
- Visual feedback for selected days and next available day

#### Customization Options
- Configurable month names (supports multiple languages)
- Adjustable grid spacing and day container dimensions
- Custom icons for validated days
- Flexible color schemes and typography
- Optional features (navigation, completion status, amounts)

#### Accessibility
- High contrast themes for better visibility
- Semantic labels for screen readers
- Keyboard navigation support
- Proper focus management

### Breaking Changes
None (initial release)

### Migration Guide
None (initial release)

### Known Issues
None

### Dependencies
- Flutter SDK: >=3.0.0
- Dart SDK: >=3.1.0 <4.0.0

### Supported Platforms
- Android
- iOS
- Web
- Windows
- macOS
- Linux
