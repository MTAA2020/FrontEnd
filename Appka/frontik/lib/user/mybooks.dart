import 'package:flutter/material.dart';

class MyBooks extends StatefulWidget {
  MyBooks({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {


  Container kniha(String nazov, String obrazok){
    return Container(
      width: 120.0,
      height: 200.0,
      child: Card(
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
          top: Radius.circular(20)
          ),
        ),
        child: new Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              child: Image.network(
                  obrazok,
                  height: 160.0,
                  width: 140.0,
              ),
            ),
            new Text(
                        nazov,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0 ),
                        textAlign: TextAlign.center,
                      )
          ],
        ),
      ),
    );
  }


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