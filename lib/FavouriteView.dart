
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grupp3/restaurantInfoView.dart';

import 'DatabaseHandler.dart';
import 'model.dart';
import 'RestaurantList.dart';

class FavouriteView extends StatefulWidget {
  State<StatefulWidget> createState() {
    return FavouriteViewState();
  }
}

class FavouriteViewState extends State<FavouriteView> {
  static List<Restaurant> favouritelist = [];

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: favouritelist.map((restaurant) {
      return _restaurant(context, restaurant);
    }).toList());
  }

  Widget _restaurant(context, restaurant) {
    return Container(
      child: Card(
        child: new InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RestaurantInfoView(
                      restaurant.name,
                      restaurant.address,
                      restaurant.rating,
                      restaurant.priceLevel,
                      restaurant.coordinates)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.restaurant),
                  title: Text('${restaurant.name}'),
                  subtitle: Text('${restaurant.address}'),
                  trailing: IconButton(
                    icon: Icon(Icons.star, color: Colors.amber),
                    onPressed: () async {
                      DatabaseHandler.deleteRestaurantFromDatabase(
                          restaurant.name);
                      await DatabaseHandler.getFavouritelistFromDatabase();
                      setState(() {});
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RatingBarIndicator(
                      rating:
                          RestaurantList.convertToDouble(restaurant.priceLevel),
                      itemBuilder: (context, index) => Icon(
                        Icons.attach_money,
                        color: Colors.black,
                      ),
                      itemCount: 4,
                      itemSize: 25.0,
                      direction: Axis.horizontal,
                    ),
                    RatingBarIndicator(
                      rating: restaurant.rating,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 25.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void addToList(Restaurant restaurant) {
    FavouriteViewState.favouritelist.add(restaurant);
  }

  static bool restaurantIsInList(String name) {
    String restaurantname = name;
    bool restaurantexists = false;
    for (int i = 0; i < favouritelist.length; i++) {
      if (favouritelist[i].name == restaurantname) {
        restaurantexists = true;
      }
    }
    return restaurantexists;
  }
}
