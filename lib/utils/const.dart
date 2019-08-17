import 'package:flutter/material.dart';

class Constants {
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.black;

  static Color lightAccent = Colors.blue[800];
  static Color darkAccent = Colors.blue[800];

  static Color lightBG = Colors.white;
  static Color darkBG = Colors.black;
  static Color white = Colors.white;

  static ThemeData lightTheme = ThemeData(
      backgroundColor: lightBG,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      cursorColor: lightAccent,
      cardColor: lightBG,
      scaffoldBackgroundColor: lightBG,
      primarySwatch: Colors.orange);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      backgroundColor: darkBG,
      primaryColor: darkPrimary,
      accentColor: darkAccent,
      scaffoldBackgroundColor: darkBG,
      cursorColor: darkAccent,
      cardColor: darkBG,
      primarySwatch: Colors.orange
      );
}
