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
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/onboarding1.png'),
                fit: BoxFit
                    .cover, // Stretch the image to cover the entire container
              ),
            ),
          ),
        ),
      ),
    );
  }
}
