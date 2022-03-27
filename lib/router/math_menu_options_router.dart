import 'package:flutter/material.dart';
import 'package:helper/models/models.dart';
import 'package:helper/screens/screens.dart';

import '../screens/screens.dart';

class MathMenuOptions {
  static const initialRoute = 'home_math_screen';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'lsRegressions',
        name: 'Regresión lineal por mínimos cuadrados',
        screen: const LeastSquaresRegressionScreen(),
        icon: Icons.line_axis_outlined),
    MenuOption(
        route: 'exponentialRegressions',
        name: 'Regresión Exponencial',
        screen: const ExponentialRegressionScreen(),
        icon: Icons.line_axis_outlined)
  ];

  static Map<String, Widget Function(BuildContext)> getAppMathRoutes() {
    Map<String, Widget Function(BuildContext)> mathMenuOptions = {};
    mathMenuOptions
        .addAll({'home_math': (BuildContext context) => MathMenuScreen()});
    for (final option in menuOptions) {
      mathMenuOptions
          .addAll({option.route: (BuildContext context) => option.screen});
    }
    return mathMenuOptions;
  }

  static Route onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => const LeastSquaresRegressionScreen());
  }
}
