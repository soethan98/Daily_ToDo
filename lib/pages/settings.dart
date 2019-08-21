import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/pages/profile.dart';
import 'package:flutter_todo/utils/app_theme.dart';
import 'package:flutter_todo/utils/bloc/theme_bloc.dart';
import 'package:flutter_todo/utils/bloc/theme_event.dart';
import 'package:flutter_todo/utils/const.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _value = Constants.prefs.getBool(Constants.darkModePref) ?? false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 22.0),
        ),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SwitchListTile(
            activeColor: Theme.of(context).accentColor,
            value: _value,
            title: Text(
              "Dark Theme",
              style: TextStyle(fontSize: 18.0),
            ),
            onChanged: (value) {
              setState(() {
                _value = value;
                debugPrint('$_value');
              });

              value
                  ? BlocProvider.of<ThemeBloc>(context).dispatch(
                      ThemeChanged(appTheme: AppTheme.DarkTheme),
                    )
                  : BlocProvider.of<ThemeBloc>(context)
                      .dispatch(ThemeChanged(appTheme: AppTheme.LightTheme));
            },
          ),
          SizedBox(
            height: 12.0,
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AboutMe(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12.0),
              child: Container(
                width: double.infinity,
                height: 48.0,
                child: Text(
                  'About',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
