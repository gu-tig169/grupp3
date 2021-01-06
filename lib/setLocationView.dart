import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'RestaurantListView.dart';

class SetLocationView extends StatefulWidget {
  @override
  State<SetLocationView> createState() => SetLocationViewState();
}

class SetLocationViewState extends State<SetLocationView> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng currentCameraCoordinates;

  static final CameraPosition _startpos = CameraPosition(
    target: LatLng(59.467168594101345, 14.994096712241383),
    zoom: 5,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _startpos,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMove: (position) {
                currentCameraCoordinates = position.target;
              }),
          Center(
            child: Icon(Icons.adjust, color: Colors.red, size: 34),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _setLocation,
        label: Text('Sök restaurang!'),
        icon: Icon(Icons.adjust, color: Colors.red),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _setLocation() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RestaurantListView()),
    );
    print(currentCameraCoordinates);
  }
}
