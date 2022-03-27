import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xff202333);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      // Primary color
      primaryColor: primary,

      // AppBar theme
      appBarTheme: const AppBarTheme(color: primary, elevation: 20),
      textButtonTheme:
          TextButtonThemeData(style: TextButton.styleFrom(primary: primary)),

      // Floating button theme
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: primary),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: primary, shape: const StadiumBorder(), elevation: 10),
      ),
      inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: primary),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10))))

      // end of identation
      );

  static final ThemeData darkTheme = ThemeData.light().copyWith(
      // Primary color
      primaryColor: primary,

      // AppBar theme

      appBarTheme: const AppBarTheme(color: primary, elevation: 20),
      // scaffoldBackgroundColor: Colors.black
      textButtonTheme:
          TextButtonThemeData(style: TextButton.styleFrom(primary: primary)),

      // Floating button theme
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: primary),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: primary, shape: const StadiumBorder(), elevation: 10),
      ),
      inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: primary),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10))))
      // end of identation
      );
}
