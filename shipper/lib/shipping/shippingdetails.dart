import 'package:flutter/material.dart';
import '../home/dashboard.dart';
import 'package:intl/intl.dart';

class DetailPengiriman extends StatelessWidget {
  final String orderId;
  final String time;
  final String date;
  final String status;
  final int quantity;
  final double price;

  const DetailPengiriman({super.key, 
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
      backgroundColor:  Colors.white,
      appBar: AppBar(
        title: const Text('Detail Pengiriman', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor:  Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Text('Order ID:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    orderId,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Tanggal:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '$date $time',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
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
            const SizedBox(height: 10),
            const Row(
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
            const SizedBox(height: 10),
            const Row(
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
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Status:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    status,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Pesanan:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/menu/sidedish/rendangdaging.png',
                      width: 90,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Rendang', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(formatCurrency.format(17000), style: const TextStyle(color: Color(0xFFE00E0F), fontWeight: FontWeight.bold, fontSize: 18)),
                      const Text('2x', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 17),
            const Divider(
              color: Colors.black,
              thickness: 1,
              indent: 15,
              endIndent: 15,
            ),

            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatCurrency.format(24000),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'Status Pengiriman:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 10),
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
                              backgroundColor: const Color(0xFFE00E0F),
                              title: const Text(
                                'Konfirmasi',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: const Text(
                                'Apakah Anda ingin menyelesaikan pengiriman?', 
                                style: TextStyle(
                                        color: Colors.white,
                                      ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'Tidak',
                                    style: TextStyle(
                                      color: Colors.white,
                                      
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Ya',
                                    style: TextStyle(
                                      color: Colors.white,
                                      
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Dashboard(initialIndex: 1)),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
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
                        backgroundColor: const Color(0xFF1A8A07),
                      ),
                      child: const Text(
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
                              backgroundColor: const Color(0xFFE00E0F),
                              title: const Text(
                                'Konfirmasi',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: const Text(
                                'Apakah Anda ingin membatalkan pengiriman?', 
                                style: TextStyle(
                                        color: Colors.white,
                                      ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'Tidak',
                                    style: TextStyle(
                                      color: Colors.white,
                                      
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Ya',
                                    style: TextStyle(
                                      color: Colors.white,
                                      
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Dashboard(initialIndex: 1)),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
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
                        backgroundColor: const Color(0xFFE00E0F),
                      ),
                      child: const Text(
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