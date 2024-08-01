import 'package:flutter/material.dart';
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
  

  // Daftar produk
  final List<Map<String, dynamic>> _product = [
    {
      'image': 'assets/images/menu/drink/air.png',
      'name': 'Air Mineral',
      'price': '8.000',
      'description': 'Nikmati kesegaran air mineral kami yang menghilangkan dahaga. Dibuat dengan kualitas terbaik, setiap tegukan memberikan kepuasan yang sejati.',
      'category': 'Minuman',
    },
    {
      'image': 'assets/images/menu/sidedish/asampadehdaging.png',
      'name': 'Asam Padeh Daging',
      'price': '18.000',
      'description': 'Nikmati kelezatan daging asam padeh kami yang khas dan menggugah selera. Dibuat dengan bumbu rempah yang melimpah, setiap gigitan menghadirkan sensasi cita rasa yang memikat.',
      'category': 'Lauk',
    },
    {
      'image': 'assets/images/menu/sidedish/ayambakar.png',
      'name': 'Ayam Bakar',
      'price': '17.000',
      'description': 'Dibuat dengan daging ayam segar pilihan dan dipadukan dengan bumbu-bumbu khas serta rempah-rempah berkualitas untuk menghadirkan cita rasa otentik dan memikat.',
      'category': 'Lauk',
    },
    {
      'image': 'assets/images/menu/sidedish/ayamgoreng.png',
      'name': 'Ayam Goreng',
      'price': '18.000',
      'description': 'Kelezatan ayam goreng kami tidak tertandingi! Dibumbui dengan rempah-rempah pilihan, kulitnya renyah dan dagingnya juicy. Nikmati kepuasan setiap gigitannya!',
      'category': 'Lauk',
    },
    {
      'image': 'assets/images/menu/sidedish/ayamgulai.png',
      'name': 'Ayam Gulai',
      'price': '18.000',
      'description': 'Ayam gulai dengan kuah santan yang gurih, memberikan cita rasa istimewa untuk berbagai macam hidangan.',
      'category': 'Lauk',
    },
    {
      'image': 'assets/images/menu/sidedish/ayamkalioladoijo.png',
      'name': 'Ayam Kalio Lado Ijo',
      'price': '19.000',
      'description': 'Ayam kalio lado ijo kami diolah dengan bumbu rempah yang autentik. Dibumbui dengan bahan-bahan berkualitas, nikmati sensasi cita rasa yang memikat dalam setiap gigitannya!',
      'category': 'Lauk',
    },
    {
      'image': 'assets/images/menu/sidedish/ayampop.png',
      'name': 'Ayam Pop',
      'price': '19.000',
      'description': 'Ayam pop kami sajikan dengan kulit renyah dan daging juicy yang menggugah selera. Dibumbui dengan rempah-rempah pilihan, setiap suapannya menghadirkan kepuasan yang tiada duanya.',
      'category': 'Lauk',
    },
    {
      'image': 'assets/images/menu/sidedish/ayamrendang.png',
      'name': 'Ayam Rendang',
      'price': '19.000',
      'description': 'Rendang ayam kami hadir dengan cita rasa otentik dan memikat. Disajikan dengan kuah kental dan bumbu rempah yang meresap sempurna di dalam daging ayam, nikmati kelezatannya dalam setiap suapan!',
      'category': 'Lauk',
    },
    {
      'image': 'assets/images/menu/sidedish/dendengbatako.png',
      'name': 'Dendeng Batako',
      'price': '19.000',
      'description': 'Nikmati sensasi pedas manis dendeng balado yang gurih dan lezat. Dibuat dengan bahan-bahan berkualitas dan balutan rempah balado yang khas.',
      'category': 'Lauk',
    },
    {
      'image': 'assets/images/menu/drink/esjeruk.png',
      'name': 'Es Jeruk',
      'price': '10.000',
      'description': 'Nikmati kesegaran es jeruk kami yang menyegarkan. Disajikan dingin, setiap tegukan memberikan sensasi rasa yang menyegarkan dan memikat.',
      'category': 'Minuman',
    },
    {
      'image': 'assets/images/menu/drink/estehmanis.png',
      'name': 'Es Teh Manis',
      'price': '7.000',
      'description': 'Nikmati kesegaran es teh manis kami yang diolah dengan rasa yang autentik. Disajikan dingin, setiap tegukan memberikan kepuasan yang tiada duanya.',
      'category': 'Minuman',
    },
    {
      'image': 'assets/images/menu/drink/estehtarik.png',
      'name': 'Es Teh tarik',
      'price': '15.000',
      'description': 'Nikmati kesegaran es teh tarik kami yang khas dan menggugah selera! Disajikan dingin, setiap tegukan memberikan kelezatan yang tiada duanya.',
      'category': 'Minuman'
    },
    {
      'image': 'assets/images/menu/sidedish/gulaicincang.png',
      'name': 'Gulai Cincang',
      'price': '25.000',
      'description': 'Nikmati kelezatan gulai cincang kami yang kaya akan rempah-rempah pilihan. Setiap suapannya membawa cita rasa yang memanjakan lidah dan memuaskan selera!',
      'category': 'Lauk'
    },
    {
      'image': 'assets/images/menu/sidedish/gulaitunjang.png',
      'name': 'Gulai Tunjang',
      'price': '20.000',
      'description': 'Rasakan kelezatan gulai tunjang kami yang lezat dan menggugah selera. Dibuat dengan rempah-rempah pilihan, nikmati sensasi cita rasa yang autentik dalam setiap suapannya!',
      'category': 'Lauk'
    },
    {
      'image': 'assets/images/menu/sidedish/ikanguramebakar.png',
      'name': 'Ikan Gurame Bakar',
      'price': '17.000',
      'description': 'Nikmati sensasi gurame bakar kami yang lezat dan segar. Disajikan dengan bumbu-bumbu pilihan, setiap gigitan memberikan cita rasa yang memikat dari laut!',
      'category': 'Lauk'
    },
    {
      'image': 'assets/images/menu/sidedish/ikanguramegoreng.png',
      'name': 'Ikan Gurame Goreng',
      'price': '16.000',
      'description': 'Dihadirkan dengan bahan-bahan terbaik, kami menawarkan cita rasa yang menggugah selera. Nikmati kesegaran ikan gurame yang digoreng sempurna di setiap gigitannya!',
      'category': 'Lauk'
    },
    {
      'image': 'assets/images/menu/sidedish/ikankembungbakar.png',
      'name': 'Ikan Kembung Bakar',
      'price': '16.000',
      'description': 'Kami hadirkan ikan kembung bakar lezat dengan cita rasa asli laut. Rasakan kesegaran dan kelezatan yang tiada duanya dalam setiap potongan!',
      'category': 'Lauk'
    },
    {
      'image': 'assets/images/menu/sidedish/ikankembunggoreng.png',
      'name': 'Ikan Kembung Goreng',
      'price': '15.000',
      'description': 'Nikmati ikan kembung goreng kami yang renyah di luar, lembut di dalam. Rasakan cita rasa laut yang autentik dalam setiap suapan!',
      'category': 'Lauk'
    },
    {
      'image': 'assets/images/menu/sidedish/ikantunabalado.png',
      'name': 'Ikan Tuna Balado',
      'price': '15.000',
      'description': 'Kelezatan ikan tuna balado kami akan memanjakan lidah Anda dengan perpaduan pedas dan manis yang sempurna. Rasakan kesegaran dan kaya rasa ikan tuna yang terjaga dalam balado khas kami!',
      'category': 'Lauk'
    },
    {
      'image': 'assets/images/menu/sidedish/ikantunagulai.png',
      'name': 'Ikan Tuna Gulai',
      'price': '15.000',
      'description': 'Kami sajikan ikan tuna gulai kuning dengan cita rasa yang khas dan menggugah selera. Setiap potongan tuna yang lembut terendam dalam kuah kuning yang gurih dan nikmat.',
      'category': 'Lauk'
    },
    {
      'image': 'assets/images/menu/drink/jusalpukat.png',
      'name': 'Jus Alpukat',
      'price': '17.000',
      'description': 'Jus alpukat kami hadir dengan rasa kaya dan menggugah selera. Dibuat dengan alpukat pilihan, nikmati kelezatan yang tiada duanya.',
      'category': 'Minuman'
    },
    {
      'image': 'assets/images/menu/drink/jusmangga.png',
      'name': 'Jus Mangga',
      'price': '17.000',
      'description': 'Jus mangga kami sajikan dengan rasa segar dan kaya akan nutrisi. Dibuat dengan buah mangga terbaik, setiap tegukan memberikan kesegaran yang sejati.',
      'category': 'Minuman'
    },
    {
      'image': 'assets/images/menu/package/paketnasiayambakarperkedelterongteri.png',
      'name': 'Paket Nasi Ayam Bakar, Perkedel, Terong Teri',
      'price': '36.000',
      'description': 'Paket nasi ayam bakar dengan perkedel dan terong teri.',
      'category': 'Paket'
    },
     {
      'image': 'assets/images/menu/package/paketnasiayampopterongteri.png',
      'name': 'Paket Nasi Ayam Pop-Terong Teri',
      'price': '26.000',
      'description': 'Paket nasi dengan ayam pop dan terong teri.',
      'category': 'Paket'
    },
    {
      'image': 'assets/images/menu/package/paketnasiayamremas.png',
      'name': 'Paket Nasi Ayam Remas',
      'price': '24.000',
      'description': 'Paket nasi dengan ayam remas.',
      'category': 'Paket'
    },
    {
      'image': 'assets/images/menu/package/paketnasirendangayamgoreng.png',
      'name': 'Paket Nasi Rendang Ayam Goreng',
      'price': '47.000',
      'description': 'Paket nasi dengan rendang dan ayam goreng.',
      'category': 'Paket'
    },
    {
      'image': 'assets/images/menu/package/paketnasirendangtelordadar.png',
      'name': 'Paket Nasi Rendang Telor Dadar',
      'price': '32.000',
      'description': 'Paket nasi dengan rendang dan telor dadar.',
      'category': 'Paket'
    },
    {
      'image': 'assets/images/menu/package/paketnasitunjang.png',
      'name': 'Paket Nasi Tunjang',
      'price': '36.000',
      'description': 'Paket nasi dengan tunjang yang empuk.',
      'category': 'Paket'
    },
    {
      'image': 'assets/images/menu/sidedish/rendangdaging.png',
      'name': 'Rendang Daging',
      'price': '17.000',
      'description': 'Dibuat penuh cinta dengan daging sapi pilihan dan disempurnakan dengan rempah-rempah berkualitas, menghadirkan cita rasa yang tak tertandingi.',
      'category': 'Lauk'
    },
    {
      'image': 'assets/images/menu/sidedish/sopdaging.png',
      'name': 'Sop Daging',
      'price': '25.000',
      'description': 'Nikmati kehangatan dan kelezatan sop daging kami yang diolah dengan bumbu rempah yang kaya. Setiap sendokannya menghadirkan cita rasa yang memanjakan lidah dan menenangkan jiwa.',
      'category': 'Lauk'
    },
    {
      'image': 'assets/images/menu/other/tahugoreng.png',
      'name': 'Tahu Goreng',
      'price': '5.000',
      'description': 'Tahu goreng kami hadir dengan cita rasa otentik. Dibuat dengan tahu berkualitas, nikmati kelezatan yang tiada duanya!',
      'category': 'Lainnya'
    },
    {
      'image': 'assets/images/menu/other/tempegoreng.png',
      'name': 'Tempe Goreng',
      'price': '5.000',
      'description': 'Tempe goreng kami hadir dengan rasa renyah di luar, lembut di dalam. Dibuat dengan bumbu rempah pilihan, nikmati kelezatan yang memikat!',
      'category': 'Lainnya'
    },
    {
      'image': 'assets/images/menu/other/tumistoge.png',
      'name': 'Tumis Toge',
      'price': '8.000',
      'description': 'Tumis toge kami hadir dengan rasa yang segar dan menggugah selera. Dibuat dengan bahan-bahan berkualitas, nikmati kelezatan yang tiada duanya!',
      'category': 'Lainnya'
    },
    {
      'image': 'assets/images/menu/sidedish/udangbalado.png',
      'name': 'Udang Balado',
      'price': '22.000',
      'description': 'Udang balado kami diolah dengan bumbu balado yang kaya dan menggugah selera. Rasakan kesegaran dan kelezatan udang dalam balado khas kami!',
      'category': 'Lauk'
    },

  ];

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
    _tabController = TabController(length: _categoryItems.length, vsync: this, initialIndex: widget.initialTabIndex);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                child: _buildItemsWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemsWidget() {
    List<int> itemIndexes = _categoryItems.values.elementAt(_tabController.index);

    // Filter item berdasarkan pencarian
    if (_searchText.isNotEmpty) {
      itemIndexes = _product.asMap().entries.where((entry) =>
          entry.value['name'].toString().toLowerCase().contains(_searchText) ||
          entry.value['description'].toString().toLowerCase().contains(_searchText)
      ).map((entry) => entry.key).toList();
    }

    // Filter itemIndexes berdasarkan kategori yang dipilih
    String selectedCategory = _categoryItems.keys.elementAt(_tabController.index);
    itemIndexes.retainWhere((index) =>
        _product[index]['category'] == selectedCategory ||
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
                  image: _product[itemIndex]['image'],
                  itemName: _product[itemIndex]['name'],
                  itemPrice: _product[itemIndex]['price'],
                  itemDescription: _product[itemIndex]['description'],
                ),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        child: Image.asset(
                          _product[itemIndex]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        _product[itemIndex]['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Rp ${_product[itemIndex]['price']}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE00E0F),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
