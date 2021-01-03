import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

class RestaurantInfoView extends StatelessWidget {
  static const String restaurantname = 'mcdonalds';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantname),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            print("click");
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
                    Location(57.70664641710256, 11.937165422493168),
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
                    subtitle: Text('$restaurantname'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RatingBarIndicator(
                        rating: 3,
                        itemBuilder: (context, index) => Icon(
                          Icons.attach_money,
                          color: Colors.black,
                        ),
                        itemCount: 4,
                        itemSize: 25.0,
                        direction: Axis.horizontal,
                      ),
                      RatingBarIndicator(
                        rating: 3,
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
