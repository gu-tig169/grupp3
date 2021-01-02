import 'dart:convert';

import 'package:grupp3/model.dart';
import 'package:http/http.dart' as http;

const API_KEY = 'AIzaSyD7kiuiB-122EFPjUl4VRI8PW1aLtge3b0';
const API_GEOCODE_URL = 'https://maps.googleapis.com/maps/api/geocode/json';
const API_PLACES_URL =
    'https://maps.googleapis.com/maps/api/place/textsearch/json';

class Api {
  static Future<Coordinates> getCoordinates(String address) async {
    var response =
        await http.get('$API_GEOCODE_URL?address=$address&key=$API_KEY');

    var results = jsonDecode(response.body);
    var coordinates = results['results'][0]['geometry']['location'];
    print('api: $coordinates');
    return Coordinates(lat: coordinates['lat'], lng: coordinates['lng']);
    /* List<Coordinates> coordinateList =
        (results as List).map((e) => Coordinates.fromJson(e)).toList();
    return coordinateList; */
/*     return results.map<Coordinates>((data) {
      return Coordinates.fromJson(data);
    }).toList(); */
  }

  static Future<List<Restaurant>> getRestaurants(
      Coordinates coordinates) async {
    print('api: $coordinates');
    var lat = coordinates.lat;
    var lng = coordinates.lng;
    var response = await http.get(
        '$API_PLACES_URL?query=restaurant&location=$lat,$lng&radius=1000&key=$API_KEY');
    //print(response.body);
    var results = jsonDecode(response.body);
    print('resultat: $results');
    var test = results['results'];

    return test.map<Restaurant>((data) {
      return Restaurant.fromJson(data);
    }).toList();
  }
}