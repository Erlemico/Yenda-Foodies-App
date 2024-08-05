import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  final String orderId;
  final String orderStatus;
  final Function(String) updatePaymentStatus;
  final VoidCallback onPop;

  const OrderDetail({super.key, 
    required this.orderId,
    required this.orderStatus,
    required this.updatePaymentStatus,
    required this.onPop,
  });

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String? paymentStatus;

  void updatePaymentStatus(String status) {
    setState(() {
      paymentStatus = status;
    });
    widget.updatePaymentStatus(status);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth > 800 ? 32.0 : 10.0;
    final contentPadding = screenWidth > 800 ? 20.0 : 10.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Detail Pesanan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.onPop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: contentPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Orders ID ${widget.orderId}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  OrderItem(),
                  OrderItem(),
                  OrderItem(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:', style: TextStyle(fontSize: 18)),
                Text('Rp. 64.000', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            if (widget.orderStatus == 'Diproses' && paymentStatus == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      updatePaymentStatus('Pembayaran Diterima');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A8A07)),
                    child: const Text('Terima Pembayaran', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      updatePaymentStatus('Pembayaran Ditolak');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE00E0F)),
                    child: const Text('Tolak Pembayaran', style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            else if (paymentStatus != null)
              Text(
                'Status Pembayaran: $paymentStatus',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: paymentStatus == 'Pembayaran Diterima' ? Colors.green : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalMargin = screenWidth > 800 ? 24.0 : 16.0;
    final itemPadding = screenWidth > 800 ? 16.0 : 8.0;

    return Container(
      margin: EdgeInsets.only(bottom: horizontalMargin),
      padding: EdgeInsets.all(itemPadding),
      child: Row(
        children: [
          Image.asset('assets/images/rendang.png', width: 50, height: 50),
          SizedBox(width: horizontalMargin),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sop Daging', style: TextStyle(fontSize: 16)),
              Text('Rp20.000'),
            ],
          ),
          const Spacer(),
          const Text('1'),
        ],
      ),
    );
  }
}

class Order {
  final String orderId;
  final String date;
  final int quantity;
  final int price;
  final String status;
  final Color statusColor;
  final String orderTime;

  Order(
    this.orderId,
    this.date,
    this.quantity,
    this.price,
    this.status,
    this.statusColor,
    this.orderTime,
  );
}