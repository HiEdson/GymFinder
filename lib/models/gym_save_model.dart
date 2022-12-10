import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class NewGymModel extends ChangeNotifier {
  final Map<String, _Image> images = {};
  final storageRef = FirebaseStorage.instance.ref();
  final rng = Random();

  Future<void> addImage(String name, Uint8List bytes) async {
    name = (rng.nextInt(1000) + 1).toString() +
        name.replaceAll(RegExp(r'\W+'), "");
    var imageRef = storageRef.child(name);
    try {
      await imageRef.putData(bytes);
      var url = await imageRef.getDownloadURL();
      images[name] = _Image(name, bytes, url);
    } catch (e) {
      print("error uploading");
      print(e);
    }
  }

  void removeImage(String name) {
    name = (rng.nextInt(1000) + 1).toString() +
        name.replaceAll(RegExp(r'\W+'), "");
    images.remove(name);
  }
}

class _Image {
  final String name;
  final Uint8List bytes;
  final String url;

  _Image(this.name, this.bytes, this.url);
}
