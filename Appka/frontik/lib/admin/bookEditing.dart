import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(home: new EditingBook()));
}

class EditingBook extends StatefulWidget {
  EditingBook(
      {Key key,
      this.id,
      this.selectedDate,
      this.authorName,
      this.price,
      this.bookTitle,
      this.genres})
      : super(key: key);
  String selectedDate;
  int id;
  String authorName;
  double price;
  String bookTitle;
  List genres;

  @override
  EditingBookState createState() => new EditingBookState();
}

class EditingBookState extends State<EditingBook> {
  //final TextEditingController controller = new TextEditingController();
  var selectedDate = TextEditingController();
  String _fileName;
  String _path;
  Map<String, String> _paths;
  var filePath = TextEditingController();
  var authorName = TextEditingController();
  var price = TextEditingController();
  var bookTitle = TextEditingController();
  var genres = TextEditingController();
  String _extension;
  bool _loadingPath = false;
  //bool _multiPick = false;
  FileType _pickingType;
  //TextEditingController _controller = new TextEditingController();
  String result = "";

  @override
  Widget build(BuildContext context) {
    selectedDate.text = widget.selectedDate;
    authorName.text = widget.authorName;
    price.text = widget.price.toString();
    bookTitle.text = widget.bookTitle;
    genres.text = widget.genres.toString();
    print(genres.text);
    //selectedDate.text = dateFormat.format(DateTime.now());
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
                  controller: authorName,
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
                  controller: bookTitle,
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
                  controller: selectedDate,
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
                  controller: price,
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
                  controller: genres,
                  decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Enter book genres (;)"),
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
                        give10();
                      }),
                ),
              ),
              //displaying input text
              new Text(result)
            ]))));


  }
      Future give10() async {
      var url = Uri.http('10.0.2.2:5000', "/bookEdit");
      var body =
          jsonEncode({'book_id': '${widget.id}', 'name': '${authorName.text}','title':'${bookTitle.text}','date':'${selectedDate.text}','price':'${price.text}','genres':jsonDecode('${genres.text.split(';')}')});

      http.Response response;
      try {
        response = await http.put(url,
            headers: {
              'Content-Type': 'application/json',
              'Connection': 'keep-alive',
              'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1ODc3Mjk5MDcsIm5iZiI6MTU4NzcyOTkwNywianRpIjoiYTlkYTE0YmEtZjg0My00NjUzLWE4YzQtMDFjOWYwNDdiYTYzIiwiZXhwIjoxNTg3NzMwODA3LCJpZGVudGl0eSI6ImFkbWluIiwiZnJlc2giOmZhbHNlLCJ0eXBlIjoiYWNjZXNzIn0.oywXFQmVBRNaQGXkJ0NITapxQDEn8bP2u1zQTDvl5wE'
            },
            body: body);
      } catch (error) {
        print(error);
      }

      final jsonResponse = json.decode(response.body);
     

      if (response.statusCode == 201) {
  
      } else {
        throw Exception('fail');
      }
    }
}
