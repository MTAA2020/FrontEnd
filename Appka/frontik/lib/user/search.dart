import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontik/user/bookdetail.dart';


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

class Search extends StatefulWidget {
  Search({Key key,this.token}) : super(key: key);

  final String token;
  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  final SearchBarController<Book> _searchBarController = SearchBarController();


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

  Widget stars() {
    return Container(
      width: 200,
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


  Container info(String title,String author) {
    return Container(
      width: 200,
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






  Future<List<Book>> getbooks(String text) async {

    http.Response response;
    try{
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/searchbook",{"hladanie": text}),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive',
        },
      );
    }
    catch(error){
      print(error);
    }
    
    List<Book> books = new List();

    if (response.statusCode==200){
      final jsonResponse = json.decode(response.body);
      BookList b = BookList.fromJson(jsonResponse);
        for(final book in b.books){
          books.add(book);
          print(book.title);
        }
      
      return books;
    }
    else if(response.statusCode==204){
      return [];
    }
    else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Read It!',
            style: TextStyle(fontFamily: 'EmilysCandy',fontSize: 30),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SearchBar<Book>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: getbooks,
          searchBarController: _searchBarController,
          placeHolder: Text("Type something to search"),
          cancellationWidget: Text("Cancel"),
          emptyWidget: Text("No results"),
          crossAxisCount: 1,
          onItemFound: (Book book, int index) {
            int idcko=book.id;
            return Container(
                  padding: EdgeInsets.fromLTRB(10,5,10,0),
                  height: 180,
                  width: 360,
                  child: GestureDetector(
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookDetail(
                            title: book.title,
                            author: book.author,
                            image: "http://10.0.2.2:5000/jpg?book_id=$idcko",
                            about: book.about,
                            bookid: book.id,
                            price: book.price,
                            rating: book.rating,
                            token: widget.token,
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
                                      info(book.title,book.author)
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
          },
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}