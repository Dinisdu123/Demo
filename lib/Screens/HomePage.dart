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
            children: [const MainImg(), const NewArrivals()],
          ),
        ));
  }
}

class MainImg extends StatelessWidget {
  const MainImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset(
        'lib/Images/home page cover.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}

class NewArrivals extends StatelessWidget {
  const NewArrivals({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New Arrivals",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Image.network(
                "https://cdn-images.farfetch-contents.com/24/04/79/66/24047966_54414891_1000.jpg",
                height: 140,
                width: 140,
              ),
              SizedBox(width: 8),
              Text("This is 2"),
              SizedBox(width: 8),
              Text("This is 3"),
            ],
          ),
        ],
      ),
    );
  }
}
