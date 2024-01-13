import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late SharedPreferences _prefs;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userProdiController = TextEditingController();
  TextEditingController _userFakultasController = TextEditingController();
  String _photoUrl = ''; // Store the image path
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    _userNameController.text = _prefs.getString('userName') ?? '';
    _userProdiController.text = _prefs.getString('userProdi') ?? '';
    _userFakultasController.text = _prefs.getString('userFakultas') ?? '';
    _photoUrl = _prefs.getString('photoUrl') ?? '';
  }

  Future<void> _saveUserData() async {
    await _prefs.setString('userName', _userNameController.text);
    await _prefs.setString('userProdi', _userProdiController.text);
    await _prefs.setString('userFakultas', _userFakultasController.text);
    await _prefs.setString('photoUrl', _photoUrl);
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photoUrl = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'Ubah Informasi Profil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _photoUrl.isNotEmpty
                    ? Image.file(File(_photoUrl)).image
                    : AssetImage('asset/Images/p.jpg') as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: 'Nama Pengguna',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _userProdiController,
              decoration: InputDecoration(
                labelText: 'Program Studi',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _userFakultasController,
              decoration: InputDecoration(
                labelText: 'Fakultas',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _saveUserData();
                Navigator.pop(context); // Kembali ke halaman sebelumnya setelah menyimpan
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
