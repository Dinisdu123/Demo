import 'package:flutter/material.dart';
import 'package:assingment/main.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage(title: "Aurora Luxe")));
              },
              icon: Icon(Icons.home)),
          Icon(Icons.search),
          Icon(Icons.favorite),
          Icon(Icons.person)
        ],
      ),
    );
  }
}
