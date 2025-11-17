# Exemples d'Utilisation des Thèmes Material 3

Ce document présente des exemples concrets d'utilisation des nouveaux thèmes Material 3 et des fonctionnalités avancées de style disponibles dans la version 1.2.0.

## Table des Matières

1. [Thèmes Material 3 de Base](#thèmes-material-3-de-base)
2. [Thèmes Adaptatifs](#thèmes-adaptatifs)
3. [Thèmes Personnalisés avec Gradients](#thèmes-personnalisés-avec-gradients)
4. [Thèmes avec Ombres et Élévation](#thèmes-avec-ombres-et-élévation)
5. [Thèmes avec Animations Personnalisées](#thèmes-avec-animations-personnalisées)
6. [Exemples Complets](#exemples-complets)

---

## Thèmes Material 3 de Base

### Thème Material 3 Clair

```dart
import 'package:flutter/material.dart';
import 'package:tontine_calendar/tontine_calendar.dart';

class Material3LightExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 1500.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Material 3 Light Theme'),
      ),
      body: TontineCalendar(
        config: config,
        style: Material3Themes.material3Light(),
        onDaySelected: (data) {
          print('${data.totalUnvalidatedDays} jours sélectionnés');
        },
      ),
    );
  }
}
```

### Thème Material 3 Sombre

```dart
class Material3DarkExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 1500.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Material 3 Dark Theme'),
      ),
      body: TontineCalendar(
        config: config,
        style: Material3Themes.material3Dark(),
        onDaySelected: (data) {
          print('${data.totalUnvalidatedDays} jours sélectionnés');
        },
      ),
    );
  }
}
```

### Thème Material 3 Premium

```dart
class Material3PremiumExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 2000.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Material 3 Premium Theme'),
      ),
      body: TontineCalendar(
        config: config,
        style: Material3Themes.material3Premium(),
        onDaySelected: (data) {
          print('${data.totalUnvalidatedDays} jours - ${data.totalAmount} FCFA');
        },
      ),
    );
  }
}
```

---

## Thèmes Adaptatifs

### Thème qui s'adapte au thème système

```dart
class AdaptiveThemeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 1500.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Thème Adaptatif'),
      ),
      body: TontineCalendar(
        config: config,
        // S'adapte automatiquement au thème clair/sombre du système
        style: Material3Themes.material3Adaptive(context),
        onDaySelected: (data) {
          print('${data.totalUnvalidatedDays} jours sélectionnés');
        },
      ),
    );
  }
}
```

### Thème depuis une couleur seed

```dart
class SeedColorExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 1500.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Thème depuis Couleur Seed'),
      ),
      body: Column(
        children: [
          // Sélecteur de couleur
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _buildColorButton(Colors.purple),
                _buildColorButton(Colors.blue),
                _buildColorButton(Colors.green),
                _buildColorButton(Colors.orange),
              ],
            ),
          ),
          
          // Calendrier avec thème basé sur la couleur
          Expanded(
            child: TontineCalendar(
              config: config,
              style: Material3Themes.material3FromSeed(
                Colors.purple, // Changez cette couleur
                isDark: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
    );
  }
}
```

---

## Thèmes Personnalisés avec Gradients

### Thème avec Gradients Personnalisés

```dart
class CustomGradientThemeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 2000.0,
    );

    final customStyle = TontineCalendarStyle(
      // Gradients pour les jours réguliers
      regularDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blue[100]!,
          Colors.blue[50]!,
        ],
      ),
      
      // Gradients pour les jours validés
      validatedDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.green[400]!,
          Colors.green[600]!,
        ],
      ),
      
      // Gradients pour les jours sélectionnés
      selectedDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.orange[300]!,
          Colors.orange[500]!,
        ],
      ),
      
      // Couleurs de texte
      regularDayTextColor: Colors.blue[900]!,
      validatedDayTextColor: Colors.white,
      selectedDayTextColor: Colors.white,
      
      // Bordures
      selectedDayBorderColor: Colors.orange,
      selectedDayBorderWidth: 3.0,
      dayBorderRadius: BorderRadius.circular(12.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Thème avec Gradients'),
      ),
      body: TontineCalendar(
        config: config,
        style: customStyle,
        onDaySelected: (data) {
          print('${data.totalUnvalidatedDays} jours sélectionnés');
        },
      ),
    );
  }
}
```

### Thème avec Gradients Radiaux

```dart
class RadialGradientThemeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 2000.0,
    );

    final customStyle = TontineCalendarStyle(
      // Gradient radial pour les jours validés
      validatedDayGradient: RadialGradient(
        center: Alignment.topLeft,
        colors: [
          Colors.purple[400]!,
          Colors.purple[800]!,
        ],
      ),
      
      // Gradient radial pour les jours sélectionnés
      selectedDayGradient: RadialGradient(
        center: Alignment.center,
        colors: [
          Colors.amber[300]!,
          Colors.orange[600]!,
        ],
      ),
      
      validatedDayTextColor: Colors.white,
      selectedDayTextColor: Colors.white,
      dayBorderRadius: BorderRadius.circular(16.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Thème avec Gradients Radiaux'),
      ),
      body: TontineCalendar(
        config: config,
        style: customStyle,
      ),
    );
  }
}
```

---

## Thèmes avec Ombres et Élévation

### Thème avec Ombres Personnalisées

```dart
class ShadowThemeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 2000.0,
    );

    final customStyle = TontineCalendarStyle(
      // Ombres pour les jours réguliers
      dayBoxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: Offset(0, 2),
          spreadRadius: 0,
        ),
      ],
      
      // Ombres pour les jours validés (plus prononcées)
      validatedDayBoxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.4),
          blurRadius: 12,
          offset: Offset(0, 6),
          spreadRadius: 2,
        ),
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.2),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ],
      
      // Ombres pour les jours sélectionnés
      selectedDayBoxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.5),
          blurRadius: 16,
          offset: Offset(0, 8),
          spreadRadius: 3,
        ),
      ],
      
      regularDayColor: Colors.grey[100]!,
      validatedDayColor: Colors.green[400]!,
      selectedDayColor: Colors.orange[300]!,
      dayBorderRadius: BorderRadius.circular(12.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Thème avec Ombres'),
      ),
      body: TontineCalendar(
        config: config,
        style: customStyle,
      ),
    );
  }
}
```

### Thème avec Élévation Material

```dart
class ElevationThemeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 2000.0,
    );

    final customStyle = TontineCalendarStyle(
      // Activer l'élévation
      enableElevation: true,
      
      // Élévation pour les jours réguliers
      regularDayElevation: 1.0,
      
      // Élévation pour les jours validés
      validatedDayElevation: 6.0,
      
      // Élévation pour les jours sélectionnés
      selectedDayElevation: 10.0,
      
      regularDayColor: Colors.grey[200]!,
      validatedDayColor: Colors.blue[600]!,
      selectedDayColor: Colors.purple[400]!,
      dayBorderRadius: BorderRadius.circular(12.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Thème avec Élévation'),
      ),
      body: TontineCalendar(
        config: config,
        style: customStyle,
      ),
    );
  }
}
```

---

## Thèmes avec Animations Personnalisées

### Thème avec Animations Rapides

```dart
class FastAnimationThemeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 2000.0,
    );

    final customStyle = TontineCalendarStyle(
      // Transitions rapides entre les mois
      transitionDuration: Duration(milliseconds: 150),
      transitionCurve: Curves.easeOut,
      
      // Animations de sélection rapides
      selectionAnimationDuration: Duration(milliseconds: 100),
      selectionAnimationCurve: Curves.easeIn,
      
      // Style de base
      regularDayColor: Colors.blue[100]!,
      validatedDayColor: Colors.green[400]!,
      dayBorderRadius: BorderRadius.circular(8.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Animations Rapides'),
      ),
      body: TontineCalendar(
        config: config,
        style: customStyle,
      ),
    );
  }
}
```

### Thème avec Animations Lentes et Fluides

```dart
class SmoothAnimationThemeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 2000.0,
    );

    final customStyle = TontineCalendarStyle(
      // Transitions lentes et fluides
      transitionDuration: Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOutCubic,
      
      // Animations de sélection fluides
      selectionAnimationDuration: Duration(milliseconds: 400),
      selectionAnimationCurve: Curves.easeOutCubic,
      
      // Style de base
      regularDayColor: Colors.blue[100]!,
      validatedDayColor: Colors.green[400]!,
      dayBorderRadius: BorderRadius.circular(12.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Animations Fluides'),
      ),
      body: TontineCalendar(
        config: config,
        style: customStyle,
      ),
    );
  }
}
```

---

## Exemples Complets

### Application Complète avec Thème Material 3 et Localisation

```dart
import 'package:flutter/material.dart';
import 'package:tontine_calendar/tontine_calendar.dart';

class CompleteTontineApp extends StatefulWidget {
  @override
  _CompleteTontineAppState createState() => _CompleteTontineAppState();
}

class _CompleteTontineAppState extends State<CompleteTontineApp> {
  String selectedTheme = 'Premium';
  String selectedLocale = 'fr';
  List<TontineDay> validatedDays = [];

  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig.withLocale(
      locale: selectedLocale,
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 2000.0,
      validatedDays: validatedDays,
    );

    TontineCalendarStyle style;
    switch (selectedTheme) {
      case 'Light':
        style = Material3Themes.material3Light();
        break;
      case 'Dark':
        style = Material3Themes.material3Dark();
        break;
      case 'Adaptive':
        style = Material3Themes.material3Adaptive(context);
        break;
      case 'Premium':
      default:
        style = Material3Themes.material3Premium();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tontine Calendar - Exemple Complet'),
      ),
      body: Column(
        children: [
          // Contrôles
          Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Sélectionner un thème:'),
                  Wrap(
                    spacing: 8,
                    children: ['Light', 'Dark', 'Adaptive', 'Premium']
                        .map((theme) => ChoiceChip(
                              label: Text(theme),
                              selected: selectedTheme == theme,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    selectedTheme = theme;
                                  });
                                }
                              },
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 16),
                  Text('Sélectionner une langue:'),
                  Wrap(
                    spacing: 8,
                    children: ['fr', 'es', 'en']
                        .map((locale) => ChoiceChip(
                              label: Text(locale.toUpperCase()),
                              selected: selectedLocale == locale,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    selectedLocale = locale;
                                  });
                                }
                              },
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          
          // Calendrier
          Expanded(
            child: TontineCalendar(
              config: config,
              style: style,
              onDaySelected: (data) {
                // Export des données
                final json = TontineExportUtils.exportToJson(data);
                final summary = TontineExportUtils.generateSummaryReport(data);
                
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Sélection'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Jours: ${data.totalUnvalidatedDays}'),
                          Text('Montant: ${data.totalAmount} FCFA'),
                          SizedBox(height: 16),
                          Text('Résumé:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(summary),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Fermer'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Ajouter les jours validés
                            data.unvalidatedDaysByMonth.forEach((month, days) {
                              for (var day in days) {
                                validatedDays.add(day.copyWith(
                                  isValidated: true,
                                  validatedDate: DateTime.now(),
                                ));
                              }
                            });
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Valider'),
                      ),
                    ],
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
```

### Thème Personnalisé Complet avec Toutes les Fonctionnalités

```dart
class UltimateCustomThemeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = TontineCalendarConfig(
      monthCount: 6,
      daysPerMonth: 31,
      defaultDayAmount: 2500.0,
    );

    final ultimateStyle = TontineCalendarStyle(
      // Gradients complexes
      regularDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.indigo[50]!,
          Colors.indigo[100]!,
          Colors.indigo[50]!,
        ],
        stops: [0.0, 0.5, 1.0],
      ),
      validatedDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.teal[400]!,
          Colors.teal[600]!,
          Colors.teal[400]!,
        ],
        stops: [0.0, 0.5, 1.0],
      ),
      selectedDayGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.amber[300]!,
          Colors.orange[500]!,
          Colors.amber[300]!,
        ],
        stops: [0.0, 0.5, 1.0],
      ),
      
      // Ombres multiples
      dayBoxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
      validatedDayBoxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.5),
          blurRadius: 16,
          offset: Offset(0, 8),
          spreadRadius: 2,
        ),
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.3),
          blurRadius: 24,
          offset: Offset(0, 12),
        ),
      ],
      selectedDayBoxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.6),
          blurRadius: 20,
          offset: Offset(0, 10),
          spreadRadius: 3,
        ),
      ],
      
      // Élévation
      enableElevation: true,
      regularDayElevation: 2.0,
      validatedDayElevation: 8.0,
      selectedDayElevation: 12.0,
      
      // Animations
      transitionDuration: Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOutCubic,
      selectionAnimationDuration: Duration(milliseconds: 300),
      selectionAnimationCurve: Curves.easeOutCubic,
      
      // Style de base
      dayBorderRadius: BorderRadius.circular(16.0),
      gridSpacing: 14.0,
      dayHeight: 60.0,
      headerTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Thème Ultime Personnalisé'),
      ),
      body: TontineCalendar(
        config: config,
        style: ultimateStyle,
        onDaySelected: (data) {
          print('Sélection: ${data.totalUnvalidatedDays} jours');
        },
      ),
    );
  }
}
```

---

## Conseils d'Utilisation

### Performance
- Les gradients et ombres peuvent impacter les performances sur les appareils moins puissants
- Utilisez `enableElevation: false` si vous avez des problèmes de performance
- Réduisez le nombre d'ombres pour améliorer les performances

### Accessibilité
- Assurez-vous que les gradients maintiennent un bon contraste
- Utilisez les thèmes à haut contraste pour l'accessibilité
- Testez avec les lecteurs d'écran

### Design
- Les gradients fonctionnent mieux avec des couleurs similaires
- Les ombres multiples créent plus de profondeur
- L'élévation Material donne un look plus natif

---

**Note** : Tous ces exemples sont compatibles avec la version 1.2.0 du package `tontine_calendar`.

