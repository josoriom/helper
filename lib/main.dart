import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:helper/providers/providers.dart';
import 'package:helper/router/router.dart';
import 'package:helper/themes/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FormProvider()),
          ChangeNotifierProvider(create: (_) => AgendaListProvider()),
          ChangeNotifierProvider(create: (_) => UiProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Periodic Table',
            initialRoute: AppRoutes.initialRoute,
            routes: AppRoutes.getAppRoutes(),
            onGenerateRoute: AppRoutes.onGenerateRoute,
            theme: AppTheme.darkTheme));
  }
}
