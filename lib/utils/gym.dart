import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:gymfinder/models/gym_save_model.dart';
import 'package:provider/provider.dart';

import '../models/address.dart';

final db = FirebaseFirestore.instance;
Future<void> saveGym(String name, List<String> materials, Address address,
    BuildContext context) async {
  try {
    var images = Provider.of<NewGymModel>(context, listen: false)
        .images
        .values
        .map((e) => e.url)
        .toList();
    var doc = {
      "name": name,
      "province": address.province,
      "district": address.district,
      "mahalle": address.mahalle,
      "location": {
        "latitude": address.location.latitude,
        "longitude": address.location.longitude,
      },
      "materials": materials,
      "images": images
    };
    var ref = await db.collection("gyms").add(doc);
    print("saved");
  } catch (e) {
    print("error");
    print(e);
  }
}
