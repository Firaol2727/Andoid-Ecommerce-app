import 'package:flutter/material.dart';

import 'package:harena/widgets/login.dart';
import 'package:harena/widgets/signUp.dart';
import 'package:harena/widgets/Home.dart';

void main() {
  runApp(MyApp());
  // const ChooseProductPage();
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harena',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/login': (context) => const MyLogin(),
        '/register': (context) => const MyRegister()
      },
    );
  }
}
