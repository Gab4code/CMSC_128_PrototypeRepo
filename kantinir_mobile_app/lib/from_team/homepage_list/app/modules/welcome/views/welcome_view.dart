import 'package:coffee/app/modules/welcome/controllers/welcome_controller.dart';
import 'package:coffee/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/controllers/home_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFF421E1E),
              Color.fromARGB(181, 121, 87, 69),
            ])),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            itemImage(),
            // const SizedBox(height: 1),
            welcomeText(),
            const SizedBox(height: 50),
            getStarted(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget itemImage() {
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: 300,
        height: 450,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
      Positioned(
        child: welcomeImage(),
      ),
    ]);
  }

  Widget welcomeImage() {
    return SizedBox(
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          height: 200.00,
          'image/biji 1.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget welcomeText() {
    return const Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "Enjoy\nYour Coffee",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget getStarted() {
    return GestureDetector(
      onTap: () {
        // Navigate back to the home page and reset the index
        Get.toNamed(Routes.HOME);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                width: 300,
                height: 75,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ],
          ),
          Positioned(
            child: getStartedText(),
          ),
        ],
      ),
    );
  }

  Widget getStartedText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Get Started',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF583732),
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }
}
