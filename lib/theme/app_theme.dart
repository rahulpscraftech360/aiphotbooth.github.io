import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    // Using the new text theme API
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        // formerly bodyText1
        fontSize: 16.0,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        // formerly bodyText2
        fontSize: 14.0,
        color: Colors.black54,
      ),
      titleLarge: TextStyle(
        // formerly headline6
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}
