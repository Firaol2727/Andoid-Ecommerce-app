import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:harena/helpers/Register.dart';
import 'package:harena/widgets/chooseBroadcategory.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  late String phonenumber, password, cp;
  String message = '';
  bool loading = false;
  bool isNumber(String input) {
    debugPrint(input.substring(1));
    final a = num.tryParse(input.substring(1));
    if (a == null) {
      return false;
    } else {
      setState(() {
        message = "please enter a valid phonenumber";
      });
      return true;
    }
  }

  bool isphonenumber(String input) {
    String a = '+2519';
    String b = '+2517';
    String c = '09';
    String d = '07';
    if (input.startsWith(a) ||
        input.startsWith(b) ||
        input.startsWith(c) ||
        input.startsWith(d)) {
      return true;
    } else {
      setState(() {
        message = "Invalid phonenumber";
      });
      return false;
    }
  }

  bool isphoneLength(String input) {
    String a = '+2519';
    String b = '+2517';
    String c = '09';
    String d = '07';
    if (input.startsWith(a) || input.startsWith(a) && input.length == 13) {
      return true;
    } else if (input.startsWith(c) ||
        input.startsWith(d) && input.length == 10) {
      return true;
    } else {
      setState(() {
        message = "Invalid phonenumber length";
      });
      return false;
    }
  }

  void registerUser() async {
    setState(() {
      loading = true;
    });
    // checking if the phone is a number;
    // checking if the phone number is less than 14
    // checking if the number starts with 09 / 07 / +251
    if (phonenumber.isEmpty || password.isEmpty || cp.isEmpty) {
      setState(() {
        loading = false;
      });
    } else {
      if (isphoneLength(phonenumber) && isphonenumber(phonenumber)) {
        if (cp == password) {
          Register register = Register();
          await register.registerCustomer(phonenumber, password, cp);
          bool registerd = register.registerd;
          if (registerd) {
            setState(() {
              loading = false;
            });
            // ignore: use_build_context_synchronously
            Navigator.push<void>(
                context,
                MaterialPageRoute(
                    builder: ((context) => chooseBroadCategory())));
          } else {
            setState(() {
              message = " network error or used phonenumber";
              loading = false;
            });
          }
        } else {
          setState(() {
            message = "password must be the same";
            loading = false;
          });
        }
      } else {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 72, 12, 8),
        elevation: 0,
      ),
      body: Container(
        color: Color.fromRGBO(72, 12, 8, 1),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 20, left: 100),
                child: const Image(image: AssetImage("assets/harena4.png"))),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Text(
                            message,
                            style: TextStyle(color: Colors.amber[100]),
                          ),
                          TextField(
                            style: const TextStyle(color: Colors.white),
                            onChanged: (value) {
                              phonenumber = value.toString().trim();
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "phonenumber",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: const TextStyle(color: Colors.white),
                            onChanged: ((value) {
                              password = value.toString().trim();
                              setState(() {
                                message = '';
                              });
                            }),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "password",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            onChanged: (value) {
                              cp = value.toString().trim();
                              setState(() {
                                message = '';
                              });
                            },
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "confirmpassword",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    color: Colors.brown,
                                    onPressed: () {
                                      registerUser();
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
                          loading
                              ? const CircularProgressIndicator(
                                  color: Colors.amber,
                                )
                              : const SizedBox()
                        ],
                      ),
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
