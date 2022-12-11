import 'package:google_maps_flutter/google_maps_flutter.dart';

class Address {
  String province = "";
  String district = "";
  String mahalle = "";
  LatLng location = LatLng(48, 24);

  Address(
      [this.province = "",
      this.district = "",
      this.mahalle = "",
      this.location = const LatLng(48, 24)]);

  Address copy(String mahalle) {
    return Address(province, district, mahalle, location);
  }
}
