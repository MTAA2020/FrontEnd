import 'package:flutter/material.dart';

class Deposit extends StatefulWidget {
  Deposit({Key key}) : super(key: key);

  
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
}