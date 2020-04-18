import 'package:flutter/material.dart';


class BookDetail extends StatefulWidget {
  BookDetail({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {

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