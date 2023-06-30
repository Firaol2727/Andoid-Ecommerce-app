import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:harena/models/product.dart';
import 'package:harena/widgets/DetailProduct.dart';

class PhotoImage extends StatefulWidget {
  PhotoImage({super.key, required this.displayitem});
  Product displayitem;
  @override
  State<PhotoImage> createState() => _PhotoImageState();
}

class _PhotoImageState extends State<PhotoImage> {
  @override
  Widget build(BuildContext context) {
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
              // color: Color.fromARGB(255, 84, 83, 83),
              color: Colors.white,
              width: sfat * 0.5,
              height: sfat * 0.5,
              child: GestureDetector(
                onTap: (() {
                  Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => DetailProduct(
                                productpid: widget.displayitem.pid,
                              ))));
                }),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    // color: Color.fromARGB(255, 84, 83, 83),
                    color: Color.fromARGB(255, 84, 83, 83),
                  ),
                  imageUrl:
                      "http://localhost:5000/images/${widget.displayitem.letmeSee}",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              color: Color.fromARGB(255, 249, 249, 246),
              width: sfat * 0.45,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.displayitem.pname,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Center(
                        child: Text(
                          "${widget.displayitem.price} Birr",
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
                          children: <Widget>[
                            const Icon(
                              Icons.location_city_sharp,
                              color: Color.fromARGB(255, 46, 43, 43),
                            ),
                            Text(
                              "${widget.displayitem.markerPrice}",
                              style: const TextStyle(
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
                      border: Border.all(color: Colors.green),
                    ),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart_sharp,
                        color: Colors.green,
                      ),
                      label: const Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.green),
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
                          Border.all(color: Color.fromARGB(255, 244, 133, 23)),
                    ),
                    child: TextButton.icon(
                      onPressed: (() {
                        Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DetailProduct(
                                      productpid: widget.displayitem.pid,
                                    ))));
                      }),
                      icon: const Icon(Icons.more,
                          color: Color.fromARGB(255, 244, 133, 23)),
                      label: const Text("Read more...",
                          style: TextStyle(
                              color: Color.fromARGB(255, 244, 133, 23))),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
