import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontik/user/beforelogin.dart';

class MyBooks extends StatefulWidget {
  MyBooks({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {


  Widget stars() {
    return Align(
      alignment: Alignment.bottomRight,
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
    );
  }

  Widget image(obrazok){
    return Align(
      alignment: Alignment.centerLeft,
      child: Image.network(
        obrazok,
        height: 167.0,
        width: 113.0,
      	),
    );
  }

  Container kniha(String title, String obrazok,String author){
    return Container(
      padding: EdgeInsets.fromLTRB(10,5,10,0),
      height: 180,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
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
                        Column(
                          children: <Widget>[
                            image(obrazok)
                          ],
                        ),
                      stars()
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


  @override
  Widget build(BuildContext context) {

    Widget picksforyouscroll = new Container(
    margin: EdgeInsets.symmetric(vertical:1.0,horizontal: 5.0),
    height: 500.0,
    child: new ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        kniha("Toto je kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60","author1"),
        kniha("Harry Potter a Kamen mudrcov", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60","author1"),
        kniha("Tretie kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60","author1"),
        kniha("Najlepsia kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60","author1")
      ],
    ));

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
}