import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siujaya/EditProfilePage.dart';
import 'package:siujaya/Login.dart';
import 'package:siujaya/PengaturanPage.dart';

import 'NotificationsPage.dart';
import 'home.dart';
import 'mata_kuliah.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentPageIndex = 3; // Index untuk halaman Notifikasi
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;


  late SharedPreferences _prefs;
  String _userName = '';
  String _userProdi = '';
  String _userFakultas = '';
  String _photoUrl = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    print('userName: $_userName'); // Tambahkan print statements
    print('userProdi: $_userProdi');
    print('userFakultas: $_userFakultas');
    print('photoUrl: $_photoUrl');

    setState(() {
      _userName = _prefs.getString('userName') ?? '';
      _userProdi = _prefs.getString('userProdi') ?? '';
      _userFakultas = _prefs.getString('userFakultas') ?? '';
      _photoUrl = _prefs.getString('photoUrl') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('asset/Images/bg.jpg'), // replace with your image path
    fit: BoxFit.cover,
    ),
    ),
    child : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Profil',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            UserProfile(
              userName: _userName,
              userProdi: _userProdi,
              userFakultas: _userFakultas,
              photoUrl: _photoUrl,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Pengaturan',
                style: TextStyle(fontSize: 12,), // Set a smaller font size
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PengaturanPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profil',
                style: TextStyle(fontSize: 12),
              ),
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                ).then((value) {
                  // Di sini kita reload data setelah selesai dari EditProfilePage
                  _loadUserData();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout',
                style: TextStyle(fontSize: 12),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
        ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          // Navigation logic
          switch (index) {
            case 0:
            // Navigate to Home page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
              break;
            case 1:
            // Navigate to Home page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListPage(),
                ),
              );
              break;
            case 2:
            // Stay on Notifications page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationsPage(),
                ),
              );
              break;

            case 3:
            // Navigate to Profile page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
              break;
            default:
              break;
          }
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: InkWell(child: Icon(Icons.person)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  final String userName;
  final String userProdi;
  final String userFakultas;
  final String photoUrl;

  UserProfile({
    required this.userName,
    required this.userProdi,
    required this.userFakultas,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    File? imageFile;

    if (photoUrl.isNotEmpty) {
      imageFile = File(photoUrl);
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: imageFile != null
                ? Image.file(imageFile).image
                : AssetImage('asset/Images/p.jpg') as ImageProvider,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          userName,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          userProdi,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
        Text(
          userFakultas,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}
