import 'dart:io'; // Hapus ini jika tidak digunakan di web
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'tambahprodukpage.dart';

// MenuCardWithActions widget
class MenuCardWithActions extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final int initialStock;

  const MenuCardWithActions({super.key, 
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.initialStock,
  });

  @override
  _MenuCardWithActionsState createState() => _MenuCardWithActionsState();
}

class _MenuCardWithActionsState extends State<MenuCardWithActions> {
  late int _stock;

  @override
  void initState() {
    super.initState();
    _stock = widget.initialStock;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: kIsWeb
                ? Image.network(widget.imagePath,
                    width: 100, height: 100, fit: BoxFit.cover)
                : Image.file(File(widget.imagePath),
                    width: 100, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.subtitle,
                  style: const TextStyle(fontSize: 14, color: Color(0xFFE00E0F), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_stock > 0) _stock--;
                        });
                      },
                      child: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Stok: $_stock',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _stock++;
                        });
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ProdukPage widget
class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  String selectedPage = 'Produk';
  String selectedFilter = 'Semua';
  String searchQuery = '';
  List<Map<String, dynamic>> produkList = []; // Daftar produk

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Produk',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(
                          color: Colors.black,
                          thickness: 1.0,
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value.toLowerCase();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari Produk',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                _buildFilterButton(Icons.category, 'Semua'),
                                const SizedBox(width: 8.0),
                                _buildFilterButton(Icons.shopping_bag, 'Paket'),
                                const SizedBox(width: 8.0),
                                _buildFilterButton(Icons.local_dining, 'Lauk'),
                                const SizedBox(width: 8.0),
                                _buildFilterButton(
                                    Icons.local_drink, 'Minuman'),
                                const SizedBox(width: 8.0),
                                _buildFilterButton(Icons.more_horiz, 'Lainnya'),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE00E0F),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                final newProduct = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TambahProdukPage()),
                                );

                                if (newProduct != null) {
                                  setState(() {
                                    produkList.add(newProduct);
                                  });
                                }
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 8.0),
                                  Text('Tambah Produk'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Pilih Menu',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: _buildMenuCards(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuCards() {
    Map<String, List<MenuCardWithActions>> menuData = {
      'Semua': [
        const MenuCardWithActions(
          title: 'Ayam Bakar',
          subtitle: 'Rp. 17.000',
          imagePath: 'assets/images/ayambakar.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Rendang',
          subtitle: 'Rp. 17.000',
          imagePath: 'assets/images/rendangdaging.png',
          initialStock: 0,
        ),
         const MenuCardWithActions(
          title: 'Ayam Gulai',
          subtitle: 'Rp. 18.000',
          imagePath: 'assets/images/ayamgulai.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Dendeng Batako',
          subtitle: 'Rp. 18.000',
          imagePath: 'assets/images/dendengbatako.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Gulai Cincang',
          subtitle: 'Rp. 25.000',
          imagePath: 'assets/images/gulaicincang.png',
           initialStock: 0,        
        ),
        const MenuCardWithActions(
          title: 'Ikan Kembung Bakar',
          subtitle: 'Rp. 16.000',
          imagePath: 'assets/images/ikankembungbakar.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Kembung Goreng',
          subtitle: 'Rp. 16.000',
          imagePath: 'assets/images/ikankembunggoreng.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Gurame Bakar',
          subtitle: 'Rp. 17.000',
          imagePath: 'assets/images/ikanguramebakar.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Tuna Gulai',
          subtitle: 'Rp. 15.000',
          imagePath: 'assets/images/ikantunagulai.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Tuna Balado',
          subtitle: 'Rp. 15.000',
          imagePath: 'assets/images/ikantunabalado.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ayam Goreng',
          subtitle: 'Rp. 18.000',
          imagePath: 'assets/images/ayamgoreng.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Daging Asam Padeh',
          subtitle: 'Rp. 18.000',
          imagePath: 'assets/images/asampadehdaging.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Sop Daging',
          subtitle: 'Rp. 25.000',
          imagePath: 'assets/images/sopdaging.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ayam Kalio Lado Ijo',
          subtitle: 'Rp. 19.000',
          imagePath: 'assets/images/ayamkalioladoijo.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ayam Pop',
          subtitle: 'Rp. 19.000',
          imagePath: 'assets/images/ayampop.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ayam Rendang',
          subtitle: 'Rp. 19.000',
          imagePath: 'assets/images/ayamrendang.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Gulai Tunjang',
          subtitle: 'Rp. 20.000',
          imagePath: 'assets/images/gulaitunjang.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Gurame Goreng',
          subtitle: 'Rp. 45.000',
          imagePath: 'assets/images/ikanguramegoreng.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Udang Balado',
          subtitle: 'Rp. 22.000',
          imagePath: 'assets/images/udangbalado.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Rendang-Ayam Goreng',
          subtitle: 'Rp. 47.000',
          imagePath: 'assets/images/rendangayamgoreng.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Ayam Bakar + Perkedel + Terong Teri',
          subtitle: 'Rp. 36.000',
          imagePath:
              'assets/images/Pakat ayam bakar + perkedel + terong teri.jpg',
               initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Tunjang',
          subtitle: 'Rp. 36.000',
          imagePath: 'assets/images/Paket tunjang.jpg',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Rendang + Telor Dadar',
          subtitle: 'Rp. 32.000',
          imagePath: 'assets/images/Paket nasi rendang + telor dadar.jpg',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Ayam Remas',
          subtitle: 'Rp. 24.000',
          imagePath: 'assets/images/Paket ayam remas.jpg',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Ayam Pop + Terong  Teri',
          subtitle: 'Rp. 26.000',
          imagePath: 'assets/images/Paket ayam pop + terong teri_.jpg',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Es Jeruk',
          subtitle: 'Rp. 10.000',
          imagePath: 'assets/images/esjeruk.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Es Teh Manis',
          subtitle: 'Rp. 7.000',
          imagePath: 'assets/images/teh.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Es Teh Tarik',
          subtitle: 'Rp. 15.000',
          imagePath: 'assets/images/tehtarik.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Air Mineral',
          subtitle: 'Rp. 8.000',
          imagePath: 'assets/images/airmineral.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Jus Alpukat',
          subtitle: 'Rp. 17.000',
          imagePath: 'assets/images/jusalpukat.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Jus Mangga',
          subtitle: 'Rp. 17.000',
          imagePath: 'assets/images/jusmangga.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Tahu Goreng',
          subtitle: 'Rp. 5.000',
          imagePath: 'assets/images/tahugoreng.png',
           initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Tempe Goreng',
          subtitle: 'Rp. 5.000',
          imagePath: 'assets/images/tempegoreng.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Tumis Toge',
          subtitle: 'Rp. 8.000',
          imagePath: 'assets/images/tumistoge.png',
          initialStock: 0,
        ),
      ],
      'Lauk': [
        const MenuCardWithActions(
          title: 'Ayam Bakar',
          subtitle: 'Rp. 17.000',
          imagePath: 'assets/images/ayambakar.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Rendang',
          subtitle: 'Rp. 17.000',
          imagePath: 'assets/images/rendangdaging.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ayam Gulai',
          subtitle: 'Rp. 18.000',
          imagePath: 'assets/images/ayamgulai.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Dendeng Batako',
          subtitle: 'Rp. 18.000',
          imagePath: 'assets/images/dendengbatako.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Gulai Cincang',
          subtitle: 'Rp. 25.000',
          imagePath: 'assets/images/gulaicincang.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Kembung Bakar',
          subtitle: 'Rp. 16.000',
          imagePath: 'assets/images/ikankembungbakar.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Kembung Goreng',
          subtitle: 'Rp. 16.000',
          imagePath: 'assets/images/ikankembunggoreng.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Gurame Bakar',
          subtitle: 'Rp. 17.000',
          imagePath: 'assets/images/ikanguramebakar.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Tuna Gulai',
          subtitle: 'Rp. 15.000',
          imagePath: 'assets/images/ikantunagulai.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Tuna Balado',
          subtitle: 'Rp. 15.000',
          imagePath: 'assets/images/ikantunabalado.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ayam Goreng',
          subtitle: 'Rp. 18.000',
          imagePath: 'assets/images/ayamgoreng.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Daging Asam Padeh',
          subtitle: 'Rp. 18.000',
          imagePath: 'assets/images/asampadehdaging.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Sop Daging',
          subtitle: 'Rp. 25.000',
          imagePath: 'assets/images/sopdaging.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ayam Kalio Lado Ijo',
          subtitle: 'Rp. 19.000',
          imagePath: 'assets/images/ayamkalioladoijo.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ayam Pop',
          subtitle: 'Rp. 19.000',
          imagePath: 'assets/images/ayampop.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ayam Rendang',
          subtitle: 'Rp. 19.000',
          imagePath: 'assets/images/ayamrendang.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Gulai Tunjang',
          subtitle: 'Rp. 20.000',
          imagePath: 'assets/images/gulaitunjang.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Ikan Gurame Goreng',
          subtitle: 'Rp. 45.000',
          imagePath: 'assets/images/ikanguramegoreng.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Udang Balado',
          subtitle: 'Rp. 22.000',
          imagePath: 'assets/images/udangbalado.png',
          initialStock: 0,
        ),
      ],
      'Paket': [
        const MenuCardWithActions(
          title: 'Paket Nasi Rendang-Ayam Goreng',
          subtitle: 'Rp. 47.000',
          imagePath: 'assets/images/rendangayamgoreng.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Ayam Bakar + Perkedel + Terong Teri',
          subtitle: 'Rp. 36.000',
          imagePath:
              'assets/images/Pakat ayam bakar + perkedel + terong teri.jpg',
              initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Tunjang',
          subtitle: 'Rp. 36.000',
          imagePath: 'assets/images/Paket tunjang.jpg',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Rendang + Telor Dadar',
          subtitle: 'Rp. 32.000',
          imagePath: 'assets/images/Paket nasi rendang + telor dadar.jpg',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Ayam Remas',
          subtitle: 'Rp. 24.000',
          imagePath: 'assets/images/Paket ayam remas.jpg',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Paket Nasi Ayam Pop + Terong  Teri',
          subtitle: 'Rp. 26.000',
          imagePath: 'assets/images/Paket ayam pop + terong teri_.jpg',
          initialStock: 0,
        ),
      ],
      'Minuman': [
        const MenuCardWithActions(
          title: 'Es Jeruk',
          subtitle: 'Rp. 10.000',
          imagePath: 'assets/images/esjeruk.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Es Teh Manis',
          subtitle: 'Rp. 7.000',
          imagePath: 'assets/images/teh.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Es Teh Tarik',
          subtitle: 'Rp. 15.000',
          imagePath: 'assets/images/tehtarik.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Air Mineral',
          subtitle: 'Rp. 8.000',
          imagePath: 'assets/images/airmineral.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Jus Alpukat',
          subtitle: 'Rp. 17.000',
          imagePath: 'assets/images/jusalpukat.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Jus Mangga',
          subtitle: 'Rp. 17.000',
          imagePath: 'assets/images/jusmangga.png',
          initialStock: 0,
        ),
      ],
      'Lainnya': [
        const MenuCardWithActions(
          title: 'Tahu Goreng',
          subtitle: 'Rp. 5.000',
          imagePath: 'assets/images/tahugoreng.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Tempe Goreng',
          subtitle: 'Rp. 5.000',
          imagePath: 'assets/images/tempegoreng.png',
          initialStock: 0,
        ),
        const MenuCardWithActions(
          title: 'Tumis Toge',
          subtitle: 'Rp. 8.000',
          imagePath: 'assets/images/tumistoge.png',
          initialStock: 0,
        ),
      ],
        
      
      // Daftar kategori lainnya
    };

    // Add new products to the 'Semua' category
    menuData['Semua']!.addAll(produkList.map((produk) {
      return MenuCardWithActions(
        title: produk['nama'],
        subtitle: 'Rp. ${produk['harga']}',
        imagePath: produk['imagePath'],
        initialStock: produk['stok'] ?? 0, // Pastikan stok ada di produk
      );
    }).toList());

    List<MenuCardWithActions> selectedMenuItems = menuData[selectedFilter]!;
    List<MenuCardWithActions> filteredMenuItems = selectedMenuItems
        .where((menuItem) => menuItem.title.toLowerCase().contains(searchQuery))
        .toList();

    if (filteredMenuItems.isEmpty) {
      return [
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 16.0),
              Text(
                'Produk tidak tersedia',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ];
    }

    return filteredMenuItems.map((menuItem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: menuItem,
      );
    }).toList();
  }

  Widget _buildFilterButton(IconData icon, String label) {
    bool isSelected = selectedFilter == label;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE00E0F) : const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: IconButton(
            icon: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                selectedFilter = label;
              });
            },
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}