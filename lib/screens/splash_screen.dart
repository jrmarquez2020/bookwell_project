import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.21,
          ),
          Center(
            child: Image.asset(
              'assets/images/Logo.png',
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
