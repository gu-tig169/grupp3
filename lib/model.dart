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
  List<Restaurant> _filterList = [];
  List<Restaurant> get list => _list;
  List<Restaurant> get filterList => _filterList;
  Coordinates get coordinates => _coordinates;

  RangeValues _ratingRangeValues;
  RangeValues _priceRangeValues;
  bool _isOpen;

  Future<void> getCoordinates(String text) async {
    _coordinates = await Api.getCoordinates(text);
    //getRestaurantsFromApi();
  }

  void setCoordinates(Coordinates coordinates) {
    if (coordinates != null) {
      _coordinates = coordinates;
    }
  }

  void setList(List<Restaurant> restaurants) {
    if (restaurants != null) {
      _list = restaurants;
    }
  }

  Future<List<Restaurant>> getRestaurantsFromApi() async {
    List<Restaurant> list = await Api.getRestaurants(_coordinates);

    resetFilterValues();

    _list = list;
    return list;
  }

  void setFilterValues(RangeValues ratingRangeValues,
      RangeValues priceRangeValues, bool isOpen) {
    _ratingRangeValues = ratingRangeValues;
    _priceRangeValues = priceRangeValues;
    _isOpen = isOpen;

    _filterList = getFilteredList();
    notifyListeners();
  }

  void resetFilterValues() {
    _ratingRangeValues = null;
    _priceRangeValues = null;
    _isOpen = false;
  }

  List<Restaurant> getFilteredList() {
    if (_priceRangeValues != null &&
        _ratingRangeValues != null &&
        _isOpen != null) {
      List<Restaurant> restaurants = _list;
      List<Restaurant> filteredList = [];
      for (int i = 0; i < restaurants.length; i++) {
        //Om restaurangen är inom rätt betyg och prisklass
        if (restaurants[i].rating >= _ratingRangeValues.start &&
            restaurants[i].rating <= _ratingRangeValues.end) {
          if (restaurants[i].priceLevel != null) {
            if (restaurants[i].priceLevel >= _priceRangeValues.start &&
                restaurants[i].priceLevel <= _priceRangeValues.end) {
              //Om användaren endast vill ha öppna restauranger
              if (_isOpen) {
                if (restaurants[i].openNow) {
                  filteredList.add(restaurants[i]);
                }
                //Returnera både stängda och öppna restauranger
              } else {
                filteredList.add(restaurants[i]);
              }
            }
          }
        }
      }
      return (filteredList);
    } else {
      return _list;
    }
  }
}