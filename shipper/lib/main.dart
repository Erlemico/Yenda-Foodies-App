import 'package:flutter/material.dart'; //untuk memanggil segala material user interface dalam dart
import 'screen/splash.dart'; //untuk memanggil halaman splash yang ada dalam folder screen

//void main untuk titik awal memanggil aplikasi
void main() {
  runApp(MyApp());
}

//class Myapp terdapat beralih kehalaman splash
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shipper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}