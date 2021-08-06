import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static Widget create(BuildContext context) => SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 30),
            Text('Bienvenido...', style: TextStyle(fontSize: 24)),
            SizedBox(height: 25),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
