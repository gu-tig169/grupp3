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
        return ListTile(
          leading: Text('${restaurants[index].name}'),
        );
      },
    );
  }
}
