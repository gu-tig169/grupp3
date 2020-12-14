import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;

  RestaurantList(this.restaurants);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        //return ListTile(
        //leading: Text('${restaurants[index].name}'),
        return Container(
          height: 150,
          child: Card(
            child: new InkWell(
              onTap: () {
                print("tapped ${restaurants[index].name}");
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.restaurant),
                    title: Text('${restaurants[index].name}'),
                    subtitle: Text('${restaurants[index].address}'),
                  ),
                ],
              ),
            ),
          ),
        );
        //);
      },
    );
  }
}
