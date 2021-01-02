import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grupp3/restaurantInfoView.dart';

import 'DatabaseHandler.dart';
import 'FavouriteView.dart';
import 'model.dart';

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;

  RestaurantList(this.restaurants);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return Container(
          child: Card(
            child: new InkWell(
              onTap: () {
                print("tapped ${restaurants[index].name}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RestaurantInfoView(restaurants[index].name, restaurants[index].address, restaurants[index].rating, restaurants[index].priceLevel, restaurants[index].coordinates)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text('${restaurants[index].name}'),
                      subtitle: Text('${restaurants[index].address}'),
                      trailing: IconButton(
                        icon: Icon(Icons.star),
                        onPressed: () {
                          FavouriteViewState.addToList(Restaurant(
                              name: "${restaurants[index].name}",
                              address: "${restaurants[index].address}",
                              rating: restaurants[index].rating,
                              userRatingsTotal:
                                  restaurants[index].userRatingsTotal,
                              priceLevel: restaurants[index].priceLevel,
                              coordinates: Coordinates(
                                lat: restaurants[index].coordinates.lat,
                                lng: restaurants[index].coordinates.lng,
                              )));
                          DatabaseHandler.insertRestaurant(Restaurant(
                              name: "${restaurants[index].name}",
                              address: "${restaurants[index].address}",
                              rating: restaurants[index].rating,
                              userRatingsTotal:
                                  restaurants[index].userRatingsTotal,
                              priceLevel: restaurants[index].priceLevel,
                              coordinates: Coordinates(
                                lat: restaurants[index].coordinates.lat,
                                lng: restaurants[index].coordinates.lng,
                              )));
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RatingBarIndicator(
                          rating:
                              convertToDouble(restaurants[index].priceLevel),
                          itemBuilder: (context, index) => Icon(
                            Icons.attach_money,
                            color: Colors.black,
                          ),
                          itemCount: 4,
                          itemSize: 25.0,
                          direction: Axis.horizontal,
                        ),
                        RatingBarIndicator(
                          rating: restaurants[index].rating,
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
      },
    );
  }

  static double convertToDouble(var rating) {
    if (rating != null) {
      return rating.toDouble();
    } else {
      return 0;
    }
  }
}
