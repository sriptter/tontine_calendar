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
