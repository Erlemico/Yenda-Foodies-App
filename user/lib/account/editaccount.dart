import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String userNickname;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userAddress;
  final String userPhotoURL; // Tambahkan variabel untuk URL gambar profil

  EditProfile({
    required this.userNickname,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
    required this.userPhotoURL, // Terima URL gambar profil dari AccountScreen
  });

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nicknameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: widget.userNickname);
    _phoneController = TextEditingController(text: widget.userPhone);
    _emailController = TextEditingController(text: widget.userEmail);
    _addressController = TextEditingController(text: widget.userAddress);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      String updatedNickname = _nicknameController.text;
      String updatedPhone = _phoneController.text;
      String updatedEmail = _emailController.text;
      String updatedAddress = _addressController.text;

      // Navigate back to previous screen
      Navigator.pop(context);
    }
  }

  void _editProfilePhoto() {
    print('Edit profile photo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: _editProfilePhoto,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: NetworkImage(widget.userPhotoURL),
                      child: Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                _buildTextField('Nickname', _nicknameController),
                _buildTextField('Username', TextEditingController(text: widget.userName), readOnly: true),
                _buildTextField('No. Telepon', _phoneController, keyboardType: TextInputType.phone),
                _buildTextField('Email', _emailController, keyboardType: TextInputType.emailAddress),
                _buildTextField('Nama Jalan', _addressController),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE00E0F),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Color(0xFFE00E0F)),
                      ),
                    ),
                    child: const Text(
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
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool readOnly = false, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: const Color(0xFFE00E0F)),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: const Color(0xFFE00E0F), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: const Color(0xFFE00E0F), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: const Color(0xFFE00E0F), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
