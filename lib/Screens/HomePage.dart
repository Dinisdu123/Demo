import 'package:flutter/material.dart';

class MainImg extends StatelessWidget {
  const MainImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Image.asset(
        'lib/Images/home page cover.jpg',
      ),
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
          Text("New Arrivals"),
          Row(
            children: [
              Image.network(
                "https://cdn-images.farfetch-contents.com/24/04/79/66/24047966_54414891_1000.jpg",
                height: 100,
                width: 100,
              ),
              Image.network(
                "https://cdn-images.farfetch-contents.com/24/04/79/66/24047966_54414891_1000.jpg",
                height: 100,
                width: 100,
              ),
              Image.network(
                "https://cdn-images.farfetch-contents.com/24/04/79/66/24047966_54414891_1000.jpg",
                height: 100,
                width: 100,
              )
            ],
          )
        ],
      ),
    );
  }
}
