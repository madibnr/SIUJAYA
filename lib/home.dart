import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siujaya/presensi.dart';

import 'Jadwal.dart';
import 'KrsPage.dart';
import 'NotificationsPage.dart';
import 'ProfilePage.dart';
import 'TranskipPage.dart';
import 'mata_kuliah.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences _prefs;
  String _userName = '';
  String _userProdi = '';
  String _userFakultas = '';
  String _photoUrl = '';
  late HomeScreen homeScreen;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    print('userName from SharedPreferences: ${_prefs.getString('userName')}');
    print('userName: $_userName'); // Tambahkan print statements
    print('userProdi: $_userProdi');
    print('userFakultas: $_userFakultas');
    print('photoUrl: $_photoUrl');
    setState(() {
      _userName = _prefs.getString('userName') ?? 'Username';
      _userProdi = _prefs.getString('userProdi') ?? 'Prodi';
      _userFakultas = _prefs.getString('userFakultas') ?? '';
      _photoUrl = _prefs.getString('photoUrl') ?? '';
    });
  }


  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(
        userName: _userName,
        userProdi: _userProdi,
        userFakultas: _userFakultas,
        photoUrl: _photoUrl,
      ),

      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          // Navigation logic
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
              break;
            case 1:
            // Navigate to Profile page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListPage(),
                ),
              );
              break;
            case 2:
            // Navigate to Loan page (PeminjamanPage.dart)
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
            icon: InkWell(
                child: Icon(Icons.person)),
            label: 'Profile',
          ),
        ],
      ),


    );
  }
}

class HomeScreen extends StatelessWidget {
  late final String userName;
  late final String userProdi;
  late final String userFakultas;
  late final String photoUrl;

  HomeScreen({
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


    return Scaffold(
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('asset/Images/bg.jpg'), // replace with your image path
    fit: BoxFit.cover,
    ),
    ),
    child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: imageFile != null
                        ? Image.file(imageFile).image
                        : AssetImage('asset/Images/p.jpg') as ImageProvider,
                  ),
                ),
                const SizedBox(width: 10),
                // Kolom sebelah kanan berisi nama, prodi, dan fakultas
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      userName,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      userProdi,
                      style: const TextStyle(fontSize: 8),
                    ),
                    Text(
                      userFakultas,
                      style: const TextStyle(fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
            DashboardCard(),
            // Card tagihan dan pembayaran
            TagihanCard(),
            // IconButton untuk jadwal, presensi, KRS, dan transkrip nilai
            const SizedBox(height: 35),
            // IconButton untuk jadwal, presensi, KRS, dan transkrip nilai
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildRoundedButton(
                  'asset/icons/schedule_icon.png',
                  'Jadwal',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JadwalPage()),
                    );
                  },
                ),
                buildRoundedButton(
                  'asset/icons/presensi_icon.png',
                  'Presensi',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PresensiPage()),
                    );
                  },
                ),
                buildRoundedButton(
                  'asset/icons/krs_icon.png',
                  'KRS',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KrsPage()),
                    );
                  },
                ),
                buildRoundedButton(
                  'asset/icons/transkrip_nilai_icon.png',
                  'Transkrip',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TranskipPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
    ),
        ),
    );
  }
}

// Widget dan kelas lainnya di sini

Widget buildRoundedButton(String iconPath, String label, {VoidCallback? onPressed}) {
  return Column(
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFD4C9FF),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: IconButton(
          icon: Image.asset(
            iconPath,
            width: 24,
            height: 24,
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              print('Error loading image: $error');
              return const Icon(Icons.error_outline); // Tampilkan ikon kesalahan jika gambar tidak dapat dimuat
            },
          ),
          onPressed: onPressed,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
    ],
  );
}

class TagihanCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 2,
      margin: EdgeInsets.only(top: 25.0),
      color: Color(0xFF5C42C4),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Tagihan',
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Anda Telah Membayar',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 2,
      margin: EdgeInsets.only(top: 16.0),
      color: Color(0xFF5C42C4),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Semester 5 >',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white,),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '3.75',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
                    ),
                    Text(
                      'IPK Kumulatif',
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ],
                ),
                Divider( // Menambahkan garis pembatas di tengah
                  color: Colors.white,
                  thickness: 5.5,
                  height: 36,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '22',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      'SKS Tempuh',
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
