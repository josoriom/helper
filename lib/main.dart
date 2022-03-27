import 'package:flutter/material.dart';
import 'package:helper/providers/agenda_list_provider.dart';
import 'package:helper/providers/contact_provider.dart';
import 'package:helper/providers/contacts_list_provider.dart';
import 'package:helper/providers/form_provider.dart';
import 'package:helper/providers/speech_provider.dart';
import 'package:helper/providers/ui_provider.dart';

import 'package:helper/router/router.dart';
import 'package:helper/themes/themes.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FormProvider()),
          ChangeNotifierProvider(create: (_) => SpeechProvider()),
          ChangeNotifierProvider(create: (_) => ContactProvider()),
          ChangeNotifierProvider(create: (_) => AgendaListProvider()),
          ChangeNotifierProvider(create: (_) => ContactsListProvider()),
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
