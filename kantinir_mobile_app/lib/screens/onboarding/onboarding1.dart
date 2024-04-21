import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/onboarding/onboarding2.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Onboarding2(),
            ),
          );
        },
        child: Center(
          child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(double.infinity),
            minScale: 0.1,
            maxScale: 5.0,
            child: Image.asset(
              'images/onboarding1.png', 
            ),
          ),
        ),
      ),
    );
  }
}
