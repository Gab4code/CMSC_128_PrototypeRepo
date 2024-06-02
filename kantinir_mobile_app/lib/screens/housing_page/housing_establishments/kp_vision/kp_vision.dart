import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/kp_vision/kp_vision_info.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/kp_vision/kp_vision_items.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/kp_vision/kp_vision_reviews.dart';

class kpVisionPage extends StatefulWidget {
  const kpVisionPage({super.key});

  @override
  State<kpVisionPage> createState() => _kpVisionPageState();
}

class _kpVisionPageState extends State<kpVisionPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text ('KP Vison Boarding House'),
        bottom: TabBar(tabs: [
          Tab(text: 'Info',),
          Tab(text: 'Facilities',),
          Tab(text: 'Reviews',),
        ]),),
        body: TabBarView(children: [
          kpVisionInfoPage(),
          kpVisionItemPage(),
          kpVisionReviewPage(),
        ],)
      ),
    );
  }
}