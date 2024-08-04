import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiSignUp {
  final String baseUrl = 'http://localhost:8000/api/customers/signup';

  Future<Map<String, dynamic>> signUp(String customerName, String email, String numberPhone, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'CustomerName': customerName,
        'Email': email,
        'NumberPhone': numberPhone,
        'Password': password,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }
}
