import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:frontik/user/bookdetail.dart';
import 'package:frontik/user/loginpage.dart';
import 'package:frontik/user/category.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

    Container kniha(String nazov, String obrazok){
    return Container(
      width: 120.0,
      height: 200.0,
      child: GestureDetector(
        onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookDetail(title: nazov)),
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
                Expanded( // Constrains AutoSizeText to the width of the Row
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


  Container kategoria(String nazov){
    return Container(
      width: 140.0,
      height: 50.0,
      child: GestureDetector(
        onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCategory(title: nazov)),
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
                          nazov,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0 ),
                        )
                      ],
                    ),
          )
        ),
      )
    );
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
        child: new ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            kniha("Toto je kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
            kniha("Harry Potter a Kamen mudrcov jksndkjnkjdnjkdasnajs", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
            kniha("Tretie kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
            kniha("Najlepsia kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60")
          ],
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
    child: new ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        kniha("Toto je kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
        kniha("Harry Potter a Kamen mudrcov", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
        kniha("Tretie kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
        kniha("Najlepsia kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60")
      ],
    ));

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
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          kniha("Toto je kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
          kniha("Harry Potter a Kamen mudrcov", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
          kniha("Tretie kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
          kniha("Najlepsia kniha", "https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60")
        ],
      ));

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
        automaticallyImplyLeading: false,
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(5.0),
        
        child: RaisedButton(
          elevation: 8.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()), 
            );
          },
          color: Color(0xff3F6CE1),
          textColor: Colors.white,
          child: Text('Login'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(60),
            top: Radius.circular(60)
            ),
          ),
        ),
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
}