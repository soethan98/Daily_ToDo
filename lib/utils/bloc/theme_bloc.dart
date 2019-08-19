import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/utils/app_theme.dart';
import './bloc.dart';
import 'package:flutter_todo/utils/const.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  

  @override
  ThemeState get initialState => Constants.prefs.getBool(Constants.darkModePref)
      ? ThemeState(themeData: appThemeData[AppTheme.DarkTheme])
      : ThemeState(themeData: appThemeData[AppTheme.LightTheme]);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      if (event.appTheme == AppTheme.LightTheme) {
        _setSharedPref(false);
      } else if (event.appTheme == AppTheme.DarkTheme) {
        _setSharedPref(true);
      }
      yield ThemeState(themeData: appThemeData[event.appTheme]);
    }
  }

  _setSharedPref(bool value) async {
    await Constants.prefs.setBool(Constants.darkModePref, value);
  }
}
