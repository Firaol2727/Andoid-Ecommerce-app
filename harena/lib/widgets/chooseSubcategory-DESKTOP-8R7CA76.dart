import 'dart:html';
import 'package:flutter/material.dart';
import '../helpers/GetProducts.dart';
import '../helpers/Getcategories.dart';
import '../models/product.dart';
import 'package:harena/widgets/carts.dart';
import 'package:harena/widgets/photoItem.dart';
import 'package:harena/widgets/RenderProducts.dart';
import 'SearchPage .dart';
import 'package:harena/models/category.dart';

class ChooseSubcategory extends StatefulWidget {
  late String broadcategoryId;
  late String broadcategoryname;
  ChooseSubcategory(
      {Key? key,
      required this.broadcategoryId,
      required this.broadcategoryname})
      : super(key: key);
  @override
  State<ChooseSubcategory> createState() => _ChooseSubcategoryState();
}

class _ChooseSubcategoryState extends State<ChooseSubcategory> {
  List<Category> categories = [];
  List<Product> broadproducts = [];
  bool _loading = true;
  bool firstload = true;
  bool isloadmore = false;
  bool _hasNextPage = true;
  late ScrollController _controller;
  int page = 1;

  void loadmore() async {
    debugPrint("fetching more data from the database");
    page = page + 1;
    debugPrint(page.toString());

    if (_hasNextPage == true && isloadmore == false && firstload == false) {
      GetProduct getMoreProduct = GetProduct();
      List<Product> more =
          await getMoreProduct.getBroadProducts(widget.broadcategoryId, page);
      setState(() {
        broadproducts.addAll(more);
        _hasNextPage = getMoreProduct.hasnextpage;
        isloadmore = false;
      });
    }
  }

  void getSubcategories() async {
    GetCategories getCategories = GetCategories();
    // await getCategories.getSubCategories(widget.broadcategoryId);
    List<Category> recent =
        await getCategories.getSubCategories(widget.broadcategoryId);
    categories.addAll(recent);
    setState(() {
      _loading = false;
    });
  }

  void getbroadProducts() async {
    GetProduct getproduct = GetProduct();
    List<Product> b =
        await getproduct.getBroadProducts(widget.broadcategoryId, 1);
    debugPrint("has next page is $_hasNextPage");
    setState(() {
      broadproducts.addAll(b);
      _hasNextPage = getproduct.hasnextpage;
      firstload = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSubcategories();
    getbroadProducts();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels >=
                _controller.position.maxScrollExtent &&
            isloadmore == false &&
            _hasNextPage == true) {
          debugPrint("new data fetching ");
          loadmore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.broadcategoryId),
        backgroundColor: Color.fromARGB(255, 177, 20, 20),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push<void>(context,
                      MaterialPageRoute(builder: ((context) => SearchPage())));
                },
                child: const Icon(Icons.search),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Carts()));
                },
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            if (_loading && categories.isEmpty)
              const CircularProgressIndicator(),
            if (categories.isNotEmpty)
              displaySubcategory(categories: categories),
            broadproducts.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: broadproducts.length,
                    itemBuilder: (context, index) {
                      if (index == broadproducts.length - 1) {
                        if (_hasNextPage == false) {
                          return Column(
                            children: [
                              PhotoImage(displayitem: broadproducts[index]),
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
                              PhotoImage(displayitem: broadproducts[index]),
                              const Center(child: CircularProgressIndicator()),
                            ],
                          );
                        }
                      }
                      return PhotoImage(displayitem: broadproducts[index]);
                    })
                : const Center(
                    child: Center(
                    child: Text(
                        "No products yet!,we are adding products keep in touch with us  "),
                  ))
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class displaySubcategory extends StatelessWidget {
  const displaySubcategory({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.38,
      ),
      child: ListView.builder(
          itemCount: categories.length - 1,
          itemBuilder: ((context, index) {
            return Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 156, 153, 153)))),
              height: 50,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RenderProducts(title: categories[index].name)));
                },
                title: Text(
                  categories[index].name,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
                tileColor: Colors.white,
                trailing: const Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                ),
              ),
            );
          })),
    );
  }
}
