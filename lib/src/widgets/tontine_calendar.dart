import 'package:flutter/material.dart';
import '../models/tontine_calendar_config.dart';
import '../models/tontine_calendar_data.dart';
import '../models/tontine_calendar_style.dart';
import '../models/tontine_day.dart';
import '../models/tontine_month.dart';

/// A customizable Flutter calendar widget designed for tontine applications
/// with paginated months, configurable days, and contribution tracking.
class TontineCalendar extends StatefulWidget {
  /// Configuration for the calendar
  final TontineCalendarConfig config;

  /// Style configuration for the calendar
  final TontineCalendarStyle style;

  /// Callback when a day is selected
  final void Function(TontineCalendarData data)? onDaySelected;

  /// Callback when a validated day is tapped (for showing details)
  final void Function(TontineDay day)? onValidatedDayTapped;

  /// Callback when the calendar page changes
  final void Function(int pageIndex)? onPageChanged;

  /// Callback when the calendar initialization is complete
  final void Function()? onInitializationComplete;

  /// Callback when the mode changes (simple/multiple)
  final void Function(bool isSimpleMode)? onModeChanged;

  /// Whether to enable simple mode (only next day can be selected)
  final bool simpleMode;

  /// Whether to show mode selection tabs
  final bool showModeSelection;

  /// Optional controller for programmatic access
  final TontineCalendarController? controller;

  const TontineCalendar({
    super.key,
    required this.config,
    this.style = const TontineCalendarStyle(),
    this.onDaySelected,
    this.onValidatedDayTapped,
    this.onPageChanged,
    this.onInitializationComplete,
    this.onModeChanged,
    this.simpleMode = false,
    this.showModeSelection = true,
    this.controller,
  });

  @override
  State<TontineCalendar> createState() => _TontineCalendarState();
}

/// Controller class to provide programmatic access to TontineCalendar
class TontineCalendarController {
  _TontineCalendarState? _state;

  void _attach(_TontineCalendarState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  /// Navigate to a specific month (1-based index)
  void navigateToMonth(int month) {
    _state?._navigateToMonth(month);
  }

  /// Navigate to the next month
  void navigateToNextMonth() {
    _state?._navigateToNextMonth();
  }

  /// Navigate to the previous month
  void navigateToPreviousMonth() {
    _state?._navigateToPreviousMonth();
  }

  /// Get the current month index (0-based)
  int? get currentMonthIndex => _state?._currentMonthIndex;

  /// Get the current mode (true for simple, false for multiple)
  bool? get isSimpleMode => _state?._isSimpleMode;

  /// Set the mode programmatically
  void setMode(bool isSimpleMode) {
    _state?._setMode(isSimpleMode);
  }

  /// Get the next day to select in simple mode
  int? get nextDayToSelect => _state?._nextDayToSelect;

  /// Get the currently selected days
  List<int>? get selectedDays => _state?._selectedDays;

  /// Clear the current selection
  void clearSelection() {
    _state?._clearSelection();
  }
}

class _TontineCalendarState extends State<TontineCalendar> {
  late PageController _pageController;
  late List<TontineMonth> _months;
  int _currentMonthIndex = 0;
  bool _isSimpleMode = false;
  List<int> _selectedDays = [];
  int? _nextDayToSelect;

  @override
  void initState() {
    super.initState();
    _isSimpleMode = widget.simpleMode;
    _initializeCalendar();

    // Attach controller if provided
    widget.controller?._attach(this);

    // Notify initialization complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onInitializationComplete?.call();
    });
  }

  @override
  void dispose() {
    // Detach controller
    widget.controller?._detach();
    _pageController.dispose();
    super.dispose();
  }

  void _initializeCalendar() {
    // Initialize months
    _months = List.generate(widget.config.monthCount, (index) {
      final monthNumber = index + 1;
      return TontineMonth.create(
        month: monthNumber,
        totalDays: widget.config.daysPerMonth,
        monthNames: widget.config.effectiveMonthNames,
        validatedDays: widget.config.getValidatedDaysForMonth(monthNumber),
      );
    });

    // Find the current month based on the latest validated day
    _currentMonthIndex = _findCurrentMonth();

    // Calculate next day to select
    _nextDayToSelect = _calculateNextDayToSelect();

    // Initialize page controller
    _pageController = PageController(
      initialPage: _currentMonthIndex,
      keepPage: true,
    );
  }

  int _findCurrentMonth() {
    if (widget.config.validatedDays == null ||
        widget.config.validatedDays!.isEmpty) {
      return widget.config.initialMonth - 1;
    }

    // Find the month with the latest validated day
    final validatedDays = widget.config.validatedDays!;
    validatedDays.sort((a, b) {
      final monthComparison = a.month.compareTo(b.month);
      if (monthComparison != 0) return monthComparison;
      return a.day.compareTo(b.day);
    });

    final latestDay = validatedDays.last;
    final monthIndex = latestDay.month - 1;
    final month = _months[monthIndex];

    // If the month is not completed, stay on it
    // If completed, move to next month
    if (month.validatedCount < widget.config.daysPerMonth) {
      return monthIndex;
    } else if (monthIndex < widget.config.monthCount - 1) {
      return monthIndex + 1;
    } else {
      return monthIndex; // Last month
    }
  }

  int? _calculateNextDayToSelect() {
    if (widget.config.validatedDays == null ||
        widget.config.validatedDays!.isEmpty) {
      return 1;
    }

    final currentMonth = _months[_currentMonthIndex];
    final validatedDaysInMonth = currentMonth.validatedDays;

    if (validatedDaysInMonth.isEmpty) {
      return 1;
    }

    validatedDaysInMonth.sort((a, b) => a.day.compareTo(b.day));
    final lastValidatedDay = validatedDaysInMonth.last.day;

    if (lastValidatedDay < widget.config.daysPerMonth) {
      return lastValidatedDay + 1;
    }

    return null; // Month is completed
  }

  void _onDayTapped(int dayNumber) {
    final currentMonth = _months[_currentMonthIndex];
    final tappedDay = currentMonth.getDay(dayNumber);

    if (tappedDay == null) return;

    // If day is already validated, call the validated day callback
    if (tappedDay.isValidated) {
      widget.onValidatedDayTapped?.call(tappedDay);
      return;
    }

    // Check if selection is allowed
    if (!_canSelectDay(dayNumber)) {
      return;
    }

    // Handle day selection based on mode
    if (_isSimpleMode) {
      _selectedDays = [dayNumber];
    } else {
      _handleMultipleModeSelection(dayNumber);
    }

    setState(() {});

    // Create and emit calendar data
    final selectedDay = TontineDay(
      day: dayNumber,
      month: currentMonth.month,
      amount: widget.config.defaultDayAmount,
    );

    final calendarData = TontineCalendarData.fromSelection(
      selectedDay: selectedDay,
      allMonths: _months,
      defaultDayAmount: widget.config.defaultDayAmount,
    );

    widget.onDaySelected?.call(calendarData);
  }

  bool _canSelectDay(int dayNumber) {
    if (_isSimpleMode) {
      return dayNumber == _nextDayToSelect;
    }
    return true; // Multiple mode allows any unvalidated day
  }

  void _handleMultipleModeSelection(int dayNumber) {
    if (_nextDayToSelect == null) {
      _selectedDays = [dayNumber];
      return;
    }

    final startDay = _nextDayToSelect!;
    final endDay = dayNumber;

    if (startDay == endDay) {
      _selectedDays = [startDay];
    } else {
      final minDay = startDay < endDay ? startDay : endDay;
      final maxDay = startDay > endDay ? startDay : endDay;
      _selectedDays = List.generate(
        maxDay - minDay + 1,
        (index) => minDay + index,
      );
    }
  }

  void _onPageChanged(int pageIndex) {
    setState(() {
      _currentMonthIndex = pageIndex;
      _nextDayToSelect = _calculateNextDayToSelect();
      _selectedDays.clear();
    });

    // Notifier le parent du changement de page
    widget.onPageChanged?.call(pageIndex);
  }

  void _navigateToPreviousMonth() {
    if (_currentMonthIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToNextMonth() {
    if (widget.config.restrictiveNavigation) {
      final currentMonth = _months[_currentMonthIndex];
      // Only allow navigation to next month if current month is completed
      if (currentMonth.isCompleted &&
          _currentMonthIndex < widget.config.monthCount - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    } else {
      // Allow navigation to next month if it exists
      if (_currentMonthIndex < widget.config.monthCount - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  /// Navigate to a specific month (1-based index)
  void _navigateToMonth(int month) {
    final monthIndex = month - 1; // Convert to 0-based index
    if (monthIndex >= 0 && monthIndex < widget.config.monthCount) {
      _pageController.animateToPage(
        monthIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Set the mode programmatically
  void _setMode(bool isSimpleMode) {
    if (_isSimpleMode != isSimpleMode) {
      setState(() {
        _isSimpleMode = isSimpleMode;
        _selectedDays.clear();
        _nextDayToSelect = _calculateNextDayToSelect();
      });
      widget.onModeChanged?.call(isSimpleMode);
    }
  }

  /// Clear the current selection
  void _clearSelection() {
    setState(() {
      _selectedDays.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.style.calendarPadding,
      child: Column(
        children: [
          if (widget.showModeSelection) _buildModeSelectionTabs(),
          _buildCalendarHeader(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: widget.config.monthCount,
              itemBuilder: (context, index) => _buildMonthView(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeSelectionTabs() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildModeTab(
            isSelected: _isSimpleMode,
            label: 'SIMPLE',
            icon: Icons.loyalty,
            onTap: () => _setMode(true),
          ),
          _buildModeTab(
            isSelected: !_isSimpleMode,
            label: 'MULTIPLE',
            icon: Icons.spoke,
            onTap: () => _setMode(false),
          ),
        ],
      ),
    );
  }

  Widget _buildModeTab({
    required bool isSelected,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 45,
        decoration: BoxDecoration(
          color: isSelected
              ? widget.style.validatedDayColor.withValues(alpha: 0.9)
              : widget.style.regularDayColor.withValues(alpha: 0.9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    final currentMonth = _months[_currentMonthIndex];
    final previousMonthIndex =
        _currentMonthIndex > 0 ? _currentMonthIndex - 1 : null;
    final nextMonthIndex = _currentMonthIndex < widget.config.monthCount - 1
        ? _currentMonthIndex + 1
        : null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous month button
          if (widget.config.enableNavigation && previousMonthIndex != null)
            _buildNavigationButton(
              onPressed: _navigateToPreviousMonth,
              icon: Icons.chevron_left,
              label: _months[previousMonthIndex].name,
              isNext: false,
            )
          else
            const SizedBox(width: 100),

          // Current month info
          Column(
            children: [
              Text(
                currentMonth.name,
                style: widget.style.headerTextStyle.copyWith(
                  color: widget.style.headerTextColor,
                ),
              ),
              if (widget.config.showTotalAmount)
                Text(
                  '${currentMonth.totalAmount.toStringAsFixed(0)} ${widget.config.defaultDayAmount != null ? 'FCFA' : ''}',
                  style: widget.style.headerTextStyle.copyWith(
                    color: widget.style.headerTextColor,
                  ),
                ),
              if (widget.config.showCompletionStatus)
                Text(
                  '${currentMonth.validatedCount}/${currentMonth.totalDays}',
                  style: widget.style.headerTextStyle.copyWith(
                    color: widget.style.headerTextColor,
                    fontSize: 14,
                  ),
                ),
            ],
          ),

          // Next month button
          if (widget.config.enableNavigation && nextMonthIndex != null)
            _buildNavigationButton(
              onPressed: _navigateToNextMonth,
              icon: Icons.chevron_right,
              label: _months[nextMonthIndex].name,
              isNext: true,
            )
          else
            const SizedBox(width: 100),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required bool isNext,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor:
            widget.style.navigationButtonColor.withValues(alpha: 0.9),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isNext)
            Icon(icon, color: widget.style.navigationButtonTextColor),
          Text(
            label,
            style: TextStyle(color: widget.style.navigationButtonTextColor),
          ),
          if (isNext) Icon(icon, color: widget.style.navigationButtonTextColor),
        ],
      ),
    );
  }

  Widget _buildMonthView(int monthIndex) {
    final month = _months[monthIndex];

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: month.totalDays,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: widget.style.dayHeight,
        mainAxisSpacing: widget.style.gridSpacing,
        crossAxisSpacing: widget.style.gridSpacing,
        crossAxisCount: 5,
      ),
      itemBuilder: (context, index) {
        final dayNumber = index + 1;
        final day = month.getDay(dayNumber);
        return _buildDayContainer(day!, monthIndex == _currentMonthIndex);
      },
    );
  }

  Widget _buildDayContainer(TontineDay day, bool isCurrentMonth) {
    final isValidated = day.isValidated;
    final isSelected = isCurrentMonth && _selectedDays.contains(day.day);
    final isNextDay = isCurrentMonth && day.day == _nextDayToSelect;

    Color backgroundColor;
    Color textColor;
    Widget content;

    if (isValidated) {
      backgroundColor = widget.style.validatedDayColor.withValues(alpha: 0.9);
      textColor = widget.style.validatedDayTextColor;
      content = Icon(
        widget.style.effectiveValidatedDayIcon,
        color: textColor,
        size: widget.style.validatedDayIconSize,
      );
    } else {
      backgroundColor = widget.style.regularDayColor.withValues(alpha: 0.9);
      textColor = widget.style.regularDayTextColor;
      content = widget.config.showDayNumbers
          ? Text(
              day.day.toString(),
              style: widget.style.dayTextStyle.copyWith(color: textColor),
            )
          : const SizedBox.shrink();
    }

    BoxDecoration decoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: widget.style.dayBorderRadius,
    );

    if (widget.config.highlightSelectedDays && (isSelected || isNextDay)) {
      decoration = decoration.copyWith(
        border: Border.all(
          color: widget.style.selectedDayBorderColor,
          width: widget.style.selectedDayBorderWidth,
        ),
      );
    }

    return InkWell(
      onTap: () => _onDayTapped(day.day),
      borderRadius: widget.style.dayBorderRadius,
      child: Container(
        decoration: decoration,
        padding: widget.style.dayPadding,
        child: Center(child: content),
      ),
    );
  }
}
