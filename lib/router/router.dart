import 'package:flutter/material.dart';
import 'package:helper/models/menu_options.dart';
import 'package:helper/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'home_math_screen',
        name: 'Matematicas',
        screen: const MathMenuScreen(),
        icon: Icons.emoji_symbols_rounded),
    MenuOption(
        route: 'speech_screen',
        name: 'Speech',
        screen: SpeechScreen(),
        icon: Icons.phone_in_talk),
    MenuOption(
        route: 'home_chem_screen',
        name: 'Regresión Exponencial',
        screen: const ChemMenuScreen(),
        icon: Icons.whatshot_outlined),
    MenuOption(
        route: 'contacts_screen',
        name: 'Agenda',
        screen: ContactsScreen(),
        icon: Icons.whatshot_outlined),
    MenuOption(
        route: 'contacts_create_screen',
        name: 'Create Item',
        screen: ContactsCreateScreen(),
        icon: Icons.whatshot_outlined),
    MenuOption(
        route: 'contacts_display_screen',
        name: 'Display Item',
        screen: ContactsDisplayScreen(),
        icon: Icons.whatshot_outlined),
    MenuOption(
        route: 'contacts_edit_screen',
        name: 'Edit Item',
        screen: ContactsEditScreen(),
        icon: Icons.whatshot_outlined),
    MenuOption(
        route: 'agenda_screen',
        name: 'Agenda',
        screen: AgendaScreen(),
        icon: Icons.whatshot_outlined),
    MenuOption(
        route: 'agenda_create_screen',
        name: 'Create Item',
        screen: AgendaCreateScreen(),
        icon: Icons.whatshot_outlined),
    MenuOption(
        route: 'agenda_display_screen',
        name: 'Create Item',
        screen: AgendaDisplayScreen(),
        icon: Icons.whatshot_outlined),
    MenuOption(
        route: 'agenda_edit_screen',
        name: 'Create Item',
        screen: AgendaEditScreen(),
        icon: Icons.whatshot_outlined),
    MenuOption(
        route: 'settings',
        name: 'Configuraciones',
        screen: const SettingsScreen(),
        icon: Icons.whatshot_outlined),
    MenuOption(
        route: 'lsRegressions',
        name: 'Regresión lineal por mínimos cuadrados',
        screen: const LeastSquaresRegressionScreen(),
        icon: Icons.line_axis_outlined),
    MenuOption(
        route: 'exponentialRegressions',
        name: 'Regresión Exponencial',
        screen: const ExponentialRegressionScreen(),
        icon: Icons.line_axis_outlined),
    MenuOption(
        route: 'table',
        name: 'Tabla periódica',
        screen: const TableScreen(),
        icon: Icons.list_alt)
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> AppRoutes = {};
    AppRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});

    for (final option in menuOptions) {
      AppRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return AppRoutes;
  }

  static Route onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => const LeastSquaresRegressionScreen());
  }
}
