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

  static final CameraPosition _lindholmen = CameraPosition(
    target: LatLng(57.70664641710256, 11.937165422493168),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.keyboard_backspace),
      //     onPressed: () {
      //       print("click");
      //     },
      //   ),
      // ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _lindholmen,
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
        label: Text('Set location!'),
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
    print(currentCameraCoordinates.latitude);
  }
}
