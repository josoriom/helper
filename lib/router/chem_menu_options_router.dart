import 'package:flutter/material.dart';
import 'package:helper/models/models.dart';
import 'package:helper/screens/screens.dart';

import '../screens/screens.dart';

class ChemMenuOptions {
  static const initialRoute = 'home_screen_screen';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'table',
        name: 'Tabla periódica',
        screen: const TableScreen(),
        icon: Icons.list_alt)
  ];

  static Map<String, Widget Function(BuildContext)> getAppMathRoutes() {
    Map<String, Widget Function(BuildContext)> chemMenuOptions = {};
    chemMenuOptions.addAll(
        {'home_chem_screen': (BuildContext context) => const ChemMenuScreen()});
    for (final option in menuOptions) {
      chemMenuOptions
          .addAll({option.route: (BuildContext context) => option.screen});
    }
    return chemMenuOptions;
  }

  static Route onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const TableScreen());
  }
}
