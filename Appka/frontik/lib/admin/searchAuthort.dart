import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontik/admin/adminAddBook.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';

class AuthorList {
  final List<Author> authors;

  AuthorList({
    this.authors,
  });

  factory AuthorList.fromJson(List<dynamic> parsedJson) {
    List<Author> authors = new List<Author>();
    authors = parsedJson.map((i) => Author.fromJson(i)).toList();

    return new AuthorList(
      authors: authors,
    );
  }
}

class Author {
  final int id;
  final String author;
  final String about;
 

  Author(
      {this.id,
      this.author,
      this.about
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return new Author(
      id: json['id'],
      author: json['name'],
      about: json['about']
   
    );
  }
}

class SearchAuthor extends StatefulWidget {
  SearchAuthor({Key key, this.token}) : super(key: key);

  final String token;
  @override
  _Search createState() => _Search();
}

class _Search extends State<SearchAuthor> {
  final SearchBarController<Author> _searchBarController = SearchBarController();


  Future<List<Author>> getAuthor(String text) async {
    http.Response response;
    try {
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/searchauthor", {"hladanie": text}),
        headers: {
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
        },
      );
    } catch (error) {
      print(error);
    }

    List<Author> authors = new List();

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(response);
      print(jsonResponse);
      AuthorList b = AuthorList.fromJson(jsonResponse);
      for (final author in b.authors) {
        authors.add(author);
      }

      return authors;
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
        child: SearchBar<Author>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: getAuthor,
          searchBarController: _searchBarController,
          placeHolder: Text("Type something to search"),
          cancellationWidget: Text("Cancel"),
          emptyWidget: Text("No results"),
          crossAxisCount: 1,
          onItemFound: (Author author, int index) {

            int idcko=author.id;
            return Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                height: 180,
                width: 360,
                child: GestureDetector(
                  onTap: () {
                  Navigator.pop(context,author.author);
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
                                      info(author.author, author.about,author.id, index)
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

  Widget info(String name, String about,int id, int index) {
    return Container(
      width: 233,
      height: 160,
      child: new Column(
        children: <Widget>[
          tit(name),
          auth(about),
        ],
      ),
    );
  }

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

}
