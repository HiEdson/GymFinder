import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectLocationMap();
}

class _SelectLocationMap extends State<SelectLocationMap> {
  var position = CameraPosition(target: LatLng(41.04, 28.69), zoom: 14);
  GoogleMapController? controller;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: position,
      mapType: MapType.normal,
      onMapCreated: ((_controller) => controller = _controller),
      onTap: (value) async {
        print("pressed at ${value.latitude} ${value.longitude}");
        // controller.
      },
    );
  }
}
