import 'package:flutter/material.dart';
import 'package:homemenu/adminloginpage.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String selectedPage = 'Akun';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: <Widget>[
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Akun',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(thickness: 1, color: Colors.black),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/fotoprofil.png'),
                          ),
                          const SizedBox(height: 20),
                          const UserInfo(label: 'ID Staff', value: '120328231'),
                          const UserInfo(label: 'Nama', value: 'Laras Maulidya'),
                          const UserInfo(
                              label: 'Email', value: 'kiranasufi@gmail.com'),
                          const UserInfo(
                              label: 'Nomor Telepon',
                              value: '+62 878 8181 4646'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE00E0F),
                            ),
                            child: const Text('Keluar',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  
}

class UserInfo extends StatelessWidget {
  final String label;
  final String value;

  const UserInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.start, // Align the entire row to the start (left)
        children: <Widget>[
          Expanded(
            flex: 2, // Adjust flex values as needed
            child: Text(
              label,
              textAlign: TextAlign.left, // Align label text to the left
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(width: 20), // Increase the spacing between label and value
          Expanded(
            flex: 3, // Adjust flex values as needed
            child: Text(
              value,
              textAlign: TextAlign.right, // Align value text to the right
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}