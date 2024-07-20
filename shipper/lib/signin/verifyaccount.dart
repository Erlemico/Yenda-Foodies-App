import 'package:flutter/material.dart';
import 'resetpassword.dart'; // Sesuaikan dengan path halaman OTP reset password

class VerifyAccount extends StatelessWidget {
  final TextEditingController verificationController = TextEditingController();

  void _verifyAccount(BuildContext context) {
    String username = verificationController.text.trim(); // Ambil nilai dari TextField

    if (username.isEmpty) {
      // Jika nama pengguna kosong, tampilkan dialog peringatan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Peringatan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            backgroundColor: Color(0xFFE00E0F),
            content: Text(
              'Silakan isi nama pengguna terlebih dahulu!',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: Colors.white)), // Ubah warna teks menjadi putih
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      // Jika nama pengguna tidak kosong, lanjutkan verifikasi
      bool accountExists = checkAccountExists(username); // Ganti dengan logika sesungguhnya

      if (accountExists) {
        // Jika akun ditemukan, tampilkan dialog sukses dan navigasi ke OTP reset password
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Akun Ditemukan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Color(0xFFE00E0F),
              content: Text(
                'Akun dengan nama pengguna $username telah ditemukan.',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK', style: TextStyle(color: Colors.white)), // Ubah warna teks menjadi putih
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPassword()), // Navigasi ke halaman OTP reset password
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Jika akun tidak ditemukan, tampilkan dialog peringatan
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Akun Tidak Ditemukan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Color(0xFFE00E0F),
              content: Text(
                'Pastikan akun yang Anda masukkan terdaftar!',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK', style: TextStyle(color: Colors.white)), // Ubah warna teks menjadi putih
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  bool checkAccountExists(String username) {
    // Logika sederhana untuk mengecek keberadaan akun
    // Gantilah dengan logika sesungguhnya (misalnya panggil API atau cek database)
    // Contoh sederhana: kembalikan nilai true secara acak untuk simulasi
    return true; // Ubah ini dengan logika sesungguhnya (misalnya panggil API atau cek database)
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
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Konfirmasi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE00E0F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8), // Tambahkan jarak yang lebih kecil
                      Text(
                        'Silakan masukkan nama pengguna terlebih dahulu',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 80),
                      TextFormField(
                        controller: verificationController,
                        keyboardType: TextInputType.text,
                        cursorColor: const Color(0xFFE00E0F),
                        showCursor: true,
                        decoration: InputDecoration(
                          labelText: 'Nama Pengguna',
                          labelStyle: TextStyle(color: const Color(0xFFE00E0F)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                      SizedBox(height: 95),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _verifyAccount(context); // Panggil metode verifikasi saat tombol ditekan
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE00E0F),
                            minimumSize: Size(200, 45),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Color(0xFFE00E0F)),
                            ),
                          ),
                          child: Text(
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
