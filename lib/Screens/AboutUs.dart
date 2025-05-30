import 'package:flutter/material.dart';
import 'package:assingment/Screens/bottomNav.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 122),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "About us",
                style: TextStyle(
                    fontFamily: "serif",
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Welcome to Aurora Luxe, where luxury meets timeless elegance. We are a premier destination for those who appreciate the finer things in life, offering a curated selection of exquisite goods crafted to perfection.At Aurora Luxe, we believe luxury is more than just a product—it’s an experience that evokes emotion and celebrates individuality. Our collection is a testament to unparalleled craftsmanship, meticulous attention to detail, and a passion for artistry.",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Our Story",
                style: TextStyle(
                    fontFamily: "serif",
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "Founded with a passion for sophistication and excellence, Aurora Luxe was born out of a desire to bring exceptional artistry and design to discerning clients. Our journey began with a simple belief: luxury is not just a product, it’s an experience.",
                    textAlign: TextAlign.center,
                  )),
              Text(
                "Our vision",
                style: TextStyle(
                    fontFamily: "Serif",
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Text(
                  "We aim to redefine luxury by blending tradition with innovation. Every piece in our collection is a celebration of craftsmanship, attention to detail, and unparalleled quality. We strive to inspire and delight our clients by creating products that are as unique as they are timeless.",
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Why to choose us",
                style: TextStyle(
                    fontFamily: "serif",
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
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
                style: TextStyle(
                    fontFamily: "Serif",
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Sustainability and ethical practices are at the heart of what we do. We are dedicated to creating luxury goods that not only enhance your lifestyle but also respect our planet and its people. Experience the epitome of elegance and discover the world of Aurora Luxe, where luxury knows no bounds.",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: Footer(),
    );
  }
}
