import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:harena/models/product.dart';
import 'package:http/http.dart' as http;

class SearchItems {
  late bool find;
  late bool hasnextpage;
  int page = 1;

  Future<List<Product>> getProducts(String item, int page) async {
    List<Product> products = [];
    debugPrint("searching for products");
    debugPrint("The searched item $item the page $page");
    String url = "http://localhost:5000/search/?item=$item&page=$page";
    var response = await http.get(Uri.parse(url));
    int status = response.statusCode;
    int nopage = 0;
    // debugPrint(response.body.toString());
    if (status == 200 && response.body.isNotEmpty) {
      var jsonData = jsonDecode(response.body);
      // debugPrint(jsonData.toString());
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
    debugPrint("the length is ${products.length.toString()}");
    if (page >= nopage) {
      hasnextpage = false;
    }
    return products;
  }
}
