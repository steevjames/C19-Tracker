import 'package:datacollect/Pages/homepage.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  gotoHomePage(context) async {
    await Future.delayed(Duration(microseconds: 500));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    gotoHomePage(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/icon.png",
          width: 100,
        ),
      ),
    );
  }
}
