import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';
import 'RestaurantList.dart';

class RestaurantListView extends StatefulWidget {
  RestaurantListView({Key key}) : super(key: key);

  @override
  _RestaurantListViewState createState() => _RestaurantListViewState();
}

class _RestaurantListViewState extends State<RestaurantListView> {
  bool _showFilter = false;
  Widget build(BuildContext context) {
    List<Restaurant> restaurantList =
        Provider.of<MyState>(context, listen: false).getRestaurants();
    return Scaffold(
      appBar: AppBar(
        title: Text('resultat'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                _showFilter = !_showFilter;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            child: FilterWidget(),
            visible: _showFilter,
          ),
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
