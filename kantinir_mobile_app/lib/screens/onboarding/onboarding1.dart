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
          child: Image.asset(
            'images/onboarding1.png',
            fit: BoxFit
                .fill, // Use BoxFit.fill to stretch the image to fit the screen
          ),
        ),
      ),
    );
  }
}
