import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'resetpassword.dart';

class VerifyAccount extends StatelessWidget {
  final TextEditingController verificationController = TextEditingController();

  Future<void> _verifyAccount(BuildContext context) async {
    String email = verificationController.text.trim();

    if (email.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Peringatan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            backgroundColor: const Color(0xFFE00E0F),
            content: const Text(
              'Silakan isi email terlebih dahulu!',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/staff/forgot-password/verify-email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Email': email,
        }),
      );

      if (response.statusCode == 200) {
        // If the server returns an OK response, show success dialog and navigate to reset password screen
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Akun Ditemukan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: const Color(0xFFE00E0F),
              content: Text(
                'Akun dengan email $email telah ditemukan.',
                style: const TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPassword()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        // If the server returns an error response, show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Akun Tidak Ditemukan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: const Color(0xFFE00E0F),
              content: const Text(
                'Pastikan email yang Anda masukkan terdaftar!',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK', style: TextStyle(color: Colors.white)),
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
  }

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
            top: (MediaQuery.of(context).size.height - 300) / 2,  // Center vertically
            left: (MediaQuery.of(context).size.width - 430) / 2,  // Center horizontally
            child: Container(
              width: 430,
              height: 400,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Konfirmasi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE00E0F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Silakan masukkan email terlebih dahulu',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 80),
                      TextFormField(
                        controller: verificationController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: const Color(0xFFE00E0F),
                        showCursor: true,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Color(0xFFE00E0F), width: 2),
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
                      const SizedBox(height: 95),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _verifyAccount(context); // Call verification method on button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE00E0F),
                            minimumSize: const Size(200, 45),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Color(0xFFE00E0F)),
                            ),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
