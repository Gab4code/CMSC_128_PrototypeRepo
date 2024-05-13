import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/elgaraje/el_garaje_info.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/elgaraje/el_garaje_menu.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/elgaraje/el_garaje_reviews.dart';

class elGarajePage extends StatefulWidget {
  const elGarajePage({super.key});

  @override
  State<elGarajePage> createState() => _elGarajePageState();
}

class _elGarajePageState extends State<elGarajePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text ('El Garaje'),
        bottom: TabBar(tabs: [
          Tab(text: 'Info',),
          Tab(text: 'Menu',),
          Tab(text: 'Reviews',),
        ]),),
        body: TabBarView(children: [
          elGarajeInfoPage(),
          elGarajeMenuPage(),
          elGarajeReviewPage(),
        ],)
      ),
    );
  }
}