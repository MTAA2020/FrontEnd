import 'package:flutter/material.dart';
import 'package:frontik/user/navigation.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {




  final loginusername = TextEditingController();
  final loginpassword = TextEditingController();
  final regusername = TextEditingController();
  final regpassword = TextEditingController();
  final regemail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    

    Container login(){
      return Container(
        height: 260,
        margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
         child: Card(
           color: Colors.grey[400],
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
              top: Radius.circular(20)
              ),
            ),
            child: Column(

              children: <Widget>[
                Container(
                  width: 330,
                  padding: new EdgeInsets.all(5.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Login',
                      style: TextStyle(fontFamily: 'PermanentMarker',fontSize: 40),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  padding: new EdgeInsets.all(5.0),
                  child: new Material(
                    color: Colors.white,
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(50.0),
                    child: TextFormField(
                      controller: loginusername,
                      decoration: InputDecoration(
                          hintText: 'Username',
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                        ),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  padding: new EdgeInsets.all(5.0),
                  child: new Material(
                    color: Colors.white,
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(50.0),
                    child: TextFormField(
                      controller: loginpassword,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                        ),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  padding: new EdgeInsets.all(5.0),
                  child: new Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color(0xff01A0C7),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Navigation()),
                        );
                      },
                      child: Text("Login",
                          textAlign: TextAlign.center,
                        ),
                    )
                  ), 
                ),
              ],

            ),
         ),
      );
    }


    Container registration(){
      return Container(
        height: 320,
        margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
         child: Card(
           color: Colors.grey[400],
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
              top: Radius.circular(20)
              ),
            ),
            child: Column(

              children: <Widget>[
                Container(
                  width: 330,
                  padding: new EdgeInsets.all(5.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Registration',
                      style: TextStyle(fontFamily: 'PermanentMarker',fontSize: 40),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  padding: new EdgeInsets.all(5.0),
                  child: new Material(
                    color: Colors.white,
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(50.0),
                    child: TextFormField(
                      controller: regusername,
                      decoration: InputDecoration(
                          hintText: 'Username',
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                        ),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  padding: new EdgeInsets.all(5.0),
                  child: new Material(
                    color: Colors.white,
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(50.0),
                    child: TextFormField(
                      controller: regemail,
                      decoration: InputDecoration(
                          hintText: 'E-mail',
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                        ),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  padding: new EdgeInsets.all(5.0),
                  child: new Material(
                    color: Colors.white,
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(50.0),
                    child: TextFormField(
                      controller: regpassword,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                        ),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  padding: new EdgeInsets.all(5.0),
                  child: new Material(
                    //onPressed:
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color(0xff01A0C7),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      onPressed: () {},
                      child: Text("Registrate",
                          textAlign: TextAlign.center,
                        ),
                    )
                  ), 
                ),
              ],

            ),
         ),
      );
    }


    return new Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Read It!',
            style: TextStyle(fontFamily: 'EmilysCandy',fontSize: 30),
          ),
        ),
        centerTitle: true,
      ),
      body: new Center(
        child: new Container(
          child: ListView(
            children: <Widget>[
              login(),
              registration()
            ],
          ),
        ),
      ),
    );
  }
}