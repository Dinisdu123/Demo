import 'package:assingment/Screens/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:assingment/Screens/AboutUs.dart';
import 'package:assingment/Screens/Fragrances.dart';
import 'package:assingment/Screens/HomePage.dart';
import 'package:assingment/Screens/LeatherGoods.dart';

class Accesories extends StatelessWidget {
  const Accesories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accessories"),
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
