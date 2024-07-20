import 'package:flutter/material.dart';
import '../home/dashboard.dart';

class ResetPassword extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
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
            duration: Duration(seconds: 1),
            top: MediaQuery.of(context).size.height * 0.03,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/verifylogo.png', // Ganti dengan path gambar ikon verifikasi Anda
                width: 250,
                height: 130,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 0),
            top: (MediaQuery.of(context).size.height - 300) / 2,  // Center vertically
            left: (MediaQuery.of(context).size.width - 430) / 2,  // Center horizontally
            child: Container(
              width: 430,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ubah Kata Sandi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE00E0F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey, // Gray color
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(text: 'Masukkan kata sandi baru'),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: newPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        cursorColor: const Color(0xFFE00E0F),
                        decoration: InputDecoration(
                          labelText: 'Masukkan Kata Sandi Baru',
                          labelStyle: TextStyle(color: const Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: const Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: const Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: const Color(0xFFE00E0F), width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.red, width: 1.5),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        cursorColor: const Color(0xFFE00E0F),
                        decoration: InputDecoration(
                          labelText: 'Masukkan Ulang Kata Sandi',
                          labelStyle: TextStyle(color: const Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: const Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: const Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: const Color(0xFFE00E0F), width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.red, width: 1.5),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement reset password logic here
                            String newPassword = newPasswordController.text.trim();
                            String confirmPassword =
                                confirmPasswordController.text.trim();

                            if (newPassword.isEmpty || confirmPassword.isEmpty) {
                              // Handle empty fields (optional)
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Error',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Masukan kata sandi baru terlebih dahulu',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: const Color(0xFFE00E0F),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
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
                              // Handle password mismatch (optional)
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Error',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Kata sandi tidak sesuai',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: const Color(0xFFE00E0F),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
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
                              // Password reset successful (simulate success)
                              // Show success dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Berhasil',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Kata sandi Anda berhasil diubah',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: const Color(0xFFE00E0F),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close success dialog
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Dashboard(), // Navigate to home screen
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE00E0F),
                            minimumSize: Size(200, 20),  // Adjusted width to be smaller
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Color(0xFFE00E0F)),
                            ),
                          ),
                          child: Text(
                            'Simpan',
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