import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gymfinder/models/address.dart';
import 'package:gymfinder/utils/maps.dart';

class SelectLocationMap extends StatefulWidget {
  final Address address;
  final Function(LatLng) setLocation;
  const SelectLocationMap(this.address, this.setLocation, {super.key});
  @override
  State<StatefulWidget> createState() => _SelectLocationMapState();
}

class _SelectLocationMapState extends State<SelectLocationMap> {
  var position = CameraPosition(target: LatLng(41.04, 28.69), zoom: 14);
  late Future<LatLng> future;
  GoogleMapController? controller;
  LatLng location = LatLng(48.04, 28.98);
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    var address =
        "${widget.address.mahalle}/${widget.address.district}, ${widget.address.province}";
    future = getLocationFromAdress(address);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var target = CameraPosition(target: snapshot.data!, zoom: 14);
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: target,
                  mapType: MapType.normal,
                  markers: markers,
                  onMapCreated: ((_controller) => controller = _controller),
                  onTap: (value) async {
                    markers.clear();
                    location = LatLng(value.latitude, value.longitude);
                    var marker = Marker(
                        markerId: MarkerId(value.toString()),
                        position: location);
                    setState(() {
                      markers.add(marker);
                    });
                    widget.setLocation(location);
                    print("pressed at ${value.latitude} ${value.longitude}");
                    // controller.
                  },
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Text(
                      "${location.latitude.toStringAsFixed(3)} ${location.longitude.toStringAsFixed(3)}"),
                )
              ],
            );
          }
          return Center(
              child: SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator()));
        });
  }
}
