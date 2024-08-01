import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../home/dashboard.dart'; // Update with your actual import path

class ResetPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFE00E0F),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            top: MediaQuery.of(context).size.height * 0.03,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/logo/yendafoodies.png',
                width: 250,
                height: 130,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 0),
            top: (MediaQuery.of(context).size.height - 400) / 2,  // Center vertically
            left: (MediaQuery.of(context).size.width - 430) / 2,  // Center horizontally
            child: Container(
              width: 430,
              height: 500,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Ubah Kata Sandi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE00E0F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(text: 'Masukkan email dan kata sandi baru'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Color(0xFFE00E0F), width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.red, width: 1.5),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: newPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        cursorColor: const Color(0xFFE00E0F),
                        decoration: InputDecoration(
                          labelText: 'Masukkan Kata Sandi Baru',
                          labelStyle: const TextStyle(color: Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Color(0xFFE00E0F), width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.red, width: 1.5),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        cursorColor: const Color(0xFFE00E0F),
                        decoration: InputDecoration(
                          labelText: 'Masukkan Ulang Kata Sandi',
                          labelStyle: const TextStyle(color: Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Color(0xFFE00E0F), width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.red, width: 1.5),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            String email = emailController.text.trim();
                            String newPassword = newPasswordController.text.trim();
                            String confirmPassword = confirmPasswordController.text.trim();

                            if (email.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
                              // Handle empty fields
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Error',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                      'Semua kolom harus diisi',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: const Color(0xFFE00E0F),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (newPassword != confirmPassword) {
                              // Handle password mismatch
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Error',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                      'Kata sandi tidak sesuai',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: const Color(0xFFE00E0F),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // Password reset logic
                              final response = await http.post(
                                Uri.parse('http://localhost:8000/api/staff/forgot-password/reset-password'),
                                headers: <String, String>{
                                  'Content-Type': 'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, String>{
                                  'email': email,
                                  'new_password': newPassword,
                                  'confirm_password': confirmPassword,
                                }),
                              );

                              if (response.statusCode == 200) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Dashboard()),
                                );
                              } else {
                                // Handle error
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Error',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        jsonDecode(response.body)['message'] ?? 'Terjadi kesalahan',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: const Color(0xFFE00E0F),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50),
                            backgroundColor: const Color(0xFFE00E0F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text(
                            'Kirim',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
