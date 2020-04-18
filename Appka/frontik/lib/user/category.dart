import 'package:flutter/material.dart';


class MyCategory extends StatefulWidget {
  MyCategory({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyCategoryState createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
    );
  }
}