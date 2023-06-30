import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:harena/models/category.dart';
import 'package:http/http.dart' as http;

// ignore: empty_constructor_bodies
class GetCategories {
  Future<List<Category>> getSubCategories(String broadname) async {
    List<Category> subcategories = [];
    String url = "http://localhost:5000/category/$broadname";
    var response = await http.get(Uri.parse(url));
    debugPrint(response.body.toString());
    int status = response.statusCode;
    print(status);
    if (status == 200 && response.body.isNotEmpty) {
      var jsonData = jsonDecode(response.body);
      debugPrint(jsonData["name"]);
      jsonData["Categories"].forEach((element) {
        Category category =
            Category(cid: element['cid'], name: element["cname"]);
        subcategories.add(category);
      });
      debugPrint(" the broad category length is ${subcategories.length}");
    }
    return subcategories;
  }
}
