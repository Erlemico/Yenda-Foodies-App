import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../product/product.dart';
import '../account/account.dart';
import '../history/history.dart';
import '../cart/cart.dart';
import '../product/productdetails.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  HomeScreen({this.initialIndex = 0});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  PageController _pageController1 = PageController();
  PageController _pageController2 = PageController();
  int _currentPage1 = 0;
  int _currentPage2 = 0;
  Timer? _bannerTimer;

  List<Map<String, dynamic>> _products = [
    {
      'image': 'assets/images/menu/sidedish/rendangdaging.png',
      'name': 'Rendang Daging',
      'price': '17.000',
      'description': 'Dibuat penuh cinta dengan daging sapi pilihan dan disempurnakan dengan rempah-rempah berkualitas, menghadirkan cita rasa yang tak tertandingi.',
    },
    {
      'image': 'assets/images/menu/sidedish/ayambakar.png',
      'name': 'Ayam Bakar',
      'price': '17.000',
      'description': 'Dibuat dengan daging ayam segar pilihan dan dipadukan dengan bumbu-bumbu khas serta rempah-rempah berkualitas untuk menghadirkan cita rasa otentik dan memikat.',
    },
    {
      'image': 'assets/images/menu/sidedish/ayamgulai.png',
      'name': 'Ayam Gulai',
      'price': '18.000',
      'description': 'Ayam gulai dengan kuah santan yang gurih, memberikan cita rasa istimewa untuk berbagai macam hidangan.',
    },
    {
      'image': 'assets/images/menu/sidedish/gulaicincang.png',
      'name': 'Gulai Cincang',
      'price': '25.000',
      'description': 'Nikmati kelezatan gulai cincang kami yang kaya akan rempah-rempah pilihan. Setiap suapannya membawa cita rasa yang memanjakan lidah dan memuaskan selera!',
    },
    {
      'image': 'assets/images/menu/sidedish/dendengbatako.png',
      'name': 'Dendeng Batako',
      'price': '25.000',
      'description': 'Nikmati sensasi pedas manis dendeng balado yang gurih dan lezat. Dibuat dengan bahan-bahan berkualitas dan balutan rempah balado yang khas.',
    },
    {
      'image': 'assets/images/menu/package/paketnasirendangayamgoreng.png',
      'name': 'Paket Nasi Rendang Ayam Goreng',
      'price': '47.000',
      'description': 'Paket nasi dengan rendang dan ayam goreng.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _bannerTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      setState(() {
        _currentPage1 = (_currentPage1 + 1) % 5;
        _currentPage2 = (_currentPage2 + 1) % 5;
        _pageController1.animateToPage(
          _currentPage1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _pageController2.animateToPage(
          _currentPage2,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController1.dispose();
    _pageController2.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Widget> _widgetOptions() {
    return <Widget>[
      _buildBeranda(),
      ProductScreen(initialTabIndex: 0),
      HistoryScreen(),
      AccountScreen(),
    ];
  }

  Widget _buildBeranda() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Container(
          height: 110,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController1,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Image.asset(
                'assets/images/banner/banner${index + 1}.png',
              );
            },
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCurvedButton(Icons.category, 'Semua'),
              _buildCurvedButton(Icons.shopping_bag, 'Paket'),
              _buildCurvedButton(Icons.local_dining, 'Lauk'),
              _buildCurvedButton(Icons.local_drink, 'Minuman'),
              _buildCurvedButton(Icons.more_horiz, 'Lainnya'),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Jangan lupa cobain!',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 110,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController2,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Image.asset(
                'assets/images/banner/banner${index + 6}.png',
              );
            },
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rekomendasi enak',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(initialIndex: 1)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                ),
                child: Text(
                  'Lihat lainnya',
                  style: TextStyle(fontSize: 14.0, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        image: _products[index]['image'],
                        itemName: _products[index]['name'],
                        itemPrice: _products[index]['price'],
                        itemDescription: _products[index]['description'],
                      ),
                    ),
                  );
                },
                child: _buildRecommendedItem(
                  _products[index]['image'],
                  _products[index]['name'],
                  _products[index]['price'],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _selectedIndex == 0 ? _buildAppBar() : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFFE00E0F),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Selamat Pagi',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Halo, Kirana!',
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
          color: Colors.black,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          height: 1,
        ),
      ),
    );
  }

  Widget _buildCurvedButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFE00E0F),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(initialIndex: 1),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(color: Color(0xFFE00E0F)),
        ),
      ],
    );
  }

  Widget _buildRecommendedItem(String imagePath, String name, String price) {
    double priceValue;
    try {
      priceValue = double.parse(price.replaceAll(RegExp('[^0-9]'), '')); // Remove non-numeric characters
    } catch (e) {
      priceValue = 0.0;
    }

    return Container(
      width: 160,
      margin: EdgeInsets.only(left: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3),
                Text(
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(priceValue),
                  style: TextStyle(fontSize: 14.0, color: Color(0xFFE00E0F)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}