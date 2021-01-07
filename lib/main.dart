import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DatabaseHandler.dart';
import 'HomeView.dart';
import 'model.dart';

void main() { //TODO fixa enhetligt språk/design
  var state = MyState();
  DatabaseHandler.connectToDatabase();
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
