import 'package:flutter/material.dart';

class FragranceDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String description;

  FragranceDetailScreen({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "robot"),
            ),
            SizedBox(height: 8),
            Text(price,
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.bodyMedium?.color)),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "robot",
                  color: Theme.of(context).textTheme.bodyMedium?.color),
            ),
          ],
        ),
      )),
    );
  }
}
