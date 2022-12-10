import 'package:flutter/material.dart';
import 'package:gymfinder/models/gym_save_model.dart';
import 'package:gymfinder/models/user_model.dart';
import 'package:gymfinder/screens/homepage_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
        ChangeNotifierProvider<NewGymModel>(create: (_) => NewGymModel()),
      ],
      child: const MyApp(),
    ),
  );
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
        // color: const Color(0xFF151026),
        color: Colors.black,
      )),
      home: const HomePage(title: 'GymFinder'),
    );
  }
}
