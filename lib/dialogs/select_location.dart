import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gymfinder/utils/city.dart';

class SelectLocation extends StatefulWidget {
  final Function(String) onAddressChange;
  SelectLocation({required this.onAddressChange});
  @override
  State<StatefulWidget> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  final provinces = getProvinces();
  var province = "";
  var district = "";
  var mahalle = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onAddressChange(province);
              },
              child: Text("OK")),
        ],
        title: Text("Choose Address"),
        content: ListView(
          children: [
            Text("Province"),
            DropdownSearch<String>(
              items: provinces,
              selectedItem: province,
              onChanged: (value) {
                setState(() {
                  province = value!;
                });
              },
            ),
            SizedBox(height: 40),
            Text("District"),
            DropdownSearch<String>(
              items: getProvinceDistricts(province),
              selectedItem: district,
              onChanged: (value) {
                setState(() {
                  district = value!;
                });
              },
            ),
            SizedBox(height: 40),
            Text("Mahalle"),
            DropdownSearch<String>(
              items: getDistrictMahalle(province, district),
              selectedItem: mahalle,
              onChanged: (value) {
                setState(() {
                  mahalle = value!;
                });
              },
            ),
            SizedBox(height: 40),
          ],
        ));
  }
}
