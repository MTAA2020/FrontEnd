import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(home: new AddAuthor()));
}

class AddAuthor extends StatefulWidget {
  AddAuthor({Key key, this.token}) : super(key: key);
  final String token;
  @override
  AddAuthorState createState() => new AddAuthorState();
}

class Author {
  final String name;
  final String about;

  Author({this.name, this.about});

  factory Author.fromJson(Map<String, dynamic> json) {
    return new Author(name: json['name'], about: json['about']);
  }
}

class AddAuthorState extends State<AddAuthor> {
  var authorName = TextEditingController();
  var about = TextEditingController();
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
              /*Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "First Name"),
                ),
              ),*/
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  controller: authorName,
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Author's Name"),
                ),
              ),
              Container(
                height: 250,
                width: 300,
                padding: EdgeInsets.all(10),
                child: new TextField(
                  controller: about,
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
                    /*onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(),
                          );
                          ;
                        },
                      );
                    },*/
                    onPressed: () {
                      if ((authorName.text.trim()=="")||(about.text.trim()=="")){
                        showAlertDialog9(context);
                      }else{
                      addnewauthor();}
                    },
                  ),
                ),
              ),
              //displaying input text
            ]))));
  }

  Future addnewauthor() async {
    var url = Uri.http('127.0.0.1:5000', "/addAuthor");
    var body = jsonEncode({'name': '${authorName.text}', 'about': about.text});
    http.Response response;
    try {
      response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
            'Authorization': 'Bearer ${widget.token}'
          },
          body: body);
    } catch (error) {
      print(error);
    }

    final jsonResponse = json.decode(response.body);
    Author autor = Author.fromJson(jsonResponse);

    if (response.statusCode == 201) {
      setState(() {
        print(autor.name);
      });
    } else {
      throw Exception('fail');
    }
  }
  showAlertDialog9(BuildContext context) {

    Widget continueButton = FlatButton(
      child: new Text("OK",style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed:  () => Navigator.of(context).pop(),
    );

  // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: new Text("Fields cannot be empty",style: TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      actions: [
        continueButton
      ],
   );

  // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
