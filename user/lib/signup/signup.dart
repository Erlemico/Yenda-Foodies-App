import 'package:flutter/material.dart';
import '../signin/signin.dart'; // Sesuaikan dengan path yang benar
import '../home/home.dart'; // Sesuaikan dengan path yang benar

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFE00E0F),
          title: Text(
            'Sukses',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Akun berhasil dibuat!',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showWarningDialog(String fieldName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFE00E0F),
          title: Text(
            'Peringatan',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Field $fieldName tidak boleh kosong!',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
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
  }

  void _validateAndSubmit() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFE00E0F),
            title: Text(
              'Peringatan',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Lengkapi semua field terlebih dahulu!',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
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
      _showSuccessDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFE00E0F),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: _animate ? MediaQuery.of(context).size.height * 0.03 : -150,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/img.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: _animate ? MediaQuery.of(context).size.height * 0.3 : MediaQuery.of(context).size.height,
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
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 5), // Adjusted height here
                      Text(
                        'Buat Akun Baru',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE00E0F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: usernameController,
                        cursorColor: Color(0xFFE00E0F),
                        decoration: InputDecoration(
                          labelText: 'Masukkan Nama Pengguna',
                          labelStyle: TextStyle(color: Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Color(0xFFE00E0F),
                        decoration: InputDecoration(
                          labelText: 'Masukkan Email',
                          labelStyle: TextStyle(color: Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: phoneController,
                        cursorColor: Color(0xFFE00E0F),
                        decoration: InputDecoration(
                          labelText: 'Masukkan Nomor Telepon',
                          labelStyle: TextStyle(color: Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: Color(0xFFE00E0F),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Masukkan Kata Sandi',
                          labelStyle: TextStyle(color: Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFE00E0F), width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _validateAndSubmit,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Color(0xFFE00E0F)),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                        child: Text(
                          'Daftar',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignInScreen()),
                            );
                          },
                          child: Text(
                            'Sudah punya akun? Masuk di sini',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFE00E0F),
                              fontWeight: FontWeight.bold,
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
