import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';
import 'RestaurantList.dart';

class RestaurantListView extends StatelessWidget {
  final restaurantList = List<Restaurant>.generate(
    100,
    (i) => Restaurant(
      name: "Restaurant $i",
      address: "Address $i",
      rating: (100 - i) / 20,
      priceLevel: (100 - i) / 25,
    ),
  );
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('resultat'),
      ),
      body: Column(
        children: [
          FilterWidget(),
          Expanded(
            child: RestaurantList(restaurantList),
          ),
        ],
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  FilterWidget({Key key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<FilterWidget> {
  RangeValues _ratingFilterValues = const RangeValues(0, 5);
  RangeValues _priceFilterValues = const RangeValues(0, 4);
  bool _isChecked = false;
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Rating'),
        RangeSlider(
          values: _ratingFilterValues,
          min: 0,
          max: 5,
          divisions: 5,
          labels: RangeLabels(
            _ratingFilterValues.start.round().toString(),
            _ratingFilterValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _ratingFilterValues = values;
            });
          },
        ),
        Text('Price'),
        RangeSlider(
          values: _priceFilterValues,
          min: 0,
          max: 4,
          divisions: 4,
          labels: RangeLabels(
            _priceFilterValues.start.round().toString(),
            _priceFilterValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _priceFilterValues = values;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Is Open'),
          value: _isChecked,
          onChanged: (bool value) {
            setState(() {
              _isChecked = value;
            });
          },
        ),
      ],
    );
  }
}
