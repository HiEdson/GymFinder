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
      content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            children: [
              DropdownSearch<String>(
                items: provinces,
                selectedItem: address.province,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration:
                      InputDecoration(labelText: "Province"),
                ),
                onChanged: (value) {
                  setState(() {
                    address.province = value!;
                  });
                },
              ),
              DropdownSearch<String>(
                items: getProvinceDistricts(address.province),
                selectedItem: address.district,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration:
                      InputDecoration(labelText: "District"),
                ),
                onChanged: (value) {
                  setState(() {
                    address.district = value!;
                  });
                },
              ),
              DropdownSearch<String>(
                items: getDistrictMahalle(address.province, address.district),
                selectedItem: address.mahalle,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration:
                      InputDecoration(labelText: "Mahalle"),
                ),
                onChanged: (value) {
                  setState(() {
                    address = address.copy(value!);
                  });
                },
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: SelectLocationMap(
                  address,
                  (LatLng loc) {
                    setState(() {
                      address.location = loc;
                    });
                  },
                  key: ValueKey(address.mahalle),
                ),
              )
            ],
          )),
    );
  }
}
