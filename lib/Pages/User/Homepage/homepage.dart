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
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2F1.jpg?alt=media&token=a7c2da09-4bfe-4d0c-bee9-670619a48684"
                        ), // Ubah sesuai dengan path gambar latar belakang
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
            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Finner%20child.png?alt=media&token=e1296ddb-721f-4676-a8b6-06c58281e7ec',
            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fisabella.png?alt=media&token=514563a5-0b06-4b20-bd68-9f123249116b',
            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Flove%20brings%20you%20home.png?alt=media&token=f68aa02c-1bf4-4bd8-87df-687a635c9df1',
            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Falone.png?alt=media&token=28e4bb59-2d82-4e5b-bcbf-a3f59f119428',
            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fone%20night.png?alt=media&token=bc5c486a-7b6e-42c5-860f-93cf52b329cc',
          ]),
          const SizedBox(height: 20),
          _buildSectionTitle('Terbaru'),
          _buildHorizontalBookList([
            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fsilence.png?alt=media&token=c8b72563-6d86-4a57-acce-7d9f7e533de5',
            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2FThe%20Art%20of%20Living.png?alt=media&token=83e1938f-74fb-45d3-9263-a6b4e2ef133a',
            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fthe%20sound%20of%20silence.png?alt=media&token=c5016c61-f315-42c4-a1bd-2278ab39fc2a',
            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fwinter.png?alt=media&token=584a04c4-de08-417b-a738-8a5893785237',
            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fyoung%20wizard.png?alt=media&token=7914176d-02fd-4958-8a0e-04d519a4a9ba',
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
                image: NetworkImage(bookCovers[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }