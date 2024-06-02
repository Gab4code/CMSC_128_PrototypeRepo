import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/royal_angels/royal_angels_dorm_info.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/royal_angels/royal_angels_dorm_items.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/royal_angels/royal_angels_dorm_reviews.dart';

class royalAngelsPage extends StatefulWidget {
  const royalAngelsPage({super.key});

  @override
  State<royalAngelsPage> createState() => _royalAngelsPageState();
}

class _royalAngelsPageState extends State<royalAngelsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text ('Royal Angels Deluxe Dormtelle'),
        bottom: TabBar(tabs: [
          Tab(text: 'Info',),
          Tab(text: 'Facilities',),
          Tab(text: 'Reviews',),
        ]),),
        body: TabBarView(children: [
          royalAngelsInfoPage(),
          royalAngelsItemPage(),
          royalAngelsReviewsPage(),
        ],)
      ),
    );
  }
}