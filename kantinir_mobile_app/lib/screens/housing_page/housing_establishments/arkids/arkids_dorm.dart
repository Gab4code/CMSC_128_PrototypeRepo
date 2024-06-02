import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/arkids/arkids_dorm_info.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/arkids/arkids_dorm_items.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/arkids/arkids_dorm_reviews.dart';

class arkidsDormPage extends StatefulWidget {
  const arkidsDormPage({super.key});

  @override
  State<arkidsDormPage> createState() => _arkidsDormPageState();
}

class _arkidsDormPageState extends State<arkidsDormPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text ('Arkids Dorm'),
        bottom: TabBar(tabs: [
          Tab(text: 'Info',),
          Tab(text: 'Facilities',),
          Tab(text: 'Reviews',),
        ]),),
        body: TabBarView(children: [
          arkidsDormInfoPage(),
          arkidsDormItemPage(),
          arkidsDormReviewsPage(),
        ],)
      ),
    );
  }
}