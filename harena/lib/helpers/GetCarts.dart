import 'dart:convert';

import 'package:harena/models/product.dart';
import 'package:harena/models/carts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetCarts {
  bool hasnextpage = true;
  int page = 0;
  Future<List<CartData>> getCarts(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("u");
    Map<String, String> headers = {
      "content-type": "text/json",
      "cookies": "u=${token!}"
    };
    List<CartData> carts = [];
    String url = "http://localhost:5000/custom/cart";
    var response = await http.get(Uri.parse(url), headers: headers);
    int status = response.statusCode;
    int nopage = 0;
    if (status == 200) {
      var jsonData = jsonDecode(response.body);
      nopage = jsonData['count'] + 1;
      jsonData['rows'].forEach((var element) {
        if (element["Product"] != null) {
          CartData cartdata = CartData(
            cartid: element["cid"],
            pid: element["Product"]['pid'],
            price: element["Product"]['price'],
            pname: element["Product"]['pname'],
            markerPrice: element["Product"]['marketprice'],
            letmeSee: element["Product"]['letmeSee'],
            description: element["Product"]['description'],
            SellerSid: element["Product"]['SellerSid'],
          );
          carts.add(cartdata);
        }
      });
    }
    if (page >= nopage) {
      hasnextpage = false;
    } else {
      hasnextpage = true;
    }
    return carts;
  }
}
