import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KrsPage(),
    );
  }
}

class KrsPage extends StatefulWidget {
  @override
  _KrsPageState createState() => _KrsPageState();
}

class _KrsPageState extends State<KrsPage> {
  List<Map<String, dynamic>> krsData = [];

  @override
  void initState() {
    super.initState();
    loadKrsData();
  }

  void loadKrsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? krsJson = prefs.getString('krs');
    if (krsJson != null) {
      setState(() {
        krsData = List<Map<String, dynamic>>.from(json.decode(krsJson));
      });
    }
  }

  void saveKrsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String krsJson = json.encode(krsData);
    prefs.setString('krs', krsJson);
  }

  void generatePdf() {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Table.fromTextArray(
          context: context,
          data: [
            ['No.', 'Mata Kuliah', 'SKS', 'Jadwal'],
            for (int i = 0; i < krsData.length; i++)
              [i + 1, krsData[i]['mataKuliah'], krsData[i]['sks'], krsData[i]['jadwal']],
          ],
        ),
      ),
    );

    pdf.save().then((value) {
      // Implement file saving logic here
      // You can use plugins like `path_provider` to get the directory
      // and save the file
    });
  }

  Future<void> _showAddDialog() async {
    TextEditingController mataKuliahController = TextEditingController();
    TextEditingController sksController = TextEditingController();
    TextEditingController jadwalController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Mata Kuliah'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: mataKuliahController,
                  decoration: const InputDecoration(labelText: 'Mata Kuliah'),
                ),
                TextField(
                  controller: sksController,
                  decoration: const InputDecoration(labelText: 'SKS'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: jadwalController,
                  decoration: const InputDecoration(labelText: 'Jadwal'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  krsData.add({
                    'mataKuliah': mataKuliahController.text,
                    'sks': int.parse(sksController.text),
                    'jadwal': jadwalController.text,
                  });
                  saveKrsData();
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditDialog(int index) async {
    TextEditingController mataKuliahController =
    TextEditingController(text: krsData[index]['mataKuliah']);
    TextEditingController sksController =
    TextEditingController(text: krsData[index]['sks'].toString());
    TextEditingController jadwalController =
    TextEditingController(text: krsData[index]['jadwal']);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Mata Kuliah'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: mataKuliahController,
                  decoration: const InputDecoration(labelText: 'Mata Kuliah'),
                ),
                TextField(
                  controller: sksController,
                  decoration: const InputDecoration(labelText: 'SKS'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: jadwalController,
                  decoration: const InputDecoration(labelText: 'Jadwal'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  krsData[index]['mataKuliah'] = mataKuliahController.text;
                  krsData[index]['sks'] = int.parse(sksController.text);
                  krsData[index]['jadwal'] = jadwalController.text;
                  saveKrsData();
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteDialog(int index) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Mata Kuliah'),
          content: const Text('Apakah Anda yakin ingin menghapus mata kuliah ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  krsData.removeAt(index);
                  saveKrsData();
                });
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KRS'),
        toolbarHeight: 50, // Sesuaikan dengan kebutuhan Anda
      ),
    body: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('asset/Images/bg.jpg'), // replace with your image path
    fit: BoxFit.cover,
    ),
    ),
    child : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showAddDialog();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF5C42C4),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: const Size(150, 40), // Atur lebar dan tinggi sesuai kebutuhan
                ),
                child: const Text('Isi KRS'),
              ),
              ElevatedButton(
                onPressed: () {
                  generatePdf();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF5C42C4),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: const Size(150, 40), // Atur lebar dan tinggi sesuai kebutuhan
                ),
                child: const Text('Cetak KRS'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Semester 5',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          DataTable(
            dataRowHeight: 60, // Sesuaikan dengan kebutuhan Anda
            columns: [
              DataColumn(label: Text('No.')),
              DataColumn(label: Text('Mata Kuliah')),
              DataColumn(label: Text('SKS')),
              DataColumn(label: Text('Jadwal')),
              DataColumn(label: Text('Aksi')),
            ],
            rows: krsData.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> data = entry.value;

              return DataRow(
                cells: [
                  DataCell(Text('${krsData.indexOf(data) + 1}')),
                  DataCell(Text(data['mataKuliah'])),
                  DataCell(Text(data['sks'].toString())),
                  DataCell(Text(data['jadwal'])),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteDialog(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
                color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    // Warna baris tabel dengan abu-abu saat diaktifkan atau dihovver
                    if (states.contains(MaterialState.selected)) return Colors.blue;
                    return krsData.indexOf(data) % 2 == 0
                        ? Colors.grey[200]! // Atur warna abu-abu untuk baris genap
                        : Colors.transparent; // Biarkan baris ganjil tidak terwarnai
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
    );
  }
}
