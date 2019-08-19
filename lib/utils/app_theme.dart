import 'package:flutter/material.dart';
import 'const.dart';

enum AppTheme {
  LightTheme,
  DarkTheme,
}

final appThemeData = {
  AppTheme.LightTheme: ThemeData(
    brightness: Brightness.light,
      backgroundColor: Constants.lightBG,
      primaryColor: Constants.lightPrimary,
      accentColor: Constants.lightAccent,
      cursorColor: Constants.lightAccent,
      cardColor: Constants.lightBG,
      scaffoldBackgroundColor: Constants.lightBG,
      iconTheme: IconThemeData(color: Constants.lightAccent),
      appBarTheme: AppBarTheme(brightness: Brightness.light),
     ),
  AppTheme.DarkTheme: ThemeData(
      brightness: Brightness.dark,
      backgroundColor: Constants.darkBG,
      primaryColor: Constants.darkPrimary,
      accentColor: Constants.darkAccent,
      scaffoldBackgroundColor: Constants.darkBG,
      cursorColor: Constants.darkAccent,
      cardColor: Constants.darkBG,
      iconTheme: IconThemeData(color: Constants.lightAccent),
      appBarTheme: AppBarTheme(brightness: Brightness.dark),
      ),
};
