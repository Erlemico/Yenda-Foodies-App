import 'package:flutter/material.dart';
import '../signin/signin.dart'; //untuk navigasi ke halaman signin yang ada dalam folder signin

//class splashscreen untuk mendefinisikan class dari splash yang terdiri dari widget berisi image splash untuk dan akan
//langsung mengarahkan ke halaman signin
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: 400,
          height: 400,
        ),
      ),
    );
  }
}