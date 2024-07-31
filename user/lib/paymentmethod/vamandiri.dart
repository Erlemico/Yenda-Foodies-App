import 'package:flutter/material.dart';
import 'dart:math';
import '../../payment/waitingconfirm.dart';
import '../../payment/paymentmethod.dart';

class VaMandiri extends StatefulWidget {
  final PaymentMethod selectedMethod;
  final String totalPayment;

  VaMandiri({Key? key, required this.selectedMethod, required this.totalPayment}) : super(key: key);

  @override
  _VaBcaState createState() => _VaBcaState();
}

class _VaBcaState extends State<VaMandiri> {
  late String orderId;

  @override
  void initState() {
    super.initState();
    generateOrderId();
  }

  void generateOrderId() {
    String date = DateTime.now().toString().substring(2, 10).replaceAll('-', '');
    String randomDigits = getRandomDigits(6);
    String randomAlphabets = getRandomAlphabets(5);

    setState(() {
      orderId = '$date$randomDigits$randomAlphabets'; // Gabungkan tanggal, angka acak, dan huruf acak untuk OrderID
    });
  }

  String getRandomDigits(int length) {
    // Fungsi untuk generate angka acak sepanjang length
    var random = Random();
    var digits = List.generate(length, (index) => random.nextInt(10)).join('');
    return digits;
  }

  String getRandomAlphabets(int length) {
    // Fungsi untuk generate huruf kapital acak sepanjang length
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var random = Random();
    var alphabets = List.generate(length, (index) => letters[random.nextInt(letters.length)]).join('');
    return alphabets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            'Pembayaran',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  Image.asset(
                    widget.selectedMethod.imagePath,
                    width: 150.0,
                    height: 100,
                  ),
                  SizedBox(height: 0),
                  Text(widget.selectedMethod.name),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'No. Rekening',
                  border: OutlineInputBorder(),
                  suffixIcon: InkWell(
                    onTap: () {
                      // Handle copy action
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Salin',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                readOnly: true,
                controller: TextEditingController(text: '125 000 000 000'),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'Dicek dalam 10 menit setelah pembayaran dilakukan',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFFE00E0F),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Bayar pesanan ke Virtual Account di atas sebelum melewati masa pembayaran 10 menit setelah membuat pesanan',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.totalPayment,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          'Ubah Metode Pembayaran',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WaitingConfirm(
                              orderId: orderId,
                              metodePembayaran: widget.selectedMethod.name,
                              totalPayment: widget.totalPayment,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE00E0F),
                        foregroundColor: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Lanjut',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                    ),
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