import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 5),
            _ratingInputField(),
            _mapInputField(),
            _textInputField(),
            Container(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _ratingInputField() {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        autocorrect: true,
        style: TextStyle(
          fontSize: 18.0,
        ),
        decoration: InputDecoration(hintText: 'Search by rating..'),
      ),
    );
  }
}

Widget _mapInputField() {
  return Container(
    padding: EdgeInsets.all(10.0),
    margin: EdgeInsets.only(left: 16, right: 16),
    child: TextField(
      autocorrect: true,
      style: TextStyle(
        fontSize: 18.0,
      ),
      decoration: InputDecoration(hintText: 'Search on map..'),
    ),
  );
}

Widget _textInputField() {
  return Container(
    padding: EdgeInsets.all(10.0),
    margin: EdgeInsets.only(left: 16, right: 16),
    child: TextField(
      autocorrect: true,
      style: TextStyle(
        fontSize: 18.0,
      ),
      decoration: InputDecoration(hintText: 'Search by text..'),
    ),
  );
}
