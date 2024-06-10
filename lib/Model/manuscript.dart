import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String? dataUrl = "https://client-and-server-default-rtdb.firebaseio.com/Books";

List<Map<String, dynamic>> flattenJsonToList(Map<String, dynamic> jsonData) {
  List<Map<String, dynamic>> flattenedList = [];

  jsonData.forEach((key, value) {
    Map<String, dynamic> book = {
      'key': key,
      'title': value['title'],
      'date': value['date'],
      'status': value['status'],
      'year' : value['year'],
      'author' : value['author'],
      'feedback' : value['feedback'],
      'contentUrl' : value['contentUrl'],
      'content' : value['content'],
      'coverUrl' : value['coverUrl'],
      'cover' : value['cover'],
    };
    flattenedList.add(book);
  });

  return flattenedList;
}

Future<void> postData(Map<String, dynamic> data) async {
  final response = await http.post(
    Uri.parse('$dataUrl.json'),
    body: json.encode(data),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    if (kDebugMode) {
      print('Data posted successfully');
    }
  } else {
    if (kDebugMode) {
      print('Failed to post data: ${response.statusCode}');
    }
  }
}

Future<Map<String, dynamic>?> getData() async {
  final response = await http.get(Uri.parse('$dataUrl.json'));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  } else {
    if (kDebugMode) {
      print('Failed to get data: ${response.statusCode}');
    }
    return null;
  }
}

Future<void> deleteData(String key) async {
  final response = await http.delete(Uri.parse('$dataUrl/$key.json'));

  if (response.statusCode == 200) {
    if (kDebugMode) {
      print('Data deleted successfully');
    }
  } else {
    if (kDebugMode) {
      print('Failed to delete data: ${response.statusCode}');
    }
  }
}

Future<void> putData(String key, Map<String, dynamic> data) async {
  final response = await http.put(
    Uri.parse('$dataUrl/$key.json'),
    body: json.encode(data),
  );

  if (response.statusCode == 200) {
    if (kDebugMode) {
      print('Data updated successfully');
    }
  } else {
    if (kDebugMode) {
      print('Failed to update data: ${response.statusCode}');
    }
  }
}


