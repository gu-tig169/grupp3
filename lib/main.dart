import 'package:flutter/material.dart';
import 'package:grupp3/RestaurantInfoView.dart';
import 'package:grupp3/setLocationView.dart';
import 'TextView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SetLocationView(),
    );
  }
}
