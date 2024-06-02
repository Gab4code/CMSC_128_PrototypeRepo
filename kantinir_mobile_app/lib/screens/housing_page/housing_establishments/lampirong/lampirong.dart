import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/lampirong/lampirong_info.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/lampirong/lampirong_items.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/lampirong/lampirong_reviews.dart';

class lampirongPage extends StatefulWidget {
  const lampirongPage({super.key});

  @override
  State<lampirongPage> createState() => _lampirongPageState();
}

class _lampirongPageState extends State<lampirongPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text ('Balay Lampirong (Holwan)'),
        bottom: TabBar(tabs: [
          Tab(text: 'Info',),
          Tab(text: 'Facilities',),
          Tab(text: 'Reviews',),
        ]),),
        body: TabBarView(children: [
          lampirongInfoPage(),
          lampirongItemPage(),
          lampirongReviewsPage(),
        ],)
      ),
    );
  }
}