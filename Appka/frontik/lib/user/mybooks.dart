import 'package:flutter/material.dart';

class MyBooks extends StatefulWidget {
  MyBooks({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("mybooks"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey
      
    );
  }
}