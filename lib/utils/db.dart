import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

Future<List<String>> getMaterials() async {
  var ref = await db.collection("materials").get();
  var materials = ref.docs.map((e) => e.data()["name"] as String).toList();

  return materials;
}
