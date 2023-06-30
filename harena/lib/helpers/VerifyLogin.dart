import 'dart:convert';
import 'dart:io';
import 'dart:js';
import 'dart:js_util';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class Uservalidate {
  static bool validated = false;
  static Future<bool> verifyLogin(
      {required String phonenumber, required String password}) async {
    if (kDebugMode) {
      print("checking for login $password and $phonenumber");
    }
    String url = "http://localhost:5000/custom/loginmobile";
    
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
            <String, String>{"phonenumber": phonenumber, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      int status = response.statusCode;
      print(status);
      var jsonData = jsonDecode(response.body);
      String token = jsonData['u'];
      print("the token is $token ");
      if (status == 200) {
        validated = true;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('u', token);
      } else {
        validated = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      validated = false;
    }
    return validated;
  }
}
