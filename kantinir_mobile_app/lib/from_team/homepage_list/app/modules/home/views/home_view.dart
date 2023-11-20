import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:coffee/app/modules/cart/views/cart_view.dart';
import 'package:coffee/app/modules/item_view/views/item_view_view.dart';
import 'package:coffee/app/modules/welcome/views/welcome_view.dart';
import 'package:coffee/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) => {controller.changeIndex(index)},
        physics: const NeverScrollableScrollPhysics(),
        children: [
          homeView(context),
          const ItemViewView(),
          const CartView(),
          const WelcomeView(),
        ],
      ),
    );
  }

  Widget homeView(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 40.0, 12.0, 12.0),
      child: ListView(
        children: [
          header(),
          const SizedBox(height: 10),
          const Align(
              alignment: Alignment.center,
              child: Text(
                "What are you looking for?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(height: 10),
          itemList(),
          const SizedBox(height: 10),
          promotionItem(context),
          const SizedBox(height: 10),
          popularList(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   controller.pageController.dispose();
  //   super.dispose();
  // }

  Widget header() {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('image/Ellipse 2.png'),
            const SizedBox(width: 10),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('image/information.png'),
            ],
          ),
        )
      ],
    );
  }

  Widget images(imageUrl, menuName) {
    return Column(
      children: [
        Container(
          width: 70.00,
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            imageUrl,
            height: 70.00,
          ),
        ),
        Text(
          menuName,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget itemList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        images('image/food.png', 'FOOD'),
        images('image/housing.png', 'HOUSING'),
      ],
    );
  }

  Widget promotion() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'RECOMMENDATIONS',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget promotionItem(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            promotion(),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: 110,
              width: 450,
              decoration: ShapeDecoration(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "on all orders above Rp.250.000",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget popularImage(imageUrl, popularName, popularPrice) {
    return GestureDetector(
      // onTap: () {
      //   Get.toNamed(Routes.ITEM_VIEW); // Navigate to item_view_view.dart
      // },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 155.00,
            padding: const EdgeInsets.all(10.0),
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.56, -0.83),
                end: Alignment(-0.56, 0.83),
                colors: [Color(0x11583732), Color(0x7C583732)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    imageUrl,
                    height: 75.00,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  popularName,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      popularPrice,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 70, 63, 0),
                        fontSize: 16,
                      ),
                    ),
                    const Icon(Icons.add_box),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget popularList() {
    return GestureDetector(
      onTap: () {
        controller.pageController.jumpToPage(1); // Navigate to home_view.dart
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                popularImage('image/ok.png', 'Creamy Latte', 'Rp. 40.000'),
                popularImage('image/3.png', 'Capuccino Latte', 'Rp. 50.000'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                popularImage('image/keju.png', 'Creamy Latte', 'Rp. 40.000'),
                popularImage('image/boba.png', 'Capuccino Latte', 'Rp. 50.000'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                popularImage(
                    'image/Capucino 1.png', 'Creamy Latte', 'Rp. 40.000'),
                popularImage('image/3.png', 'Capuccino Latte', 'Rp. 50.000'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                popularImage('image/3.png', 'Creamy Latte', 'Rp. 40.000'),
                popularImage('image/ok.png', 'Capuccino Latte', 'Rp. 50.000'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Obx(
      () => BottomNavyBar(
        selectedIndex: controller.currentIndex.value,
        onItemSelected: (index) {
          controller.changeIndex(index);
        },
        backgroundColor: Colors.brown,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: Colors.white, // Set the color for the selected item
            inactiveColor: Colors.grey, // Set the color for inactive items
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text('search'),
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.shopping_cart),
            title: const Text('cart'),
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.account_circle),
            title: const Text('user'),
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
