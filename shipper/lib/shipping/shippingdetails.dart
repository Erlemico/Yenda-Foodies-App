import 'package:flutter/material.dart';
import 'package:homemenu/home/dashboard.dart';
import 'package:intl/intl.dart';

class DetailPengiriman extends StatelessWidget {
  final String orderId;
  final String time;
  final String date;
  final String status;
  final int quantity;
  final double price;

  DetailPengiriman({
    required this.orderId,
    required this.time,
    required this.date,
    required this.status,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengiriman', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text('Order ID:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '$orderId',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Text('Tanggal:', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '$date $time',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Text(
                    'Staff:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Laras Maulidya',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Text(
                    'Customer ID:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Kirana21',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Text(
                    'Metode Pembayaran:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Text(
                    'BCA Virtual Account',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Text('Status:', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '$status',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Text('Pesanan:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/rendangdaging.png',
                      width: 90,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Rendang', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(formatCurrency.format(17000), style: TextStyle(color: Color(0xFFE00E0F), fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('2x', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 17),
            Divider(
              color: Colors.black,
              thickness: 1,
              indent: 15,
              endIndent: 15,
            ),

            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatCurrency.format(24000),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'Status Pengiriman:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color(0XFFF0F0F0),
                              title: Text(
                                'Konfirmasi',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                'Apakah Anda ingin menyelesaikan pengiriman?', 
                                style: TextStyle(
                                        color: Colors.black,
                                      ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Tidak',
                                    style: TextStyle(
                                      color: Colors.black,
                                      
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Ya',
                                    style: TextStyle(
                                      color: Colors.black,
                                      
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => Dashboard(initialIndex: 1)),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Pengiriman telah diselesaikan'),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1A8A07),
                      ),
                      child: Text(
                        'Selesaikan Pengiriman',
                        style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color(0xFFF0F0F0),
                              title: Text(
                                'Konfirmasi',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                'Apakah Anda ingin membatalkan pengiriman?', 
                                style: TextStyle(
                                        color: Colors.black,
                                      ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Tidak',
                                    style: TextStyle(
                                      color: Colors.black,
                                      
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Ya',
                                    style: TextStyle(
                                      color: Colors.black,
                                      
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => Dashboard(initialIndex: 1)),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Pengiriman telah dibatalkan'),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE00E0F),
                      ),
                      child: Text(
                        'Batalkan Pengiriman',
                        style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
