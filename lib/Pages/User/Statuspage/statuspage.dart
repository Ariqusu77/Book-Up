import 'package:flutter/material.dart';
import 'package:appclient/Model/manuscript.dart';

import 'uploadpage.dart';
import 'rejectedpage.dart';
import 'acceptedpage.dart';

class MyStatusPageUser extends StatefulWidget {
  const MyStatusPageUser({super.key});

  @override
  State<MyStatusPageUser> createState() => _MyStatusPageUserState();
}

class _MyStatusPageUserState extends State<MyStatusPageUser> {
  List<Map<String, dynamic>> manuscripts = [];

  Future<void> _refresh() async {
    Map<String, dynamic>? data = await getData();
    setState(() {
      manuscripts = flattenJsonToList(data!);
    });
  }

  void _navigateToAccepted(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyAcceptedPageUser()),
    );
  }

  void _navigateToRejected(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyRejectedPageUser()),
    );
  }

  void _navigateToUpload(BuildContext context) async {
    final newManuscript = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => const MyUploadPageUser()),
    );
    if (newManuscript != null) {
      await postData({
        'title': newManuscript['title'],
        'date': "Sedang diproses",
        'status': "Ditunggu",
        'year': newManuscript['year'],
        'author': newManuscript['author'],
        'feedback' : '',
        'contentUrl' : newManuscript['contentUrl'],
        'coverUrl' : '',
      });
      _refresh();
    }
  }

  void _navigateToEdit(
      BuildContext context, Map<String, dynamic> manuscript) async {
    final newManuscript = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => const MyUploadPageUser()),
    );
    if (newManuscript != null) {
      manuscript['title'] = newManuscript['title'];
      manuscript['year'] = newManuscript['year'];
      manuscript['author'] = newManuscript['author'];
      manuscript['date'] = "Sedang diproses";
      manuscript['status'] = "Ditunggu";
      await putData(manuscript['key'], manuscript);
      _refresh();
    }
  }

  void _navigateToDelete(Map<String, dynamic> manuscript) async {
    await deleteData(manuscript['key']);
    _refresh();
  }

  Widget _buildAddButton() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(44, 194, 209, 1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _navigateToUpload(context);
        },
      ),
    );
  }

  Widget _buildStatusItem(Map<String, dynamic> manuscript, Color statusColor,
      Function(BuildContext) onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: () => onTap(context),
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        manuscript['title'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      manuscript['status'],
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Tanggal: ${manuscript['date']}',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  'Penulis: ${manuscript['author']}',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  'Tahun: ${manuscript['year']}',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (manuscript['status'] != 'Diterima')
                      ElevatedButton.icon(
                          onPressed: () {
                            _navigateToEdit(context, manuscript);
                          },
                          label: const Icon(Icons.edit)),
                    ElevatedButton.icon(
                        onPressed: () {
                          _navigateToDelete(manuscript);
                        },
                        label: const Icon(Icons.delete))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              children: manuscripts.map((manuscript) {
                Color statusColor = manuscript['status'] == 'Diterima'
                    ? Colors.green
                    : manuscript['status'] == 'Ditolak'
                        ? Colors.red
                        : Colors.orange;
                Function(BuildContext) onTap;
                if (manuscript['status'] == 'Diterima') {
                  onTap = _navigateToAccepted;
                } else if (manuscript['status'] == 'Ditolak') {
                  onTap = _navigateToRejected;
                } else {
                  onTap = (context) {};
                }
                return _buildStatusItem(
                  manuscript,
                  statusColor,
                  onTap,
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: _buildAddButton(),
            ),
          ),
        ],
      ),
    );
  }
}
