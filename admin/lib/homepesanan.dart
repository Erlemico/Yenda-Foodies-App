import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'detailpesanan.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({super.key});

  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  String selectedFilter = 'Semua';
  List<Order> orders = [
    Order('1201241275', 'Selasa, 3 Januari 2024', 4, 55000, 'Diproses',
        Colors.blue, '12:30 PM'),
    Order('1201241214', 'Senin, 2 Januari 2024', 2, 60000, 'Selesai',
        Colors.green, '11:15 AM'),
    Order('1201241213', 'Senin, 2 Januari 2024', 3, 68000, 'Dibatalkan',
        Colors.red, '10:45 AM'),
  ];
  Order? selectedOrder;
  String selectedPage = 'Pesanan';

  void setSelectedFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  List<Order> get filteredOrders {
    if (selectedFilter == 'Semua') {
      return orders;
    } else {
      return orders.where((order) => order.status == selectedFilter).toList();
    }
  }

  void selectOrder(Order order) {
    setState(() {
      selectedOrder = order;
    });
  }

  void updatePaymentStatus(String status) {
    setState(() {
      if (selectedOrder != null) {
        selectedOrder = Order(
          selectedOrder!.orderId,
          selectedOrder!.date,
          selectedOrder!.quantity,
          selectedOrder!.price,
          status,
          selectedOrder!.statusColor,
          selectedOrder!.orderTime,
        );
      }
    });
  }

  void handleBackNavigation() {
    setState(() {
      selectedOrder = null; // Hide the order details
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Row(
      children: <Widget>[
        
        // Main content
        Expanded(
          child: Column(
            children: <Widget>[
              // Title Text
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: const Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Pesanan',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
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
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                FilterButton(
                                    'Semua',
                                    selectedFilter == 'Semua',
                                    setSelectedFilter),
                                const SizedBox(width: 2.0),
                                FilterButton(
                                    'Diproses',
                                    selectedFilter == 'Diproses',
                                    setSelectedFilter),
                                const SizedBox(width: 2.0),
                                FilterButton(
                                    'Selesai',
                                    selectedFilter == 'Selesai',
                                    setSelectedFilter),
                                const SizedBox(width: 2.0),
                                FilterButton(
                                    'Dibatalkan',
                                    selectedFilter == 'Dibatalkan',
                                    setSelectedFilter),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              children: filteredOrders.map((order) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderDetail(
                                          orderId: order.orderId,
                                          orderStatus: order.status,
                                          updatePaymentStatus:
                                              updatePaymentStatus,
                                          onPop: handleBackNavigation,
                                        ),
                                      ),
                                    ).then((_) =>
                                        handleBackNavigation()); // Ensure that back navigation updates the state
                                  },
                                  child: OrderCard(order, selectOrder),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Order details
                    if (selectedOrder != null)
                      Expanded(
                        flex: 3,
                        child: OrderDetail(
                          orderId: selectedOrder!.orderId,
                          orderStatus: selectedOrder!.status,
                          updatePaymentStatus: updatePaymentStatus,
                          onPop:
                              handleBackNavigation, // Handle back navigation
                        ),
                      ),
                  ],
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

// Other classes (FilterButton, OrderCard, OrderDetail, OrderItem, Order) remain the same.

class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function(String) onSelected;

  const FilterButton(this.text, this.isSelected, this.onSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFFE00E0F) : const Color(0xFFEBEBEB),
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      onPressed: () {
        onSelected(text);
      },
      child: Text(text),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  final Function(Order) onTap;

  const OrderCard(this.order, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);

    return GestureDetector(
      onTap: () => onTap(order),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10.0),
          constraints: const BoxConstraints(maxWidth: 600), // Set max width for desktop
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Orders ID: #${order.orderId}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(order.date),
                    Text('Qty: ${order.quantity}'),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    order.orderTime,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: <Widget>[
                      Text(
                        currencyFormatter.format(order.price),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        order.status,
                        style: TextStyle(color: order.statusColor),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}