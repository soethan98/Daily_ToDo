import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/profile.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
            value: false,
            title: Text(
              "Dark Theme",
              style: TextStyle(fontSize: 18.0),
            ),
            onChanged: (value) {},
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
