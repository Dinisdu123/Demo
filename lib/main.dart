import 'package:assingment/Screens/AboutUs.dart';
import 'package:assingment/Screens/Fragrances.dart';
import 'package:assingment/Screens/HomePage.dart';
import 'package:assingment/Screens/LeatherGoods.dart';
import 'package:assingment/Screens/bottomNav.dart';
import 'package:assingment/Screens/accesories.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(useMaterial3: true, scaffoldBackgroundColor: Colors.white),
      home: MyHomePage(),
    );
  }
}

