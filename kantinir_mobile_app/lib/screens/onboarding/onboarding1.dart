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
            'images/onboarding1.png', // Replace 'your_image_path_here' with the actual path to your image asset
            // Set the height as per your requirement
          ),
        ),
      ),
    );
  }
}
