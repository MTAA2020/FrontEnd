import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Container kniha(String nazov, String obrazok){
    return Container(
      width: 120.0,
      height: 200.0,
      child: Card(
        child: Wrap(children: <Widget>[
          Image.network(obrazok),
          ListTile(
            title: Text(nazov)
            
            ),
          
        ]),
      ),
    );
  }


  Container kategoria(String nazov){
    return Container(
      width: 140.0,
      height: 50.0,
      child: Card(
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
    );
  }


  @override
  Widget build(BuildContext context) {
    
    Widget categorylist = new Container(
      margin: EdgeInsets.symmetric(vertical: 30.0,horizontal: 5.0),
      height: 50.0,
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


    Widget bestsellerlist = new Container(
        margin: EdgeInsets.symmetric(vertical:10.0,horizontal: 5.0),
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
    margin: EdgeInsets.symmetric(vertical:10.0,horizontal: 5.0),
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
      margin: EdgeInsets.symmetric(vertical:10.0,horizontal: 5.0),
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

    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}