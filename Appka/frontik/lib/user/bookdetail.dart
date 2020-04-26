import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:frontik/user/pdfviewer.dart';



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
    String myreview ="";
    double myrating = 0;

   Widget stars(double r) {
    return Container(
      width: 180,
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
      width: 220,
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
                onPressed: () async {
                  if(widget.token==null){
                    showAlertDialog(context);
                  }
                  else{
                    var bought = await isbought();
                    if(bought['code']=="1"){
                      print("now youre reading the book");//Treba otvorit PDF
                      int idcko=widget.bookid;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PdfViewPage(
                          url: 'http://10.0.2.2:5000/pdf?book_id=$idcko',
                          )
                        ),
                      );
                    }
                    else if(bought['code']=="3"){
                      showAlertDialog2(context,widget.price);
                    }
                    else{

                    }
                  }
                },
                child: Text(mytext,
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
      width: 360,
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

  Widget stars2(){
    return Container(
      height: 54,
      width: 250,
      color: Colors.blueAccent,
      child: Align(
        alignment: Alignment.bottomCenter,
          child: RatingBar(
            itemSize: 43,
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.fromLTRB(1, 2, 1, 5),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              if(widget.token==null){
                showAlertDialog(context);
              }else{
                addreview(rating);
              }
            },
          )
        )
    );
  }
  Widget sendbutton(){
    return Container(
      height: 54,
      width: 143,
      color: Colors.white,
      padding: new EdgeInsets.all(5.0),
      child: new Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(0.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          onPressed: () {
            if(widget.token==null){
              showAlertDialog(context);
            }
            else{
              double tmp=0;
              addreview(tmp);
            }
          },
          child: Text("Send",
              textAlign: TextAlign.center,
            ),
        )
      ), 
    );
  }

  Widget comment(){
    return Container(
      height: 200,
      child: Card(
        color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: commentcontroller,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Write your review here"
              ),
            ),
            new Row(
              children: <Widget>[
                stars2(),
                sendbutton(),
              ]
            )
          ],
        )  
      )
    );
  }
  

  List<Review> reviews = new List();
  ScrollController scrollController = new ScrollController();
  final commentcontroller = TextEditingController();
  String mytext= "Read";
  TextEditingController myreviewcontroller = new TextEditingController();

  @override
  void initState(){
    super.initState();


    //getmyreview();


    //Reviews Section
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
              comment(),
              new Container(
                height: 400,
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: reviews.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 10.0, right: 8.0, top: 8.0, bottom: 8.0),
                      child:  Card(
                        child: ExpandablePanel(
                          header: Text('${reviews[index].user} rated it ${reviews[index].rating}'),
                          collapsed: Text(reviews[index].comment, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                          expanded: Text(reviews[index].comment, softWrap: true, ),
                        ),
                      )
                    );
                  },
                ),
              )
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

  Future addreview(double rating) async{
    http.Response response;
    try{
      response = await http.put(
        Uri.http('10.0.2.2:5000', "/addReview"),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive',
          'Authorization' : 'Bearer ${widget.token}'
        },
        body: json.encode(
          {
            'book_id': widget.bookid.toString(),
            'comment': commentcontroller.text,
            'rating' : rating.toString(),
          }
        )
      );
    }
    catch(error){
      print(error);
    }
    
    if (response.statusCode==200){
      reviews.clear();
      give10(1);
    }
    else{
      throw Exception('fail');
    }
  }

  getmyreview() async{
    http.Response response;
    try{
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/getmyReview",{'book_id': widget.bookid.toString()}),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive',
          'Authorization' : 'Bearer ${widget.token}'
        }
      );
    }
    catch(error){
      print(error);
    }
    
    if (response.statusCode==200){
      final jsonResponse = json.decode(response.body);
    }
    else{
      throw Exception('fail');
    }
  }

  buybook() async{
    http.Response response;
    try{
      response = await http.post(
        Uri.http('10.0.2.2:5000', "/purchase"),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive',
          'Authorization' : 'Bearer ${widget.token}'
        },
        body: json.encode(
          {
            'book_id': widget.bookid.toString(),
          }
        )
      );
    }
    catch(error){
      print(error);
    }
    
    if (response.statusCode==201){
      return json.decode(response.body);
    }
    else if(response.statusCode==406){
      return json.decode(response.body);
    }
    else{
      throw Exception('fail');
    }

  }

  isbought() async{
    http.Response response;
    try{
      response = await http.get(
        Uri.http('10.0.2.2:5000', "/isbought",{'book_id': widget.bookid.toString()}),
        headers: {
          'Content-Type' : 'application/json',
          'Connection' : 'keep-alive',
          'Authorization' : 'Bearer ${widget.token}'
        },
      );
    }
    catch(error){
      print(error);
    }

    final jsonresponse= json.decode(response.body);
    if (response.statusCode==200){
      return jsonresponse;
    }
    else{
      throw Exception('fail');
    }

  }



  showAlertDialog(BuildContext context) {

    Widget continueButton = FlatButton(
      child: new Text("OK",style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed:  () => Navigator.of(context).pop(),
    );

  // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: new Text("You must be logged in to perform this action",style: TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      actions: [
        continueButton
      ],
   );

  // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showAlertDialog2(BuildContext context,double price) {

    Widget cancelButton = FlatButton(
      child: new Text("No",style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed:  () => Navigator.of(context).pop(),
    );

    Widget continueButton = FlatButton(
      child: new Text("Yes",style: new TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      onPressed:  () async{
        var res=await buybook();
        if(res['code']=="1"){
          print("Readin");
        }
        else if(res['code']=="2"){
          print("No credit");
        }
        else if(res['code']=="3"){
          print("reading");
        }

      },
    );

  // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: new Text("You will be charged $price credits.  Do you wish to continue?",style: TextStyle(fontFamily: 'EmilyCandy', fontSize: 20)),
      actions: [
        cancelButton,
        continueButton
      ],
   );

  // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
  final double rating;
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