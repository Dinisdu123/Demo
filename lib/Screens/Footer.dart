import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.favorite),
          Icon(Icons.person)
        ],
      ),
    );
  }
}
