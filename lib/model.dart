import 'package:flutter/material.dart';

class Restaurant {
  String name;
  String address;

  bool openNow;

  double rating;
  int userRatingsTotal;

  double priceLevel;

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
}

class Coordinates {
  double lat;
  double lng;

  Coordinates({this.lat, this.lng});
}
