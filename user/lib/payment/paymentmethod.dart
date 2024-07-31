import 'package:flutter/material.dart';
import '../paymentmethod/cash.dart';
import '../paymentmethod/vabca.dart';
import '../paymentmethod/qris.dart';
import '../paymentmethod/vamandiri.dart';
import '../paymentmethod/vabri.dart';

class PaymentMethod {
  final String name;
  final String imagePath;
  bool isSelected;

  PaymentMethod({required this.name, required this.imagePath, this.isSelected = false});
}

class PaymentMethodScreen extends StatefulWidget {
  final String totalPayment;
  const PaymentMethodScreen({Key? key, required this.totalPayment }) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final List<PaymentMethod> virtualBankMethods = [
    PaymentMethod(name: 'Bank BCA', imagePath: 'assets/images/payments/va/bca.png'),
    PaymentMethod(name: 'Bank Mandiri', imagePath: 'assets/images/payments/va/mandiri.png'),
    PaymentMethod(name: 'Bank BRI', imagePath: 'assets/images/payments/va/bri.png'),
  ];

  final List<PaymentMethod> otherPaymentMethods = [
    PaymentMethod(name: 'Scan Qris', imagePath: 'assets/images/payments/other/qris.png'),
    PaymentMethod(name: 'Tunai', imagePath: 'assets/images/payments/other/cash.png'),
  ];

  void _selectMethod(PaymentMethod selectedMethod) {
    setState(() {
      // Clear previous selection
      for (var method in virtualBankMethods) {
        method.isSelected = false;
      }
      for (var method in otherPaymentMethods) {
        method.isSelected = false;
      }

      // Select the current method
      selectedMethod.isSelected = true;
    });

    // Navigate to the appropriate payment detail page
    if (selectedMethod.name == 'Bank BCA') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VaBca(selectedMethod: selectedMethod, totalPayment: widget.totalPayment),
        ),
      );
    } else if (selectedMethod.name == 'Bank Mandiri') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VaMandiri(selectedMethod: selectedMethod, totalPayment: widget.totalPayment),
        ),
      );
    } else if (selectedMethod.name == 'Bank BRI') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VaBri(selectedMethod: selectedMethod, totalPayment: widget.totalPayment),
        ),
      );
    } else if (selectedMethod.name == 'Scan Qris') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Qris(selectedMethod: selectedMethod, totalPayment: widget.totalPayment),
        ),
      );
    } else if (selectedMethod.name == 'Tunai') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Cash(selectedMethod: selectedMethod, totalPayment: widget.totalPayment),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Akun Virtual Bank',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...virtualBankMethods.map((method) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPaymentMethodTile(method),
                      );
                    }).toList(),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Metode Pembayaran Lainnya',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...otherPaymentMethods.map((method) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPaymentMethodTile(method),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(PaymentMethod method) {
    return InkWell(
      onTap: () => _selectMethod(method),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: method.isSelected ? Colors.grey[300] : Colors.white,
          border: Border.all(
            color: method.isSelected ? Color(0xFFE00E0F) : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Image.asset(
              method.imagePath,
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 16),
            Text(
              method.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: method.isSelected ? Color(0xFFE00E0F) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}