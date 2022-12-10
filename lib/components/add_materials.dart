import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddMaterials extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddMaterialsState();
}

class _AddMaterialsState extends State<AddMaterials> {
  final List<String> selectedMaterials = [];
  final List<String> materials = ["bar", "run", "ball", "dumbbell", "rope"];
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

void _getDropDown(BuildContext context, List<String> materials,
    List<String> initial, Function(List<String>) onConfirm) async {
  await showDialog(
      context: context,
      builder: (context) {
        return MultiSelectDialog(
          title: Text("Add Materials"),
          searchable: true,
          items: [
            for (var material in materials) MultiSelectItem(material, material)
          ],
          initialValue: initial,
          onConfirm: onConfirm,
        );
      });
}
