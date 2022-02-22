import 'package:flutter/material.dart';
import 'package:my_garage/pages/garage/garage_page.dart';
import 'package:my_garage/pages/splash/splash_page.dart';

void main() {
  runApp(const GarageApp());
}

class GarageApp extends StatelessWidget {
  const GarageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Garage',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const SplashPage(),
    );
  }
}
