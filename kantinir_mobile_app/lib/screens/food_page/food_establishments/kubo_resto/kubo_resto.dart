import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/kubo_resto/kubo_resto_info.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/kubo_resto/kubo_resto_menu.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/kubo_resto/kubo_resto_reviews.dart';

class kuboRestoPage extends StatefulWidget {
  const kuboRestoPage({super.key});

  @override
  State<kuboRestoPage> createState() => _kuboRestoPageState();
}

class _kuboRestoPageState extends State<kuboRestoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text ('Kubo Resto'),
        bottom: TabBar(tabs: [
          Tab(text: 'Info',),
          Tab(text: 'Menu',),
          Tab(text: 'Reviews',),
        ]),),
        body: TabBarView(children: [
          kuboRestoInfoPage(),
          kuboRestoMenuPage(),
          kuboRestoReviewPage(),
        ],)
      ),
    );
  }
}