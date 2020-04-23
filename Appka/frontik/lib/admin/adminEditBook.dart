import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontik/user/bookdetail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

class EditBook extends StatefulWidget {
  EditBook({Key key, this.category}) : super(key: key);

  final String category;
  
  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {



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

  Widget image(String image){
    //Uint8List bytes=getcover(id.toString());
    return Container(
      width: 120,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.network(
        image,
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
              MaterialPageRoute(builder: (context) => BookDetail(title: title,author: author,image: obrazok)),
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
    give10();
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
              int idcko=books[index].id;
              return Container(
                padding: EdgeInsets.fromLTRB(10,5,10,0),
                height: 180,
                width: 360,
                child: GestureDetector(
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookDetail(title: books[index].title,author: books[index].author,image: "http://10.0.2.2:5000/jpg?book_id=$idcko",about: "hello",)),
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
                                    image('http://10.0.2.2:5000/jpg?book_id=$idcko'),
                                    info(books[index].title,books[index].author)
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
          )
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future give10() async {
    
    http.Response response;
    try{
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/getBookCategory",{"strana": "1" ,"kategoria": widget.category}),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive'
        },
      );
    }
    catch(error){
      print(error);

    }

    final jsonResponse = json.decode(response.body);
    BookList b = BookList.fromJson(jsonResponse);
    
    if (response.statusCode==200){
      setState(() {
        for(final book in b.books){
          books.add(book);
          print(book.title);
        }
      });
    }
    else{
      throw Exception('fail');
    }
    
  }

  Future getcover(String id) async{

    http.Response response;
    try{
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/jpg",{"book_id": id}),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive'
        },
      );
    }
    catch(error){
      print(error);

    }
    return response.body;
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