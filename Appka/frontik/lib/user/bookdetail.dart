import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class BookDetail extends StatefulWidget {
  BookDetail({Key key, this.title,this.author,this.image,this.about,this.token,@required this.bookid,@required this.price,@required this.rating}) : super(key: key);
  final int bookid;
  final String title;
  final String author;
  final String image;
  final String about;
  final String token;
  final double price;
  final double rating;
  
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {


   Widget stars(double r) {
    return Container(
      width: 150,
      height: 30,
      child: Align(
        alignment: Alignment.bottomCenter,
          child: RatingBar(
            itemSize: 30,
            initialRating: r,
            minRating: 1,
            ignoreGestures: true,
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
    
  Widget bookdetail2(double r){
    return Container(
      width: 180,
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
          stars(r),
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
          bookdetail2(widget.rating),
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

  
  

  List<Review> reviews = new List();
  ScrollController scrollController = new ScrollController();

  @override
  void initState(){
    super.initState();
    give10(1);
    scrollController.addListener((){
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        int tmp=1;
        if(reviews.length%10!=0){
          tmp=2;
        }
        int nextpage=(reviews.length/10-(reviews.length%10)/10 +tmp).toInt();
        give10(nextpage);
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
    
    Widget reviewcont(){
      return Container(
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          itemCount: reviews.length,
          itemBuilder: null
          )
      );
    }


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
              //reviewcont(),
            ],
          ),
        ),
      ),
    );
  }

  Future give10(int page) async {
    
    http.Response response;
    try{
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/getBookReviews",{"strana": page.toString(),"book_id": widget.bookid.toString()}),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive',
        },
      );
    }
    catch(error){
      print(error);

    }
    
    print(response.body);
    if (response.statusCode==200){
      final jsonResponse = json.decode(response.body);
      ReviewList r = ReviewList.fromJson(jsonResponse);
      setState(() {
        for(final review in r.reviews){
          reviews.add(review);
        }
      });
    }
    else if(response.statusCode==204){

    }
    else{
      throw Exception('fail');
    }
    
  }
}


class ReviewList {
  final List<Review> reviews;

  ReviewList({
    this.reviews,
  });

  factory ReviewList.fromJson(List<dynamic> parsedJson) {

    List<Review> reviews = new List<Review>();
    reviews = parsedJson.map((i)=>Review.fromJson(i)).toList();

    return new ReviewList(
      reviews: reviews,
    );
  }

}
class Review {
  final String user;
  final String rating;
  final String date;
  final String comment;


  Review({this.user, this.rating, this.date,this.comment});

  factory Review.fromJson(Map<String, dynamic> json) {

    return new Review(
      user: json['user'],
      rating: json['rating'],
      date: json['time'],
      comment: json['comment'],
    );
  }

}