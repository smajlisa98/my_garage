import 'package:flutter/material.dart';
import 'package:my_garage/pages/garage/garage_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    _switchToHome();
  }

  void _switchToHome() async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const GaragePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.jpg', height: 324, width: 324,),
                const SizedBox(height: 48,),
                const Text('Author: Jelena Korugic'),
                const SizedBox(height: 12,),
                const Text('Production date: 2022.')
              ],
            ),
          ],
        )
    );
  }
}
