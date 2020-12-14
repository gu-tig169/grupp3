import 'package:flutter/material.dart';
import 'package:restaurant_finder/setLocationView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Finder',
      home: SetLocationView(),
    );
  }
}


