import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'album.dart';
import 'dart:convert';

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
  if (response.statusCode == 200) {
    if (kDebugMode) {
      print(response.body);
    }
    return Album.fromJson(jsonDecode(response.body));
  } else {
    if (kDebugMode) {
      print("object");
    }

    throw Exception("Failed to load");
  }
}
