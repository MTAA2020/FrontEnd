import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontik/admin/bookEditing.dart';
import 'package:frontik/user/bookdetail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class EditBook extends StatefulWidget {
  EditBook({Key key, this.token}) : super(key: key);
  final String token;
  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
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

  removeButton(int index) {
    return FlatButton(
      child: new Text("Remove",
          style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed: () {
        deleteBook(books[index].id,index);
      },
    );
  }

  editButton(int index) {
    return FlatButton(
      child: new Text("Edit",
          style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditingBook(
                  authorName: books[index].author,
                  bookTitle: books[index].title,
                  genres: books[index].genres,
                  price: books[index].price,
                  selectedDate: books[index].published,
                  id: books[index].id,token: widget.token)),
        
        );
      },
    );
  }

  Widget info(String title, String author, int index) {
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
              children: <Widget>[removeButton(index), editButton(index)],
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

  List<Book> books = new List();

  void initState() {
    super.initState();
    give10();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(
        title: new Text('PEPE'),
        centerTitle: true,
      ),
      body: new Center(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
            height: 600.0,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: books.length,
                itemBuilder: (BuildContext context, int index) {
                  int idcko = books[index].id;
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
                                      title: books[index].title,
                                      author: books[index].author,
                                      image:
                                          "http://127.0.0.1:5000/jpg?book_id=$idcko",
                                      about: "hello",
                                      bookid: books[index].id,
                                      price: books[index].price,
                                      rating: books[index].rating,
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
                                        padding: const EdgeInsets.only(
                                            left: 0, top: 0),
                                        child: Row(
                                          children: <Widget>[
                                            image(
                                                'http://127.0.0.1:5000/jpg?book_id=$idcko'),
                                            info(books[index].title,
                                                books[index].author, index)
                                          ],
                                        )),
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ),
                      ));
                })),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future deleteBook(int id,int index) async {
    setState(() {
      books.remove(index);
    });
    http.Response response;
    try {
      response =
          await http.delete(Uri.http('127.0.0.1:5000', "/bookDelete",{"book_id":"${id}"}), headers: {
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Authorization': 'Bearer ${widget.token}'
      },);
    } catch (error) {
      print(error);
    }
  }

  Future give10() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.http('127.0.0.1:5000', "/searchbook", {"hladanie": "ggg"}),
        headers: {
          'Content-Type': 'application/json',
          'Connection': 'keep-alive'
        },
      );
    } catch (error) {
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

  Future getcover(String id) async {
    http.Response response;
    try {
      response = await http.get(
        Uri.http('127.0.0.1:5000', "/jpg", {"book_id": id}),
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
