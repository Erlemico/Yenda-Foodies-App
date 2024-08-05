import 'dart:io'; // Hapus ini jika tidak digunakan di web
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  _TambahProdukPageState createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final TextEditingController _namaMenuController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void _tambahProduk() {
    final namaMenu = _namaMenuController.text;
    final harga = _hargaController.text;
    final deskripsi = _deskripsiController.text;

    if (namaMenu.isEmpty || harga.isEmpty || deskripsi.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua field dan tambahkan gambar produk')),
      );
      return;
    }

    final produk = {
      'nama': namaMenu,
      'harga': harga,
      'deskripsi': deskripsi,
      'imagePath': _image!.path,
    };

    Navigator.of(context).pop(produk); // Pass data back to previous screen

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produk berhasil ditambahkan')),
    );

    _namaMenuController.clear();
    _hargaController.clear();
    _deskripsiController.clear();
    setState(() {
      _image = null;
    });
  }

  void _batalTambah() {
    Navigator.of(context).pop(); // Just go back without passing data
  }

  @override
  void dispose() {
    _namaMenuController.dispose();
    _hargaController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Tambah Produk Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _image == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate, size: 50, color: Colors.red),
                          Text(
                            'Tambahkan foto produk',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      )
                    : kIsWeb
                        ? Image.network(_image!.path) // Gunakan Image.network untuk web
                        : Image.file(File(_image!.path)), // Gunakan Image.file untuk platform selain web
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _namaMenuController,
              decoration: InputDecoration(
                labelText: 'Nama Menu',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _hargaController,
              decoration: InputDecoration(
                labelText: 'Harga (Rp)',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Color(0xFFE00E0F), width: 1.5),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              maxLines: 3,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _tambahProduk,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A8A07),
                  ),
                  child: const Text('Tambah', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: _batalTambah,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE00E0F),
                  ),
                  child: const Text('Batal Tambah', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}