import 'package:flutter/material.dart';

class PaymentInfo extends StatelessWidget {
  final String paymentId;
  final String orderId;
  final String totalPayment;
  final String metodePembayaran;
  final String status;

  PaymentInfo({
    required this.paymentId,
    required this.orderId,
    required this.totalPayment,
    required this.metodePembayaran,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow('Payment ID', paymentId),
        SizedBox(height: 10),
        _buildRow('Order ID', orderId),
        SizedBox(height: 10),
        _buildRow('Total', totalPayment),
        SizedBox(height: 10),
        _buildRow('Metode Pembayaran', metodePembayaran),
        SizedBox(height: 10),
        _buildRow('Tanggal', _getCurrentDate()),
        SizedBox(height: 10),
        _buildRow('Status', status),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return '${now.day}-${now.month}-${now.year}';
  }
}
