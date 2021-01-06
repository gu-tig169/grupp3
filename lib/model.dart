import 'package:flutter/material.dart';

import 'api.dart';

class Restaurant {
  String name;
  String address;

  var openNow;

  double rating;
  int userRatingsTotal;

  int priceLevel;

  Coordinates coordinates;

  Restaurant({
    @required this.name,
    this.address,
    this.openNow,
    this.rating,
    this.userRatingsTotal,
    this.priceLevel,
    this.coordinates,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'rating': rating,
      'userratingstotal': userRatingsTotal,
      'pricelevel': priceLevel,
      'lat': coordinates.lat,
      'lng': coordinates.lng,
    };
  }

  factory Restaurant.fromJson(Map<dynamic, dynamic> json) {
    bool open;
    if (json['opening_hours'] == null) {
      print('open == null. Setting to false');
      open = false;
    } else {
      open = json['opening_hours']['open_now'];
    }
    return Restaurant(
      name: json['name'],
      address: json['formatted_address'],
      openNow: open,
      rating: json['rating'].toDouble(),
      userRatingsTotal: json['user_ratings_total'],
      priceLevel: json['price_level'],
      coordinates: Coordinates(
        lat: json['geometry']['location']['lat'],
        lng: json['geometry']['location']['lng'],
      ),
    );
  }
}

class Coordinates {
  double lat;
  double lng;

  Coordinates({this.lat, this.lng});
}

class MyState extends ChangeNotifier {
  Coordinates _coordinates = Coordinates();
  List<Restaurant> _list = [];

  List<Restaurant> get list => _list;

  Coordinates get coordinates => _coordinates;

  Future<void> getCoordinates(String text) async {
    _coordinates = await Api.getCoordinates(text);
    //getRestaurantsFromApi();
  }

  void setCoordinates(Coordinates coordinates) {
    if (coordinates != null) {
      _coordinates = coordinates;
    }
  }

  Future<List<Restaurant>> getRestaurantsFromApi() async {
    List<Restaurant> list = await Api.getRestaurants(_coordinates);
    _list = list;
    return list;
  }

  List<Restaurant> getRestaurants() {
    return _list;
  }

  List<Restaurant> getFilteredList(
      List<Restaurant> list,
      RangeValues ratingRangeValues,
      RangeValues priceRangeValues,
      bool isOpen) {
    throw new UnimplementedError();
  }
}
