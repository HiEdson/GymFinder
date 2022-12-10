import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

void checkUser(String email, String password) {}
final db = FirebaseFirestore.instance;

Future<void> addUser() async {
  final user = {"name": "Leon", "age": 18};
  Completer completer = Completer();
  var ref = await db.collection("users").add(user);
  print("inserted ${ref.id}");
  return completer.future;
}
