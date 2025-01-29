import 'package:assingment/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:assingment/Screens/AboutUs.dart';
import 'package:assingment/Screens/Fragrances.dart';
import 'package:assingment/Screens/bottomNav.dart';

class LeatherGoods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leather Goods"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          )
        ],
      ),
      body: Footer(),
    );
  }
}
