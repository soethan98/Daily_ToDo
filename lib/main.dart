import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/utils/bloc/bloc.dart';
import 'package:flutter_todo/utils/bloc/theme_bloc.dart';
import 'package:flutter_todo/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  Constants.prefs = await SharedPreferences.getInstance();
  if (Constants.prefs.getBool(Constants.darkModePref) == null) {
    Constants.prefs.setBool(Constants.darkModePref, false);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildHomePage,
      ),
    );
  }

  Widget _buildHomePage(
    BuildContext context,
    ThemeState state,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily ToDo',
      home: HomePage(),
      theme: state.themeData,
    );
  }
}
