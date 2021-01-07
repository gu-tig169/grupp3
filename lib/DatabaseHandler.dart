import 'dart:async';
import 'package:grupp3/FavouriteView.dart';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class DatabaseHandler {
  static Database db;

  static void connectToDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'favourites_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE favourites(name TEXT PRIMARYKEY, address TEXT PRIMARYKEY, rating DOUBLE, userratingstotal INTEGER, pricelevel INTEGER, lat DOUBLE, lng DOUBLE)",
        );
      },
      version: 1,
    );
    db = await database;
    getFavouritelistFromDatabase();
  }

  static Future<void> insertRestaurant(Restaurant restaurant) async {
    await db.insert(
      'favourites',
      restaurant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> getFavouritelistFromDatabase() async {
    final List<Map<String, dynamic>> maps = await db.query('favourites');

    FavouriteViewState.favouritelist = List.generate(
      maps.length,
      (i) {
        return Restaurant(
            name: maps[i]['name'],
            address: maps[i]['address'],
            rating: maps[i]['rating'],
            userRatingsTotal: maps[i]['userratingstotal'],
            priceLevel: maps[i]['pricelevel'],
            coordinates: Coordinates(
              lat: maps[i]['lat'],
              lng: maps[i]['lng'],
            ));
      },
    );
  }

  static Future<void> deleteRestaurantFromDatabase(
      String name, String address) async {
    await db.delete('favourites',
        where: "name = ? AND address = ?", whereArgs: [name, address]);
  }
}
