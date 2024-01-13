import 'package:flutter/material.dart';
import 'package:siujaya/ProfilePage.dart';
import 'package:siujaya/home.dart';
import 'package:siujaya/mata_kuliah.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationsPage(); // Set NotificationsPage as the content of HomeScreen
  }
}

class NotificationsPage extends StatelessWidget {
  int currentPageIndex = 2; // Index untuk halaman Notifikasi
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: const BoxDecoration(
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
            const Text(
              'Notifikasi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: [
                  TaskCard(
                    task: 'Tugas 1',
                    taskTitle: 'Advance Mobile Programming',
                    taskDescription: 'Deadline',
                    taskDeadline: 'Hari Kamis, 23.59 WIB',
                  ),
                  TaskCard(
                    task: 'Presensi',
                    taskTitle: 'Advance Mobile Programming',
                    taskDescription: 'Sedang Berlangsung',
                    taskDeadline: 'Sampai 12.00 WIB',
                  ),
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

class TaskCard extends StatelessWidget {
  final String task;
  final String taskTitle;
  final String taskDescription;
  final String taskDeadline;

  TaskCard({
    required this.task,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDeadline,
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
              task,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              taskTitle,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              taskDescription,
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              taskDeadline,
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
