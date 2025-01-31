import 'package:assingment/Screens/Register.dart';

import 'package:assingment/Screens/HomePage.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aurora Luxe - Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Password", border: OutlineInputBorder()),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text(
                  "Don't have Account? Register Now",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    _createRoute(MyHomePage()),
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                )),
          ],
        ),
      ),
    );
  }
}
