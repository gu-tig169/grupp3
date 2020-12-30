import 'dart:convert';

import 'package:grupp3/model.dart';
import 'package:http/http.dart' as http;

const API_KEY = 'AIzaSyD7kiuiB-122EFPjUl4VRI8PW1aLtge3b0';
const API_GEOCODE_URL = 'https://maps.googleapis.com/maps/api/geocode/json';

class Api {
  static Future<Coordinates> getCoordinates(String address) async {
    var response =
        await http.get('$API_GEOCODE_URL?address=$address&key=$API_KEY');

    var results = jsonDecode(response.body);
    var coordinates = results['results'][0]['geometry']['location'];
    print(coordinates);
    return Coordinates(lat: coordinates['lat'], lng: coordinates['lng']);
  }
}
