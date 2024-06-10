import 'package:flutter/material.dart';
import 'Admin/mainadmin.dart';
import 'User/mainuser.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyAdminPage()),
                  );
                },
                child: const Text('Admin-page')),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyUserPage()),
              );
            }, child: const Text('User-page')),
          ],
        ),
      ),
    );
  }
}
