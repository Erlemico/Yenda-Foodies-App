import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiVerifyAccount {
  final String verifyEmailUrl = 'http://localhost:8000/api/customers/forgot-password/verify-email'; // Ganti dengan URL API Anda

  Future<Map<String, dynamic>> verifyEmail(String email) async {
    final response = await http.post(
      Uri.parse(verifyEmailUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'Email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify email');
    }
  }
}
