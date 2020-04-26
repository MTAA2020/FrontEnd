import 'package:flutter/material.dart';
import 'package:frontik/user/navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontik/admin/adminMain.dart';

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
                      obscureText: true,
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
                        var res = await loginrequest();
                        if (res['msg'] == "Success") {
                          loginusername.clear();
                          loginpassword.clear();
                          if(res['admin'] == true){
                             Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AdminMainPage(token: res['access_token'])),
                            );  
                          }else{
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Navigation(token: res['access_token'])),
                            );  
                          }
                        } else {
                          {showAlertDialog(context);}
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
      var _validate=false;
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
                            keyboardType: TextInputType.emailAddress,
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
                            obscureText: true,
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
                      onPressed: () async{
                        if ((regusername.text.trim()=="")||(regemail.text.trim()=="")||(regpassword.text.trim()=="")){
                            showAlertDialog9(context);
                        } else {
                        var res = await registerrequest();
                        if (res['msg'] == "Success") {
                          loginusername.clear();
                          loginpassword.clear();
                          {showAlertDialog1(context);} 
                        } else {
                          {showAlertDialog2(context,res['msg']);}
                        }
                        }
                      },
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
              logincard(),
              registrationcard()
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    Widget continueButton = FlatButton(
      child: new Text("OK",style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed:  () => Navigator.of(context).pop(),
    );

  // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: new Text("Wrong Details",style: TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
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

  showAlertDialog1(BuildContext context) {

    Widget continueButton = FlatButton(
      child: new Text("OK",style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed:  () => Navigator.of(context).pop(),
    );

  // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: new Text("Successful registration. Please sign in to continue.",style: TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
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

  showAlertDialog2(BuildContext context,String msg) {

    Widget continueButton = FlatButton(
      child: new Text("OK",style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed:  () => Navigator.of(context).pop(),
    );

  // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: new Text(msg,style: TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
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
  

  registerrequest() async{

    http.Response response;
    try{
      response = await http.post(
        Uri.http('10.0.2.2:5000', "/register"),
        headers: {
          'Content-Type' : 'application/json'
        },
        body: json.encode({
          "username": regusername.text,
          "password": regpassword.text,
          "email" : regemail.text,
          "admin" : "0",
        })
      );
    }
    catch(error){
      print(error);
    }
    final jsonresponse= json.decode(response.body);
    if (response.statusCode==201){
      return jsonresponse;
    }
    return jsonresponse;
  }
}