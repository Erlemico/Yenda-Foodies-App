import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiResetPassword {
  final String apiUrl = "http://localhost:8000/api/customers/forgot-password/reset-password";

  Future<Map<String, dynamic>> resetPassword(String email, String password, String confirmPassword) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'Email': email,
        'Password': password,
        'Password_confirmation': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to reset password');
    }
  }
}