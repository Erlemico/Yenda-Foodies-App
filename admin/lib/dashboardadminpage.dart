import 'package:flutter/material.dart';
import 'produkpage.dart';
import 'riwayatpage.dart';
import 'akunpage.dart';
import 'homepesanan.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedPage = 'Dashboard';

  void _selectPage(String page) {
    setState(() {
      selectedPage = page;
    });
  }

  int _getPageIndex() {
    switch (selectedPage) {
      case 'Produk':
        return 1;
      case 'Pesanan':
        return 2;
      case 'Riwayat':
        return 3;
      case 'Akun':
        return 4;
      case 'Dashboard':
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DashboardContentPage(onSelectPage: _selectPage),
      const ProdukPage(),
      const PesananPage(),
      const RiwayatPage(),
      const Account(),
    ];

    return Scaffold(
      body: Row(
        children: <Widget>[
          ButtonSidebar(
            selectedPage: selectedPage,
            onSelectPage: _selectPage,
          ),
          Expanded(
            child: IndexedStack(
              index: _getPageIndex(),
              children: pages,
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardContentPage extends StatelessWidget {
  final Function(String)? onSelectPage;

  const DashboardContentPage({super.key, this.onSelectPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Divider(
                  color: Colors.black,
                  thickness: 1.0,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if (onSelectPage != null) onSelectPage!('Produk');
                  },
                  child: const InfoCard(
                    title: 'Total Produk',
                    value: '34',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (onSelectPage != null) onSelectPage!('Pesanan');
                  },
                  child: const InfoCard(
                    title: 'Total Pesanan',
                    value: '50',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (onSelectPage != null) onSelectPage!('Riwayat');
                  },
                  child: const InfoCard(
                    title: 'Total Pembayaran',
                    value: '0',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Produk Rekomendasi',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: const <Widget>[
                  MenuCard(
                    title: 'Ayam Bakar',
                    subtitle: 'Rp. 17.000',
                    imagePath: 'assets/images/ayambakar.png',
                  ),
                  MenuCard(
                    title: 'Rendang',
                    subtitle: 'Rp. 17.000',
                    imagePath: 'assets/images/rendangdaging.png',
                  ),
                  MenuCard(
                    title: 'Ayam Gulai',
                    subtitle: 'Rp. 18.000',
                    imagePath: 'assets/images/ayamgulai.png',
                  ),
                  MenuCard(
                    title: 'Dendeng Batako',
                    subtitle: 'Rp. 18.000',
                    imagePath: 'assets/images/dendengbatako.png',
                  ),
                  MenuCard(
                    title: 'Paket Nasi Rendang-Ayam Goreng',
                    subtitle: 'Rp. 47.000',
                    imagePath: 'assets/images/rendangayamgoreng.png',
                  ),
                  MenuCard(
                    title: 'Gulai Cincang',
                    subtitle: 'Rp. 25.000',
                    imagePath: 'assets/images/gulaicincang.png',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE00E0F),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const MenuCard({super.key, required this.title, required this.subtitle, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFFE00E0F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonSidebar extends StatelessWidget {
  final String selectedPage;
  final Function(String) onSelectPage;

  const ButtonSidebar({super.key, required this.selectedPage, required this.onSelectPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFFE00E0F),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 32),
          Center(
            child: Image.asset(
              'assets/images/yendafoodies.png',
              height: 100,
            ),
          ),
          const SizedBox(height: 32),
          _buildSidebarButton(context, 'Dashboard', Icons.home),
          const SizedBox(height: 32),
          _buildSidebarButton(context, 'Produk', Icons.fastfood),
          const SizedBox(height: 32),
          _buildSidebarButton(context, 'Pesanan', Icons.receipt),
          const SizedBox(height: 32),
          _buildSidebarButton(context, 'Riwayat', Icons.history),
          const SizedBox(height: 32),
          _buildSidebarButton(context, 'Akun', Icons.account_circle),
        ],
      ),
    );
  }

  Widget _buildSidebarButton(BuildContext context, String title, IconData icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedPage == title ? Colors.white : const Color(0xFFE00E0F),
        foregroundColor: selectedPage == title ? const Color(0xFFE00E0F) : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16),
        elevation: 0,
      ),
      onPressed: () {
        onSelectPage(title);
      },
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(icon),
          ),
          Text(title),
        ],
      ),
    );
  }
}