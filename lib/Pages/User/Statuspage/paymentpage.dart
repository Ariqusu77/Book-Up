import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPaymentPageUser extends StatelessWidget {
  final Map<String, dynamic> manuscript;

  const MyPaymentPageUser({super.key,required this.manuscript});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(44, 194, 209, 1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: 100,
                //   height: 150,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     image: DecorationImage(
                //       image: NetworkImage(
                //           "https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/cover%2F${manuscript['cover']}?alt=media&token=${manuscript['coverUrl']}"
                //         ),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                const SizedBox(width: 16),
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                           manuscript['title'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          manuscript['author'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          manuscript['year'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Progress Buku',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildFeedbackBox(
                            "Silahkan Untuk Menyelesaikan Pembayaran Terlebih Dahulu"),
                        // _buildFeedbackBox(
                        //     'Kami menghargai usaha Anda dalam menulis, namun naskah ini tidak sesuai dengan kriteria penerbitan kami saat ini.'),
                        // Tambahkan lebih banyak umpan balik sesuai kebutuhan
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    const url =
                        'https://wa.me/+6289518464287'; // Ganti nomor WhatsApp dengan nomor tujuan Anda
                    // ignore: deprecated_member_use
                    if (await canLaunch(url)) {
                      // ignore: deprecated_member_use
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    backgroundColor: const Color.fromRGBO(44, 194, 209, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Berikutnya',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget _buildFeedbackBox(String feedback) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2), // Warna bayangan biru
            spreadRadius: 3,
            blurRadius: 6,
            offset: const Offset(0, 3), // Perubahan posisi bayangan
          ),
        ],
      ),
      child: ListTile(
        title: Text(feedback),
      ),
    );
  }