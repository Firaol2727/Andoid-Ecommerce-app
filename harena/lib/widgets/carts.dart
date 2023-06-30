import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:harena/helpers/BuyCart.dart';
import '../helpers/GetCarts.dart';
import '../models/carts.dart';
import 'DetailProduct.dart';
import 'SearchPage .dart';
import '../models/product.dart';

class Carts extends StatefulWidget {
  const Carts({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  State createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  List<CartData> carts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getCarts();
  }

  Future<void> getCarts() async {
    GetCarts getcarts = GetCarts();
    carts = await getcarts.getCarts(1);
    setState(() {
      loading = false;
    });
  }

  Future<void> removeCart(int productpid, int cartid) async {
    BuyCart buyCart = BuyCart();
    await buyCart.removeCart(cartid);
    bool deletesuccess = buyCart.deletesuccess;
    if (deletesuccess) {
      setState(() {
        carts.removeWhere((cart) => cart.pid == productpid);
      });
    } else {
      SnackBar snackBar = const SnackBar(
          backgroundColor: Color.fromARGB(255, 156, 48, 5),
          content: Text(
            "Some error has occured !",
            style: TextStyle(color: Colors.white),
          ));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Confirmation',
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You have successfull ordered the product'),
                Text('We will contact you soon with  phone call!'),
                SizedBox(),
                Text(
                  'Thank for choosing us  !',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> performOrder(int productpid) async {
    debugPrint("performing the order request");
    BuyCart buyCart = BuyCart();
    await buyCart.buyproduct(productpid);
    bool buysuccess = buyCart.buysuccess;
    if (buysuccess) {
      _showMyDialog();
    } else {
      SnackBar snackBar = const SnackBar(
          backgroundColor: Color.fromARGB(255, 181, 70, 14),
          content: Text(
            "Some error has occured !",
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Harena"),
          backgroundColor: const Color.fromARGB(255, 177, 20, 20),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const SearchPage())));
                  },
                  child: const Icon(Icons.search),
                )),
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: carts.length,
                itemBuilder: (context, index) {
                  if (carts.isNotEmpty) {
                    return cartdisplay(context, carts[index]);
                  } else {
                    return const Center(child: Text("hoops! No carts yet!"));
                  }
                }));
  }

  Widget cartdisplay(BuildContext context, CartData displayitem) {
    final sfat = MediaQuery.of(context).size.width;
    final gon = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 112, 108, 104)),
      ),
      child: Column(
        children: [
          Row(children: <Widget>[
            Container(
              width: sfat * 0.5,
              height: sfat * 0.5,
              child: GestureDetector(
                onTap: (() {
                  Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              DetailProduct(productpid: displayitem.pid))));
                }),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    color: Color.fromARGB(255, 95, 93, 93),
                  ),
                  imageUrl:
                      "http://localhost:5000/images/${displayitem.letmeSee}",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              color: Color.fromARGB(255, 249, 249, 246),
              width: sfat * 0.45,
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Column(
                  children: <Widget>[
                    Text(
                      displayitem.pname,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Center(
                        child: Text(
                          "ETB -  ${displayitem.price}Birr",
                          style: const TextStyle(
                              wordSpacing: 2,
                              color: Color.fromARGB(255, 7, 153, 12)),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Center(
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.location_city_sharp,
                              color: Color.fromARGB(255, 46, 43, 43),
                            ),
                            Text(
                              "AddisAbaba,Bole",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 81, 70, 70)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(4.0),
                    width: (MediaQuery.of(context).size.width - 10) * 0.45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        removeCart(displayitem.pid, displayitem.cartid);
                      },
                      icon: const Icon(
                        Icons.shopping_cart_checkout_outlined,
                        color: Colors.red,
                      ),
                      label: const Text(
                        "Remove from Cart",
                        style: TextStyle(color: Colors.red),
                      ),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    width: (MediaQuery.of(context).size.width - 10) * 0.45,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(137, 3, 38, 120)),
                    ),
                    child: TextButton.icon(
                      onPressed: (() {
                        performOrder(displayitem.pid);
                      }),
                      icon: const Icon(Icons.shop,
                          color: Color.fromARGB(137, 4, 28, 85)),
                      label: const Text("Buy item",
                          style:
                              TextStyle(color: Color.fromARGB(137, 4, 28, 85))),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
