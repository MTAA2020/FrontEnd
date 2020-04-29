import 'dart:convert';
import 'dart:core';
import 'package:frontik/admin/searchAuthor2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multiselect_formfield/multiselect_formfield.dart';

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
      this.genres,
      this.token})
      : super(key: key);
  String selectedDate;
  int id;
  String authorName;
  double price;
  String bookTitle;
  List genres;
  final String token;
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
  var _myActivities = [];
  var zanrere = [];
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
    List<String> zanre = new List();
    for (String item in widget.genres) {
      zanre.add("\"" + item + "\"");
    }
    _myActivities = zanre;
    genres.text = widget.genres.toString();
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
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  var res = await deleteBook(widget.id);
                  if (res['msg'] == "success") {
                    Navigator.pop(context);
                  } else {
                    {
                      showAlertDialog(context, res['msg']);
                    }
                  }
                }),
          ],
        ),
        body: new Container(
            child: new Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
              Container(
                width: 300,
                padding: EdgeInsets.all(5),
                child: new TextField(
                  controller: authorName,
                  decoration: new InputDecoration(
                      prefixIcon: IconButton(
                          icon: Icon(Icons.find_in_page),
                          onPressed: () {
                            _getAuthorName();
                            print(authorName.text);
                          }),
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
                      hintText: "Enter book title"),
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
                child: MultiSelectFormField(
                  autovalidate: false,
                  titleText: 'Genres',
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                  },
                  dataSource: [
                    {
                      "display": "Thriller",
                      "value": "\"Thriller\"",
                    },
                    {
                      "display": "SciFi",
                      "value": "\"SciFi\"",
                    },
                    {
                      "display": "Child",
                      "value": "\"Child\"",
                    },
                    {
                      "display": "History",
                      "value": "\"History\"",
                    },
                    {
                      "display": "Romance",
                      "value": "\"Romance\"",
                    },
                    {
                      "display": "Bibliography",
                      "value": "\"Bibliography\"",
                    },
                    {
                      "display": "Technology",
                      "value": "\"Technology\"",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  // required: true,
                  hintText: 'Please choose one or more',
                  value: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                      zanrere = value;
                    });
                  },
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
              //authorName.text=result;
            ]))));
  }

  Future deleteBook(int id) async {
    http.Response response;
    try {
      response = await http.delete(
        Uri.http('127.0.0.1:5000', "/bookDelete", {"book_id": "${id}"}),
        headers: {
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer ${widget.token}'
        },
      );
    } catch (error) {
      print(error);
    }
  }

  void _getAuthorName() async {
    result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchAuthor(token: widget.token)),
    );
    setState(() {
    widget.authorName = result;
                    });

  }

  showAlertDialog(BuildContext context, String msg) {
    Widget continueButton = FlatButton(
      child: new Text("OK",
          style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed: () => Navigator.of(context).pop(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: new Text(msg,
          style: TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      actions: [continueButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future give10() async {
    var url = Uri.http('127.0.0.1:5000', "/bookEdit");
    var body = jsonEncode({
      'book_id': '${widget.id}',
      'name': '${authorName.text}',
      'title': '${bookTitle.text}',
      'date': '${selectedDate.text}',
      'price': '${price.text}',
      'genres': jsonDecode('$zanrere')
    });
    print(body);
    http.Response response;
    try {
      response = await http.put(url,
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

    if (response.statusCode == 200) {
      print("keke");
    } else {
      throw Exception(Exception);
    }
  }
}
