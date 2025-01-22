import 'package:assingment/Screens/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aurora Luxe',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 33, 163, 85)),
          useMaterial3: true,
        ),
        // home: const HomePage(title: 'Arura Luxe'),
        home: HomePage());
  }
}
