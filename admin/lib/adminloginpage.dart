import 'package:flutter/material.dart';
import 'dashboardadminpage.dart';
import 'forgotpasswordpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    // Delay the animation to start after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFE00E0F),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            top: _animate ? MediaQuery.of(context).size.height * 0.1 : MediaQuery.of(context).size.height,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 430,
                height: 550,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  ),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 5),
                        Center(
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            margin: EdgeInsets.only(top: _animate ? MediaQuery.of(context).size.height * 0.03 : -150),
                            child: Image.asset(
                              'assets/images/yendalogo.png',
                              width: 150,
                              height: 150,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Selamat Datang Admin!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE00E0F),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          cursorColor: const Color(0xFFE00E0F),
                          showCursor: true,
                          decoration: InputDecoration(
                            labelText: 'Masukkan Nomor Karyawan',
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
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          cursorColor: const Color(0xFFE00E0F),
                          showCursor: true,
                          decoration: InputDecoration(
                            labelText: 'Masukkan Kata Sandi',
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
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                              );
                            },
                            child: const Text(
                              'Lupa Kata Sandi?',
                              style: TextStyle(
                                color: Color(0xFFE00E0F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50), // Adjust the height as needed
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 275,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Validasi nomor telepon dan password
                                String phoneNumber = phoneNumberController.text.trim();
                                String password = passwordController.text.trim();

                                if (phoneNumber.isEmpty || password.isEmpty) {
                                  // Menampilkan pesan error jika ada field yang kosong
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Error',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                        content: const Text(
                                          'Masukan Nama Pengguna dan Kata Sandi Terlebih Dahulu',
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
                                  // Simulasi sign in berhasil
                                  // Navigasi ke halaman HomeScreen setelah sign in berhasil
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const DashboardPage()),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE00E0F),
                                minimumSize: const Size(275, 20),
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
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
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
