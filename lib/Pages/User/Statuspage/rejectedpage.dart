import 'package:flutter/material.dart';

class MyRejectedPageUser extends StatelessWidget {
  final Map<String, dynamic> manuscript;

  const MyRejectedPageUser({super.key,required this.manuscript});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ditolak'),
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
                Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/cover%2F${manuscript['cover']}?alt=media&token=${manuscript['coverUrl']}"
                        ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
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
                    'Umpan Balik',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildFeedbackBox(
                            manuscript['feedback']),
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