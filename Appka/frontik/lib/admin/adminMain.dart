import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new AwesomeButton()));
}

class AwesomeButton extends StatefulWidget {
  @override
  AwesomeButtonState createState() => new AwesomeButtonState();
}

class AwesomeButtonState extends State<AwesomeButton> {
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
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AwesomeButton()),
                  );
                }),
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AwesomeButton()),
                  );
                })
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
                      child: new Text("Press me!",
                          style: new TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 20.0)),
                      color: Colors.lightBlue,
                      onPressed: onPressed),
                ),
              ),
              new RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(60), top: Radius.circular(60)),
                  ),
                  child: new Text("Press me 2!",
                      style: new TextStyle(
                          color: Colors.black,
                          fontFamily: 'EmilysCandy',
                          fontSize: 20.0)),
                  color: Colors.lightBlue,
                  onPressed: onPressed),
              new RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10), top: Radius.circular(60)),
                  ),
                  child: new Text("Press me 3!",
                      style: new TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0)),
                  color: Colors.lightBlue,
                  onPressed: onPressed)
            ]))));
  }
}
