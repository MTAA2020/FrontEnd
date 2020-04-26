import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Deposit extends StatefulWidget {
  Deposit({Key key,this.token}) : super(key: key);

  final String token;
  
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {




  final cardid = TextEditingController();
  final amount = TextEditingController();


  @override
  Widget build(BuildContext context) {

    Container deposit(){
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
                      text: 'Deposit',
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
                      controller: cardid,
                      decoration: InputDecoration(
                          hintText: 'Card ID',
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
                      controller: amount,
                      decoration: InputDecoration(
                          hintText: 'Amount',
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
                      onPressed: () {
                        getmoney(widget.token);
                      },
                      child: Text("Confirm",
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
              deposit(),
            ],
          ),
        ),
      ),
    );
  }

  Future getmoney(String token) async{

    var url = Uri.http('10.0.2.2:5000', "/deposit");
    var body = jsonEncode({'amount': amount.text});
    http.Response response;
    print('Bearer $token');
    try {
      response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
            'Authorization': 'Bearer $token',
          },
          body: body);
    } catch (error) {
      print(error);
    }
    final jsonresponse = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        cardid.clear();
        amount.clear();
        showAlertDialog(context, "Success",jsonresponse['balance']);
      });
    } else {
      throw Exception('fail');
    }

  }

  showAlertDialog(BuildContext context,String msg,double balance) {

    Widget continueButton = FlatButton(
      child: new Text("OK",style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed:  () => Navigator.of(context).pop(),
    );

  // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: new Text('$msg! Your new balance is $balance credits.',style: TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
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

}