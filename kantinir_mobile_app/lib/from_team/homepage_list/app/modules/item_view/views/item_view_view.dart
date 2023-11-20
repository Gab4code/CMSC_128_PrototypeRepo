import 'package:coffee/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/item_view_controller.dart';

class ItemViewView extends GetView<ItemViewController> {
  const ItemViewView({Key? key}) : super(key: key);

  get mainAxisAlignment => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      // backgroundColor: Colors.brown

      body: ListView(
        children: [
          itemImage(),
          const SizedBox(height: 10),
          itemDetails(),
          // const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget displayImage() {
    return SizedBox(
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          height: 300.00,
          'image/3.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget itemImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              width: 300,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(255, 199, 199, 199),
                    Color.fromARGB(0, 238, 238, 238),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          child: displayImage(),
        ),
      ],
    );
  }

  Widget itemDetails() {
    return Column(
      children: [
        Container(
          height: 480,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              ratingAndPrice(),
              const SizedBox(height: 25),
              productName(),
              const SizedBox(height: 15),
              description(),
              const SizedBox(height: 25),
              addOns(),
              const SizedBox(height: 25),
              addOnsList(),
              const SizedBox(height: 20),
              addToCart(),
            ],
          ),
        ),
      ],
    );
  }

  Widget rate() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: ShapeDecoration(
        color: Colors.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.star,
            color: Colors.orange,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            '4.5',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ratingAndPrice() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        rate(),
        Text(
          'Rp. 50.000',
          style: GoogleFonts.poppins(
            color: const Color(0xFFD8C61C),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }

  Widget productName() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Creamy Latte',
            style: GoogleFonts.poppins(
              color: const Color(0xFF583732),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 15),
              const Icon(Icons.remove_circle_outline_outlined),
              const SizedBox(width: 15),
              Text(
                '1',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF583732),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              const Icon(Icons.add_circle_outline_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget description() {
    return const Column(
      children: [
        Text(
            "Creamy Latte dapat mengatur\ntingkat kemanisan kopi sesuai selera",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xAF583732),
            )),
      ],
    );
  }

  Widget addOns() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add Ons',
            style: GoogleFonts.poppins(
              color: const Color(0xFF583732),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addIcon() {
    return const Icon(
      size: 35,
      Icons.add_box,
      color: Color(0xFF583732),
    );
  }

  Widget addOnsImage(imageUrl) {
    return Stack(
      children: [
        Container(
          height: 90.00,
          width: 90.00,
          padding: const EdgeInsets.all(10.0),
          decoration: ShapeDecoration(
            color: const Color(0xFFD9D9D9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            // Use a Stack to overlay the image and the icon
            children: [
              Align(
                alignment: Alignment
                    .center, // Align the image to the bottom right corner
                child: Image.asset(
                  imageUrl,
                  height: 60.00,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -4,
          right: -4,
          child: addIcon(),
        ),
      ],
    );
  }

  Widget addOnsList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        addOnsImage('image/B_Brown-Sugar.png'),
        addOnsImage('image/keju.png'),
        addOnsImage('image/boba.png'),
      ],
    );
  }

  Widget addToCart() {
    return GestureDetector(
      onTap: () {
        Get.find<HomeController>()
            .pageController
            .jumpToPage(2); // Navigate to home_view.dart
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        width: 300.00,
        decoration: ShapeDecoration(
          color: const Color(0xFF583732),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            Text(
              'Add to Cart',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
