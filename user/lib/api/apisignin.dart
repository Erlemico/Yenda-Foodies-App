import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiSignIn {
  final String apiUrl = 'http://localhost:8000/api/customers/signin';

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
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        return {
          'status': true,
          'message': responseBody['message'],
          'customer': responseBody['customer'], // Pastikan respons memiliki struktur ini
        };
      } else {
        throw Exception(responseBody['message'] ?? 'Gagal masuk');
      }
    } else {
      throw Exception('Gagal masuk');
    }
  }
}
