import 'package:datacollect/Pages/homepage.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  gotoHomePage(context) async {
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
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
