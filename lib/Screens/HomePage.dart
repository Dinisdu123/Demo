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
              Image.network(
                "https://www.ninetynine.lk/wp-content/uploads/2024/01/2111701866-939155881-min.jpg",
                height: 100,
                width: 100,
              ),
              Image.network(
                "https://www.chanel.com/images/w_0.51,h_0.51,c_crop/q_auto:good,f_auto,fl_lossy,dpr_1.1/w_1920/coco-mademoiselle-eau-de-parfum-intense-spray-3-4fl-oz--packshot-default-116660-9539148283934.jpg",
                height: 100,
                width: 100,
              ),
              Image.network(
                "https://cdn.cosmostore.org/cache/front/shop/products/568/1752562/350x350.jpg",
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
