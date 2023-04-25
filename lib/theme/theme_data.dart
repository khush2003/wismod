import 'package:flutter/material.dart';

class AppThemeData { 
  static ThemeData themedata = ThemeData(
    colorScheme: const ColorScheme(brightness: Brightness.light, primary: Color.fromRGBO(123, 56, 255, 1), onPrimary: Colors.white, secondary: Color.fromARGB(255, 255, 77, 143), onSecondary: Colors.white, error: Colors.red, onError: Colors.white, background: Colors.white, onBackground: Colors.black, surface: Colors.white, onSurface: Colors.black),
    textTheme: const TextTheme(displayLarge: TextStyle(fontFamily: "Gotham", fontWeight: FontWeight.normal, fontSize: 20), displayMedium: TextStyle(fontFamily: "Gotham", fontWeight: FontWeight.normal, fontSize: 16)),
  );
}
