import 'package:flutter/material.dart';
import 'FavouriteView.dart';
import 'TextView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FavouriteView(),
    );
  }
}
