import 'package:flutter/material.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  _RiwayatPageState createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  String selectedPage = 'Riwayat';
  String selectedFilter = 'Semua';
  String searchQuery = '';

  List<RiwayatCard> allTransactions = [
    const RiwayatCard(
      orderID: '#1201241213',
      tanggal: 'Senin, 3 Januari 2024',
      totalPesanan: '7',
      jumlahPesanan: 'Rp. 51.000',
      alamatPengiriman: 'JL. Metro Pondok Indah Blok Th No.10/93',
      status: 'Sukses',
      metodePembayaran: 'Tunai',
    ),
    const RiwayatCard(
      orderID: '#1201241214',
      tanggal: 'Selasa, 4 Januari 2024',
      totalPesanan: '5',
      jumlahPesanan: 'Rp. 35.000',
      alamatPengiriman: 'JL. Sudirman No.12',
      status: 'Sukses',
      metodePembayaran: 'M-banking',
    ),
    const RiwayatCard(
      orderID: '#1201241215',
      tanggal: 'Rabu, 5 Januari 2024',
      totalPesanan: '3',
      jumlahPesanan: 'Rp. 21.000',
      alamatPengiriman: 'JL. Thamrin No.15',
      status: 'Sukses',
      metodePembayaran: 'Qris',
    ),
    // Add more transactions here if needed
  ];

  List<RiwayatCard> filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    filteredTransactions = allTransactions; // Initialize with all transactions
  }

  void filterTransactions(String filter) {
    setState(() {
      selectedFilter = filter;
      filteredTransactions = allTransactions.where((transaction) {
        final matchesFilter = filter == 'Semua' || transaction.metodePembayaran == filter;
        final matchesSearch = transaction.orderID.toLowerCase().contains(searchQuery.toLowerCase());
        return matchesFilter && matchesSearch;
      }).toList();
    });
  }

  void searchTransactions(String query) {
    setState(() {
      searchQuery = query;
      filteredTransactions = allTransactions.where((transaction) {
        final matchesFilter = selectedFilter == 'Semua' || transaction.metodePembayaran == selectedFilter;
        final matchesSearch = transaction.orderID.toLowerCase().contains(searchQuery.toLowerCase());
        return matchesFilter && matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white, // Warna putih untuk konten
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Riwayat',
                          style: TextStyle(
                            fontSize: 20, // Ukuran font yang lebih besar
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(
                          color: Colors.black,
                          thickness: 1.0,
                        ),
                        const SizedBox(height: 16.0), // Jarak antara teks dan bilah pencarian
                        TextField(
                          onChanged: searchTransactions,
                          decoration: InputDecoration(
                            hintText: 'Cari Order ID',
                            prefixIcon: const Icon(Icons.search), // Add the search icon
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0), // Radius of 50
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(color: Color(0xFF000000)), // Border color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(color: Colors.black), // Border color when not focused
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildFilterButton('Semua'),
                        const SizedBox(width: 8), // Add some spacing between buttons
                        _buildFilterButton('Tunai'),
                        const SizedBox(width: 8),
                        _buildFilterButton('Qris'),
                        const SizedBox(width: 8),
                        _buildFilterButton('M-banking'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: _buildTransactionList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String filter) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedFilter == filter ? const Color(0xFFE00E0F) : const Color(0xFFEBEBEB), // Warna latar belakang
        foregroundColor: selectedFilter == filter ? Colors.white : Colors.black, // Warna teks
      ),
      onPressed: () {
        filterTransactions(filter);
      },
      child: Text(filter),
    );
  }

  Widget _buildTransactionList() {
    if (filteredTransactions.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.remove_shopping_cart, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Pesanan Tidak Tersedia',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ],
        ),
      );
    } else {
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: filteredTransactions,
      );
    }
  }
}

class RiwayatCard extends StatelessWidget {
  final String orderID;
  final String tanggal;
  final String totalPesanan;
  final String jumlahPesanan;
  final String alamatPengiriman;
  final String status;
  final String metodePembayaran;

  const RiwayatCard({super.key, 
    required this.orderID,
    required this.tanggal,
    required this.totalPesanan,
    required this.jumlahPesanan,
    required this.alamatPengiriman,
    required this.status,
    required this.metodePembayaran,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Change this to white
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [ // Optional: Add shadow for better visibility
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildColumn('Order ID:', orderID),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildColumn('Tanggal:', tanggal),
              _buildColumn('Total Pesanan:', totalPesanan),
              _buildColumn('Jumlah Pesanan:', jumlahPesanan),
              _buildColumn('Alamat Pengiriman:', alamatPengiriman),
              _buildColumn('Status:', status),
              _buildColumn('Metode Pembayaran:', metodePembayaran),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4.0),
          Text(value),
        ],
      ),
    );
  }
}