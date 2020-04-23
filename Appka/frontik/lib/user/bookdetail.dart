import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';


class BookDetail extends StatefulWidget {
  BookDetail({Key key, this.title,this.author,this.image,this.about}) : super(key: key);

  final String title;
  final String author;
  final String image;
  final String about;
  
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {


   Widget stars() {
    return Container(
      width: 150,
      height: 30,
      child: Align(
        alignment: Alignment.bottomCenter,
          child: RatingBar(
            itemSize: 30,
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

  Widget bookdetail1(String image){
    return Container(
      width: 160,
      height: 300,
      child: new Column(
        children: <Widget>[
          Container(
            width:155,
            alignment: Alignment.bottomLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Image.network(
                  widget.image,
                  width: 150,
              ),
            ),
          ),
          Container(

          ),
        ]
      )
    );
  }
    
  Widget bookdetail2(){
    return Container(
      width: 230,
      height: 250,
      child: new Column(
        children: <Widget>[
          Container(
            height:90,
              child:  AutoSizeText(
                widget.title,
                maxLines: 3,
                textAlign: TextAlign.center,
                minFontSize: 8.0,
                style: TextStyle(fontFamily: 'PermanentMarker', fontSize: 30.0 , color: Colors.white),
              )
          ),
          Container(
            height:60,
            child:  AutoSizeText(
                widget.author,
                maxLines: 2,
                textAlign: TextAlign.center,
                minFontSize: 8.0,
                style: TextStyle(fontFamily: 'PermanentMarker', fontSize: 30.0 , color: Colors.black),
              )
          ),
          stars(),
          Container(
            width: 170,
            padding: new EdgeInsets.all(5.0),
            child: new Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(50.0),
              color: Color(0xff01A0C7),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                onPressed: () {
                  
                },
                child: Text("Buy",
                    textAlign: TextAlign.center,
                  ),
              )
            ), 
          ),
        ],
      ),
    );
  }

  Widget bookdetails() {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 330,
      height: 250,
      child: new Row(
        children: <Widget>[
          bookdetail1(widget.image),
          bookdetail2(),
        ],
      )
    );
  }
  Widget about() {
    return   ExpandablePanel(
      header: Text("About"),
      collapsed: Text(widget.about, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
      expanded: Text(widget.about, softWrap: true, ),
    );
  }

  
  Widget reviews(){
    return Container(
      
    );
  }
  

  @override
  Widget build(BuildContext context) {
    print(widget.title);
    print(widget.author);
    return new Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: widget.title,
            style: TextStyle(fontFamily: 'PermanentMarker',fontSize: 20),
          ),
        ),
        centerTitle: true,
      ),
      body: new Center(
        child: new Container(
          padding: EdgeInsets.all(5.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              bookdetails(),
              about(),
              reviews(),
            ],
          ),
        ),
      ),
    );
  }
}