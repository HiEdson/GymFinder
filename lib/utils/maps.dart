import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gymfinder/utils/constants.dart';

void getLocationFromAdress(String address) async {
  try {
    var response = await Dio().get(
        "https://maps.googleapis.com/maps/api/geocode/json",
        queryParameters: {"key": Constants.googleMapsKey, "address": address});
    var json = jsonDecode(response.data);
    print(json);
  } catch (e) {
    print("error");
    print(e);
  }
}
