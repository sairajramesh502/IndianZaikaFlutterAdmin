import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:indian_zaika_admin/screens/home_screen.dart';
import 'package:indian_zaika_admin/screens/login_screen.dart';

void main() {
  if (fb.apps.isEmpty) {
    fb.initializeApp(
        apiKey: "AIzaSyBE4f8_RH6CDW_m17h0fiRUQL37cOVdYnM",
        authDomain: "indianzaikaflutter-95dfa.firebaseapp.com",
        projectId: "indianzaikaflutter-95dfa",
        storageBucket: "indianzaikaflutter-95dfa.appspot.com",
        messagingSenderId: "969855738399",
        appId: "1:969855738399:web:4363bc4fa28c83b7052b2a");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //close dialog
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Indian Zaika Admin Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const MyHomePage(title: 'Indian Zaika Admin Dashboard'),
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          MyHomePage.id: (context) => const MyHomePage(
                title: 'Indian Zaika Admin Dashboard',
              ),
        });
  }
}
