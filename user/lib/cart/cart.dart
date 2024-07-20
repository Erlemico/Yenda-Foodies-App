import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../payment/paymentmethod.dart';

class CartScreen extends StatefulWidget {
  static List<Map<String, dynamic>> _cartItems = [];

  CartScreen({Key? key}) : super(key: key);

  static void addToCart(Map<String, dynamic> newItem) {
    _cartItems.add(newItem);
  }

  static int getCartItemCount() {
    return _cartItems.length;
  }

  static List<Map<String, dynamic>> get cartItems => _cartItems;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _noteController = TextEditingController();

  void _updateCartItemQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity == 0) {
        CartScreen._cartItems.removeAt(index);
      } else {
        CartScreen._cartItems[index]['quantity'] = newQuantity;
      }
    });
  }

  String _calculateTotalPrice() {
    int total = 0;
    CartScreen._cartItems.forEach((item) {
      String price = item['price'].replaceAll(RegExp(r'[^0-9]'), '');
      int quantity = item['quantity'];
      total += int.parse(price) * quantity;
    });
    final formatCurrency = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(total);
  }

  void _incrementQuantity(int index) {
    int currentQuantity = CartScreen._cartItems[index]['quantity'];
    _updateCartItemQuantity(index, currentQuantity + 1);
  }

  void _decrementQuantity(int index) {
    int currentQuantity = CartScreen._cartItems[index]['quantity'];
    if (currentQuantity > 1) {
      _updateCartItemQuantity(index, currentQuantity - 1);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hapus Produk', style: TextStyle(color: Colors.white)),
            content: Text('Apakah Anda yakin ingin menghapus produk dari keranjang?', style: TextStyle(color: Colors.white)),
            backgroundColor: const Color(0xFFE00E0F),
            actions: [
              TextButton(
                child: Text('Batal', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Hapus', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    CartScreen._cartItems.removeAt(index);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: CartScreen._cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 100, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Keranjang Kosong',
                    style: TextStyle(fontSize: 24, color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: CartScreen._cartItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    CartScreen._cartItems[index]['image'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        CartScreen._cartItems[index]['name'],
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        CartScreen._cartItems[index]['price'],
                                        style: TextStyle(fontSize: 16, color: Color(0xFFE00E0F), fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              _decrementQuantity(index);
                                            },
                                            child: Icon(Icons.remove, color: Color(0xFF000000)),
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(8),
                                              shape: CircleBorder(),
                                              minimumSize: Size(36, 36),
                                              backgroundColor: Color(0xFFF0F0F0),
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Text(
                                            '${CartScreen._cartItems[index]['quantity']}',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(width: 16),
                                          ElevatedButton(
                                            onPressed: () {
                                              _incrementQuantity(index);
                                            },
                                            child: Icon(Icons.add, color: Color(0xFFFFFFFF)),
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(8),
                                              shape: CircleBorder(),
                                              minimumSize: Size(36, 36),
                                              backgroundColor: Color(0xFFE00E0F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Catatan:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _noteController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Catatan tambahan',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Items:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${CartScreen.getCartItemCount()}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE00E0F)),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _calculateTotalPrice(),
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE00E0F)),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PaymentMethodScreen(totalPayment: _calculateTotalPrice())),
                            );
                          },
                          child: Text('Pesan', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            minimumSize: Size(270, 50),
                            backgroundColor: Color(0xFFE00E0F),
                          ),
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