import 'package:flutter/material.dart';
import '../home/home.dart';
import '../payment/paymentinfo.dart';

class Confirmed extends StatelessWidget {
  final String orderId;
  final String metodePembayaran;
  final String totalPayment;
  final String paymentId;

  const Confirmed({
    Key? key,
    required this.orderId,
    required this.metodePembayaran,
    required this.totalPayment,
    required this.paymentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    'Konfirmasi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  Icon(
                    Icons.check_circle,
                    size: 200,
                    color: Colors.green,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Pembayaran Berhasil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Terima kasih telah melakukan pembayaran.\nPesanan Anda sedang diproses.',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  PaymentInfo(
                    paymentId: paymentId,
                    orderId: orderId,
                    totalPayment: totalPayment,
                    metodePembayaran: metodePembayaran,
                    status: 'Pembayaran Berhasil',
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(initialIndex: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE00E0F),
                    ),
                    child: Text('Selesai', style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}