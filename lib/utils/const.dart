import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.black;

  static Color lightAccent = Colors.blue[800];
  static Color darkAccent = Colors.blue[800];

  static Color lightBG = Colors.white;
  static Color darkBG = Colors.black;
  static Color white = Colors.white;

  //SharePref
  //* Preferences
  static SharedPreferences prefs;
  static const String darkModePref = "darkModePref";
}
