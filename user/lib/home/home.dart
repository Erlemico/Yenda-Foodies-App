// home.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../product/product.dart';
import '../account/account.dart';
import '../history/history.dart';
import '../cart/cart.dart';
import '../product/productdetails.dart';
import '../api/apirecommendation.dart';


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

  Future<List<Map<String, dynamic>>>? _productsFuture;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _productsFuture = ApiRecommendation().fetchMenuItems(); // Fetch data

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
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Failed to load products'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No products available'));
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              image: product['image'],
                              itemName: product['name'],
                              itemPrice: product['price'],
                              itemDescription: product['description'],
                            ),
                          ),
                        );
                      },
                      child: _buildRecommendedItem(
                        product['image'],
                        product['name'],
                        product['price'],
                      ),
                    );
                  },
                );
              }
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

  Widget _buildRecommendedItem(String image, String name, String price) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 16, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Rp $price',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}