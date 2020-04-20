import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontik/user/bookdetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyCategory extends StatefulWidget {
  MyCategory({Key key, this.category}) : super(key: key);

  final String category;
  
  @override
  _MyCategoryState createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {


  Widget tit(String title) {
    return Container(
      width: 240,
      height: 60,
      padding: new EdgeInsets.all(1.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: title,
          style: TextStyle(fontFamily: 'PermanentMarker',fontSize: 20,color: Colors.black),
        ),
      ),
    );
  }

  Widget auth(String auth) {
    return Container(
      width: 240,
      height: 60,
      padding: new EdgeInsets.all(1.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: auth,
          style: TextStyle(fontFamily: 'PermanentMarker',fontSize: 20,color: Colors.black),
        ),
      ),
    );
  }

  Widget stars() {
    return Container(
      width: 240,
      height: 40,
      child: Align(
        alignment: Alignment.bottomCenter,
          child: RatingBar(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          )
        )
    );
  }

  Widget info(String title,String author) {
    return Container(
      width: 240,
      height: 160,
      child: new Column(
        children: <Widget>[
          tit(title),
          auth(author),
          stars(),
        ],
      ),
    );
  }

  Widget image(String obrazok){
    return Container(
      width: 120,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.network(
        obrazok,
        height: 167.0,
        width: 113.0,
        ),
      )
    );
  }

  Container book(String title, String obrazok,String author){
    return Container(
      padding: EdgeInsets.fromLTRB(10,5,10,0),
      height: 180,
      width: 360,
      child: GestureDetector(
        onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookDetail(title: title,author: author)),
            );
          },
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
                          image(obrazok),
                          info(title,author)
                        ],
                      )
                  ),
                ],
              ),
            )
          ]),
          ),
        ),
      )
    );
  }


  List<Book> books = new List();
  
  void initState(){
    super.initState();
    fetch();
  }


  @override
  Widget build(BuildContext context) {

    
    return new Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(
        title: new Text(widget.category),
        centerTitle: true,
      ),
      body: new Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical:1.0,horizontal: 5.0),
          height: 600.0,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: books.length,
            itemBuilder: (BuildContext context,int index){
              book(books[index].title,"https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60","hello");
            }
          )
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  fetch() async {


    //Tu by sme mali pridat request ale pisal mi chybu ze connection refused

    //if (response.statusCode==200){
    //  setState(() {
    //    books.add(json.decode(response.body));
    //  });
    //}
   // else{
   //   throw Exception('fail');
   // }

  }
}

class Book {
  final String author;
  final String title;
  final String date;
  final Float rating;
  final Float price;
  final List<String> genres;

  Book({this.author, this.title, this.date,this.rating,this.price,this.genres});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      author: json['name'],
      title: json['title'],
      date: json['title'],
      rating: json['rating'],
      price: json['price'],
      genres: json['genres'],
    );
  }
}