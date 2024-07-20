import 'package:flutter/material.dart';
import '../cart/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  final String image;
  final String itemName;
  final String itemDescription;
  final String itemPrice;

  // Contoh rating, bisa diganti dengan logika rating sesungguhnya
  final double rating = 4.5;

  ProductDetailScreen({
    required this.image,
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1; // Jumlah awal

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  bool _animate = false;

  @override
  void initState() {
    super.initState();
    // Menunda animasi untuk dimulai setelah layar dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE00E0F), // Warna latar belakang
        title: Text(
          'Detail',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Aksi tombol tutup
          },
        ),
      ),
      extendBodyBehindAppBar: true, // Memperluas body di belakang app bar
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFE00E0F), // Warna latar belakang
          ),
          AnimatedOpacity(
            opacity: _animate ? 1.0 : 0.0,
            duration: Duration(seconds: 1), // Durasi animasi
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3, // Tinggi latar belakang merah (30% dari tinggi layar)
                  color: const Color(0xFFE00E0F), // Warna latar belakang merah
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 60),
                                Center(
                                  child: Text(
                                    widget.itemName,
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Center(
                                  child: Text(
                                    'Rp ${widget.itemPrice}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFFE00E0F),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 20),
                                      SizedBox(width: 4),
                                      Text(
                                        '${widget.rating}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  textAlign: TextAlign.center,
                                  widget.itemDescription, // Menampilkan deskripsi produk
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: decrementQuantity,
                                      child: Icon(Icons.remove, color: Color(0xFF000000)), // Warna ikon
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFF0F0F0), // Warna tombol
                                        shape: CircleBorder(),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                      '$quantity',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: incrementQuantity,
                                      child: Icon(Icons.add, color: Color(0xFFFFFFFF)), // Warna ikon
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFE00E0F), // Warna tombol
                                        shape: CircleBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    // Menambahkan produk ke keranjang dan menampilkan notifikasi snackbar
                                    _addToCart(widget.itemName, widget.itemPrice, quantity);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFE00E0F), // Warna tombol
                                    textStyle: TextStyle(color: Colors.white), // Warna teks
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    child: Text('Tambah ke Keranjang', style: TextStyle(fontSize: 14, color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2, // Menyesuaikan posisi gambar
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 143,
                height: 159,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Menambahkan border radius
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Menggunting gambar agar memiliki border radius
                  child: Image.asset(
                    widget.image,
                    width: 143,
                    height: 159,
                    fit: BoxFit.cover, // Memastikan gambar mencakup seluruh container
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(String itemName, String itemPrice, int quantity) {
    // Mencari apakah produk sudah ada dalam keranjang
    bool found = false;
    CartScreen.cartItems.forEach((item) {
      if (item['name'] == itemName) {
        // Jika ditemukan, tambahkan quantity dan tampilkan snackbar
        found = true;
        item['quantity'] += quantity;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$quantity $itemName berhasil ditambahkan ke keranjang'),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Buka Keranjang',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
            ),
          ),
        );
      }
    });

    // Jika tidak ditemukan, tambahkan produk baru ke keranjang
    if (!found) {
      Map<String, dynamic> newItem = {
        'name': itemName,
        'price': itemPrice,
        'image': widget.image,
        'description': widget.itemDescription,
        'quantity': quantity,
      };
      CartScreen.addToCart(newItem); // Tambahkan produk baru ke keranjang
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$quantity $itemName berhasil ditambahkan ke keranjang'),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Buka Keranjang',
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ),
      );
    }
  }
}