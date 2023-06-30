import 'dart:html';

import 'package:flutter/material.dart';
import 'package:harena/helpers/Register.dart';
import 'package:harena/widgets/SearchPage%20.dart';

import '../models/profile.dart';

class ProfileEdit extends StatefulWidget {
  Profile p;
  ProfileEdit({Key? key, required this.p}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late String fname, lname, telUname, email, phone, region, city;
  bool edited = false;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fname = widget.p.fname;
      lname = widget.p.lname;
      telUname = widget.p.telUname;
      email = widget.p.email;
      phone = widget.p.phone;
      region = widget.p.region;
      city = widget.p.city;
    });
  }

  void handleEdit() async {
    setState(() {
      loading = true;
    });
    Register r = Register();
    await r.editUserProfile(fname, lname, telUname, email, phone, region, city);
    edited = r.edited;
    if (edited) {
      setState(() {
        loading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // fname,lname,telUname,email,phone,region,city
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit "),
      ),
      body: Container(
        color: Color.fromARGB(255, 139, 101, 87),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  const Text(
                    "FirstName",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: widget.p.fname,
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onChanged: (value) {
                      setState(() {
                        fname = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Text(
                    "LastName",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        lname = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: widget.p.lname,
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: widget.p.email,
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Text(
                    "Telegram Username",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        telUname = value;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: widget.p.telUname,
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Text(
                    "Regional State",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        region = value;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: widget.p.region,
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Text(
                    "City",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        city = value;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: widget.p.city,
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 100,
                height: 50,
                color: Colors.white,
                child: TextButton.icon(
                  onPressed: () {
                    handleEdit();
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.brown,
                  ),
                  label: const Text(
                    'Edit',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.brown,
                        fontSize: 18),
                  ),
                ),
              ),
              loading ? CircularProgressIndicator() : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
