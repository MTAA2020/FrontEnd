import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontik/user/bookdetail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyBooks extends StatefulWidget {
  MyBooks({Key key,this.token}) : super(key: key);

  final String token;
  
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {


  Widget tit(String title) {
    return Container(
      width: 200,
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
      width: 200,
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

  Widget stars(r) {
    return Container(
      width: 200,
      height: 40,
      child: Align(
        alignment: Alignment.bottomCenter,
          child: RatingBar(
            initialRating: r,
            minRating: 1,
            direction: Axis.horizontal,
            ignoreGestures: true,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
          )
        )
    );
  }

  Container info(String title,String author,double rating) {
    return Container(
      width: 200,
      height: 160,
      child: new Column(
        children: <Widget>[
          tit(title),
          auth(author),
          stars(rating),
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

  

  List<Book> books = new List();
  ScrollController scrollController = new ScrollController();

  @override
  void initState(){
    super.initState();
    give10(1,widget.token);
    scrollController.addListener((){
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        int tmp=1;
        if(books.length%10!=0){
          tmp=2;
        }
        int nextpage=(books.length/10-(books.length%10)/10 +tmp).toInt();
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

    Widget picksforyouscroll = new Container(
      margin: EdgeInsets.symmetric(vertical:1.0,horizontal: 5.0),
      height: 600.0,
      child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            itemCount: books.length,
            itemBuilder: (BuildContext context,int index){
              if(books.length==0){
                return Container(
                  child: Text(
                    "You have no books"
                  ),
                );
              }else{
                int idcko=books[index].id;
                return Container(
                  padding: EdgeInsets.fromLTRB(10,5,10,0),
                  height: 180,
                  width: 360,
                  child: GestureDetector(
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookDetail(
                            title: books[index].title,
                            author: books[index].author,
                            image: "http://10.0.2.2:5000/jpg?book_id=$idcko",
                            about: books[index].about,
                            bookid: books[index].id,
                            price: books[index].price,
                            rating: books[index].rating,
                            )
                          ),
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
                                      info(books[index].title,books[index].author,books[index].rating)
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
            }
          )
    );

    return new Scaffold(
      backgroundColor: Colors.grey,
      
      body: new Center(
        child: new Container(
          child: ListView(
            children: <Widget>[
              picksforyouscroll,
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
Future give10(int page,String token) async {
    
    http.Response response;
    try{
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/getMyBooks",{"strana": page.toString()}),
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
      BookList b = BookList.fromJson(jsonResponse);
      setState(() {
        for(final book in b.books){
          books.add(book);
        }
      });
    }
    else if(response.statusCode==204){

    }
    else{
      setState(() {
        
      });
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