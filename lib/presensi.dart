import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        title: const Text('Presensi'),
        backgroundColor: Colors.white,
      ),
      body: HomeScreen(),
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
    return PresensiPage();
  }
}

class PresensiPage extends StatefulWidget {
  @override
  _PresensiPageState createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  String selectedAttendanceStatus = 'Presensi';

  @override
  void initState() {
    super.initState();
    _loadAttendanceStatus();
  }

  void _loadAttendanceStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedAttendanceStatus = prefs.getString('attendanceStatus') ?? 'Presensi';
    });
  }

  void _saveAttendanceStatus(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('attendanceStatus', status);
  }

  void _handleAttendance(String status) {
    print('Attendance status: $status');
    _saveAttendanceStatus(status);

    setState(() {
      selectedAttendanceStatus = status;
    });
  }

  void _showAttendanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Attendance Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Hadir'),
                onTap: () {
                  _handleAttendance('Hadir');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Sakit'),
                onTap: () {
                  _handleAttendance('Sakit');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Izin'),
                onTap: () {
                  _handleAttendance('Izin');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Pergi'),
                onTap: () {
                  _handleAttendance('Pergi');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presensi'),
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
                'Sedang Berlangsung >',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  TaskCard(
                    task: 'Presensi',
                    taskTitle: '(5A) Advance Mobile Programming',
                    taskDescription: 'Sampai 12.00 WIB',
                    attendanceStatus: selectedAttendanceStatus,
                    onAttendancePressed: () {
                      _showAttendanceDialog(context);
                    },
                    onSubmitPressed: () {
                      print('Submit Button Pressed');
                    },
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
  final String attendanceStatus;
  final VoidCallback onAttendancePressed;
  final VoidCallback onSubmitPressed;

  TaskCard({
    required this.task,
    required this.taskTitle,
    required this.taskDescription,
    required this.attendanceStatus,
    required this.onAttendancePressed,
    required this.onSubmitPressed,
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onAttendancePressed,
                  child: Text(attendanceStatus),
                ),
                ElevatedButton(
                  onPressed: onSubmitPressed,
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
