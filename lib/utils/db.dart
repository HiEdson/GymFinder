import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final db = FirebaseFirestore.instance;

Future<List<String>> getMaterials() async {
  var ref = await db.collection("materials").get();
  var materials = ref.docs.map((e) => e.data()["name"] as String).toList();

  return materials;
}
