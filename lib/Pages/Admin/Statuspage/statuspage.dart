import 'package:flutter/material.dart';
import 'manuscriptdetail.dart';
import 'package:appclient/Model/manuscript.dart';

class MyStatusPageAdmin extends StatefulWidget {
  const MyStatusPageAdmin({super.key});

  @override
  State<MyStatusPageAdmin> createState() => _MyStatusPageAdminState();
}

class _MyStatusPageAdminState extends State<MyStatusPageAdmin> {
  List<Map<String, dynamic>> manuscripts = [];

  Future<void> _refresh() async {
    Map<String, dynamic>? data = await getData();
    setState(() {
      manuscripts = flattenJsonToList(data!);
    });
  }

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(44, 194, 209, 1),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: manuscripts.length,
          itemBuilder: (context, index) {
            final manuscript = manuscripts[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(manuscript['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Penulis: ${manuscript['author']}'),
                    Text('Tanggal Pengiriman: ${manuscript['date']}'),
                  ],
                ),
                onTap: () {
                  if (manuscript['status'] == 'Ditunggu') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MyManuscriptDetailPage(manuscript: manuscript),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
