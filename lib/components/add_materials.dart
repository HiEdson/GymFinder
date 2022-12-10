import 'package:flutter/material.dart';
import 'package:gymfinder/utils/db.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddMaterials extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddMaterialsState();
}

class _AddMaterialsState extends State<AddMaterials> {
  final List<String> selectedMaterials = [];
  final Future<List<String>> materials = getMaterials();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Materials",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black, blurRadius: 10)]),
        ),
        Wrap(spacing: 10, children: [
          for (var material in selectedMaterials)
            Chip(
                label: Text(material),
                onDeleted: () {
                  setState(() {
                    selectedMaterials.remove(material);
                  });
                }),
          ElevatedButton(
            onPressed: () async {
              _getDropDown(context, materials, selectedMaterials, (values) {
                selectedMaterials.clear();
                setState(() {
                  selectedMaterials.addAll(values);
                });
              });
            },
            style: ElevatedButton.styleFrom(shape: CircleBorder()),
            child: Icon(Icons.add),
          ),
        ])
      ],
    );
  }
}

void _getDropDown(BuildContext context, Future<List<String>> future,
    List<String> initial, Function(List<String>) onConfirm) async {
  await showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var materials = snapshot.data ?? [];
                return MultiSelectDialog(
                  title: Text("Add Materials"),
                  searchable: true,
                  items: [
                    for (var material in materials)
                      MultiSelectItem(material, material)
                  ],
                  initialValue: initial,
                  onConfirm: onConfirm,
                );
              } else {
                return AlertDialog(title: Text("Loading"));
              }
            });
      });
}
