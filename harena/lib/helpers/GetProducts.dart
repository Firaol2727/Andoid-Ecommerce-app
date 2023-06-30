import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:harena/models/product.dart';
import 'package:http/http.dart' as http;

class GetProduct {
  bool hasnextpage = true;
  Future<List<Product>> getProducts(String subname, int page) async {
    List<Product> products = [];
    debugPrint("The subname $subname the page $page");
    String url = "http://localhost:5000/subcategory/?cname=$subname&page=$page";
    var response = await http.get(Uri.parse(url));
    int status = response.statusCode;
    int nopage = 0;
    // debugPrint(response.body.toString());
    if (status == 200 && response.body.isNotEmpty) {
      var jsonData = jsonDecode(response.body);
      nopage = jsonData['count'] + 1;
      jsonData['rows'].forEach((element) {
        Product broadcategory = Product(
            pid: element['pid'],
            price: element['price'],
            pname: element['pname'],
            markerPrice: element['marketprice'],
            letmeSee: element['letmeSee'],
            description: element['description'],
            sellersid: element['SellerSid']);
        products.add(broadcategory);
      });
    }
    debugPrint(nopage.toString());
    if (page >= nopage) {
      hasnextpage = false;
    }
    return products;
  }

  Future<List<Product>> getBroadProducts(String broadname, int page) async {
    List<Product> products = [];
    String url = "http://localhost:5000/bcat/?bname=$broadname&page=$page";
    var response = await http.get(Uri.parse(url));
    int status = response.statusCode;
    int nopage = 0;
    // debugPrint(response.body.toString());
    if (status == 200 && response.body.isNotEmpty) {
      var jsonData = jsonDecode(response.body);
      nopage = jsonData['count'] + 1;
      jsonData['data'].forEach((element) {
        Product broadcategory = Product(
            pid: element['pid'],
            price: element['price'],
            pname: element['pname'],
            markerPrice: element['marketprice'],
            letmeSee: element['letmeSee'],
            description: element['description'],
            sellersid: element['SellerSid']);
        products.add(broadcategory);
      });
    }
    if (page >= nopage) {
      hasnextpage = false;
    }
    return products;
  }
}
