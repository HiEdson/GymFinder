import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  User? user;

  bool isLoggedIn() => user != null;
}

class User {
  final String name;
  final String email;
  const User(this.name, this.email);
}
