import 'package:flutter/material.dart';
import 'package:frontik/admin/adminAddAuthor.dart';
import 'package:frontik/admin/adminAddBook.dart';
import 'package:frontik/admin/adminEditBook.dart';

void main() {
  runApp(new MaterialApp(home: new AdminMainPage()));
}

class AdminMainPage extends StatefulWidget {
  AdminMainPage({Key key,this.token}) : super(key: key);
  final String token;
  @override
  AwesomeButtonState createState() => new AwesomeButtonState();
}

class AwesomeButtonState extends State<AdminMainPage> {
  void onPressed() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Admin Read It!',
              style: TextStyle(fontFamily: 'EmilysCandy', fontSize: 30),
            ),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {showAlertDialog(context);})
          ],
          centerTitle: true,
        ),
        body: new Container(
            child: new Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                      child: new Text("Add Book",
                          style: new TextStyle(
                              color: Colors.black,
                              fontFamily: 'EmilysCandy',
                              fontSize: 20.0)),
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddBook(token: widget.token)),
                        );
                      }),
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
                      child: new Text("Add Author",
                          style: new TextStyle(
                              color: Colors.black,
                              fontFamily: 'EmilysCandy',
                              fontSize: 20.0)),
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddAuthor(token: widget.token)),
                        );
                      }),
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
                      child: new Text("Edit Book",
                          style: new TextStyle(
                              color: Colors.black,
                              fontFamily: 'EmilysCandy',
                              fontSize: 20.0)),
                      color: Colors.lightBlue,
                      onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditBook(token: widget.token)),
                        );}),
                ),
              )
            ]))));
  }
  showAlertDialog(BuildContext context) {

 Widget cancelButton = FlatButton(
    child: new Text("No",style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
    onPressed:  () {},
  );
  Widget continueButton = FlatButton(
    child: new Text("Yes",style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: new Text("Are you sure yo want to log out?",style: TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
    actions: [
      cancelButton,continueButton
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
