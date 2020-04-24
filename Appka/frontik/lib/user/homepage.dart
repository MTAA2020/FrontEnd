import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:frontik/user/category.dart';
import 'package:frontik/user/bookdetail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


 Container book(String nazov, String obrazok,String author){
    return Container(
      width: 120.0,
      height: 200.0,
      child: GestureDetector(
        onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookDetail(title: nazov,author: author,image:obrazok,about: "h")),
            );
          },
        child: SizedBox(
          width: 120,
          height: 200,
          child: Card(
            elevation: 10,
            color: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
              top: Radius.circular(20)
              ),
            ),
            child: new Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                  child: Image.network(
                      obrazok,
                      height: 160.0,
                      width: 140.0,
                  ),
                ),
                Expanded(
                child:  AutoSizeText(
                  nazov,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  minFontSize: 8.0,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0 ),
                )
                ),
              ],
            ),
          ),
        )
      )
    );
  }


   Container kategoria(String category){
    return Container(
      width: 140.0,
      height: 50.0,
      child: GestureDetector(
        onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCategory(category: category)),
            );
          },
        child: Card(
          elevation: 10,
          color: Colors.red[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
            top: Radius.circular(20)
            ),
          ),
          child: new Container(
                    padding: new EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          category,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0 ),
                        )
                      ],
                    ),
          )
        ),
      )
    );
  }

  List<Book> bestsellers = new List();
  List<Book> picks = new List();
  List<Book> topbooks = new List();
  ScrollController scrollController1 = new ScrollController();
  ScrollController scrollController2 = new ScrollController();
  ScrollController scrollController3 = new ScrollController();
  @override
  void initState(){
    super.initState();
    give5(1);
    give5(2);
    give5(3);
    scrollController1.addListener((){
      if(scrollController1.position.pixels==scrollController1.position.maxScrollExtent){
        give5(1);
      }
    }
    );
    scrollController2.addListener((){
      if(scrollController2.position.pixels==scrollController2.position.maxScrollExtent){
        give5(2);
      }
    }
    );
    scrollController3.addListener((){
      if(scrollController3.position.pixels==scrollController3.position.maxScrollExtent){
        give5(3);
      }
    }
    );
  }

   @override
  void dispose(){
    scrollController1.dispose();
    scrollController2.dispose();
    scrollController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    
    //Pick a Category

    Widget categoryscroll = new Container(
      margin: EdgeInsets.symmetric(vertical: 1.0,horizontal: 5.0),
      height: 48.0,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          kategoria("Thriller"),
          kategoria("Adventure"),
          kategoria("Sci-Fi"),
          kategoria("Entertainment")
        ],
      )
    );

    Widget categorylist = new Container(
      margin: EdgeInsets.symmetric(vertical: 7.0,horizontal: 5.0),
      height: 76.0,
      child: new Column(
        children: <Widget>[
          new Text("Pick a Category",
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0 ),
          ),
          categoryscroll,
        ],
      )
    );

    //Pick a Category//End


    //Bestsellers//Start

   Widget bestsellerscroll = new Container(
        margin: EdgeInsets.symmetric(vertical:1.0,horizontal: 5.0),
        height: 200.0,
        child: ListView.builder(
          controller: scrollController1,
          scrollDirection: Axis.horizontal,
          itemCount: bestsellers.length,
          itemBuilder: (BuildContext context,int index){
            int idcko=bestsellers[index].id;
            return Container(
              width: 120.0,
              height: 200.0,
              child: GestureDetector(
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookDetail(
                        title: bestsellers[index].title,
                        author: bestsellers[index].author,
                        image: 'http://10.0.2.2:5000/jpg?book_id=$idcko',
                        about: "h")),
                    );
                  },
                child: SizedBox(
                  width: 120,
                  height: 200,
                  child: Card(
                    elevation: 10,
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                      top: Radius.circular(20)
                      ),
                    ),
                    child: new Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                          child: Image.network(
                              'http://10.0.2.2:5000/jpg?book_id=$idcko',
                              height: 160.0,
                              width: 140.0,
                          ),
                        ),
                        Expanded( // Constrains AutoSizeText to the width of the Row
                        child:  AutoSizeText(
                          bestsellers[index].title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          minFontSize: 8.0,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0 ),
                        )
                        ),
                      ],
                    ),
                  ),
                )
              )
            );
          }
        ));

    Widget bestsellerlist = new Container(
      margin: EdgeInsets.symmetric(vertical: 7.0,horizontal: 5.0),
      height: 228.0,
      child: new Column(
        children: <Widget>[
          new Text("Bestsellers",
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0 ),
          ),
          bestsellerscroll,
        ],
      )
    );

    //Bestsellers/End
    

    //Picks//Start

    Widget picksforyouscroll = new Container(
    margin: EdgeInsets.symmetric(vertical:1.0,horizontal: 5.0),
    height: 200.0,
    child: ListView.builder(
          controller: scrollController2,
          scrollDirection: Axis.horizontal,
          itemCount: picks.length,
          itemBuilder: (BuildContext context,int index){
            int idcko=picks[index].id;
            return Container(
              width: 120.0,
              height: 200.0,
              child: GestureDetector(
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookDetail(
                        title: picks[index].title,
                        author: picks[index].author,
                        image: 'http://10.0.2.2:5000/jpg?book_id=$idcko',
                        about: "h")),
                    );
                  },
                child: SizedBox(
                  width: 120,
                  height: 200,
                  child: Card(
                    elevation: 10,
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                      top: Radius.circular(20)
                      ),
                    ),
                    child: new Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                          child: Image.network(
                              'http://10.0.2.2:5000/jpg?book_id=$idcko',
                              height: 160.0,
                              width: 140.0,
                          ),
                        ),
                        Expanded( // Constrains AutoSizeText to the width of the Row
                        child:  AutoSizeText(
                          picks[index].title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          minFontSize: 8.0,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0 ),
                        )
                        ),
                      ],
                    ),
                  ),
                )
              )
            );
          }
        )
    );

    Widget picksforyoulist = new Container(
      margin: EdgeInsets.symmetric(vertical: 7.0,horizontal: 5.0),
      height: 228.0,
      child: new Column(
        children: <Widget>[
          new Text("Picks For You",
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0 ),
          ),
          picksforyouscroll,
        ],
      )
    );
    
    //Picks//End


    //Toprated/Start

    Widget topratedscroll = new Container(
      margin: EdgeInsets.symmetric(vertical:1.0,horizontal: 5.0),
      height: 200.0,
      child: ListView.builder(
          controller: scrollController3,
          scrollDirection: Axis.horizontal,
          itemCount: topbooks.length,
          itemBuilder: (BuildContext context,int index){
            int idcko=topbooks[index].id;
            return Container(
              width: 120.0,
              height: 200.0,
              child: GestureDetector(
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookDetail(
                        title: topbooks[index].title,
                        author: topbooks[index].author,
                        image: 'http://10.0.2.2:5000/jpg?book_id=$idcko',
                        about: "h")),
                    );
                  },
                child: SizedBox(
                  width: 120,
                  height: 200,
                  child: Card(
                    elevation: 10,
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                      top: Radius.circular(20)
                      ),
                    ),
                    child: new Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                          child: Image.network(
                              'http://10.0.2.2:5000/jpg?book_id=$idcko',
                              height: 160.0,
                              width: 140.0,
                          ),
                        ),
                        Expanded( // Constrains AutoSizeText to the width of the Row
                        child:  AutoSizeText(
                          topbooks[index].title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          minFontSize: 8.0,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0 ),
                        )
                        ),
                      ],
                    ),
                  ),
                )
              )
            );
          }
        )
      );

    Widget topratedlist = new Container(
      margin: EdgeInsets.symmetric(vertical: 7.0,horizontal: 5.0),
      height: 228.0,
      child: new Column(
        children: <Widget>[
          new Text("Top Rated",
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0 ),
          ),
          topratedscroll,
        ],
      )
    );

    //Toprated//End

    
    return new Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(
        leading: IconButton(
        icon: Icon(Icons.power_settings_new, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
        ), 
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Read It!',
            style: TextStyle(fontFamily: 'EmilysCandy',fontSize: 30),
          ),
        ),
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.search), 
          onPressed: (){})
        ],
        centerTitle: true,
      ),
      
      body: new Center(
        child: new Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              categorylist,
              bestsellerlist,
              picksforyoulist,
              topratedlist
            ],
          ),
        ),
      ), 
    );
  }


  Future give5(int type) async {
    
    http.Response response;
    try{
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/getBooks"),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive'
        },
      );
    }
    catch(error){
      print(error);

    }
    
    if (response.statusCode==200){
      final jsonResponse = json.decode(response.body);
      BookList b = BookList.fromJson(jsonResponse);
      setState(() {
        for(final book in b.books){
          if (type==1){
            bestsellers.add(book);
          }
          else if(type==2){
            picks.add(book);
          }
          else if(type==3){
            topbooks.add(book);
          }
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


class BookList {
  final List<Book> books;

  BookList({
    this.books,
  });

  factory BookList.fromJson(List<dynamic> parsedJson) {

    List<Book> books = new List<Book>();
    books = parsedJson.map((i)=>Book.fromJson(i)).toList();

    return new BookList(
      books: books,
    );
  }

}

class Book {
  final int id;
  final String author;
  final String title;
  final String published;
  final double rating;
  final double price;
  final List<dynamic> genres;
  final String about;

  Book({this.id,this.author, this.title, this.published,this.rating,this.price,this.genres,this.about});

  factory Book.fromJson(Map<String, dynamic> json) {

    return new Book(
      id: json['id'],
      author: json['author'],
      title: json['title'],
      published: json['published'],
      rating: json['rating'],
      price: json['price'],
      genres: json['genres'],
      about: json['about'],
    );
  }

}