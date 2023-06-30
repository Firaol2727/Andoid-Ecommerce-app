import 'package:flutter/material.dart';
import 'package:harena/widgets/SearchPage%20.dart';

import 'Electronics.dart';

class RenderProducts extends StatefulWidget {
  RenderProducts({super.key, required this.title});
  final String title;
  @override
  State<RenderProducts> createState() => _RenderProductsState();
}

class _RenderProductsState extends State<RenderProducts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Color.fromARGB(255, 177, 20, 20),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.push<void>(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => ChooseProductPage())));
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.search)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 150.0,
                  width: 30.0,
                  child: GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: <Widget>[
                        const IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          onPressed: null,
                        ),
                        Positioned(
                            child: Stack(
                          children: <Widget>[
                            Icon(Icons.brightness_1,
                                size: 20.0, color: Colors.green[800]),
                            const Positioned(
                                top: 3.0,
                                right: 4.0,
                                child: Center(
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ],
                        )),
                      ],
                    ),
                  )),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push<void>(context,
                      MaterialPageRoute(builder: ((context) => SearchPage())));
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        body: Electronics(subname: widget.title),
      ),
    );
  }
}
