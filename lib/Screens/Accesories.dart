import 'package:flutter/material.dart';
import 'package:assingment/main.dart';
import 'package:assingment/Screens/AboutUs.dart';
import 'package:assingment/Screens/Fragrances.dart';
import 'package:assingment/Screens/HomePage.dart';
import 'package:assingment/Screens/LeatherGoods.dart';
import 'package:assingment/Screens/Footer.dart';
import 'package:assingment/Screens/Accesories.dart';

class Accesories extends StatelessWidget {
  const Accesories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aurora Luxe"),
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
              // leading: Icon(Icons.home),
              title: Text("Home"),
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
              title: Text("Leather goods"),
              hoverColor: Colors.grey,
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LeatherGoods()));
              },
            ),
            ListTile(
              title: Text("Fragrances"),
              hoverColor: Colors.grey,
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Fragrances()));
              },
            ),
            ListTile(
              title: Text("Accessories"),
              hoverColor: Colors.grey,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("About Us"),
              hoverColor: Colors.grey,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Aboutus()));
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              hoverColor: Colors.grey,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
