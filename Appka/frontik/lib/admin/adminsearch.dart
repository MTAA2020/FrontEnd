import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontik/user/bookdetail.dart';
import 'package:flutter/rendering.dart';
import 'package:frontik/admin/bookEditing.dart';
import 'dart:async';

class BookList {
  final List<Book> books;

  BookList({
    this.books,
  });

  factory BookList.fromJson(List<dynamic> parsedJson) {
    List<Book> books = new List<Book>();
    books = parsedJson.map((i) => Book.fromJson(i)).toList();

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

  Book(
      {this.id,
      this.author,
      this.title,
      this.published,
      this.rating,
      this.price,
      this.genres,
      this.about});

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
  Search({Key key, this.token}) : super(key: key);

  final String token;
  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  final SearchBarController<Book> _searchBarController = SearchBarController();

  Widget tit(String title) {
    return Container(
      width: 233,
      height: 60,
      padding: new EdgeInsets.all(1.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: title,
          style: TextStyle(
              fontFamily: 'PermanentMarker', fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Widget auth(String auth) {
    return Container(
      width: 233,
      height: 60,
      padding: new EdgeInsets.all(1.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: auth,
          style: TextStyle(
              fontFamily: 'PermanentMarker', fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  removeButton(int index, Book book) {
    return FlatButton(
      child: new Text("Remove",
          style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed: () {
        deleteBook(book.id, index);
      },
    );
  }

  editButton(int index, Book book) {
    return FlatButton(
      child: new Text("Edit",
          style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed: () {_searchBarController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditingBook(
                  authorName: book.author,
                  bookTitle: book.title,
                  genres: book.genres,
                  price: book.price,
                  selectedDate: book.published,
                  id: book.id,
                  token: widget.token)),
        );
      },
    );
  }

  Widget info(String title, String author, int index, Book book) {
    return Container(
      width: 233,
      height: 160,
      child: new Column(
        children: <Widget>[
          tit(title),
          auth(author),
          Container(
            height: 40,
            child: new Row(
              children: <Widget>[
                editButton(index, book)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget image(String image) {
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
        ));
  }

  Future<List<Book>> getbooks(String text) async {
    http.Response response;
    try {
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/searchbook", {"hladanie": text}),
        headers: {
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
        },
      );
    } catch (error) {
      print(error);
    }

    List<Book> books = new List();

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      BookList b = BookList.fromJson(jsonResponse);
      for (final book in b.books) {
        books.add(book);
        print(book.title);
      }

      return books;
    } else if (response.statusCode == 204) {
      return [];
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Read It!',
            style: TextStyle(fontFamily: 'EmilysCandy', fontSize: 30),
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
            int idcko = book.id;
            return Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                height: 180,
                width: 360,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetail(
                                title: book.title,
                                author: book.author,
                                image:
                                    "http://10.0.2.2:5000/jpg?book_id=$idcko",
                                about: book.about,
                                bookid: book.id,
                                price: book.price,
                                rating: book.rating,
                                token: widget.token,
                              )),
                    );
                  },
                  child: Card(
                    elevation: 15,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, top: 0),
                                  child: Row(
                                    children: <Widget>[
                                      image(
                                          'http://10.0.2.2:5000/jpg?book_id=$idcko'),
                                      info(book.title, book.author, index, book)
                                    ],
                                  )),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  Future deleteBook(int id, int index) async {
    http.Response response;
    try {
      response = await http.delete(
        Uri.http('10.0.2.2:5000', "/bookDelete", {"book_id": "${id}"}),
        headers: {
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer ${widget.token}'
        },
      );
    } catch (error) {
      print(error);
    }
    if (response.statusCode == 200) {}
  }

  Future getcover(String id) async {
    http.Response response;
    try {
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/jpg", {"book_id": id}),
        headers: {
          'Content-Type': 'application/json',
          'Connection': 'keep-alive'
        },
      );
    } catch (error) {
      print(error);
    }
    return response.body;
  }
}
