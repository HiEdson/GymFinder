import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymfinder/utils/city.dart';

class SelectLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  final provinces = getProvinces();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Choose Address"),
        content: ListView(
          children: [
            DropdownSearch(
              items: provinces,
            )
          ],
        ));
  }
}
