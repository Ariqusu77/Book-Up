import 'package:flutter/material.dart';
import 'coveruppage.dart';
import 'feedbackpage.dart';
import 'package:appclient/Model/manuscript.dart';

class MyManuscriptDetailPage extends StatelessWidget {
  final Map<String, dynamic> manuscript;
  const MyManuscriptDetailPage({super.key, required this.manuscript});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          manuscript['title'],
          style: const TextStyle(
              color: Colors.white), // Mengubah warna teks judul menjadi putih
        ),
        centerTitle: true, // Memposisikan judul di tengah
        backgroundColor: const Color.fromRGBO(
            44, 194, 209, 1), // Mengatur latar belakang app bar menjadi biru
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Judul: ${manuscript['title']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Penulis: ${manuscript['author']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Tanggal Pengiriman: ${manuscript['date']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Kolom untuk melihat file
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika untuk melihat file
                  },
                  child: const Text(
                    'Lihat File',
                    style: TextStyle(
                      color: Color.fromRGBO(44, 194, 209,
                          1), // Mengubah warna teks tombol menjadi biru
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CoverUploadPage(manuscript: manuscript),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 56, 82,
                        228), // Mengubah warna latar belakang tombol menjadi biru
                  ),
                  child: const Text(
                    'Upload',
                    style: TextStyle(
                        color: Colors
                            .white), // Mengubah warna teks tombol menjadi putih
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Menunggu Pembayaran Penulis')),
                    );
                    manuscript['status'] = 'Menunggu Pembayaran';
                    putData(manuscript['key'], manuscript);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 170,
                        73), // Mengubah warna latar belakang tombol menjadi biru
                  ),
                  child: const Text(
                    'Terima',
                    style: TextStyle(
                        color: Colors
                            .white), // Mengubah warna teks tombol menjadi putih
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MyFeedbackPage(manuscript: manuscript),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33,
                        33), // Mengubah warna latar belakang tombol menjadi biru
                  ),
                  child: const Text(
                    'Tolak',
                    style: TextStyle(
                        color: Colors
                            .white), // Mengubah warna teks tombol menjadi putih
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
