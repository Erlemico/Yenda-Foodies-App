import 'package:flutter/material.dart';
import '../signin/signin.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Center(
        child: Image.asset(
          'assets/images/splash.png', // Replace with your image asset path
          width: 400, // Set the width as per your requirement
          height: 400, // Set the height as per your requirement
        ),
      ),
    );
  }
}