import 'package:flutter/material.dart';

class MyProfilePageUser extends StatelessWidget {
  const MyProfilePageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Profil')),
        backgroundColor: const Color.fromRGBO(44, 194, 209, 1),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20),
          Center(
            child: ClipOval(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  'images/wall.jpg', // Ubah sesuai dengan URL gambar profil Anda
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Bastian Wallner',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
              height: 20), // Tambahkan jarak antara Avatar dan ListTiles
          _buildListTile('Nama', 'Bastian Wallner'),
          _buildListTile('Email', 'wallners@example.com'),
          _buildListTile('Pengaturan', ''),
          _buildListTile('Privasi & Keamanan', ''),
          _buildListTile('Bantuan & Dukungan', ''),
          _buildListTile('Keluar', ''),
        ],
      ),
    );
  }
}

Widget _buildListTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      onTap: () {
        // Tambahkan logika untuk menu
      },
      tileColor: Colors.transparent,
      hoverColor: const Color.fromRGBO(44, 194, 209, 1).withOpacity(0.1),
      focusColor: const Color.fromRGBO(44, 194, 209, 1).withOpacity(0.1),
      splashColor: const Color.fromRGBO(44, 194, 209, 1).withOpacity(0.1),
    );
  }