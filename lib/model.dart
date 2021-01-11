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

  //Skapa en restaurang från json-fil
  factory Restaurant.fromJson(Map<dynamic, dynamic> json) {
    bool open;
    //Om opening_hours inte har returnerats från APIet
    //Detta görs för att undvika felmeddelande om restaurang inte har någon opening_hours variabel
    if (json['opening_hours'] == null) {
      print('open == null. Setting to false');
      open = false;
    } else {
      open = json['opening_hours']['open_now'];
    }
    //Returnera en ny restaurang med värden från APIet
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

  RangeValues _ratingRangeValues;
  RangeValues _priceRangeValues;
  bool _isOpen;

  //Hämta koordinater från adress
  Future<void> getCoordinates(String address) async {
    _coordinates = await Api.getCoordinates(address);
  }

  //Spara koordinater i MyState om koordinater inte behöver hämtas från API
  void setCoordinates(Coordinates coordinates) {
    //Kolla så att koordinaterna inte sätts till null
    if (coordinates != null) {
      _coordinates = coordinates;
    }
  }

  Future<List<Restaurant>> getRestaurantsFromApi() async {
    //Hämta restauranger från API
    List<Restaurant> list = await Api.getRestaurants(_coordinates);

    //Återställ filtreringen då ny sökning görs
    resetFilterValues();

    //Sätt interna listan till listan som returneras av APIet
    _list = list;
    return list;
  }

  //Sätt filtreringsvärden till de värden som har valts
  void setFilterValues(RangeValues ratingRangeValues,
      RangeValues priceRangeValues, bool isOpen) {
    _ratingRangeValues = ratingRangeValues;
    _priceRangeValues = priceRangeValues;
    _isOpen = isOpen;
  }

  //Återställ filtreringsvärden
  void resetFilterValues() {
    _ratingRangeValues = null;
    _priceRangeValues = null;
    _isOpen = false;
  }

  //Hämta filtreringslitan
  List<Restaurant> getFilteredList() {
    //Om filtreringsvärden finns returneras en lista utifrån dessa filtreringsvärden
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
    }
    //Om filtreringsvärden inte finns returneras listan som kommer från APIet
    else {
      return _list;
    }
  }
}
