import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Transactions extends StatefulWidget {
  Transactions({Key key,this.token}) : super(key: key);

  final String token;
  
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  Widget info(String type,String date){
    return Container(
      width: 200,
      height:120,
      alignment: Alignment.centerLeft,
      child: new Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.fromLTRB(3, 3, 5, 7),
            child: Text(
              type,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0 , color: Colors.black),
            )
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.fromLTRB(3, 3, 5, 7),
            child: Text(
              date,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0 , color: Colors.black),
            )
          ),
        ],
      ),
    );
  }


  Widget spent(String amount){
    return Container(
      width:142,
      height: 120,
      child:Container(
        alignment: Alignment.centerRight,
        child: new Row(
          children: <Widget>[
            Container(
              child: Text(
                amount,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0 , color: Colors.black),
              ),
            ),
            Container(
              child: Icon(
                Icons.attach_money,
                size: 30),
            )
          ],
        )
      )
    );
  }
  


 

  Container transaction(String type, String date,String amount){
    return Container(
      padding: EdgeInsets.fromLTRB(10,5,10,0),
      height: 120,
      width: 380,
      child: Card(
        elevation: 15,
        child: Padding(
        padding: EdgeInsets.all(0),
        child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 0, top: 0),
                    child: Row(
                      children: <Widget>[
                        info(type,date),
                        spent(amount)
                      ],
                    )
                ),
              ],
            ),
          )
        ]),
        ),
      ),
    );
  }
  
  List<Transaction> transactions = new List();
  ScrollController scrollController = new ScrollController();
  double mybalance=0;

  @override
  void initState(){
    super.initState();
    getbalance(widget.token);
    give10(1,widget.token);
    scrollController.addListener((){
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        int tmp=1;
        if(transactions.length%10!=0){
          tmp=2;
        }
        int nextpage=(transactions.length/10-(transactions.length%10)/10 +tmp).toInt();
        give10(nextpage,widget.token);
      }
    }
    );
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    Widget balance() {
      return Container(
        height:100,
        width:420,
        child: Card(
          color: Colors.blueGrey,
          child: Center(
            child: Text(
              "Balance: $mybalance credits",
              style: TextStyle(color: Colors.white,fontSize: 30),
            )
          )
        ),
      );
    }

    return new Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(
        title: new Text("Transactions"),
        centerTitle: true,
      ),
      body: Container(
        child:Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.fromLTRB(10,3,10,3),
              width: 420,
              height: 500,
              child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(10,3,10,3),
                      height: 120,
                      width: 400,
                      child: Card(
                        elevation: 15,
                        child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(left: 0, top: 0),
                                    child: Row(
                                      children: <Widget>[
                                        info("Purchase",transactions[index].date),
                                        spent(transactions[index].amount.toString())
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                        ]),
                        ),
                      ),
                    );
                },
              ),
            ),
            balance(),
          ]
        )
      )
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }


  getbalance(String token) async{
    
    http.Response response;
    try{
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/getbalance"),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive',
          'Authorization': 'Bearer $token',
        },
      );
    }
    catch(error){
      print(error);
    }
    
    if(response.statusCode==200){
      final jsonresponse= json.decode(response.body);
      mybalance=jsonresponse['balance'];
    }

  }


  Future give10(int page,String token) async {
    
    http.Response response;
    try{
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/seePurchases",{"strana": page.toString()}),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive',
          'Authorization': 'Bearer $token',
        },
      );
    }
    catch(error){
      print(error);
    }
    
    
    if (response.statusCode==200){
      final jsonResponse = json.decode(response.body);
      TransactionList t = TransactionList.fromJson(jsonResponse);
      setState(() {
        for(final transaction in t.transactions){
          transactions.add(transaction);
        }
      });
    }
    else if(response.statusCode==204){

    }
    else{
      throw Exception('fail');
    }
    
  }
}

class TransactionList {
  final List<Transaction> transactions;

  TransactionList({
    this.transactions,
  });

  factory TransactionList.fromJson(List<dynamic> parsedJson) {

    List<Transaction> transactions = new List<Transaction>();
    transactions = parsedJson.map((i)=>Transaction.fromJson(i)).toList();

    return new TransactionList(
      transactions: transactions,
    );
  }

}
class Transaction {
  final double amount;
  final String title;
  final String date;


  Transaction({this.amount, this.title, this.date});

  factory Transaction.fromJson(Map<String, dynamic> json) {

    return new Transaction(
      amount: json['price'],
      title: json['title'],
      date: json['date'],
    );
  }

}