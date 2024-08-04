import 'package:flutter/material.dart';
import '../api/apiproduct.dart';
import 'productdetails.dart';
import '../cart/cart.dart';
import '../home/home.dart';

class ProductScreen extends StatefulWidget {
  final int initialTabIndex;
  ProductScreen({required this.initialTabIndex});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchText = "";
  TextEditingController _searchController = TextEditingController();

  late Future<List<Map<String, dynamic>>> _productsFuture;

  // Menyusun item berdasarkan kategori
  final Map<String, List<int>> _categoryItems = {
    'Semua': List.generate(34, (index) => index), // Semua item
    'Paket': [22, 23, 24, 25, 26, 27], // Paket
    'Lauk': [1, 2, 3, 4, 5, 6, 7, 8, 12, 13, 14, 15, 16, 17, 18, 19, 28, 29, 33], // Lauk
    'Minuman': [0, 9, 10, 11, 20, 21], // Minuman
    'Lainnya': [30, 31, 32], // Lainnya
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categoryItems.length, vsync: this, initialIndex: widget.initialTabIndex);
    _tabController.addListener(_handleTabSelection);
    _productsFuture = ApiProduct().fetchMenuItems();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu populer dari kami,',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 26,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Spesial buat kamu',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
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
                  controller: _searchController,
                  cursorColor: const Color(0xFFE00E0F),
                  onChanged: (value) {
                    setState(() {
                      _searchText = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: InputBorder.none,
                    hintText: "Nyobain yang mana ya?",
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
              TabBar(
                controller: _tabController,
                labelColor: Color(0xFFE00E0F),
                unselectedLabelColor: Colors.black.withOpacity(0.5),
                isScrollable: false,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3,
                    color: Color(0xFFE00E0F),
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16),
                ),
                labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: _categoryItems.keys.map((category) => Tab(text: category)).toList(),
              ),
              SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _productsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Failed to load products'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined, // Ganti dengan ikon yang sesuai
                              size: 50,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Produk tidak ditemukan',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final products = snapshot.data!;
                      return _buildItemsWidget(products);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemsWidget(List<Map<String, dynamic>> products) {
    List<int> itemIndexes = _categoryItems.values.elementAt(_tabController.index);

    // Filter item berdasarkan pencarian
    if (_searchText.isNotEmpty) {
      itemIndexes = products.asMap().entries.where((entry) =>
          entry.value['name'].toString().toLowerCase().contains(_searchText) ||
          entry.value['description'].toString().toLowerCase().contains(_searchText)
      ).map((entry) => entry.key).toList();
    }

    // Filter itemIndexes berdasarkan kategori yang dipilih
    String selectedCategory = _categoryItems.keys.elementAt(_tabController.index);
    itemIndexes.retainWhere((index) =>
        products[index]['category'].toString() == selectedCategory ||
        selectedCategory == 'Semua' && _categoryItems.values.any((list) => list.contains(index))
    );

    // Tampilkan pesan jika tidak ada produk yang sesuai dengan filter
    if (itemIndexes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined, // Ganti dengan ikon yang sesuai
              size: 50,
              color: Colors.black.withOpacity(0.5),
            ),
            SizedBox(height: 10),
            Text(
              'Produk tidak ditemukan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 3,
      ),
      itemCount: itemIndexes.length,
      itemBuilder: (context, index) {
        int itemIndex = itemIndexes[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  image: products[itemIndex]['image'],
                  itemName: products[itemIndex]['name'],
                  itemPrice: products[itemIndex]['price'],
                  itemDescription: products[itemIndex]['description'],
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    products[itemIndex]['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[itemIndex]['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Rp ${products[itemIndex]['price']}',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
