import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/mrj_chickenhouse/mrj_info.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/mrj_chickenhouse/mrj_menu.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/mrj_chickenhouse/mrj_review.dart';


class mrJChickenHouseCoffee extends StatefulWidget {
  const mrJChickenHouseCoffee({super.key});

  @override
  State<mrJChickenHouseCoffee> createState() => _mrJChickenHouseCoffeeState();
}

class _mrJChickenHouseCoffeeState extends State<mrJChickenHouseCoffee> {
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
          mrJChickenHouseCoffeeInfoPage(),
          mrJChickenHouseCoffeeMenuPage(),
          mrJChickenHouseCoffeeReviewPage(),
        ],)
      ),
    );
  }
}