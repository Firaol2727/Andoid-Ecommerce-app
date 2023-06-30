import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:harena/models/BroadCategory.dart';
import 'package:harena/models/product.dart';
import 'package:harena/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Register {
  late bool registerd;
  late String error;
  late bool found;
  late bool edited;
  Future<void> registerCustomer(
      String phonenumber, String password, String cp) async {
    String url = "http://localhost:5000/custom/mregister";

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };
    try {
      var response = (await http.post(Uri.parse(url), body: <String, String>{
        "phonenumber": phonenumber,
        "password": password,
        "cp": cp
      }));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        String token = jsonData['u'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('u', token);
        registerd = true;
      } else {
        registerd = false;
        error = response.body.toString();
      }
    } catch (e) {
      debugPrint(e.toString());
      registerd = false;
    }
  }

  Future<Profile> getuserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('u');
    String url = "http://localhost:5000/custom/getprofile";
    Profile p;
    try {
      Map<String, String> headers = {
        "content-type": "text/json",
        "cookies": "u=${token!}"
      };
      if (token != null) {
        var response = (await http.get(Uri.parse(url), headers: headers));
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          p = Profile(
              cid: jsonData["cid"],
              fname: jsonData["fname"],
              lname: jsonData["lname"],
              telUname: jsonData["telUname"],
              email: jsonData["email"],
              phone: jsonData["phone"],
              region: jsonData["region"],
              city: jsonData["city"]);
          found = true;
          return p;
        } else {
          found = false;
          error = response.body.toString();
          p = Profile(
              cid: 0,
              fname: "",
              lname: "",
              telUname: "",
              email: "",
              phone: "",
              region: "",
              city: "");
          return p;
        }
      } else {
        found = false;
        p = Profile(
            cid: 0,
            fname: "",
            lname: "",
            telUname: "",
            email: "",
            phone: "",
            region: "",
            city: "");
        return p;
      }
    } catch (e) {
      found = false;
      return Profile(
          cid: 0,
          fname: "",
          lname: "",
          telUname: "",
          email: "",
          phone: "",
          region: "",
          city: "");
    }
  }

  Future<void> editUserProfile(
      String fname, lname, telUname, email, phone, region, city) async {
    debugPrint("Editing the user profile ");
    String url = "http://localhost:5000/custom/changepp";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('u');
    try {
      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "cookies": "u=${token!}"
      };

      var response = (await http.post(Uri.parse(url),
          body: <String, String>{
            "fname": fname,
            "lname": lname,
            "telUname": telUname,
            "email": email,
            "phone": phone,
            "region": region,
            "city": city,
          },
          headers: headers));

      if (response.statusCode == 200) {
        edited = true;
      } else {
        edited = false;
        error = response.body.toString();
      }
    } catch (e) {
      edited = false;
    }
  }
}
