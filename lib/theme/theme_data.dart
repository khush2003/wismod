import 'package:flutter/material.dart';

// To use Text theme in widgets or colors in widgets you can use it like this
// Text("..", style: Theme.of(context).textTheme.displayLarge) DisplayLarge or any other of your choice defined below
// To get primary color of app or any color in the colorScheme: Theme.of(context).colorScheme.primary
// Predefined Compoenets in global_widgets.dart

const primary = Color.fromRGBO(123, 56, 255, 1);
const secondary = Color.fromARGB(255, 255, 77, 143);

class AppThemeData {
  static ThemeData themedata = ThemeData(
    // Scaffold Background Color
    scaffoldBackgroundColor: Colors.white,
    // Color Schemeing for the app
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromRGBO(123, 56, 255, 1),
        onPrimary: Colors.white,
        secondary: Color.fromARGB(255, 255, 77, 143),
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black),

    // Text Theme for the app
    // displayLarge = Gotham Medium 20 Black
    // displayMedium = Gotham Medium 16 Black
    // titleMedium = Gotham Bold 32 Black
    // bodyMedium = Gotham Regular 16 Black
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontFamily: "Gotham",
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: Colors.black),
      displayMedium: TextStyle(
          fontFamily: "Gotham",
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black),
      titleMedium: TextStyle(
          fontFamily: "Gotham",
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black),
      bodyMedium: TextStyle(
          fontFamily: "Gotham",
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.black),
    ),

    // Theme For buttons (Ignore this)
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromRGBO(123, 56, 255, 1),
            elevation: 0,
            textStyle: const TextStyle(
                fontFamily: "Gotham",
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black),
            minimumSize: const Size(136, 53),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))))),

    // AppBar Theme (Make it Transparent)
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.white,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(weight: 900, size: 34, grade: 900),
      titleTextStyle: TextStyle(
          fontFamily: "Gotham",
          fontWeight: FontWeight.bold,
          fontSize: 32,
          color: Colors.black),
    ),
  );
}
