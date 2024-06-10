import 'package:flutter/material.dart';

class MyPromoPageUser extends StatelessWidget {
  const MyPromoPageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo'),
        centerTitle: true,
        backgroundColor:
            const Color(0xFF2CC2D1), // Mengatur warna utama #2CC2D1
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bagian Atas: Gambar Iklan Memanjang
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                      image: const DecorationImage(
                        image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fbanner5.jpg?alt=media&token=14e6f013-3d20-4dea-806f-66c5ca90a027'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Special Big Deals, Flash Sale with 50% Discount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Bagian Tengah: Iklan Geser ke Samping
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Slide to See More',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildPromoCard('https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fpromo1.jpg?alt=media&token=6da9f32d-f15f-4870-b39f-8f1f2dc08054',
                            'Big Deals for You, up to 70% Off'),
                        _buildPromoCard(
                            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fpromo2.jpg?alt=media&token=1b6d806e-90bb-47f9-a84f-afedf6b57719', 'Coming Soon "One Night"'),
                        _buildPromoCard('https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fpromo3.jpg?alt=media&token=2512a8ab-dde2-4f95-ab33-78226ec9a114', 'Big Sale 50%'),
                        _buildPromoCard(
                            'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2Fpromo4.jpg?alt=media&token=3e42b81e-f94f-41c0-8691-73191152c055', 'Mega Sale Best Offer'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Bagian Bawah: Kotak Iklan dengan Gambar dan Deskripsi Teks
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: const Color.fromARGB(255, 207, 207, 207)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o/asset%2F3.jpg?alt=media&token=fcb8715d-832c-4d6e-a14e-d92305e0073e'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              'Cyber Monday Sale with 50% Discount',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPromoCard(String imagePath, String description) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.3),
                const Color.fromARGB(0, 185, 90, 90)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }