import 'package:flutter/material.dart';
import '../home/dashboard.dart';
import 'verifyaccount.dart';

class SignInScreen extends StatefulWidget {
  
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                      AnimatedPositioned(
                        duration: Duration(seconds: 1),
                        top: _animate ? MediaQuery.of(context).size.height * 0.03 : -150,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Selamat Datang Kembali!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE00E0F),
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
                          labelText: 'Masukkan Nama Pengguna',
                          labelStyle: TextStyle(color: const Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: const Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: const Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: const Color(0xFFE00E0F), width: 2),
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
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        cursorColor: const Color(0xFFE00E0F),
                        showCursor: true,
                        decoration: InputDecoration(
                          labelText: 'Masukkan Kata Sandi',
                          labelStyle: TextStyle(color: const Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: const Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: const Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: const Color(0xFFE00E0F), width: 2),
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
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VerifyAccount()),
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
                                      title: Text(
                                        'Error',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        'Masukan Nama Pengguna dan Kata Sandi Terlebih Dahulu',
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
                                // Simulasi sign in berhasil
                                // Navigasi ke halaman HomeScreen setelah sign in berhasil
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Dashboard()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE00E0F),
                              minimumSize: Size(275, 20),
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
