import 'package:assingment/main.dart';
import 'package:flutter/material.dart';
import 'package:assingment/Screens/AboutUs.dart';
import 'package:assingment/Screens/Footer.dart';

class LeatherGoods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Leather Goods"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Home"),
              hoverColor: Colors.grey,
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(
                              title: "Aurora Luxe",
                            )));
              },
            ),
            ListTile(
              title: const Text("Leather goods"),
              hoverColor: Colors.grey,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Fragrances"),
              hoverColor: Colors.grey,
              onTap: () {},
            ),
            ListTile(
              title: const Text("Accessories"),
              hoverColor: Colors.grey,
              onTap: () {},
            ),
            ListTile(
              title: const Text("About Us"),
              hoverColor: Colors.grey,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Aboutus())); // Assuming you have AboutUs implemented
              },
            ),
          ],
        ),
      ),
    );
  }
}
