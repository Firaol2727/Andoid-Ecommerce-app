import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harena/models/BroadCategory.dart';
import 'package:harena/widgets/SearchPage%20.dart';
import 'package:harena/widgets/carts.dart';
import 'package:harena/widgets/chooseSubcategory.dart';
import 'package:harena/widgets/login.dart';
import 'package:harena/widgets/myprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types, must_be_immutable
class chooseBroadCategory extends StatelessWidget {
  chooseBroadCategory({super.key});
  List<BroadCategory> broadcategories = [
    BroadCategory(
        name: "Vehicle & Vehicle Accessories", link: "vehicleaccessories"),
    BroadCategory(name: "Phone & Tablets", link: "phonetablets"),
    BroadCategory(name: "Electronics", link: "electronics"),
    BroadCategory(name: "Home,Office & Garden", link: "homegarden"),
    BroadCategory(name: "Health & Beuty", link: "healthbeauty"),
    BroadCategory(name: "Fashion", link: "fashion"),
    BroadCategory(name: "Sport & Exercise", link: "sportequipment"),
    BroadCategory(name: "Art & Crafts", link: "artcrafts"),
    BroadCategory(name: "Musical Instrument", link: "musicalinstrument"),
    BroadCategory(name: "Babies Kids", link: "babieskids"),
    BroadCategory(name: "Animal & Pets", link: "animalpets"),
    BroadCategory(name: "Equipment & Tools", link: "equipmenttools"),
    BroadCategory(name: "Gifts", link: "gifts"),
    BroadCategory(name: "Constructioin and Repair", link: "construction"),
    BroadCategory(name: "Christean  Products", link: "christeanproducts"),
    BroadCategory(name: 'Islamic Products', link: "islamicproducts"),
    // BroadCategory(name: "Other", link: "other"),
  ];
  final Categories = [];

  @override
  Widget build(BuildContext context) {
    int length = broadcategories.length;
    if (kDebugMode) {}
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Harena"),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        backgroundColor: const Color.fromARGB(255, 177, 20, 20),
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
                  Navigator.push<void>(context,
                      MaterialPageRoute(builder: ((context) => const Carts())));
                },
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 26.0,
                ),
              )),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 177, 20, 20),
              ),
              child: Center(
                child: Text(
                  'Harena .com',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Myprofile()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('LogOut'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("u");
                // ignore: use_build_context_synchronously
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyLogin()));
              },
            ),
          ],
        ),
      ),
      body: Container(
          color: Color.fromRGBO(157, 76, 32, 1),
          child: ListView(children: [
            for (var i = 0; i < length; i = i + 2)
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: (0.2 * width + 5) / 2.5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChooseSubcategory(
                                  broadcategoryId: broadcategories[i].link,
                                  broadcategoryname: broadcategories[i].name,
                                ),
                              ));
                        },
                        child: Container(
                          width: (width - 10) / 2.4,
                          height: (width - 10) / 2.4,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.brown),
                          child: Stack(children: [
                            Positioned(
                              top: (width - 10) / 5.2,
                              left: 15,
                              right: 15,
                              child: Text(broadcategories[i].name,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 219, 231, 147),
                                      fontSize: 20)),
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseSubcategory(
                                          broadcategoryId:
                                              broadcategories[i + 1].link,
                                          broadcategoryname:
                                              broadcategories[i + 1].name,
                                        )));
                          },
                          child: Container(
                            width: (width - 10) / 2.4,
                            height: (width - 10) / 2.4,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Color.fromARGB(255, 126, 11, 3)),
                            child: Stack(children: [
                              Positioned(
                                top: (width - 10) / 5.2,
                                left: 15,
                                right: 15,
                                child: Text(broadcategories[i + 1].name,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 248, 244, 244),
                                        fontSize: 20)),
                              ),
                            ]),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              )
          ])),
    );
  }
}
