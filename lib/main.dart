import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_notebook/pages/item_adding_page.dart';
import 'package:flutter_notebook/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.deepPurple[500]),
    initialRoute: '/',
    routes: {
      '/': (context) => MainPage(),
      '/additem': (context) => ItemAddingPage(),
    },
  ));
}