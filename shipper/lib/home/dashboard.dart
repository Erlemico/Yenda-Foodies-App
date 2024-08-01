import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert'; // Untuk decode JSON
import '../shipping/shipping.dart';
import '../shipping/shippingdetails.dart';
import '../account/account.dart';

class Dashboard extends StatefulWidget {
  final int initialIndex;
  const Dashboard({super.key, this.initialIndex = 0});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  int _totalDeliveredCount = 0; // Tambahkan variabel ini

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateDeliveredCount(int count) {
    setState(() {
      _totalDeliveredCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Pengiriman',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFE00E0F),
        unselectedItemColor: const Color(0xFF838E9E),
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(color: Color(0xFFE00E0F)),
        backgroundColor: Colors.white,
      ),
    );
  }

  List<Widget> get _widgetOptions {
    return <Widget>[
      Beranda(totalDeliveredCount: _totalDeliveredCount),
      PengirimanList(onFetchComplete: _updateDeliveredCount),
      Account(),
    ];
  }
}

class Beranda extends StatelessWidget {
  final int totalDeliveredCount;

  const Beranda({super.key, required this.totalDeliveredCount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Beranda',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            width: 372,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFFE11A1A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.local_shipping, size: 80, color: Color(0xFFFFFFFF)),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$totalDeliveredCount', // Update dengan totalDeliveredCount
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
                    ),
                    const Text(
                      'Pengiriman',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: const Text(
              'Pengiriman',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
            ),
          ),
          const SizedBox(height: 5),
          PengirimanList(onFetchComplete: (count) {}),
        ],
      ),
    );
  }
}

class PengirimanList extends StatefulWidget {
  final Function(int) onFetchComplete;

  const PengirimanList({super.key, required this.onFetchComplete});

  @override
  _PengirimanListState createState() => _PengirimanListState();
}

class _PengirimanListState extends State<PengirimanList> {
  List<dynamic> _pengirimanList = [];
  bool _isLoading = true;
  int _totalDeliveredCount = 0; // Tambahkan variabel ini

  @override
  void initState() {
    super.initState();
    _fetchPengiriman();
  }

  Future<void> _fetchPengiriman() async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/delivered-order-history'));

    if (response.statusCode == 200) {
      setState(() {
        _pengirimanList = json.decode(response.body)['data'];
        _totalDeliveredCount = _pengirimanList.length; // Update count
        _isLoading = false;
      });
      widget.onFetchComplete(_totalDeliveredCount); // Notify the parent
    } else {
      // Handle the error
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load pengiriman');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: _pengirimanList.map((pengiriman) {
        return ShippingItem(
          orderId: pengiriman['OrderID'],
          time: 'N/A', // Update with actual time if available
          date: DateFormat('EEEE, d MMMM yyyy').format(DateTime.parse(pengiriman['OrderDate'])),
          status: pengiriman['StatusCode'],
          quantity: pengiriman['Details'].length, // Assuming quantity is based on the number of details
          price: pengiriman['TotalAmount'],
        );
      }).toList(),
    );
  }
}

class ShippingItem extends StatelessWidget {
  final String orderId;
  final String time;
  final String date;
  final String status;
  final int quantity;
  final double price;

  const ShippingItem({super.key, 
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: MediaQuery.of(context).size.width,
      height: 180, 
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/menu/sidedish/rendangdaging.png',
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Order ID: $orderId',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          time,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(date),
                        Row(
                          children: [
                            Icon(
                              status == 'Pesanan Baru'
                                  ? Icons.fiber_new
                                  : status == 'Pesanan Selesai'
                                      ? Icons.check_circle
                                      : Icons.cancel,
                              color: status == 'Pesanan Baru'
                                  ? Colors.blue
                                  : status == 'Pesanan Selesai'
                                      ? Colors.green
                                      : const Color(0xFFE00E0F),
                            ),
                            Text(
                              status,
                              style: TextStyle(
                                fontSize: 14,
                                color: status == 'Pesanan Baru'
                                    ? Colors.blue
                                    : status == 'Pesanan Selesai'
                                        ? Colors.green
                                        : const Color(0xFFE00E0F),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Qty: $quantity'),
                        Text(
                          formatCurrency.format(price),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
