import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(new MaterialApp(home: new EditingBook()));
}

class EditingBook extends StatefulWidget {
  EditingBook({Key key, this.selectedDate, this.authorName, this.price, this.bookTitle, this.genres}) : super(key: key);
  String selectedDate;
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
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
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
                          MaterialPageRoute(builder: (context) => EditingBook()),
                        );
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
}