import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "About us",
            style: TextStyle(fontFamily: "serif", fontSize: 30),
          ),
          Text(
              "Welcome to Aurora Luxe, where luxury meets timeless elegance. We are a premier destination for those who appreciate the finer things in life, offering a curated selection of exquisite goods crafted to perfection.At Aurora Luxe, we believe luxury is more than just a product—it’s an experience that evokes emotion and celebrates individuality. Our collection is a testament to unparalleled craftsmanship, meticulous attention to detail, and a passion for artistry."),
          Text(
            "Our Story",
            style: TextStyle(fontFamily: "serif", fontSize: 30),
          ),
          Text(
              "Founded with a passion for sophistication and excellence, Aurora Luxe was born out of a desire to bring exceptional artistry and design to discerning clients. Our journey began with a simple belief: luxury is not just a product, it’s an experience."),
          Text(
            "Our vision",
            style: TextStyle(fontFamily: "Serif", fontSize: 30),
          ),
          Text(
              "We aim to redefine luxury by blending tradition with innovation. Every piece in our collection is a celebration of craftsmanship, attention to detail, and unparalleled quality. We strive to inspire and delight our clients by creating products that are as unique as they are timeless."),
          Text(
            "Why to choose us",
            style: TextStyle(fontFamily: "serif", fontSize: 30),
          ),
          Column(
            children: [
              Text("Exclusive design"),
              Text("Uncompromising Quality"),
              Text("Personalized Service")
            ],
          ),
          Text(
            "Our commitment",
            style: TextStyle(fontFamily: "Serif", fontSize: 30),
          ),
          Text(
              "Sustainability and ethical practices are at the heart of what we do. We are dedicated to creating luxury goods that not only enhance your lifestyle but also respect our planet and its people. Experience the epitome of elegance and discover the world of Aurora Luxe, where luxury knows no bounds.")
        ],
      ),
    );
  }
}
