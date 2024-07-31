import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiSignIn {
  final String apiUrl = 'http://localhost:8000/api/customers/signin'; // Ganti dengan URL API Anda jika diperlukan

  Future<Map<String, dynamic>> signIn(String customerName, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'CustomerName': customerName,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign in');
    }
  }
}
