import 'package:assingment/Screens/Accesories.dart';
import 'package:assingment/Screens/HomePage.dart';
import 'package:assingment/Screens/LeatherGoods.dart';
import 'package:assingment/Screens/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:assingment/Screens/AboutUs.dart';

class Fragrances extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text("Fragrances"),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
        )
      ],
    ));

    // );
  }
}
