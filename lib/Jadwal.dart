import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal'),
        backgroundColor: Colors.white,
      ),
      body: HomeScreen(), // Use HomeScreen as the body
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return JadwalPage(); // Set NotificationsPage as the content of HomeScreen
  }
}

class JadwalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal'),
        backgroundColor: Colors.white,
      ),
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
                  TaskCard(
                    task: 'Senin',
                    taskTitle: '(5A) Advance Mobile Programming',
                    taskDescription: 'Deadline',
                  ),
                  TaskCard(
                    task: 'Selasa',
                    taskTitle: '(5A) Sistem Informasi Geografis',
                    taskDescription: 'Lab. GU 401 , 07.30 WIB',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String task;
  final String taskTitle;
  final String taskDescription;

  TaskCard({
    required this.task,
    required this.taskTitle,
    required this.taskDescription,
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
          ],
        ),
      ),
    );
  }
}
