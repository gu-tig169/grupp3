import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hitta Restaurang'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 50,
            width: 200,
            child: FlatButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.only(left: 50, right: 50),
                onPressed: () {},
                child: Text(
                  'Sök via karta',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
          ),
          Container(
            height: 50,
            width: 200,
            child: FlatButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {},
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  'Sök via text',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
          ),
          Container(
            height: 50,
            width: 200,
            child: FlatButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.only(left: 50, right: 50),
                onPressed: () {},
                child: Text(
                  'Sök bland dina favoriter',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
          )
        ],
      )),
    );
  }
}
