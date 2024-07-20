import 'package:flutter/material.dart';

import '../home/dashboard.dart';

class Pengiriman extends StatefulWidget {
  @override
  _PengirimanState createState() => _PengirimanState();
  
}

class _PengirimanState extends State<Pengiriman> {
  String _selectedFilter = 'Semua';

  void _setFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  // Daftar pengiriman dummy
  final List<Map<String, dynamic>> pengirimanList = [
    {
      'orderId': '#1201241215',
      'time': '14:00',
      'date': 'Selasa, 3 Juli 2024',
      'status': 'Pesanan Baru',
      'quantity': 2,
      'price': 24000,
    },
    {
      'orderId': '#1201241216',
      'time': '15:00',
      'date': 'Rabu, 4 Juli 2024',
      'status': 'Pesanan Selesai',
      'quantity': 1,
      'price': 12000,
    },
    {
      'orderId': '#1201241217',
      'time': '16:00',
      'date': 'Kamis, 5 Juli 2024',
      'status': 'Pesanan Dibatalkan',
      'quantity': 3,
      'price': 36000,
    },
  ];

  List<Map<String, dynamic>> get filteredPengirimanList {
    if (_selectedFilter == 'Semua') {
      return pengirimanList;
    }
    return pengirimanList.where((pengiriman) {
      return pengiriman['status'] == _selectedFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Text(
                    'Pengiriman',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Cari",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilterButton(
                        text: 'Semua',
                        isSelected: _selectedFilter == 'Semua',
                        onTap: () => _setFilter('Semua'),
                      ),
                      FilterButton(
                        text: 'Baru',
                        isSelected: _selectedFilter == 'Pesanan Baru',
                        onTap: () => _setFilter('Pesanan Baru'),
                      ),
                      FilterButton(
                        text: 'Selesai',
                        isSelected: _selectedFilter == 'Pesanan Selesai',
                        onTap: () => _setFilter('Pesanan Selesai'),
                      ),
                      FilterButton(
                        text: 'Dibatalkan',
                        isSelected: _selectedFilter == 'Pesanan Dibatalkan',
                        onTap: () => _setFilter('Pesanan Dibatalkan'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: filteredPengirimanList.map((pengiriman) {
                return ShippingItem(
                  orderId: pengiriman['orderId'],
                  time: pengiriman['time'],
                  date: pengiriman['date'],
                  status: pengiriman['status'],
                  quantity: pengiriman['quantity'],
                  price: pengiriman['price'],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  FilterButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFE00E0F) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xFFE00E0F) : Colors.black,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


