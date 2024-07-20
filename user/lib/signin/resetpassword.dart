import 'package:flutter/material.dart';
import '../home/home.dart';

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
                'assets/images/logo/yendafoodies.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
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
                      SizedBox(height: 20),

                      // Reset Password
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          String newPassword = newPasswordController.text.trim();
                          String confirmPassword =
                              confirmPasswordController.text.trim();

                          if (newPassword.isEmpty || confirmPassword.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Error',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    'Mohon lengkapi semua kolom yang ada',
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
                                    'Salah',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    'Masukkan kata sandi yang sama',
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
                                    'Success',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    'Password successfully changed!',
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
                                            builder: (context) => HomeScreen(), // Navigate to home screen
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
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side:
                                BorderSide(color: const Color(0xFFE00E0F)),
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
