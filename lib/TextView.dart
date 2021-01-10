import 'package:flutter/material.dart';
import 'package:grupp3/model.dart';
import 'package:grupp3/RestaurantListView.dart';
import 'package:provider/provider.dart';

class TextView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TextViewState();
  }
}

class TextViewState extends State<TextView> {
  final myController = TextEditingController();
  Coordinates c;
  List<Restaurant> restaurants;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            _textField(myController),
            _addButton(myController, context),
          ],
        ),
      ),
    );
  }

  Widget _textField(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextField(
          controller: myController,
          decoration: InputDecoration(
              labelText: 'Skriv in vilken stad',
              labelStyle: TextStyle(color: Colors.grey, fontSize: 25)),
        ),
      ],
    );
  }

  Widget _addButton(myController, context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton.icon(
            color: Colors.blue,
            onPressed: () async {
              await Provider.of<MyState>(context, listen: false)
                  .getCoordinates(myController.text);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RestaurantListView()),
              );
            },
            icon: Icon(Icons.search, color: Colors.white),
            label: Text(
              "Sök",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
