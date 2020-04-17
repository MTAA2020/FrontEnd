import 'package:flutter/material.dart';
import 'user/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Read It!',
      theme: ThemeData(
        	primarySwatch: Colors.grey
      ),
      home: MyHomePage(title: 'Read It!',),
    );
  }
}
