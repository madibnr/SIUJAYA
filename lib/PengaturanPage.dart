import 'package:flutter/material.dart';

class PengaturanPage extends StatefulWidget {
  @override
  _PengaturanPageState createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  bool notifikasiDiaktifkan = false;
  bool kunciAplikasiDiaktifkan = false;
  String kunciAplikasi = ''; // Menyimpan pola kunci aplikasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSwitchRow(Icons.notifications, 'Aktifkan Notifikasi', notifikasiDiaktifkan, (value) {
              setState(() {
                notifikasiDiaktifkan = value;
              });
            }),
            SizedBox(height: 20),
            buildSwitchRow(Icons.lock, 'Aktifkan Kunci Aplikasi', kunciAplikasiDiaktifkan, (value) {
              setState(() {
                kunciAplikasiDiaktifkan = value;
                if (!kunciAplikasiDiaktifkan) {
                  kunciAplikasi = ''; // Reset pola kunci saat kunci aplikasi dinonaktifkan
                }
                if (kunciAplikasiDiaktifkan && kunciAplikasi.isEmpty) {
                  // Jika kunci aplikasi diaktifkan, namun pola kunci belum ditetapkan, tampilkan dialog untuk menetapkan pola
                  _showSetPolaDialog();
                }
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget buildSwitchRow(IconData icon, String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Text(label),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Future<void> _showSetPolaDialog() async {
    String? newPola = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Pola Kunci Aplikasi'),
          content: TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Masukkan Pola'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('newPola');
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (newPola != null && newPola.isNotEmpty) {
      setState(() {
        kunciAplikasi = newPola;
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: PengaturanPage(),
  ));
}
