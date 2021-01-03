import 'package:flutter/material.dart';
import 'package:grupp3/RestaurantListView.dart';

class TextView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TextViewState();
  }
}

class TextViewState extends State<TextView> {
  final myController = TextEditingController();
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.grey,
      //   title: Text(''),
      // ),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RestaurantListView()),
              );
            },
            icon: Icon(Icons.search),
            label: Text(
              "Sök",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
