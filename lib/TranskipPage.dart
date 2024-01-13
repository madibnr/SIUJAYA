import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TranskipPage(),
    );
  }
}

class TranskipPage extends StatelessWidget {
  final List<Map<String, dynamic>> transkipData = [
    {'mataKuliah': 'Pemograman Mobile', 'sks': 3, 'nilai': 'A', 'mutu': 4.0},
    {'mataKuliah': 'Sistem Informasi', 'sks': 4, 'nilai': 'B+', 'mutu': 3.5},
    // Tambahkan data mata kuliah lainnya sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transkip Nilai'),
      ),
    body: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('asset/Images/bg.jpg'), // replace with your image path
    fit: BoxFit.cover,
    ),
    ),
    child : Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Mengubah alignment menjadi start
        children: [
          Container(
            width: double.infinity, // Membuat tombol memenuhi lebar layar
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Menambahkan margin
            child: ElevatedButton(
              onPressed: () async {
                await _cetakTranskipNilaiPDF();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF5C42C4),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0), // Menambahkan padding
                child: Text('Cetak Transkip Nilai'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Semester 5 >',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView(
                children: [
                  DataTable(
                    dataRowHeight: 60,
                    columns: const [
                      DataColumn(label: Text('No.')),
                      DataColumn(label: Text('Mata Kuliah')),
                      DataColumn(label: Text('SKS')),
                      DataColumn(label: Text('Nilai')),
                      DataColumn(label: Text('Mutu')),
                    ],
                    rows: transkipData.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text('${transkipData.indexOf(data) + 1}')),
                          DataCell(Text(data['mataKuliah'])),
                          DataCell(Text(data['sks'].toString())),
                          DataCell(Text(data['nilai'])),
                          DataCell(Text(data['mutu'].toString())),
                        ],
                        color: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) return Colors.blue;
                            return transkipData.indexOf(data) % 2 == 0
                                ? Colors.white
                                : Colors.grey[200]!;
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey[200],
                    child: Text(
                      'Jumlah IPK Kumulatif: 3.75', // Ganti dengan nilai sebenarnya
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Future<void> _cetakTranskipNilaiPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Semester 5 - Teknik Informatika', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                data: [
                  ['No.', 'Mata Kuliah', 'SKS', 'Nilai', 'Mutu'],
                  for (int i = 0; i < transkipData.length; i++)
                    [
                      i + 1,
                      transkipData[i]['mataKuliah'],
                      transkipData[i]['sks'].toString(),
                      transkipData[i]['nilai'],
                      transkipData[i]['mutu'].toString(),
                    ],
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                padding: pw.EdgeInsets.all(10),
                color: PdfColors.grey200,
                child: pw.Text(
                  'Jumlah IPK Kumulatif: 3.75', // Ganti dengan nilai sebenarnya
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Simpan PDF ke penyimpanan lokal
    final File file = await _savePDF(pdf);

    // Bagikan file PDF
    if (file != null) {
      await Share.shareFiles([file.path], text: 'Sharing Transkip Nilai');
    }
  }

  Future<File> _savePDF(pw.Document pdf) async {
    final Directory directory = await getTemporaryDirectory();
    final String path = '${directory.path}/transkip_nilai.pdf';
    final File file = File(path);

    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
