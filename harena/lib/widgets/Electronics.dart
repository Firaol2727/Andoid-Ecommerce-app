import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harena/helpers/GetProducts.dart';
import 'package:harena/widgets/photoItem.dart';
import 'package:harena/models/product.dart';

class Electronics extends StatefulWidget {
  late String subname;
  Electronics({Key? key, required this.subname}) : super(key: key);
  @override
  State<Electronics> createState() => _ElectronicsState();
}

class _ElectronicsState extends State<Electronics> {
  int page = 1;
  bool firstload = true;
  bool isloadmore = false;
  bool _hasNextPage = true;
  List<Product> products = [];
  void _firstload() async {
    try {
      await getProducts(1);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> getProducts(int page) async {
    GetProduct getproduct = GetProduct();
    debugPrint("The page is ");
    debugPrint(page.toString());
    List<Product> recent = await getproduct.getProducts(widget.subname, page);
    setState(() {
      products.addAll(recent);
      setState(() {
        firstload = false;
        _hasNextPage = getproduct.hasnextpage;
      });
    });
  }

  void loadmore() async {
    debugPrint("fetching more data from the database");
    debugPrint(page.toString());
    page = page + 1;
    if (_hasNextPage == true && isloadmore == false && firstload == false) {
      GetProduct getMoreProduct = GetProduct();
      List<Product> more =
          await getMoreProduct.getProducts(widget.subname, page);
      setState(() {
        products.addAll(more);
        _hasNextPage = getMoreProduct.hasnextpage;
        isloadmore = false;
      });
    }
  }

  late ScrollController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _firstload();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels >=
                _controller.position.maxScrollExtent &&
            isloadmore == false &&
            _hasNextPage == true) {
          if (kDebugMode) {
            print("new data fetching ");
          }
          loadmore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      if (firstload) const Center(child: CircularProgressIndicator()),
      if (products.isNotEmpty)
        Expanded(
            child: ListView.builder(
                controller: _controller,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  if (index == products.length - 1) {
                    if (_hasNextPage == false) {
                      return Column(
                        children: [
                          PhotoImage(displayitem: products[index]),
                          Container(
                              color: Colors.red,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "This is what we have for now stay tuned",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          PhotoImage(displayitem: products[index]),
                          const Center(child: CircularProgressIndicator()),
                        ],
                      );
                    }
                  }
                  return PhotoImage(displayitem: products[index]);
                })),
      if (products.isEmpty && !firstload)
        Center(
            child: Column(
          children: const [
            Icon(
              Icons.emoji_emotions_sharp,
              color: Colors.yellow,
              size: 100,
            )
          ],
        )),
    ]);
  }
}
