import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gymfinder/components/select_location_map.dart';
import 'package:gymfinder/models/address.dart';
import 'package:gymfinder/utils/city.dart';

class SelectLocation extends StatefulWidget {
  final Function(Address) onAddressChange;
  const SelectLocation({required this.onAddressChange});
  @override
  State<StatefulWidget> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  final provinces = getProvinces();
  var address = Address();

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
                widget.onAddressChange(address);
              },
              child: Text("OK")),
        ],
        title: Text("Choose Address"),
        content: ListView(
          children: [
            Text("Province"),
            DropdownSearch<String>(
              items: provinces,
              selectedItem: address.province,
              onChanged: (value) {
                setState(() {
                  address.province = value!;
                });
              },
            ),
            SizedBox(height: 10),
            Text("District"),
            DropdownSearch<String>(
              items: getProvinceDistricts(address.province),
              selectedItem: address.district,
              onChanged: (value) {
                setState(() {
                  address.district = value!;
                });
              },
            ),
            SizedBox(height: 10),
            Text("Mahalle"),
            DropdownSearch<String>(
              items: getDistrictMahalle(address.province, address.district),
              selectedItem: address.mahalle,
              onChanged: (value) {
                setState(() {
                  address.mahalle = value!;
                });
              },
            ),
            SizedBox(height: 10),
            Container(
                height: 200,
                child: SelectLocationMap(address, (LatLng loc) {
                  setState(() {
                    address.location = loc;
                  });
                }))
          ],
        ));
  }
}
