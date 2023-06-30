import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:harena/helpers/Register.dart';
import 'package:harena/models/profile.dart';
import 'package:harena/widgets/profileEdit.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({Key? key}) : super(key: key);

  @override
  _MyprofileState createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  late Profile p;
  bool loading = true;
  bool found = true;
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    Register r = Register();
    Profile getp = await r.getuserProfile();
    setState(() {
      loading = false;
      found = r.found;
      p = getp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 177, 20, 20),
        title: const Text("Profile"),
      ),
      body: !loading
          ? ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      color: Color.fromARGB(255, 194, 127, 88),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                      child: CircleAvatar(
                        radius: 82,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 206, 201, 201),
                          radius: 80,
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: 81,
                    child: Row(
                      children: [
                        Text(
                          "${p.fname} ${p.lname}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontStyle: FontStyle.normal),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        TextButton.icon(
                            onPressed: () {
                              Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ProfileEdit(
                                            p: p,
                                          ))));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 22,
                            ),
                            label: const Text(
                              "Edit",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 22,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Row(
                    children: const [
                      Icon(
                        Icons.email,
                        color: Colors.brown,
                      ),
                      SizedBox(),
                      Text("Email",
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  subtitle: Text(p.email,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 27, 27, 29),
                        fontSize: 19,
                      )),
                ),
                const Divider(),
                ListTile(
                  title: Row(
                    children: const [
                      Icon(
                        Icons.telegram,
                        color: Colors.brown,
                      ),
                      Text("Telegram Username",
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  subtitle: Text(p.telUname,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 27, 27, 29),
                        fontSize: 19,
                      )),
                ),
                const Divider(),
                ListTile(
                  title: Row(
                    children: const [
                      Icon(Icons.phone, color: Colors.brown),
                      Text("phone",
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  subtitle: Text(p.phone,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 27, 27, 29),
                        fontSize: 19,
                      )),
                ),
                const Divider(),
                ListTile(
                  title: Row(
                    children: const [
                      Icon(Icons.location_on_outlined, color: Colors.brown),
                      Text("Region",
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  subtitle: Text(p.region,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 27, 27, 29),
                        fontSize: 19,
                      )),
                ),
                const Divider(),
                ListTile(
                  title: Row(
                    children: const [
                      Icon(Icons.location_city_rounded, color: Colors.brown),
                      Text("City",
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  subtitle: Text(p.city,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 27, 27, 29),
                        fontSize: 19,
                      )),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
