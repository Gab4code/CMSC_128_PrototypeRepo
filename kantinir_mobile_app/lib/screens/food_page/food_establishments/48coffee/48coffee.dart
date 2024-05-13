import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/48coffee/48coffee_info.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/48coffee/48coffee_menu.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/48coffee/48coffee_reviews.dart';

class coffee48Page extends StatefulWidget {
  const coffee48Page({super.key});

  @override
  State<coffee48Page> createState() => _coffee48PageState();
}

class _coffee48PageState extends State<coffee48Page> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text ('48 Coffee.Co Miagao'),
        bottom: TabBar(tabs: [
          Tab(text: 'Info',),
          Tab(text: 'Menu',),
          Tab(text: 'Reviews',),
        ]),),
        body: TabBarView(children: [
          coffee48InfoPage(),
          coffee48MenuPage(),
          coffee48ReviewPage(),
        ],)
      ),
    );
  }
}