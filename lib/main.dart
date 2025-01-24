import 'package:assingment/Screens/AboutUs.dart';
import 'package:assingment/Screens/HomePage.dart';
import 'package:assingment/Screens/LeatherGoods.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 250, 243, 243)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Aurora Luxe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              )
            ]),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                // leading: Icon(Icons.home),
                title: Text("Home"),
                hoverColor: Colors.grey,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Leather goods"),
                hoverColor: Colors.grey,
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LeatherGoods()));
                },
              ),
              ListTile(
                title: Text("Fragrances"),
                hoverColor: Colors.grey,
                onTap: () {},
              ),
              ListTile(
                title: Text("Accessories"),
                hoverColor: Colors.grey,
                onTap: () {},
              ),
              ListTile(
                title: Text("About Us"),
                hoverColor: Colors.grey,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Aboutus()));
                },
              )
            ],
          ),
        ),
        body: Column(
          children: [MainImg(), NewArrivals(),],
        ));
  }
}
