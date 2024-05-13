import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/aj_foodhub/aj_foodhub_info.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/aj_foodhub/aj_foodhub_menu.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/aj_foodhub/aj_foodhub_reviews.dart';


class ajFoodHubPage extends StatefulWidget {
  const ajFoodHubPage({super.key});

  @override
  State<ajFoodHubPage> createState() => _ajFoodHubPageState();
}

class _ajFoodHubPageState extends State<ajFoodHubPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text ('A & J Food Hub'),
        bottom: TabBar(tabs: [
          Tab(text: 'Info',),
          Tab(text: 'Menu',),
          Tab(text: 'Reviews',),
        ]),),
        body: TabBarView(children: [
          ajFoodHubInfoPage(),
          ajFoodHubMenuPage(),
          ajFoodHubReviewPage(),
        ],)
      ),
    );
  }
}