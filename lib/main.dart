import 'package:atelier03_local_data_storage/screens/home.dart';
import 'package:atelier03_local_data_storage/screens/note.dart';
import 'package:atelier03_local_data_storage/screens/passwords.dart';
import 'package:atelier03_local_data_storage/screens/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GlobApp',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: HomeScreen());
  }
}
