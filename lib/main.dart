import 'package:flutter/material.dart';
import 'package:gymfinder/screens/homepage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymFinder',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: const Color(0xFF151026),
      )),
      home: const HomePage(title: 'GymFinder'),
    );
  }
}
