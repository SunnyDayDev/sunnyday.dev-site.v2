import 'package:flutter/material.dart';
import 'package:sunnydaydev_site/pages/home/home_widget.dart';
import 'initialize_other.dart'
  if (dart.library.html) 'initialize_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SunnyDay.Dev',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Color(0xFF654338),
        primaryColorDark: Color(0xFF782D2A),
        accentColor: Color(0xFF654338)
      ),
      home: HomePage(),
    );
  }
}
