import 'package:flutter/material.dart';
import 'package:assingment/main.dart';

class LeatherGoods extends StatelessWidget {
  const LeatherGoods({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("Home"),
            hoverColor: Colors.grey,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
            },
          ),
          ListTile(
            title: Text("Leather goods"),
            hoverColor: Colors.grey,
            onTap: () {},
          ),
          ListTile(
              title: Text("Fragrances"), hoverColor: Colors.grey, onTap: () {}),
          ListTile(
            title: Text("Accessories"),
            hoverColor: Colors.grey,
            onTap: () {},
          ),
          ListTile(
            title: Text("About Us"),
            hoverColor: Colors.grey,
            onTap: () {},
          )
        ],
      ),
    );
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Text("Aurora Luxe"),
    //     ),
    //     body: Text("This is Leather goods"),
    //   );
    // }
  }
  
}

