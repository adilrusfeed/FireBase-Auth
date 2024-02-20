// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/controller/bottom_provider.dart';
import 'package:ecommerce/view/screens/cart_screen.dart';
import 'package:ecommerce/view/screens/home_screen.dart';
import 'package:ecommerce/view/screens/product%20screen/my_product.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BottomNavigation> {
  @override
  final List<Widget> _pages = [
    HomeScreen(),
    MyProductPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomBarProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 30, 41),
      body: _pages[bottomProvider.currentIndex],
      bottomNavigationBar: Container(
        child: NavigationBar(
          backgroundColor: Color.fromARGB(255, 18, 23, 31),
          selectedIndex: bottomProvider.currentIndex,
          onDestinationSelected: (index) {
            bottomProvider.navigatePage(index);
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home,
                  color: bottomProvider.currentIndex == 0
                      ? Colors.white
                      : const Color.fromARGB(255, 106, 105, 105)),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.my_library_add,
                  color: bottomProvider.currentIndex == 1
                      ? Colors.white
                      : const Color.fromARGB(255, 106, 105, 105)),
              label: 'items',
            ),
            NavigationDestination(
              icon: Icon(Icons.card_travel,
                  color: bottomProvider.currentIndex == 2
                      ? Colors.white
                      : const Color.fromARGB(255, 106, 105, 105)),
              label: 'Cart',
            ),
          ],
          indicatorColor: Colors.amber,
        ),
      ),
    );
  }
}
