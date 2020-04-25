import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:multiselect_formfield/multiselect_formfield.dart';

void main() {
  runApp(new MaterialApp(home: new AddBook()));
}

class AddBook extends StatefulWidget {
  AddBook({Key key, this.token}) : super(key: key);

  final String token;

  @override
  AddBookState createState() => new AddBookState();
}

class AddBookState extends State<AddBook> {
  //final TextEditingController controller = new TextEditingController();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  var selectedDate = TextEditingController();
  String _fileName;
  String _path;
  Map<String, String> _paths;
  var filePath = TextEditingController();
  var authorName = TextEditingController();
  var price = TextEditingController();
  var bookTitle = TextEditingController();
  var genres = TextEditingController();
  var picturePath = TextEditingController();
  String _extension;
  bool _loadingPath = false;
  var _myActivities = [];
  //bool _multiPick = false;
  FileType _pickingType;
  //TextEditingController _controller = new TextEditingController();
  String result = "";

  @override
  Widget build(BuildContext context) {
    selectedDate.text = dateFormat.format(DateTime.now());
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
                padding: EdgeInsets.all(5),
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
                padding: EdgeInsets.all(5),
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
                padding: EdgeInsets.all(5),
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
                padding: EdgeInsets.all(5),
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
                padding: EdgeInsets.all(5),
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
                    });
                  },
                ), 
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(5),
                child: new TextField(
                  controller: filePath,
                  decoration: new InputDecoration(
                      prefixIcon: IconButton(
                          icon: Icon(Icons.find_in_page),
                          onPressed: () => _openFileExplorer()),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Browse for the book"),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(5),
                child: new TextField(
                  controller: picturePath,
                  decoration: new InputDecoration(
                      prefixIcon: IconButton(
                          icon: Icon(Icons.find_in_page),
                          onPressed: () => _openFileExplorerJPG()),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Browse for the cover"),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                        addnewbook();
                      }),
                ),
              ),
              //displaying input text
              new Text(result)
            ]))));
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _paths = null;
      _path = await FilePicker.getFilePath(
          type: _pickingType,
          allowedExtensions: (_extension?.isNotEmpty ?? false)
              ? _extension?.replaceAll(' ', '')?.split(',')
              : null);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }

    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
    filePath.text = _path;
  }

  void _openFileExplorerJPG() async {
    setState(() => _loadingPath = true);
    try {
      _paths = null;
      _path = await FilePicker.getFilePath(
          type: _pickingType,
          allowedExtensions: (_extension?.isNotEmpty ?? false)
              ? _extension?.replaceAll(' ', '')?.split(',')
              : null);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }

    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
    picturePath.text = _path;
  }

  Future addnewbook() async {
    var url = Uri.http('10.0.2.2:5000', "/addBook");
    var body = jsonEncode({
      'name': '${authorName.text}',
      'title': '${bookTitle.text}',
      'date': '${selectedDate.text}',
      'price': '${double.parse(price.text)}',
      'genres': jsonDecode('$_myActivities')
    });
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

    try {
      postcover(jsonResponse['book_id']);
      postpdf(jsonResponse['book_id']);
    } catch (error) {
      print(error);
    }
    if (response.statusCode == 201) {
      setState(() {});
    } else {
      throw Exception('fail');
    }
  }

  Future postcover(int id) async {
    File picture = new File('${picturePath.text}');
    var stream = new http.ByteStream(picture.openRead());
    var length = await picture.length();
    var request = new http.MultipartRequest(
        "POST",
        Uri.http(
          '10.0.2.2:5000',
          "/addjpg",
        ));
    request.fields['book_id'] = id.toString();
    request.headers.addAll({"Authorization": 'Bearer ${widget.token}'});
    request.files.add(
        new http.MultipartFile('file', stream, length, filename: 'book_$id'));
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }

  Future postpdf(int id) async {
    File picture = new File('${filePath.text}');
    var stream = new http.ByteStream(picture.openRead());
    var length = await picture.length();
    var request = new http.MultipartRequest(
        "POST",
        Uri.http(
          '10.0.2.2:5000',
          "/addpdf",
        ));
    request.fields['book_id'] = id.toString();
    request.headers.addAll({"Authorization": 'Bearer ${widget.token}'});
    request.files.add(
        new http.MultipartFile('file', stream, length, filename: 'book_$id'));
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }
}
