import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final VoidCallback? onPressed;

  const NavBar({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: 0,
      onItemSelected: (index) {
        onPressed;
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: const Icon(Icons.home), title: const Text('Home')),
        BottomNavyBarItem(
            icon: const Icon(Icons.search), title: const Text('search')),
        BottomNavyBarItem(
            icon: const Icon(Icons.shopping_cart), title: const Text('cart')),
        BottomNavyBarItem(
            icon: const Icon(Icons.account_circle), title: const Text('user')),
      ],
    );
  }
}
