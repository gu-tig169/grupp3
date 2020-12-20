import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                      trailing: IconButton(icon: Icon( Icons.star),onPressed:() {

                      },),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RatingBarIndicator(
                          rating: restaurants[index].priceLevel,
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
}
