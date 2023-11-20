import 'package:coffee/app/modules/cart/controllers/cart_controller.dart';
import 'package:coffee/app/modules/home/controllers/home_controller.dart';
import 'package:coffee/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 40.0, 12.0, 12.0),
        child: ListView(
          children: [
            header(),
            const SizedBox(height: 10),
            cartList(),
            const SizedBox(height: 10),
            orderInstructions(),
            const SizedBox(height: 10),
            textField(),
            const SizedBox(height: 10),
            totalAmount(),
            const SizedBox(height: 10),
            checkout(),
            const SizedBox(height: 10),
            backToMenu(),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '2 items in Cart',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFF583732),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget cartImages(imageUrl, menuName, menuPrice) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100.00,
            padding: const EdgeInsets.all(10.0),
            decoration: ShapeDecoration(
              color: const Color(0xFFD9D9D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Image.asset(
              imageUrl,
              height: 90.00,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuName,
                  style: const TextStyle(
                    color: Color(0xFF583732),
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      menuPrice,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFD8C61C),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                itemQuantity(),
              ],
            ),
          ),
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.close),
            color: Colors.red,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget cartList() {
    return Column(
      children: [
        cartImages('image/ok.png', 'Creamy Latte', 'Rp. 20.000'),
        cartImages('image/3.png', 'Capuccino Latte', 'Rp. 30.000'),
      ],
    );
  }

  Widget itemQuantity() {
    return Row(
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
    );
  }

  Widget orderInstructions() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Order Instructions',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF583732),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget textField() {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          // implement the text field
          child: TextField(
            minLines: 1,
            maxLines: null, // Set maxLines to null for auto-resizing
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Color(0xFF583732)),
              ),
              hintText: 'Enter your instructions',
            ),
          ),
        ),
      ),
    );
  }

  Widget totalAmount() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'Total: ',
          style: GoogleFonts.poppins(
            color: const Color(0xFF583732),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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

  Widget checkout() {
    return Container(
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
            'Checkout',
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
    );
  }

  Widget backToMenu() {
    return GestureDetector(
      onTap: () {
        // Navigate back to the home page and reset the index
        Get.find<HomeController>().pageController.jumpToPage(0);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Back to Menu',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF583732),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
