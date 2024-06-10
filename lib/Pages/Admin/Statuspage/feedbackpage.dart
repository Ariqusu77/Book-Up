import 'package:flutter/material.dart';
import 'package:appclient/Model/manuscript.dart';

class MyFeedbackPage extends StatelessWidget {
  final Map<String, dynamic> manuscript;

  const MyFeedbackPage({super.key, required this.manuscript});

  @override
  Widget build(BuildContext context) {
    final List<String> months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    final TextEditingController feedbackController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Umpan Balik',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(44, 194, 209, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Berikan umpan balik untuk naskah "${manuscript['title']}"',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: feedbackController,
              maxLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan umpan balik Anda di sini',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implementasikan logika penyimpanan umpan balik di sini
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Umpan balik berhasil dikirim')),
                );
                manuscript['date'] =
                    "${DateTime.now().day} ${months[DateTime.now().month]} ${DateTime.now().year}";
                manuscript['status'] = 'Ditolak';
                manuscript['feedback'] = feedbackController.text;
                putData(manuscript['key'], manuscript);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(44, 194, 209, 1),
              ),
              child: const Text(
                'Kirim Umpan Balik',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
