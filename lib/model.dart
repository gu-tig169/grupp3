import 'package:flutter/material.dart';

class Restaurant {
  String name;
  String address;

  bool openNow;

  int rating;
  int userRatingsTotal;

  int priceLevel;

  Restaurant({
    @required this.name,
    this.address,
    this.openNow,
    this.rating,
    this.userRatingsTotal,
    this.priceLevel,
  });
}
