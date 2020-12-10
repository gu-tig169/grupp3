import 'package:flutter/material.dart';

import 'RestaurantListView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Finder',
      //Ändra denna rad till den klass ni vill visa. Just nu visar den RestaurantListView.dart
      //Ni behöver inte pusha main.dart innan vi har länkat ihop allting
      home: RestaurantListView(),
    );
  }
}
