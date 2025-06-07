import 'package:flutter/material.dart';
import 'package:assingment/Screens/bottomNav.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Aurora Luxe",
          style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.white,
          child: Column(
            children: [MainImg(), NewArrivals()],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(currentIndex: 0),
    );
  }
}

class MainImg extends StatelessWidget {
  const MainImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Image.asset('lib/Images/home page cover.jpg', fit: BoxFit.cover),
    );
  }
}

class NewArrivals extends StatelessWidget {
  const NewArrivals({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "New Arrivals",
            style: TextStyle(fontFamily: 'Robot', fontSize: 24),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/home-1.jpg",
                height: 100,
                width: 100,
              ),
              Image.asset(
                "assets/images/home-2.jpeg",
                height: 100,
                width: 100,
              ),
              Image.asset(
                "assets/images/home-3.jpg",
                height: 100,
                width: 100,
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Experience The luxury",
            style: TextStyle(fontFamily: "roboto", fontSize: 20),
          ),
          SizedBox(
            height: 28,
          ),
          Text(
            "Luxury is more than a statement—it’s a way of life. Indulge in the finest craftsmanship, where every detail tells a story of sophistication and elegance. From rare finds to timeless treasures, embrace the extraordinary and elevate your lifestyle with unmatched exclusivity",
            style: TextStyle(
              height: 2,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
