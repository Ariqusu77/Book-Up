import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:appclient/Model/manuscript.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class CoverUploadPage extends StatefulWidget {
  final Map<String, dynamic> manuscript;

  const CoverUploadPage({super.key, required this.manuscript});

  @override
  State<CoverUploadPage> createState() => _CoverUploadPageState();
}

class _CoverUploadPageState extends State<CoverUploadPage> {
  String? _fileName;
  String? _path;
  String urlDownload = '';

  final List<String> months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _path = result.files.single.path;
      });

      await _uploadFile(File(_path!), _fileName!);
    }
  }

  Future<void> _uploadFile(File file, String filename) async {
    var url = Uri.parse(// gs://client-and-server.appspot.com
        'https://firebasestorage.googleapis.com/v0/b/client-and-server.appspot.com/o?name=cover/$filename');

    var request = http.MultipartRequest('POST', url)
      ..files.add(http.MultipartFile(
        'file',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
      ));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Get the download URL of the uploaded file
        urlDownload = await _getDownloadUrl(response);
        if (kDebugMode) {
          print('File uploaded successfully!');
          print('Download URL: $urlDownload');
        }
      } else {
        if (kDebugMode) {
          print('Failed to upload file. Error: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading file: $e');
      }
    }
  }

  Future<String> _getDownloadUrl(http.StreamedResponse response) async {
    var jsonResponse = json.decode(await response.stream.bytesToString());
    return jsonResponse['downloadTokens'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Cover',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(44, 194, 209, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Upload cover buku '${widget.manuscript['title']}'",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            // Kolom untuk mengunggah file
            ElevatedButton.icon(
              onPressed: () {
                _openFileExplorer();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromRGBO(44, 194, 209, 1),
                backgroundColor: Colors.white,
              ),
              icon: const Icon(Icons.file_upload),
              label: const Text('Upload File'),
            ),
            const SizedBox(height: 20),
            // Kolom untuk memasukkan deskripsi cover buku
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Cover',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Kolom untuk tombol upload
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cover berhasil diupload')),
                );
                widget.manuscript['date'] =
                    "${DateTime.now().day} ${months[DateTime.now().month]} ${DateTime.now().year}";
                widget.manuscript['status'] = 'Diterima';
                widget.manuscript['coverUrl'] = urlDownload;
                widget.manuscript['cover'] = _fileName;
                putData(widget.manuscript['key'], widget.manuscript);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(44, 194, 209, 1),
              ),
              child: const Text(
                'Upload Cover',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
