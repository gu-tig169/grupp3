import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantListView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('resultat'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 50,
            child: Center(child: Text('ListItem #1')),
          ),
          Container(
            height: 50,
            child: Center(child: Text('ListItem #2')),
          ),
          Container(
            height: 50,
            child: Center(child: Text('ListItem #3')),
          ),
        ],
      ),
    );
  }
}
