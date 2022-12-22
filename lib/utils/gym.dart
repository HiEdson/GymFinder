import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gymfinder/models/gym_save_model.dart';
import 'package:provider/provider.dart';

import '../models/address.dart';

final db = FirebaseFirestore.instance;
Future<Map> saveGym(String name, int price, List<String> materials,
    Address address, BuildContext context) async {
  var images = Provider.of<NewGymModel>(context, listen: false)
      .images
      .values
      .map((e) => e.url)
      .toList();
  var doc = {
    "name": name,
    "price": price,
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
  try {
    var ref = await db.collection("gyms").add(doc);
    doc["id"] = ref.id;
    print("saved");
  } catch (e) {
    print("error");
    print(e);
  }
  return doc;
}
