import 'package:flutter/material.dart';
import 'package:frontik/user/navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
    
    bool isloading=false;


    Container logincard(){
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
                      onPressed: () async {
                        setState(() => isloading = true);
                        var res = await loginrequest();
                        
                        isloading=true;
                        if (false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Navigation()),
                          );  
                        } else {
                          
                        }
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


    Container registrationcard(){
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
          child: isloading ? Center(child: CircularProgressIndicator()) :ListView(
            children: <Widget>[
              logincard(),
              registrationcard()
            ],
          ),
        ),
      ),
    );
  }


  loginrequest() async{

    http.Response response;
    try{
      response = await http.post(
        Uri.http('10.0.2.2:5000', "/login"),
        headers: {
          'Content-Type' : 'application/json'
        },
        body: json.encode({
          "username": loginusername.text,
          "password": loginpassword.text,
        })
      );
    }
    catch(error){
      print(error);
    }
    final jsonresponse= json.decode(response.body);
    if (response.statusCode==200){
      return jsonresponse;
    }
    return jsonresponse;
  }

}