import 'package:flutter/material.dart';

class MyHomePageUser extends StatefulWidget {
  const MyHomePageUser({super.key});

  @override
  State<MyHomePageUser> createState() => _MyHomePageUserState();
}

class _MyHomePageUserState extends State<MyHomePageUser> {
  // void _onItemTapped(int index) {
  //   if (index == 1) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => AdminPage()),
  //     );
  //   } else {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'images/1.jpg'), // Ubah sesuai dengan path gambar latar belakang
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 70,
                left: 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Cari buku...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        // Implement search functionality here
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('Populer'),
          _buildHorizontalBookList([
            'images/inner child.png',
            'images/isabella.png',
            'images/love brings you home.png',
            'images/alone.png',
            'images/one night.png',
          ]),
          const SizedBox(height: 20),
          _buildSectionTitle('Terbaru'),
          _buildHorizontalBookList([
            'images/silence.png',
            'images/The Art of Living.png',
            'images/the sound of silence.png',
            'images/winter.png',
            'images/young wizard.png',
          ]),
        ],
      ),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildHorizontalBookList(List<String> bookCovers) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bookCovers.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
              image: DecorationImage(
                image: AssetImage(bookCovers[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }