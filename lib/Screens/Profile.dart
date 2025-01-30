import 'package:assingment/Screens/AboutUs.dart';
import 'package:assingment/Screens/Login.dart';
import 'package:assingment/Screens/Wishlist.dart';
import 'package:assingment/Screens/bottomNav.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aurora Luxe"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: Text(
                "SIGN IN OR REGISTER",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ),
          Expanded(child: _AccountCateg())
        ],
      ),
      bottomNavigationBar: Footer(),
    );
  }
}

class _AccountCateg extends StatelessWidget {
  const _AccountCateg({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Orders
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            children: [
              Icon(Icons.shopping_bag_outlined),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  "Orders",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_outlined),
                color: Theme.of(context).iconTheme.color,
                iconSize: 24,
              ),
            ],
          ),
        ),

        // Wishlist
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            children: [
              Icon(Icons.favorite_border),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  "Wishlist",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WishList()));
                },
                icon: const Icon(Icons.arrow_forward_outlined),
                color: Theme.of(context).iconTheme.color,
                iconSize: 24,
              ),
            ],
          ),
        ),

        // Help
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            children: [
              Icon(Icons.help_outline),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  "Help",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_outlined),
                color: Theme.of(context).iconTheme.color,
                iconSize: 24,
              ),
            ],
          ),
        ),

        // About Us
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  "About Us",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Aboutus()));
                },
                icon: const Icon(Icons.arrow_forward_outlined),
                color: Theme.of(context).iconTheme.color,
                iconSize: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
