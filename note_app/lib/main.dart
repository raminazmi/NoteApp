import 'package:flutter/material.dart';
import 'UI/home screen.dart';
import 'UI/newNoteScreen.dart';
import 'UI/splashScreen.dart';
import 'UI/edit screen.dart';

void main() async {
  runApp(MyApp());
}

// ignore:
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const splashScreen(),
      routes: {
        "home": (context) => homeScreen(),
        "addnotes": (context) => newNoteScreen(),
        "editnotes": (context) => editNoteScreen(),
      },
    );
  }
}
