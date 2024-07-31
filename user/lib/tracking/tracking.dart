import 'package:flutter/material.dart';
import '../history/orderdetail.dart';
import '../home/home.dart';

class TrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // Menghilangkan bayangan untuk tampilan lebih bersih
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            'Pengiriman',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Mengubah warna teks agar terlihat di latar belakang putih
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black), // Mengubah warna ikon agar terlihat di latar belakang putih
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(initialIndex: 0)),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 200),
              Icon(
                Icons.local_shipping,
                size: 100,
                color: Color(0xFFE00E0F),
              ),
              SizedBox(height: 10),
              Text(
                'Pesanan kamu sedang diantar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sampai dalam ',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    TextSpan(
                      text: '10:32',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: ' menit',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 150),
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman DetailPengiriman
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderDetail(
                      orderId: '123456',
                      time: '10:00',
                      date: '2024-07-15',
                      status: 'Dalam Pengiriman',
                      quantity: 2,
                      price: 34000,
                    )),
                  );
                },
                child: Text(
                  'Detail Pesanan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFE00E0F),
                  minimumSize: Size(150, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
