import 'package:flutter/material.dart';
import 'package:grupp3/FavouriteView.dart';
import 'package:grupp3/TextView.dart';
import 'setLocationView.dart';

class HomeView extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Hitta Restaurang'),
                centerTitle: true,
                backgroundColor: Colors.blue,
                bottom: TabBar(
                    unselectedLabelColor: Colors.white70,
                    indicatorPadding: EdgeInsets.only(left: 30, right: 30),
                    indicator: ShapeDecoration(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(
                              color: Colors.white,
                            ))),
                    tabs: [
                      Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Karta"),
                          ),
                          icon: Icon(Icons.map)),
                      Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Sök"),
                          ),
                          icon: Icon(Icons.search)),
                      Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Favoriter"),
                          ),
                          icon: Icon(Icons.star))
                    ]),
              ),
              body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SetLocationView(),
                    TextView(),
                    FavouriteView(),
                  ]),
            )));
  }
}
