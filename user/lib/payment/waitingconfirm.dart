import 'package:flutter/material.dart';
import 'dart:math';
import '../payment/confirmed.dart';
import 'paymentinfo.dart';

class WaitingConfirm extends StatefulWidget {
  final String orderId;
  final String metodePembayaran;
  final String totalPayment;

  WaitingConfirm({Key? key, required this.orderId, required this.metodePembayaran, required this.totalPayment}) : super(key: key);

  @override
  _WaitingConfirmState createState() => _WaitingConfirmState();
}

class _WaitingConfirmState extends State<WaitingConfirm> {
  late String _paymentId;

  @override
  void initState() {
    super.initState();
    _paymentId = _generatePaymentId();

    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Confirmed(
            orderId: widget.orderId,
            metodePembayaran: widget.metodePembayaran,
            totalPayment: widget.totalPayment,
            paymentId: _paymentId,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    'Konfirmasi',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 30),
                  Icon(
                    Icons.access_time,
                    size: 200,
                    color: Color.fromARGB(255, 232, 30, 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Menunggu Konfirmasi',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 193, 15, 2)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mohon tunggu admin mengkonfirmasi pembayaranmu.',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 60),
                  PaymentInfo(
                    paymentId: _paymentId,
                    orderId: widget.orderId,
                    totalPayment: widget.totalPayment,
                    metodePembayaran: widget.metodePembayaran,
                    status: 'Menunggu Konfirmasi',
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _generatePaymentId() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const length = 15;
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(Random().nextInt(characters.length)),
    ));
  }
}
