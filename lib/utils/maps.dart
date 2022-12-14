import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gymfinder/secretKey.dart';
import 'package:gymfinder/utils/constants.dart';

Future<LatLng> getLocationFromAdress(String address) async {
  try {
    var response = await Dio().get(
        "https://maps.googleapis.com/maps/api/geocode/json",
        queryParameters: {"key": googleMapsKey, "address": address});
    var json = response.data;
    Map<String, dynamic> location = json["results"][0]["geometry"]["location"];
    double lat = location["lat"] ?? 41.04;
    double lng = location["lng"] ?? 28.69;
    return LatLng(lat, lng);
    // print(json);
  } catch (e) {
    print("error");
    print(e);
  }
  return LatLng(41.04, 28.69);
}

Future<Position?> getCurrentLocation() async {
  var service = await Geolocator.isLocationServiceEnabled();
  if (!service) return null;
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  try {
    return await Geolocator.getCurrentPosition();
  } catch (e) {
    print("error getting location");
    print(e);
  }
  return null;
}
