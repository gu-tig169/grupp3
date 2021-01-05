import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grupp3/restaurantInfoView.dart';

import 'DatabaseHandler.dart';
import 'FavouriteView.dart';
import 'model.dart';

class RestaurantList extends StatefulWidget {
  final List<Restaurant> restaurants;

  RestaurantList(this.restaurants);

  @override
  _RestaurantListState createState() => _RestaurantListState();

  static double convertToDouble(var rating) {
    if (rating != null) {
      return rating.toDouble();
    } else {
      return 0;
    }
  }
}

class _RestaurantListState extends State<RestaurantList> {
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.restaurants.length,
      itemBuilder: (context, index) {
        return Container(
          child: Card(
            child: new InkWell(
              onTap: () {
                print("tapped ${widget.restaurants[index].name}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RestaurantInfoView(
                          widget.restaurants[index].name,
                          widget.restaurants[index].address,
                          widget.restaurants[index].rating,
                          widget.restaurants[index].priceLevel,
                          widget.restaurants[index].coordinates)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text('${widget.restaurants[index].name}'),
                      subtitle: Text('${widget.restaurants[index].address}'),
                      trailing: IconButton(
                        icon: Icon(Icons.star),
                        onPressed: () async {
                          if (!FavouriteViewState.restaurantIsInList(
                              widget.restaurants[index].name)) {
                            FavouriteViewState.addToList(Restaurant(
                                name: "${widget.restaurants[index].name}",
                                address: "${widget.restaurants[index].address}",
                                rating: widget.restaurants[index].rating,
                                userRatingsTotal:
                                    widget.restaurants[index].userRatingsTotal,
                                priceLevel: widget.restaurants[index].priceLevel,
                                coordinates: Coordinates(
                                  lat: widget.restaurants[index].coordinates.lat,
                                  lng: widget.restaurants[index].coordinates.lng,
                                )));
                            DatabaseHandler.insertRestaurant(Restaurant(
                                name: "${widget.restaurants[index].name}",
                                address: "${widget.restaurants[index].address}",
                                rating: widget.restaurants[index].rating,
                                userRatingsTotal:
                                    widget.restaurants[index].userRatingsTotal,
                                priceLevel: widget.restaurants[index].priceLevel,
                                coordinates: Coordinates(
                                  lat: widget.restaurants[index].coordinates.lat,
                                  lng: widget.restaurants[index].coordinates.lng,
                                )));
                                setState(() {});
                          }
                          else {
                            DatabaseHandler.deleteRestaurantFromDatabase(
                            widget.restaurants[index].name);
                            await DatabaseHandler.getFavouritelistFromDatabase();                          
                            setState(() {});
                          }
                        },
                        color: FavouriteViewState.restaurantIsInList(
                                    widget.restaurants[index].name) ==
                                true
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RatingBarIndicator(
                          rating:
                              RestaurantList.convertToDouble(widget.restaurants[index].priceLevel),
                          itemBuilder: (context, index) => Icon(
                            Icons.attach_money,
                            color: Colors.black,
                          ),
                          itemCount: 4,
                          itemSize: 25.0,
                          direction: Axis.horizontal,
                        ),
                        RatingBarIndicator(
                          rating: widget.restaurants[index].rating,
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
}
