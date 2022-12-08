import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AddMaterials extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddMaterialsState();
}

class _AddMaterialsState extends State<AddMaterials> {
  final List<String> materials = [];
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
        Wrap(children: [
          Chip(label: Text("Duh"), onDeleted: () {}),
          ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(shape: CircleBorder()),
            child: Icon(Icons.add),
          ),
          _getDropDown()
        ])
      ],
    );
  }
}

Widget _getDropDown() {
  return DropdownSearch<String>(
    items: ["Emma", "Leon", "azza"],
    dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            suffixIcon: Icon(Icons.add),
            suffix: Icon(Icons.add),
            fillColor: Colors.yellow,
            filled: true)),
  );
}
