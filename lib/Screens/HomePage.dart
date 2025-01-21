import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Aurora Luxe"),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
          ],
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainImg(),
            ],
          ),
        ));
  }
}

class MainImg extends StatelessWidget {
  const MainImg({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
