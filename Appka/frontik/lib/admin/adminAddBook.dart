import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new AddBook()));
}

class AddBook extends StatefulWidget {
  @override
  AddBookState createState() => new AddBookState();
}



class AddBookState extends State<AddBook> {
  final TextEditingController controller = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  String result = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          backgroundColor: Colors.grey,
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Admin Read It!',
              style: TextStyle(fontFamily: 'EmilysCandy', fontSize: 30),
            ),
          ),
        ),
        body: new Container(
            child: new Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Enter Author name"),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Ented book title"),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Enter date published"),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Enter price"),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Enter book genres (;)"),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Browse for the book"),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.all(25.0),
                child: ButtonTheme(
                  minWidth: 200,
                  height: 60,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15),
                            top: Radius.circular(15)),
                      ),
                      child: new Text("Submit",
                          style: new TextStyle(
                              color: Colors.black,
                              fontFamily: 'EmilysCandy',
                              fontSize: 20.0)),
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddBook()),
                        );
                      }),
                ),
              ),
              //displaying input text
              new Text(result)
            ]))));
  }
}
