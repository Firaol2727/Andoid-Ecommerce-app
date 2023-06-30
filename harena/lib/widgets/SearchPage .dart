import "package:flutter/material.dart";
import 'package:harena/models/product.dart';
import '../helpers/Searchproduct.dart';
import 'photoItem.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> serachedproduct = [];
  bool loading = false;
  String item = "";
  void findItems() async {
    setState(() {
      loading = true;
    });
    SearchItems findproduct = SearchItems();
    List<Product> a = await findproduct.getProducts(item, 1);
    debugPrint("the length of a  is ${a.length.toString()}");
    setState(() {
      serachedproduct.clear();
      serachedproduct.addAll(a);
      loading = false;
      debugPrint("the length is ${serachedproduct.length.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    var sfat = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          backgroundColor: Colors.red,
        ),
        body: Column(children: <Widget>[
          Container(
            color: Colors.amber[900],
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 52, 49, 49)),
                    color: const Color.fromARGB(255, 246, 242, 242),
                    borderRadius: BorderRadius.circular(8.0)),
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          item = value.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 3,
                    color: Color.fromARGB(255, 87, 85, 85),
                    child: Text("|"),
                    height: 40,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        findItems();
                      },
                      icon: const Icon(Icons.search))
                ]),
              ),
            ),
          ),
          if (loading) const Center(child: CircularProgressIndicator()),
          if (!loading)
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: serachedproduct.length,
                  itemBuilder: (context, index) {
                    return PhotoImage(displayitem: serachedproduct[index]);
                  }),
            )
          // else
          //   const SizedBox(
          //     child: Text("No item has been found !"),
          //   )
        ]));
  }
}
