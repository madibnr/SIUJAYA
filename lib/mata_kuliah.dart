import 'package:flutter/material.dart';

import 'NotificationsPage.dart';
import 'ProfilePage.dart';
import 'home.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListPage(); // Set ListPage as the content of HomeScreen
  }
}

class ListPage extends StatelessWidget {
  int currentPageIndex = 1; // Index untuk halaman Notifikasi
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

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
      child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          const Text(
            'Mata Kuliah',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Semester 5 >',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                MatkulCard(
                  mataKuliah: '(5A) Advance Pemrograman Mobile',
                  ruangan: 'Lab. Gedung Utama 401 ',
                  tanggal: 'Hari Senin, 10.00 WIB',
                ),
                MatkulCard(
                  mataKuliah: '(5A) Sistem Informasi Geografis',
                  ruangan: 'Lab. Gedung Utama 401 ',
                  tanggal: 'Hari Selasa, 07.30 WIB',
                ),
                // Add more MatkulCard widgets as needed
              ],
            ),
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

class MatkulCard extends StatelessWidget {
  final String mataKuliah;
  final String ruangan;
  final String tanggal;

  MatkulCard({
    required this.mataKuliah,
    required this.ruangan,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Color(0xFF5C42C4),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$mataKuliah',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              '$ruangan',
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              ' $tanggal',
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
