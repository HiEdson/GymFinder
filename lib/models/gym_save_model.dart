import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:gymfinder/utils/constants.dart';

class NewGymModel extends ChangeNotifier {
  final Map<String, _Image> images = {};

  Future<void> addImage(String name, Uint8List bytes) async {
    await uploadImage(name, bytes);
  }

  void removeImage(String name) {
    images.remove(name);
  }
}

final storageRef = FirebaseStorage.instance.ref();
Future<void> uploadImage(String name, Uint8List bytes) async {
  try {
    var doc = storageRef.child(name);
    var task = await doc.putData(bytes);
    var url = await doc.getDownloadURL();
    print("result");
    print(url);
  } catch (e) {
    print("error");
    print(e);
  }
}

class _Image {
  final String name;
  final Uint8List bytes;
  final String url;

  _Image(this.name, this.bytes, this.url);
}
