import 'package:flutter/material.dart';
import 'package:harena/helpers/VerifyLogin.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'chooseBroadcategory.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  State createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _loading = false;
  late String phonenumber;
  String message = "";
  late String password;
  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  void verifyUser() async {
    setState(() {
      _loading = true;
    });
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      bool logged = await Uservalidate.verifyLogin(
          phonenumber: phonenumber, password: password);
      print("logged $logged");
      if (logged) {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => chooseBroadCategory()));
      } else {
        setState(() {
          message = "username or password error";
          _loading = false;
        });
      }
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 120, 36, 6),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Positioned(
            //   top: 40,
            //   child: Center(
            //     child: Container(
            //       decoration: const BoxDecoration(
            //         borderRadius: BorderRadius.only(
            //             topRight: Radius.circular(50),
            //             bottomRight: Radius.circular(50)),
            //         color: Colors.white,
            //       ),
            //       width: MediaQuery.of(context).size.width * 0.7,
            //       height: 60,
            //       padding: const EdgeInsets.only(top: 10, left: 15),
            //       child: const Text(
            //         "HARENA",
            //         style: TextStyle(
            //             color: Color.fromARGB(255, 75, 7, 7),
            //             fontSize: 35,
            //             fontWeight: FontWeight.bold,
            //             fontStyle: FontStyle.italic),
            //       ),
            //     ),
            //   ),
            // ),
            const Image(
              image: const AssetImage("assets/harena3.png"),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 35, right: 35),
                            child: Column(
                              children: [
                                TextFormField(
                                  style: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1)),
                                  decoration: InputDecoration(
                                      icon: const Icon(Icons.key),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Phonenumber",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onChanged: (value) {
                                    phonenumber = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a phonenumber';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  style: TextStyle(),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                  onChanged: ((value) {
                                    password = value;
                                  }),
                                  decoration: InputDecoration(
                                      icon: const Icon(Icons.key),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 15, 8, 0),
                                  child: _loading
                                      ? const LinearProgressIndicator()
                                      : Text(
                                          message,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Sign in',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 208, 142, 11),
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          Color.fromARGB(255, 225, 138, 16),
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            verifyUser();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          style: const ButtonStyle(),
                          child: const Text(
                            'Sign Up',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(255, 213, 134, 15),
                                fontSize: 18),
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(255, 234, 235, 236),
                                fontSize: 18,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
