import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:harena/helpers/BuyCart.dart';
import 'package:harena/helpers/GetProductDetail.dart';
import 'package:harena/models/picture.dart';
import 'package:harena/models/product.dart';
import 'package:harena/widgets/login.dart';
import 'package:harena/widgets/showImage.dart';
import 'SearchPage .dart';

class DetailProduct extends StatefulWidget {
  int productpid;
  DetailProduct({super.key, required this.productpid});
  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct>
    with SingleTickerProviderStateMixin {
  List<Picture> pictures = [];
  static List<Tab> _tabs = [];
  static List<Widget> _views = [];
  bool _loading = true;
  late Product product;
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailProduct();
  }

  void performAddingToCart(int pid) async {
    BuyCart buycart = BuyCart();
    await buycart.addCart(pid);
    bool addingcartperformed = buycart.addedcart;
    if (addingcartperformed) {
      SnackBar snackBar = const SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            "The product has been added to your cart !",
            style: TextStyle(color: Colors.white),
          ));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      if (!buycart.loggedin) {
        // ignore: use_build_context_synchronously
        Navigator.push<void>(context,
            MaterialPageRoute(builder: ((context) => const MyLogin())));
      }
    }
  }

  void performBuying(int pid) async {
    BuyCart buycart = BuyCart();
    await buycart.buyproduct(pid);
    bool buyingperformed = buycart.buysuccess;
    if (buyingperformed) {
      const snackBar = SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            "Order was successful, We will contact you by phone call",
            style: TextStyle(color: Colors.white),
          ));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      if (!buycart.loggedin) {
        // ignore: use_build_context_synchronously
        Navigator.push<void>(context,
            MaterialPageRoute(builder: ((context) => const MyLogin())));
      }
    }
  }

  void getDetailProduct() async {
    GetProductDetail getProductDetail = GetProductDetail();
    bool got = await getProductDetail.getDetail(widget.productpid);
    if (got) {
      pictures = getProductDetail.pictures;
      product = getProductDetail.product;
      List<Tab> tab = [];
      List<Widget> veiw = [];
      int length = pictures.length;
      for (var i = 0; i < length; i++) {
        tab.add(const Tab(
          // child: Text("${i + 1}"),
          icon: Icon(
            Icons.circle,
            size: 10,
          ),
        ));
        veiw.add(
          GestureDetector(
            onTap: () {
              Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ShowImage(
                            index: i,
                            pics: pictures,
                          ))));
            },
            child: CachedNetworkImage(
              placeholder: (context, url) => Container(
                  width: 400,
                  height: 300,
                  color: Colors.grey.shade200.withOpacity(0.5)),
              imageUrl: "http://localhost:5000/images/${pictures[i].id}",
              // ignore: use_build_context_synchronously
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,
            ),
          ),
        );
      }
      setState(() {
        _tabs = tab;
        _views = veiw;
        _loading = false;
        _tabController = TabController(vsync: this, length: pictures.length);
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int length = pictures.length;
    int min = 0, max = length;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        backgroundColor: const Color.fromARGB(255, 177, 20, 20),
        actions: <Widget>[
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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                pictures.isNotEmpty
                    ? Column(
                        children: [
                          const SizedBox(),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              color: const Color.fromARGB(255, 112, 112, 112),
                              child: Stack(
                                children: [
                                  TabBarView(
                                    controller: _tabController,
                                    children: _views,
                                  ),
                                  Container(
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: TabBar(
                                            labelColor: Colors.red,
                                            isScrollable: true,
                                            unselectedLabelColor: Colors.white,
                                            controller: _tabController,
                                            tabs: _tabs)),
                                  ),
                                ],
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.topCenter,
                                      child: Text(product.pname,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25))),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        height: 80,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                              ],
                                            ),
                                            const Text(
                                              "Back in Stock ",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        // height: 80,
                                        child: Column(
                                          children: [
                                            Text(
                                              '${product.price} Birr',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 244, 89, 38)),
                                            ),
                                            const Text(
                                              "With out delivery fee",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.black,
                                      size: 26,
                                    ),
                                    Text(
                                      product.location,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    )
                                  ]),
                                  Row(children: [
                                    const Text(
                                      "provider - ",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20),
                                    ),
                                    Text(
                                      product.location,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    )
                                  ]),
                                  Text(
                                    product.description,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: TextButton.icon(
                                              onPressed: () {
                                                performAddingToCart(
                                                    widget.productpid);
                                              },
                                              icon: const Icon(
                                                  Icons.shopping_cart_outlined),
                                              label: const Text(
                                                "Add to Cart",
                                                style: TextStyle(fontSize: 20),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: TextButton.icon(
                                              onPressed: () {
                                                performBuying(
                                                    widget.productpid);
                                              },
                                              icon: const Icon(
                                                  Icons.shop_rounded),
                                              label: const Text(
                                                "Buy",
                                                style: TextStyle(fontSize: 22),
                                              )),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Column(children: const [
                        Icon(Icons.emoji_flags, color: Colors.red),
                        Text(
                            "The product you are looking for is not available"),
                      ])),
              ],
            ),
    );
  }
}
