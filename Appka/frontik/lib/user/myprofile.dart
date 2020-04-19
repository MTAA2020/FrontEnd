import 'package:flutter/material.dart';
import 'package:frontik/user/transactions.dart';
import 'package:frontik/user/deposit.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey,
      body: new Center(
        child: new Container(
          padding: new EdgeInsets.fromLTRB(0,50,0,10),
          child: Column(
            children: <Widget>[
              Container(
                  width: 330,
                  height: 140,
                  padding: new EdgeInsets.fromLTRB(5,20,5,20),
                  child: new Material(
                    //onPressed:
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color(0xffc22b2b),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Deposit()),
                          );
                      },
                      child: Text("Deposit",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                    )
                  ), 
                ),
              Container(
                  width: 330,
                  height: 140,
                  padding: new EdgeInsets.fromLTRB(5,20,5,20),
                  child: new Material(
                    //onPressed:
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color(0xffc22b2b),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Transactions()),
                          );
                      },
                      child: Text("Transactions",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                    )
                  ), 
                ),
              Container(
                  width: 330,
                  height: 140,
                  padding: new EdgeInsets.fromLTRB(5,20,5,20),
                  child: new Material(
                    //onPressed:
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color(0xffc22b2b),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      onPressed: () {},
                      child: Text("Settings",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                    )
                  ), 
                ),
              Container(
                  width: 330,
                  height: 140,
                  padding: new EdgeInsets.fromLTRB(5,20,5,20),
                  child: new Material(
                    //onPressed:
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color(0xff3F6CE1),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Log Out",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                    )
                  ), 
                ),
            ]
          )
        )
      )
    );
  }
}