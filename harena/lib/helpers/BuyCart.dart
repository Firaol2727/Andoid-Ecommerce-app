import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BuyCart {
  late bool addedcart;
  late bool buysuccess;
  late bool deletesuccess;
  bool loggedin = true;
  Future<void> addCart(int productid) async {
    String url = "http://localhost:5000/custom/addcart/?pid=$productid";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("u");
    if (token != null) {
      debugPrint("sending the request");
      Map<String, String> headers = {
        "content-type": "text/json",
        "cookies": "u=$token"
      };
      var response = await http.post(Uri.parse(url), headers: headers);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        addedcart = true;
      } else {
        addedcart = false;
      }
    } else {
      addedcart = false;
      loggedin = false;
    }
  }

  Future<void> buyproduct(int productid) async {
    String url = "http://localhost:5000/custom/order/?pid=$productid";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("u");
    if (token != null) {
      Map<String, String> headers = {
        "content-type": "text/json",
        "cookies": "u=$token"
      };
      debugPrint("sending the request");
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(<String, int>{"pid": productid}), headers: headers);
      if (response.statusCode == 200) {
        buysuccess = true;
      } else {
        buysuccess = false;
      }
    } else {
      buysuccess = false;
      loggedin = false;
    }
  }

  Future<void> removeCart(int productpid) async {
    debugPrint("removing the item from the cart");
    String url = "http://localhost:5000/custom/delcart?cid=$productpid";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("u");
    if (token != null) {
      Map<String, String> headers = {
        "content-type": "text/json",
        "cookies": "u=$token"
      };
      debugPrint("sending the request");
      var response = await http.post(Uri.parse(url), headers: headers);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        deletesuccess = true;
      } else {
        deletesuccess = false;
      }
    } else {
      debugPrint("no token");
      deletesuccess = false;
      loggedin = false;
    }
  }
}
