import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

import 'RestaurantList.dart';
import 'model.dart';

class RestaurantInfoView extends StatelessWidget { // TODO lägga till zomma in/ut knapp?
  RestaurantInfoView(this.restaurantname, this.address, this.rating, this.priceLevel, this.coordinates);
  final String restaurantname;
  final String address;
  final double rating;
  final int priceLevel;
  final Coordinates coordinates;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantname),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StaticMap(
              maptype: StaticMapType.roadmap,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              scaleToDevicePixelRatio: true,
              googleApiKey: "AIzaSyA2KWPNbD48wwqc9HAuyr9B90dviKoFMbs",
              markers: <Marker>[
                Marker(
                  color: Colors.red,
                  locations: [
                    Location(coordinates.lat, coordinates.lng),
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.restaurant),
                    title: Text('$restaurantname'),
                    subtitle: Text('$address'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RatingBarIndicator(
                        rating: RestaurantList.convertToDouble(priceLevel),
                        itemBuilder: (context, index) => Icon(
                          Icons.attach_money,
                          color: Colors.black,
                        ),
                        itemCount: 4,
                        itemSize: 25.0,
                        direction: Axis.horizontal,
                      ),
                      RatingBarIndicator(
                        rating: rating,
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
        ],
      ),
    );
  }
}
