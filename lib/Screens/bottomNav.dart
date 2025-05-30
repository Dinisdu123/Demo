import 'package:assingment/Screens/Profile.dart';
import 'package:assingment/Screens/Shop.dart';
import 'package:assingment/Screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:assingment/Screens/HomePage.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Search()));
        } else if (index == 2) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (index == 3) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyProfile()));
        }
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.shop), label: 'Shop'),
        NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
