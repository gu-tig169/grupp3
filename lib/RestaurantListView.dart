import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';
import 'RestaurantList.dart';

class RestaurantListView extends StatefulWidget {
  // TODO lägga till så man ser vilka restauranger man redan har i favoriter?
  RestaurantListView({Key key}) : super(key: key);

  @override
  _RestaurantListViewState createState() => _RestaurantListViewState();
}

class _RestaurantListViewState extends State<RestaurantListView> {
  bool _showFilter = false;
  Widget build(BuildContext context) {
    Future<List<Restaurant>> restaurantList =
        Provider.of<MyState>(context, listen: false).getRestaurantsFromApi();
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
          FutureBuilder<List<Restaurant>>(
            future: restaurantList,
            builder: (BuildContext context,
                AsyncSnapshot<List<Restaurant>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasData) {
                return Expanded(
                  child: RestaurantList(snapshot.data),
                );
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Text('No data');
            },
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
  //TODO fixa så att filter fungerar
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
