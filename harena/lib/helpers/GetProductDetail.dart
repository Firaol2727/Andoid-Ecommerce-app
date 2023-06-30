import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:harena/models/picture.dart';
import 'package:harena/models/product.dart';
import 'package:http/http.dart' as http;

class GetProductDetail {
  Product product = Product(
      pid: 0,
      pname: "",
      description: "",
      price: 0,
      markerPrice: 0,
      letmeSee: 0,
      sellersid: 0);
  List<Picture> pictures = [];

  Future<bool> getDetail(int pid) async {
    debugPrint("Fetching the detail ");
    String url = "http://localhost:5000/details/$pid";
    var response = await http.get(Uri.parse(url));
    int status = response.statusCode;
    // debugPrint(response.body.toString());
    // debugPrint(status.toString());

    if (status == 200 && response.body.isNotEmpty) {
      var jsonData = jsonDecode(response.body);
      product = Product(
          pid: jsonData["pid"],
          pname: jsonData["pname"],
          description: jsonData["description"],
          price: jsonData["price"],
          markerPrice: jsonData["marketprice"],
          letmeSee: jsonData["letmeSee"],
          sellersid: jsonData["SellerSid"],
          sellername: jsonData["Seller"]["companyName"],
          location: jsonData["Seller"]["slocation"]);
      jsonData["Pictures"].forEach((element) {
        Picture pic = Picture(
            id: element["id"],
            type: element["type"],
            productpid: element["ProductPid"]);
        pictures.add(pic);
      });
      debugPrint(" the pictureslength is ${pictures.length}");
      return true;
    } else {
      return false;
    }
  }
}
