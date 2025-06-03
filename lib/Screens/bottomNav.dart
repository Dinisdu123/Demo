import 'package:assingment/Screens/Profile.dart';
import 'package:assingment/Screens/Shop.dart';
import 'package:assingment/Screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:assingment/Screens/HomePage.dart';

class Footer extends StatefulWidget {
  final int currentIndex; // Add a parameter to receive the current index

  const Footer({super.key, required this.currentIndex});

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: widget.currentIndex, // Set the current index
      onDestinationSelected: (index) {
        // Prevent unnecessary navigation if already on the same page
        if (index != widget.currentIndex) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Search()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Cart()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyProfile()),
            );
          }
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
