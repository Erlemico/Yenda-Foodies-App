import 'package:flutter/material.dart';
import '../home/home.dart';
import '../tracking/tracking.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String selectedFilter = 'Semua';

  void updateFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Riwayat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: MediaQuery.of(context).size.width,
            height: 35,
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
                contentPadding: EdgeInsets.only(top: 2),
              ),
            ),
          ),
          Expanded(
            child: HistoryScreenBody(
              selectedFilter: selectedFilter,
              updateFilter: updateFilter,
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryScreenBody extends StatelessWidget {
  final String selectedFilter;
  final Function(String) updateFilter;

  HistoryScreenBody({required this.selectedFilter, required this.updateFilter});

  @override
  Widget build(BuildContext context) {
    List<OrderCard> allOrders = [
      OrderCard(
        title: 'Rendang',
        date: 'Hari ini',
        price: 'Rp24.000',
        status: 'Sedang diproses',
        imageUrl: 'assets/images/menu/sidedish/rendangdaging.png',
        backgroundColor: Color(0xFFF0F0F0),
      ),
      OrderCard(
        title: 'Paket Nasi Rendang Ayam Goreng',
        date: 'Juni',
        price: 'Rp47.000',
        status: 'Pesanan selesai',
        imageUrl: 'assets/images/menu/package/paketnasirendangayamgoreng.png',
        backgroundColor: Color(0xFFF0F0F0),
      ),
      OrderCard(
        title: 'Paket Nasi Ayam Pop Terong Teri',
        date: 'Juni',
        price: 'Rp26.000',
        status: 'Pesanan selesai',
        imageUrl: 'assets/images/menu/package/paketnasiayampopterongteri.png',
        backgroundColor: Color(0xFFF0F0F0),
      ),
      OrderCard(
        title: 'Paket Nasi Tunjang',
        date: 'Juni',
        price: 'Rp36.000',
        status: 'Pesanan selesai',
        imageUrl: 'assets/images/menu/package/paketnasitunjang.png',
        backgroundColor: Color(0xFFF0F0F0),
      ),
      OrderCard(
        title: 'Paket Nasi Ayam Bakar Perkedel Terong Teri',
        date: 'Juni',
        price: 'Rp36.000',
        status: 'Pesanan dibatalkan',
        imageUrl: 'assets/images/menu/package/paketnasiayambakarperkedelterongteri.png',
        backgroundColor: Color(0xFFF0F0F0),
      ),
      OrderCard(
        title: 'Paket Nasi Rendang Telor Dadar',
        date: 'Juni',
        price: 'Rp32.000',
        status: 'Pesanan dibatalkan',
        imageUrl: 'assets/images/menu/package/paketnasirendangtelordadar.png',
        backgroundColor: Color(0xFFF0F0F0),
      ),
    ];

    List<OrderCard> filteredOrders = allOrders.where((order) {
      if (selectedFilter == 'Semua') return true;
      return order.status.contains(selectedFilter);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              FilterButton(
                label: 'Semua',
                isSelected: selectedFilter == 'Semua',
                onPressed: () => updateFilter('Semua'),
              ),
              FilterButton(
                label: 'Selesai',
                isSelected: selectedFilter == 'Pesanan selesai',
                onPressed: () => updateFilter('Pesanan selesai'),
              ),
              FilterButton(
                label: 'Dibatalkan',
                isSelected: selectedFilter == 'Pesanan dibatalkan',
                onPressed: () => updateFilter('Pesanan dibatalkan'),
              ),
              FilterButton(
                label: 'Diproses',
                isSelected: selectedFilter == 'Sedang diproses',
                onPressed: () => updateFilter('Sedang diproses'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: filteredOrders.map((order) => OrderCardWidget(order: order)).toList(),
          ),
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  FilterButton({required this.label, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Color(0xFFE00E0F) : Color(0XFFF0F0F0),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class OrderCard {
  final String title;
  final String date;
  final String price;
  final String status;
  final String imageUrl;
  final Color backgroundColor;

  OrderCard({
    required this.title,
    required this.date,
    required this.price,
    required this.status,
    required this.imageUrl,
    required this.backgroundColor,
  });
}

class OrderCardWidget extends StatelessWidget {
  final OrderCard order;

  OrderCardWidget({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: order.backgroundColor,
      child: ListTile(
        leading: Image.asset(order.imageUrl),
        title: Text(
          order.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.date),
            Text(order.price),
            Row(
              children: [
                Icon(
                  order.status == 'Pesanan selesai'
                      ? Icons.check_circle
                      : order.status == 'Pesanan dibatalkan'
                          ? Icons.cancel
                          : Icons.hourglass_bottom,
                  color: order.status == 'Pesanan selesai'
                      ? Color(0xFF1A8A07)
                      : order.status == 'Pesanan dibatalkan'
                          ? Color(0xFFE00E0F)
                          : Colors.orange,
                ),
                SizedBox(width: 4),
                Text(order.status),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: order.status == 'Sedang diproses'
                ? Color(0xFF1A8A07)
                : Color(0xFFE00E0F),
          ),
          onPressed: () {
            if (order.status == 'Sedang diproses') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackingScreen()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(initialIndex: 1)),
              );
            }
          },
          child: Text(
            order.status == 'Sedang diproses' ? 'Lacak' : 'Pesan Lagi',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}