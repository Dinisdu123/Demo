import 'package:assingment/Screens/Accesories.dart';
import 'package:assingment/Screens/FragrancesDetails.dart';
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
        ),
        body: SingleChildScrollView(
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 0.12,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network(
                        "https://i0.wp.com/scentson.lk/wp-content/uploads/2022/10/Versace-Eros-Eau-De-Toilette-100ml_9002f5d3-119a-4790-b581-158e1b0a2cf0_2000x-2-1-1.jpg?fit=900%2C900&ssl=1"),
                    Text("Versase perfume"),
                    Text("LKR 45000.00"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FragranceDetailScreen(
                                        imageUrl:
                                            "https://i0.wp.com/scentson.lk/wp-content/uploads/2022/10/Versace-Eros-Eau-De-Toilette-100ml_9002f5d3-119a-4790-b581-158e1b0a2cf0_2000x-2-1-1.jpg?fit=900%2C900&ssl=1",
                                        title: "Versase perfume",
                                        price: "LKR 45000.00",
                                        description:
                                            "A premium fragrance that blends luxury and elegance.",
                                      )));
                        },
                        child: Text("See more ->"))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network(
                        "https://thesensation.lk/wp-content/uploads/2022/12/GUCCI-GUILTY-LOVE-EDITION-W-EDP-50ML-e1670224374558.jpg"),
                    Text("Gucci Guilty "),
                    Text("LKR 38000.00"),
                    TextButton(onPressed: () {}, child: Text("See more ->")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network(
                        "https://assets.woolworthsstatic.co.za/Flora-Gorgeous-Orchid-Eau-de-Parfum-for-Women-30ml-509051338-detail.jpg?V=Viin&o=eyJidWNrZXQiOiJ3dy1vbmxpbmUtaW1hZ2UtcmVzaXplIiwia2V5IjoiaW1hZ2VzL2VsYXN0aWNlcmEvcHJvZHVjdHMvYWx0ZXJuYXRlLzIwMjQtMDktMzAvNTA5MDUxMzM4XzMwTUxfZGV0YWlsLmpwZyJ9&q=75"),
                    Text("Gucci Flora  Orchid"),
                    Text("LKR 60000.00"),
                    TextButton(onPressed: () {}, child: Text("See more ->")),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Footer());
  }
}
