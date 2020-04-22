import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new AddAuthor()));
}

class AddAuthor extends StatefulWidget {
  @override
  AddAuthorState createState() => new AddAuthorState();
}

class AddAuthorState extends State<AddAuthor> {
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
                child: new Text('Enter Author details',
                    style: TextStyle(fontFamily: 'EmilysCandy', fontSize: 30)),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "First Name"),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Last Name"),
                ),
              ),
              Container(
                height: 250,
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "About"),
                  maxLines: 99,
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
                          MaterialPageRoute(builder: (context) => AddAuthor()),
                        );
                      }),
                ),
              ),
              //displaying input text
            ]))));
  }
}
