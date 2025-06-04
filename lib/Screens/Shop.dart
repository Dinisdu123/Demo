import 'package:assingment/Screens/Fragrances.dart';
import 'package:assingment/Screens/LeatherGoods.dart';
import 'package:assingment/Screens/Accessories.dart';
import 'package:assingment/Screens/all_products.dart'; // Added import for AllProducts
import 'package:flutter/material.dart';
import 'package:assingment/Screens/bottomNav.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aurora Luxe"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Shop All
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Image.network(
                  'https://perfumesociety.org/wp-content/uploads/2024/09/handbag-sized-scents-2-1024x1024.jpg',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Shop All",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const AllProducts()),
                    // );
                  },
                  icon: const Icon(Icons.arrow_forward_rounded),
                  color: Theme.of(context).iconTheme.color,
                  iconSize: 24,
                ),
              ],
            ),
          ),

          // Leather Goods
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Image.network(
                  "https://assets.manufactum.de/p/208/208685/208685_01.jpg/wallet-square.jpg?profile=pdsmain_1500",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Leather Goods",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LeatherGoods()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_rounded),
                  color: Theme.of(context).iconTheme.color,
                  iconSize: 24,
                ),
              ],
            ),
          ),

          // Fragrances
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Image.network(
                  "https://nantucketperfumes.com/cdn/shop/files/orange_3.jpg?v=1730152398&width=1445",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Fragrances",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Fragrances()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_rounded),
                  color: Theme.of(context).iconTheme.color,
                  iconSize: 24,
                ),
              ],
            ),
          ),

          // Accessories
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Image.network(
                  "https://shanijacobi.com/cdn/shop/files/shay-earing-set-724297_1800x1800.jpg?v=1715204193",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Accessories",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Accessories()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_rounded),
                  color: Theme.of(context).iconTheme.color,
                  iconSize: 24,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(currentIndex: 1),
    );
  }
}
