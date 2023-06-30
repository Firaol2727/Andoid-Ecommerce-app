import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:harena/models/picture.dart';

class ShowImage extends StatefulWidget {
  int index;
  List<Picture> pics;
  ShowImage({Key? key, required this.index, required this.pics})
      : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  String first = '';
  int i = 0;
  bool ableleft = false;
  bool ableright = false;
  @override
  void initState() {
    setState(() {
      i = widget.index;
      first = "http://localhost:5000/images/${widget.pics[i].id}";
    });

    // TODO: implement initState
    super.initState();
  }

  void showLeft() {
    if (i <= 0) {
      ableleft = false;
      return;
    }
    setState(() {
      i = i - 1;
      first = "http://localhost:5000/images/${widget.pics[i].id}";
    });
  }

  void showRight() {
    if (i >= widget.pics.length - 1) {
      ableright = false;
      return;
    }
    setState(() {
      i = i + 1;
      first = "http://localhost:5000/images/${widget.pics[i].id}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(177, 20, 20, 1),
        ),
        body: Container(
            color: Color.fromARGB(255, 29, 28, 28),
            child: Center(
              child: Stack(children: [
                Image(
                  image: NetworkImage(first),
                  fit: BoxFit.contain, //fill type of image inside aspectRatio
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: 1,
                  child: Container(
                    color: Colors.grey.shade200.withOpacity(0.3),
                    width: 40,
                    height: 40,
                    child: Center(
                      child: IconButton(
                          icon: const Icon(Icons.chevron_left_sharp,
                              color: Colors.black),
                          onPressed: () {
                            showLeft();
                          }),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: 1,
                  child: Center(
                    child: Container(
                      color: Colors.grey.shade200.withOpacity(0.5),
                      width: 40,
                      height: 40,
                      child: IconButton(
                          icon: const Icon(Icons.chevron_right_sharp,
                              color: Colors.black),
                          onPressed: () {
                            showRight();
                          }),
                    ),
                  ),
                ),
              ]),
            )));
  }
}
