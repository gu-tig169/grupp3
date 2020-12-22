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
                title: Text('Hitta restaurang'),
                centerTitle: true,
                backgroundColor: Colors.blue,
                elevation: 0,
                bottom: TabBar(
                    unselectedLabelColor: Colors.white,
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
                          child: Text("KARTA"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("SÖK"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("FAVORITER"),
                        ),
                      ),
                    ]),
              ),
              body: TabBarView(children: [
                SetLocationView(),
                TextView(),
                FavouriteView(),
              ]),
            )));
  }
}
