import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/arkids/arkids_dorm_info.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/arkids/arkids_dorm_items.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/arkids/arkids_dorm_reviews.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/gumamela/gumamela_info.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/gumamela/gumamela_items.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/gumamela/gumamela_reviews.dart';

class gumamelaPage extends StatefulWidget {
  const gumamelaPage({super.key});

  @override
  State<gumamelaPage> createState() => _gumamelaPageState();
}

class _gumamelaPageState extends State<gumamelaPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text ('Balay Gumamela'),
        bottom: TabBar(tabs: [
          Tab(text: 'Info',),
          Tab(text: 'Facilities',),
          Tab(text: 'Reviews',),
        ]),),
        body: TabBarView(children: [
          gumamelaInfoPage(),
          gumamelaItemPage(),
          gumamelaReviewPage(),
        ],)
      ),
    );
  }
}