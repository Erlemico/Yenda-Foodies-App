import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProduct {
  final String baseUrl = 'http://localhost:8000/api/products-by-name';

  Future<List<Map<String, dynamic>>> fetchMenuItems() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        List<dynamic> products = data['data'];
        return products.map((item) {
          return {
            'image': item['ImageProduct'],
            'name': item['ProductName'],
            'price': item['UnitPrice'].toString(),
            'description': item['Description'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load products: ${data['message']}');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
