import 'package:flutter/material.dart';
import 'package:frontik/user/navigation.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login"),
        centerTitle: true,
      )
    );
  }
}