import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomeView.dart';
import 'model.dart';

void main() {
  var state = MyState();
  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
    );
  }
}
