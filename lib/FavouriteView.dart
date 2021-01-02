import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';
import 'RestaurantList.dart';

class FavouriteView extends StatelessWidget {
  final restaurantList = List<Restaurant>.generate(
    100,
    (i) => Restaurant(
      name: "Restaurant $i",
      address: "Address $i",
      rating: (100 - i) / 20,
      priceLevel: i,
    ),
  );
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('resultat'),
      // ),
      body: RestaurantList(restaurantList),
    );
  }
}
