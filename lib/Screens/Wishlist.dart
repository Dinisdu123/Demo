import 'package:flutter/material.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Aurora luxe"),
        ),
        body: ListView(children: [
          ListTile(
            leading: Image.network(
                "https://m.media-amazon.com/images/I/41czzc+YnKL._SL1081_.jpg",
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('Ferrari Black EDT'),
            subtitle: Text('LKR 9400.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://divo.dam.gogemini.io/64c22c7cb0f362ded215f877.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('Miu Miu mini Wander matelassé shoulder bag'),
            subtitle: Text('LKR 940000.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://cdn-images.farfetch-contents.com/23/87/06/31/23870631_53849445_1000.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('CHANEL Pre-Owned 1994 Duma backpack'),
            subtitle: Text('LKR 7664640.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTb53DaXCZRslwRvzSXupBmxDZ7YME4s7lQZw&s',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('Gucci Horsebit 1955 wallet-on-chain'),
            subtitle: Text('LKR 365000.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://cdna.lystit.com/1040/1300/n/photos/farfetch/30189d9f/gucci-red-105Mm-Guinevere-Pumps.jpeg',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('ucci 105mm Guinevere Sandals'),
            subtitle: Text('LKR 339000.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://i0.wp.com/scentson.lk/wp-content/uploads/2022/10/Versace-Eros-Eau-De-Toilette-100ml_9002f5d3-119a-4790-b581-158e1b0a2cf0_2000x-2-1-1.jpg?fit=900%2C900&ssl=1',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('Versace Eros EDT'),
            subtitle: Text('LKR 27300.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://exclusivelines.lk/wp-content/uploads/2023/03/ARMANI-CODE-PARFUM-1-1.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('Armani Code'),
            subtitle: Text('LKR 36900.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz4_Pw_cqxkGeiI5yyfgXZqDnFsGIQXhs2SQ&s',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('Gucci Necklace'),
            subtitle: Text('LKR 439000.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://quickee.com/wp-content/uploads/2024/02/Untitled-design-2024-02-01T123847.309.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('Dolce & Gabbana The One'),
            subtitle: Text('LKR 29400.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://thesensation.lk/wp-content/uploads/2023/05/Untitled-34-e1683625813991.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('Yves Saint Laurent Y'),
            subtitle: Text('LKR 49900.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEHNBTPiXT9VDOUdODoy57fKgHlW14SZBU5Q&s',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('Prada Luna Rossa Carbon'),
            subtitle: Text('LKR 45600.00'),
            trailing: Icon(Icons.delete),
          ),
          ListTile(
            leading: Image.network(
                'https://aromaperfume.lk/wp-content/uploads/13012021-4-1.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
            title: Text('Issey Miyake LEau d Issey Pour Homme'),
            subtitle: Text('LKR 34500.00'),
            trailing: Icon(Icons.delete),
          ),
        ]));
  }
}
