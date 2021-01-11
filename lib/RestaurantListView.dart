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
  //Bool för att visa/gömma filterfunktionen
  bool _showFilter = false;
  //Lista där restaurangerna sparas
  //Får sitt värde i FutureBuilder
  Future<List<Restaurant>> restaurantList;

  void initState() {
    super.initState();
    //Hämta restauranger från API
    restaurantList =
        Provider.of<MyState>(context, listen: false).getRestaurantsFromApi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultat'),
        actions: [
          //IconButton för att visa/gömma filterfunktionen
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                //Ändra bool
                _showFilter = !_showFilter;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          //Visar/gömmer filterfunktionen baserat på "visable" variabeln
          Visibility(
            child: Column(
              children: [
                FilterWidget(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text("Filtrera"),
                )
              ],
            ),
            //Sätt "visable" till bool variablen som deklareras i början av klassen
            visible: _showFilter,
          ),
          //FutureBuilder väntar på svar från APIet och visar olika saker baserat på om den är klar eller inte
          FutureBuilder<List<Restaurant>>(
            //List<Restaurant> som returneras sparas i restaurantList
            future: restaurantList,
            builder: (BuildContext context,
                AsyncSnapshot<List<Restaurant>> snapshot) {
              //Om vi väntar på data visas en CircularProgressIndicator()
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
              //Om vi har data visas datan som returneras
              if (snapshot.hasData) {
                return Expanded(
                  child: RestaurantList(
                      Provider.of<MyState>(context, listen: false)
                          .getFilteredList()),
                );
              }
              //Om vi får ett felmeddelande visas felmeddelandet
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              //Om vi inte har någon data visas en text som säger "Ingen data"
              return Text('Ingen data');
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
  //Variabler för RangeSliders samt en bool för ta fram restauranger som är öppna
  RangeValues _ratingFilterValues = const RangeValues(0, 5);
  RangeValues _priceFilterValues = const RangeValues(0, 4);
  bool _isChecked = false;
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Betyg'),
        //RangeSlider från 0 till 5
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
            _ratingFilterValues = values;
            //Ändrar filteringsvärdena som ska användas
            //setFilterValues ligger i model.dart
            Provider.of<MyState>(context, listen: false).setFilterValues(
                _ratingFilterValues, _priceFilterValues, _isChecked);
            setState(() {});
          },
        ),
        Text('Prisklass'),
        //RangeSlider från 0 till 4
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
            _priceFilterValues = values;
            //Ändrar filteringsvärdena som ska användas
            //setFilterValues ligger i model.dart
            Provider.of<MyState>(context, listen: false).setFilterValues(
                _ratingFilterValues, _priceFilterValues, _isChecked);
            setState(() {});
          },
        ),
        //Bool för att filtrera mellan öppna restauranger
        CheckboxListTile(
          title: const Text('Öppet'),
          value: _isChecked,
          onChanged: (bool value) {
            _isChecked = value;
            //Ändrar filteringsvärdena som ska användas
            //setFilterValues ligger i model.dart
            Provider.of<MyState>(context, listen: false).setFilterValues(
                _ratingFilterValues, _priceFilterValues, _isChecked);
            setState(() {});
          },
        ),
      ],
    );
  }
}
