import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:  Colors.white,
      statusBarIconBrightness:Brightness.dark,
    ));
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Todo',
      theme: ThemeData(
        accentColor: Colors.lightBlue[800],
        primaryColor: Colors.white,
        
        scaffoldBackgroundColor: Colors.white

      ),
      home: HomePage(),
    );
  }
}
