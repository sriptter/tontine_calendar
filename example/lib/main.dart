import 'package:flutter/material.dart';
import 'package:tontine_calendar/tontine_calendar.dart';

void main() {
  runApp(const TontineCalendarExampleApp());
}

class TontineCalendarExampleApp extends StatelessWidget {
  const TontineCalendarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tontine Calendar Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0d7abc)),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BasicExamplePage(),
    const ConfigurationExamplePage(),
    const ThemeExamplePage(),
    const InteractiveExamplePage(),
    const CotisationTestPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tontine Calendar Examples'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Basic',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
          BottomNavigationBarItem(icon: Icon(Icons.palette), label: 'Themes'),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Interactive',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Cotisation',
          ),
        ],
      ),
    );
  }
}

class BasicExamplePage extends StatelessWidget {
  const BasicExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create some sample validated days
    final validatedDays = [
      const TontineDay(day: 1, month: 1, isValidated: true, amount: 1000),
      const TontineDay(day: 2, month: 1, isValidated: true, amount: 1000),
      const TontineDay(day: 3, month: 1, isValidated: true, amount: 1000),
      const TontineDay(day: 1, month: 2, isValidated: true, amount: 1000),
      const TontineDay(day: 2, month: 2, isValidated: true, amount: 1000),
    ];

    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 1000.0,
      validatedDays: validatedDays,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Tontine Calendar',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'A 6-month calendar with 31 days each. Some days are already validated.',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TontineCalendar(
              config: config,
              onDaySelected: (data) {
                _showSelectionDialog(context, data);
              },
              onValidatedDayTapped: (day) {
                _showDayDetailsDialog(context, day);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectionDialog(BuildContext context, TontineCalendarData data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Day Selected'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected: Day ${data.selectedDay.day}, ${data.selectedMonth.name}',
            ),
            Text('Total unvalidated days: ${data.totalUnvalidatedDays}'),
            Text('Total amount: ${data.totalAmount.toStringAsFixed(0)} FCFA'),
            const SizedBox(height: 8),
            const Text('Unvalidated days by month:'),
            ...data.unvalidatedDaysByMonth.entries.map(
              (entry) => Text('Month ${entry.key}: ${entry.value.length} days'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showDayDetailsDialog(BuildContext context, TontineDay day) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Day Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Day: ${day.day}'),
            Text('Month: ${day.month}'),
            Text('Validated: ${day.isValidated ? 'Yes' : 'No'}'),
            if (day.amount != null)
              Text('Amount: ${day.amount!.toStringAsFixed(0)} FCFA'),
            if (day.validatedDate != null) Text('Date: ${day.validatedDate}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class ConfigurationExamplePage extends StatefulWidget {
  const ConfigurationExamplePage({super.key});

  @override
  State<ConfigurationExamplePage> createState() =>
      _ConfigurationExamplePageState();
}

class _ConfigurationExamplePageState extends State<ConfigurationExamplePage> {
  int _monthCount = 12;
  int _daysPerMonth = 31;
  bool _showModeSelection = true;
  bool _enableNavigation = true;
  bool _showCompletionStatus = true;
  bool _showTotalAmount = true;
  bool _restrictiveNavigation = true;
  bool _highlightSelectedDays = true;
  List<String> _monthNames = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
  ];
  String _selectedLanguage = 'Français';

  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: _monthCount,
      daysPerMonth: _daysPerMonth,
      monthNames: _monthNames.take(_monthCount).toList(),
      enableNavigation: _enableNavigation,
      showCompletionStatus: _showCompletionStatus,
      showTotalAmount: _showTotalAmount,
      restrictiveNavigation: _restrictiveNavigation,
      highlightSelectedDays: _highlightSelectedDays,
      defaultDayAmount: 500.0,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configuration Options',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TontineCalendar(
                key: ValueKey(
                    '${_monthCount}_${_daysPerMonth}_${_selectedLanguage}'), // Clé unique pour forcer la reconstruction
                config: config,
                showModeSelection: _showModeSelection,
                onDaySelected: (data) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Selected ${data.totalUnvalidatedDays} days'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showConfigurationBottomSheet,
        child: const Icon(Icons.settings),
        tooltip: 'Configuration',
      ),
    );
  }

  void _showConfigurationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Configuration du Calendrier',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildConfigurationControlsForBottomSheet(setModalState),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildConfigurationControlsForBottomSheet(StateSetter setModalState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('Months: ', style: TextStyle(fontSize: 12)),
                Expanded(
                  child: Slider(
                    value: _monthCount.toDouble(),
                    min: 2,
                    max: 12,
                    divisions: 10,
                    label: _monthCount.toString(),
                    onChanged: (value) {
                      setState(() => _monthCount = value.toInt());
                      setModalState(() => _monthCount = value.toInt());
                    },
                  ),
                ),
                Text(_monthCount.toString(),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                const Text('Days/month: ', style: TextStyle(fontSize: 12)),
                Expanded(
                  child: Slider(
                    value: _daysPerMonth.toDouble(),
                    min: 28,
                    max: 31,
                    divisions: 3,
                    label: _daysPerMonth.toString(),
                    onChanged: (value) {
                      setState(() => _daysPerMonth = value.toInt());
                      setModalState(() => _daysPerMonth = value.toInt());
                    },
                  ),
                ),
                Text(_daysPerMonth.toString(),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Mode Selection',
                        style: TextStyle(fontSize: 12)),
                    value: _showModeSelection,
                    onChanged: (value) {
                      setState(() => _showModeSelection = value);
                      setModalState(() => _showModeSelection = value);
                    },
                    dense: true,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Navigation',
                        style: TextStyle(fontSize: 12)),
                    value: _enableNavigation,
                    onChanged: (value) {
                      setState(() => _enableNavigation = value);
                      setModalState(() => _enableNavigation = value);
                    },
                    dense: true,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Completion Status',
                        style: TextStyle(fontSize: 12)),
                    value: _showCompletionStatus,
                    onChanged: (value) {
                      setState(() => _showCompletionStatus = value);
                      setModalState(() => _showCompletionStatus = value);
                    },
                    dense: true,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Total Amount',
                        style: TextStyle(fontSize: 12)),
                    value: _showTotalAmount,
                    onChanged: (value) {
                      setState(() => _showTotalAmount = value);
                      setModalState(() => _showTotalAmount = value);
                    },
                    dense: true,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Restrictive Nav',
                        style: TextStyle(fontSize: 12)),
                    value: _restrictiveNavigation,
                    onChanged: (value) {
                      setState(() => _restrictiveNavigation = value);
                      setModalState(() => _restrictiveNavigation = value);
                    },
                    dense: true,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Highlight Days',
                        style: TextStyle(fontSize: 12)),
                    value: _highlightSelectedDays,
                    onChanged: (value) {
                      setState(() => _highlightSelectedDays = value);
                      setModalState(() => _highlightSelectedDays = value);
                    },
                    dense: true,
                  ),
                ),
              ],
            ),
            const Divider(height: 8),
            Row(
              children: [
                const Text('Langue: ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedLanguage,
                    isExpanded: true,
                    isDense: true,
                    items: const [
                      DropdownMenuItem(
                          value: 'Français',
                          child:
                              Text('Français', style: TextStyle(fontSize: 12))),
                      DropdownMenuItem(
                          value: 'English',
                          child:
                              Text('English', style: TextStyle(fontSize: 12))),
                      DropdownMenuItem(
                          value: 'Español',
                          child:
                              Text('Español', style: TextStyle(fontSize: 12))),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedLanguage = value;
                          _updateMonthNames(value);
                        });
                        setModalState(() {
                          _selectedLanguage = value;
                          _updateMonthNames(value);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 1,
              runSpacing: 1,
              children: _monthNames
                  .take(_monthCount)
                  .map((month) => Chip(
                        label: Text(month, style: const TextStyle(fontSize: 9)),
                        backgroundColor: Colors.blue[100],
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _updateMonthNames(String language) {
    switch (language) {
      case 'Français':
        _monthNames = [
          'Janvier',
          'Février',
          'Mars',
          'Avril',
          'Mai',
          'Juin',
          'Juillet',
          'Août',
          'Septembre',
          'Octobre',
          'Novembre',
          'Décembre'
        ];
        break;
      case 'English':
        _monthNames = [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December'
        ];
        break;
      case 'Español':
        _monthNames = [
          'Enero',
          'Febrero',
          'Marzo',
          'Abril',
          'Mayo',
          'Junio',
          'Julio',
          'Agosto',
          'Septiembre',
          'Octubre',
          'Noviembre',
          'Diciembre'
        ];
        break;
    }
  }
}

class ThemeExamplePage extends StatefulWidget {
  const ThemeExamplePage({super.key});

  @override
  State<ThemeExamplePage> createState() => _ThemeExamplePageState();
}

class _ThemeExamplePageState extends State<ThemeExamplePage> {
  String _selectedTheme = 'Default';

  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig.sixMonths();
    final style = TontineCalendarTheme.getThemeByName(
      _selectedTheme,
      context: context,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Theme Examples',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: _selectedTheme,
            isExpanded: true,
            items: TontineCalendarTheme.availableThemes
                .map(
                  (theme) => DropdownMenuItem(value: theme, child: Text(theme)),
                )
                .toList(),
            onChanged: (value) => setState(() => _selectedTheme = value!),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TontineCalendar(
              config: config,
              style: style,
              onDaySelected: (data) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Theme: $_selectedTheme - Selected ${data.totalUnvalidatedDays} days',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InteractiveExamplePage extends StatefulWidget {
  const InteractiveExamplePage({super.key});

  @override
  State<InteractiveExamplePage> createState() => _InteractiveExamplePageState();
}

class _InteractiveExamplePageState extends State<InteractiveExamplePage> {
  List<TontineDay> _validatedDays = [];
  TontineCalendarData? _lastSelection;

  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      validatedDays: _validatedDays,
      defaultDayAmount: 1000.0,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Example',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Tap days to simulate validation. View selection details below.',
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 2,
            child: TontineCalendar(
              config: config,
              onDaySelected: (data) {
                setState(() {
                  _lastSelection = data;
                  // Simulate validating the selected days
                  for (final entry in data.unvalidatedDaysByMonth.entries) {
                    for (final day in entry.value) {
                      _validatedDays.add(
                        day.copyWith(
                          isValidated: true,
                          validatedDate: DateTime.now(),
                        ),
                      );
                    }
                  }
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(flex: 1, child: _buildSelectionDetails()),
        ],
      ),
    );
  }

  Widget _buildSelectionDetails() {
    if (_lastSelection == null) {
      return const Card(
        child: Center(child: Text('Select a day to see details')),
      );
    }

    final data = _lastSelection!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Selected: Day ${data.selectedDay.day}, ${data.selectedMonth.name}',
            ),
            Text('Total unvalidated days: ${data.totalUnvalidatedDays}'),
            Text('Total amount: ${data.totalAmount.toStringAsFixed(0)} FCFA'),
            Text('Validated days: ${_validatedDays.length}'),
            const SizedBox(height: 8),
            const Text('Breakdown by month:'),
            Expanded(
              child: ListView(
                children: data.unvalidatedDaysByMonth.entries.map((entry) {
                  return ListTile(
                    title: Text('Month ${entry.key}'),
                    subtitle: Text('${entry.value.length} days'),
                    trailing: Text('${entry.value.length * 1000} FCFA'),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CotisationTestPage extends StatefulWidget {
  const CotisationTestPage({super.key});

  @override
  State<CotisationTestPage> createState() => _CotisationTestPageState();
}

class _CotisationTestPageState extends State<CotisationTestPage> {
  List<TontineDay> _validatedDays = [];
  TontineCalendarData? _lastSelection;
  double _dailyAmount = 1000.0;
  bool _restrictiveMode = true;
  bool _highlightDays = true;

  @override
  Widget build(BuildContext context) {
    // Créer une nouvelle configuration à chaque build pour forcer la mise à jour
    final config = TontineCalendarConfig(
      monthCount: 12,
      daysPerMonth: 31,
      validatedDays: List.from(_validatedDays), // Créer une nouvelle liste
      defaultDayAmount: _dailyAmount,
      restrictiveNavigation: _restrictiveMode,
      highlightSelectedDays: _highlightDays,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Test de Cotisation 12×31',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Calendrier complet avec 12 mois de 31 jours chacun.'),
            const SizedBox(height: 16),
            Expanded(
              child: TontineCalendar(
                key: ValueKey(_validatedDays
                    .length), // Clé unique pour forcer la reconstruction
                config: config,
                onDaySelected: (data) {
                  setState(() {
                    _lastSelection = data;
                  });
                  _showPaymentConfirmationDialog(data);
                },
                onValidatedDayTapped: (day) {
                  // Afficher les détails du jour validé sans demander de validation
                  _showValidatedDayDetails(day);
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildSummary(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showControlsBottomSheet,
        child: const Icon(Icons.settings),
        tooltip: 'Contrôles et Actions',
      ),
    );
  }

  void _showControlsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Contrôles et Actions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildControlsForBottomSheet(setModalState),
                  const SizedBox(height: 16),
                  _buildQuickActionsForBottomSheet(),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildControlsForBottomSheet(StateSetter setModalState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Montant par jour: '),
                Expanded(
                  child: Slider(
                    value: _dailyAmount,
                    min: 500,
                    max: 5000,
                    divisions: 18,
                    label: '${_dailyAmount.toInt()} FCFA',
                    onChanged: (value) {
                      setState(() => _dailyAmount = value);
                      setModalState(() => _dailyAmount = value);
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Mode Restrictif'),
                    subtitle: const Text('Complétion requise'),
                    value: _restrictiveMode,
                    onChanged: (value) {
                      setState(() => _restrictiveMode = value);
                      setModalState(() => _restrictiveMode = value);
                    },
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Highlighting'),
                    subtitle: const Text('Bordures sélection'),
                    value: _highlightDays,
                    onChanged: (value) {
                      setState(() => _highlightDays = value);
                      setModalState(() => _highlightDays = value);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsForBottomSheet() {
    final totalDays = 12 * 31;
    final validatedCount = _validatedDays.length;
    final remainingDays = totalDays - validatedCount;

    if (remainingDays == 0) {
      return const SizedBox.shrink(); // Masquer si tout est validé
    }

    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions Rapides de Cotisation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _buildQuickActionButton(
                  'Mois Actuel',
                  Icons.calendar_today,
                  () => _validateCurrentMonth(),
                ),
                _buildQuickActionButton(
                  '3 Mois',
                  Icons.calendar_view_month,
                  () => _validateMultipleMonths(3),
                ),
                _buildQuickActionButton(
                  'Tout Valider',
                  Icons.event_available,
                  () => _validateAllCalendar(),
                ),
                _buildQuickActionButton(
                  'Réinitialiser',
                  Icons.refresh,
                  () {
                    setState(() => _validatedDays.clear());
                    Navigator.pop(context); // Fermer le bottom sheet
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final totalDays = 12 * 31;
    final validatedCount = _validatedDays.length;
    final remainingDays = totalDays - validatedCount;

    if (remainingDays == 0) {
      return const SizedBox.shrink(); // Masquer si tout est validé
    }

    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions Rapides de Cotisation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _buildQuickActionButton(
                  'Mois Actuel',
                  Icons.calendar_today,
                  () => _validateCurrentMonth(),
                ),
                _buildQuickActionButton(
                  '3 Mois',
                  Icons.calendar_view_month,
                  () => _validateMultipleMonths(3),
                ),
                _buildQuickActionButton(
                  '6 Mois',
                  Icons.date_range,
                  () => _validateMultipleMonths(6),
                ),
                _buildQuickActionButton(
                  'Tout (12×31)',
                  Icons.event_available,
                  () => _validateAllCalendar(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
      String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: const Size(0, 32),
      ),
    );
  }

  Widget _buildSummary() {
    final totalDays = 12 * 31;
    final validatedCount = _validatedDays.length;
    final remainingDays = totalDays - validatedCount;
    final totalPaid = validatedCount * _dailyAmount;
    final remainingAmount = remainingDays * _dailyAmount;
    final completionPercentage = validatedCount / totalDays;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Résumé de Cotisation',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Validés: $validatedCount/$totalDays',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Progression: ${(completionPercentage * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Restants: $remainingDays',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Payé: ${totalPaid.toStringAsFixed(0)} FCFA',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: completionPercentage,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  completionPercentage == 1.0 ? Colors.green : Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentConfirmationDialog(TontineCalendarData data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la Cotisation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Jour sélectionné: ${data.selectedDay.day} ${data.selectedMonth.name}'),
            Text('Jours à payer: ${data.totalUnvalidatedDays}'),
            Text('Montant total: ${data.totalAmount.toStringAsFixed(0)} FCFA'),
            const SizedBox(height: 8),
            const Text('Détail par mois:'),
            ...data.unvalidatedDaysByMonth.entries.map((entry) => Text(
                '• Mois ${entry.key}: ${entry.value.length} jours (${(entry.value.length * _dailyAmount).toStringAsFixed(0)} FCFA)')),
            const SizedBox(height: 16),
            const Text(
              'Voulez-vous effectuer cette cotisation ?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Non'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _processPayment(data);
            },
            child: const Text('Oui'),
          ),
        ],
      ),
    );
  }

  void _processPayment(TontineCalendarData data) {
    setState(() {
      // Valider les jours sélectionnés
      for (final entry in data.unvalidatedDaysByMonth.entries) {
        for (final day in entry.value) {
          _validatedDays.add(day.copyWith(
            isValidated: true,
            validatedDate: DateTime.now(),
            amount: _dailyAmount,
          ));
        }
      }
    });

    // Afficher le résultat
    _showPaymentResultDialog(data);

    // Vérifier si le mois actuel est complété et naviguer automatiquement
    _checkAndNavigateToNextMonth(data.selectedMonth.month);
  }

  void _checkAndNavigateToNextMonth(int currentMonth) {
    // Vérifier si le mois actuel est complété
    final currentMonthDays =
        _validatedDays.where((day) => day.month == currentMonth).length;
    final isMonthCompleted = currentMonthDays >= 31;

    if (isMonthCompleted && currentMonth < 12) {
      // Attendre un peu avant de naviguer pour que l'utilisateur voie le changement
      Future.delayed(const Duration(milliseconds: 1500), () {
        // Ici on pourrait déclencher la navigation vers le mois suivant
        // Pour l'instant, on affiche juste un message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Mois $currentMonth complété ! Passage au mois ${currentMonth + 1}'),
              backgroundColor: Colors.green,
            ),
          );
        }
      });
    }
  }

  void _showPaymentResultDialog(TontineCalendarData data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cotisation Effectuée ✅'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text('${data.totalUnvalidatedDays} jours validés avec succès !'),
            Text('Montant payé: ${data.totalAmount.toStringAsFixed(0)} FCFA'),
            const SizedBox(height: 8),
            Text('Total validé: ${_validatedDays.length}/372 jours'),
            LinearProgressIndicator(
              value: _validatedDays.length / 372,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showValidatedDayDetails(TontineDay day) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Jour Déjà Validé ✅'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text('Jour: ${day.day}'),
            Text('Mois: ${day.month}'),
            Text(
                'Montant: ${day.amount?.toStringAsFixed(0) ?? _dailyAmount.toStringAsFixed(0)} FCFA'),
            if (day.validatedDate != null)
              Text(
                  'Validé le: ${day.validatedDate!.day}/${day.validatedDate!.month}/${day.validatedDate!.year}'),
            const SizedBox(height: 8),
            const Text(
              'Ce jour a déjà été payé.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Méthodes pour les actions rapides
  void _validateCurrentMonth() {
    final currentMonth = _getCurrentMonth();
    _showBulkValidationDialog(
      'Valider le Mois Actuel',
      'Voulez-vous valider tous les jours restants du mois $currentMonth ?',
      () => _performBulkValidation([currentMonth]),
    );
  }

  void _validateMultipleMonths(int monthCount) {
    final currentMonth = _getCurrentMonth();
    final monthsToValidate = <int>[];

    for (int i = currentMonth;
        i <= 12 && monthsToValidate.length < monthCount;
        i++) {
      if (_hasUnvalidatedDaysInMonth(i)) {
        monthsToValidate.add(i);
      }
    }

    if (monthsToValidate.isEmpty) {
      _showInfoDialog(
          'Aucun mois à valider', 'Tous les mois sont déjà complétés.');
      return;
    }

    final monthNames = monthsToValidate.map((m) => _getMonthName(m)).join(', ');
    _showBulkValidationDialog(
      'Valider $monthCount Mois',
      'Voulez-vous valider tous les jours restants des mois :\n$monthNames ?',
      () => _performBulkValidation(monthsToValidate),
    );
  }

  void _validateAllCalendar() {
    final monthsToValidate = <int>[];
    for (int i = 1; i <= 12; i++) {
      if (_hasUnvalidatedDaysInMonth(i)) {
        monthsToValidate.add(i);
      }
    }

    if (monthsToValidate.isEmpty) {
      _showInfoDialog(
          'Calendrier Complet', 'Tous les jours sont déjà validés !');
      return;
    }

    final totalDays = monthsToValidate.length * 31;
    final totalAmount = totalDays * _dailyAmount;

    _showBulkValidationDialog(
      'Valider Tout le Calendrier',
      'Voulez-vous valider TOUT le calendrier restant ?\n\n'
          '• Mois restants: ${monthsToValidate.length}\n'
          '• Jours à valider: $totalDays\n'
          '• Montant total: ${totalAmount.toStringAsFixed(0)} FCFA',
      () => _performBulkValidation(monthsToValidate),
    );
  }

  // Méthodes utilitaires
  int _getCurrentMonth() {
    // Trouve le premier mois avec des jours non validés
    for (int month = 1; month <= 12; month++) {
      if (_hasUnvalidatedDaysInMonth(month)) {
        return month;
      }
    }
    return 1; // Par défaut
  }

  bool _hasUnvalidatedDaysInMonth(int month) {
    final validatedInMonth =
        _validatedDays.where((day) => day.month == month).length;
    return validatedInMonth < 31;
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre'
    ];
    return monthNames[month - 1];
  }

  void _performBulkValidation(List<int> months) {
    final daysToValidate = <TontineDay>[];

    for (final month in months) {
      for (int day = 1; day <= 31; day++) {
        final isAlreadyValidated = _validatedDays.any(
          (validatedDay) =>
              validatedDay.month == month && validatedDay.day == day,
        );

        if (!isAlreadyValidated) {
          daysToValidate.add(TontineDay(
            day: day,
            month: month,
            isValidated: true,
            amount: _dailyAmount,
            validatedDate: DateTime.now(),
          ));
        }
      }
    }

    setState(() {
      _validatedDays.addAll(daysToValidate);
    });

    _showBulkValidationResult(daysToValidate.length, months);
  }

  // Méthodes de dialog
  void _showBulkValidationDialog(
      String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer le dialogue
              onConfirm();
              // Fermer le bottom sheet après confirmation
              Navigator.of(context).pop();
            },
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer le dialogue
              // Fermer le bottom sheet
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showBulkValidationResult(int daysValidated, List<int> months) {
    final monthNames = months.map((m) => _getMonthName(m)).join(', ');
    final totalAmount = daysValidated * _dailyAmount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cotisation Groupée Effectuée ✅'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text('Jours validés: $daysValidated'),
            Text('Mois concernés: $monthNames'),
            Text('Montant total: ${totalAmount.toStringAsFixed(0)} FCFA'),
            const SizedBox(height: 8),
            Text('Progression: ${_validatedDays.length}/372 jours'),
            LinearProgressIndicator(
              value: _validatedDays.length / 372,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
