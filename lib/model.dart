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
      'adress': address,
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

  List<Restaurant> getList() {
    return _list;
  }

  void setList(List<Restaurant> restaurants) {
    if (restaurants != null) {
      _list = restaurants;
    }
  }

  Future<List<Restaurant>> getRestaurantsFromApi() async {
    List<Restaurant> list = await Api.getRestaurants(_coordinates);
    _list = list;
    return list;
  }

  void getFilteredList(
      /*List<Restaurant> list,*/
      RangeValues ratingRangeValues,
      RangeValues priceRangeValues,
      bool isOpen) {
    List<Restaurant> restaurants = _list;
    List<Restaurant> filteredList = [];
    for (int i = 0; i < restaurants.length; i++) {
      //Om restaurangen är inom rätt betyg och prisklass
      if (restaurants[i].rating >= ratingRangeValues.start &&
          restaurants[i].rating <= ratingRangeValues.end) {
        if (restaurants[i].priceLevel != null) {
          if (restaurants[i].priceLevel >= priceRangeValues.start &&
              restaurants[i].priceLevel <= priceRangeValues.end) {
            //lägg till skit
            //Om användaren endast vill ha öppna restauranger
            if (isOpen) {
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
    _list = filteredList;
    notifyListeners();
//    throw new UnimplementedError();
  }
}
