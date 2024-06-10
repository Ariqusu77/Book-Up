import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class MyUploadPageUser extends StatefulWidget {
  const MyUploadPageUser({super.key});

  @override
  State<MyUploadPageUser> createState() => _MyUploadPageUserState();
}

class _MyUploadPageUserState extends State<MyUploadPageUser> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  String? _fileName;
  String? _path;
  String urlDownload = '';

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _path = result.files.single.path;
      });
    }

    await _uploadFile(File(_path!), _fileName!);
  }

  Future<void> _uploadFile(File file, String filename) async {
    var url = Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/joki-client-server.appspot.com/o?name=naskah/$filename');

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
        title: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Unggah',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 20,
              ),
            ),
          ),
        ),
        backgroundColor:
            const Color.fromRGBO(44, 194, 209, 1), // Warna biru untuk AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildFieldContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Judul:',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan judul',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildFieldContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tanggal:',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan tanggal',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildFieldContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Penulis:',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: authorController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan nama penulis',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildFieldContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'File:',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _openFileExplorer();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Pilih File',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'title': titleController.text,
                      'date': dateController.text,
                      'author': authorController.text,
                      'year': DateTime.now().year.toString(),
                      'contentUrl' : urlDownload,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: const Color.fromRGBO(44, 194, 209, 1),
                    side: BorderSide.none,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Kirim',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Times New Roman',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildFieldContainer({required Widget child}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      border:
          Border.all(width: 1.0, color: const Color.fromRGBO(44, 194, 209, 1)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    padding: const EdgeInsets.all(8.0),
    child: child,
  );
}
