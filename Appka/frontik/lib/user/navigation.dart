import 'package:flutter/material.dart';
import 'package:frontik/user/homepage.dart';
import 'package:frontik/user/myprofile.dart';
import 'package:frontik/user/mybooks.dart';

class Navigation extends StatefulWidget {
  Navigation({Key key}) : super(key: key);

  
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

    Container loginbutton(){
      return Container(
      width: 200.0,
      height: 200.0,
      child: new RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: Icon(
          Icons.favorite,
          color: Colors.blue,
         ),
      onPressed: (){},
      ) 
    );
    }

  int _currentIndex = 0;
  void onItemTapped(int index) {
  setState(() {
    _currentIndex = index;
  });
  }

  final List<Widget> _children = [
    MyHomePage(),
    MyBooks(),
    MyProfile()
 ];

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.red,
        notchMargin: 4,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onItemTapped,
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("My Books")),    //Icons.library_books //Icons.layers
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text("My Profile")), 
          ]),
        ),
        body: _children[_currentIndex]
    );
  }
}