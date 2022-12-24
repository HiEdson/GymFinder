import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gymfinder/components/dark_image.dart';
import 'package:gymfinder/utils/maps.dart';
import 'components/gym_component.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gymfinder/drawers/PrimaryDrawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import './secretKey.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class singleGym extends StatefulWidget {
  final gymInfo;
  const singleGym(this.gymInfo);

  @override
  State<StatefulWidget> createState() {
    return _singleGymState();
  }
}

class _singleGymState extends State<singleGym> {
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = {}; //markers for google map
  final initialPosition = CameraPosition(
    target: LatLng(41.0070391276, 28.6817442045),
    zoom: 14,
  );
  double newRating = 1;
  String googleAPiKey = googleMapsKey; //from my local file containing this key
  Map<PolylineId, Polyline> polylines = {};
  var imgUrl = [];
  var currentScore;
  var exist;
  List displayRating = [0, 0, 0, 0, 0];

  void checkExist(String docID) async {
    try {
      await FirebaseFirestore.instance.doc("rate/$docID").get().then((doc) {
        if (doc.data() != null) {
          // return true;
          setState(() {
            currentScore = doc.data();
            exist = true;
          });
          getRatePercentage(currentScore);
        } else {
          // return false;
          setState(() {
            exist = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        exist = false;
      });
    }
    // return false;
  }

  void RateGym(x) {
    // bool flag = checkExist(widget.gymInfo["id"]);
    checkExist(widget.gymInfo["id"]);
    if (exist == false) {
      FirebaseFirestore.instance
          .collection("rate")
          .doc(widget.gymInfo["id"])
          .set({
        "one": x == 1 ? 1 : 0,
        "two": x == 2 ? 1 : 0,
        "three": x == 3 ? 1 : 0,
        "four": x == 4 ? 1 : 0,
        "five": x == 5 ? 1 : 0,
        "gymId": widget.gymInfo["id"]
      });
    } else {
      var field = x == 1
          ? "one"
          : x == 2
              ? "two"
              : x == 3
                  ? "three"
                  : x == 4
                      ? "four"
                      : "five";
      FirebaseFirestore.instance
          .collection('rate')
          .doc(widget.gymInfo["id"])
          .update({field: FieldValue.increment(1)});
    }
  }

  void getRatePercentage(rateList) {
    var rateRaw = [];
    var rateInPercent = [];
    int maxVal = 0;
    rateList.forEach((k, v) {
      rateRaw.add(v);
    });
    if (exist) {
      rateRaw.removeAt(0);
    }
    print(rateRaw);
    for (var i = 0; i < rateRaw.length; i++) {
      if (rateRaw[i] > maxVal) {
        maxVal = rateRaw[i];
      }
    }

    for (var t = 0; t < rateRaw.length; t++) {
      if (rateRaw[t] > 0) {
        var x = (rateRaw[t] / maxVal).toStringAsFixed(2);
        rateInPercent.add(double.parse(x));
      } else {
        rateInPercent.add(rateRaw[t]);
      }
    }
    setState(() {
      displayRating = rateInPercent;
    });
    print(maxVal);
    print(displayRating);
  }

  calculateDistances() async {
    var position = await getCurrentLocation();
    if (position == null) return;
    var src = LatLng(position.latitude, position.longitude);
    var dst = LatLng(widget.gymInfo["location"]["latitude"],
        widget.gymInfo["location"]["latitude"]);
    markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: src,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)));

    markers.add(Marker(
      markerId: MarkerId(widget.gymInfo["id"]),
      position: dst,
      icon: BitmapDescriptor.defaultMarker,
    ));

    var polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(src.latitude, src.longitude),
        PointLatLng(dst.latitude, dst.longitude));

    List<LatLng> polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    Polyline polyline = Polyline(
      polylineId: PolylineId(widget.gymInfo["id"]),
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    // Adding the polyline to the map
    polylines[polyline.mapsId] = polyline;
    setState(() {
      polylines = polylines;
      markers = markers;
    });
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(src, 8));
    // mapController?.animateCamera(CameraUpdate.zoomTo(zoom + 1));
  }

  @override
  void initState() {
    imgUrl = widget.gymInfo["images"];
    var gymId = widget.gymInfo["id"];
    checkExist(gymId);
    calculateDistances();
    //get the current Score

    FirebaseFirestore.instance.doc("rate/$gymId").get().then((doc) {
      setState(() {
        currentScore = doc;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "GymFinder",
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          //have to add the hamburger here, i cant find it
          // iconTheme: IconThemeData(
          //   color: Colors.grey,
          //   size: 55.0,
          // ),
        ),
        body: Stack(
          children: [
            DarkImage(
              alpha: 80,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.jpeg"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    // height: 1000.0,
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          widget.gymInfo["name"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 7),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ...(imgUrl).map((img) {
                          return Container(
                              // width: 550.0,
                              padding: EdgeInsets.all(20),
                              color: Colors.black.withOpacity(0),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                imageUrl: img,
                              ));
                        })
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 7),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Container(
                        child: GoogleMap(
                            zoomGesturesEnabled:
                                true, //enable Zoom in, out on map
                            initialCameraPosition: initialPosition,
                            markers: markers, //markers to show on map
                            mapType: MapType.normal, //map type
                            onMapCreated: (controller) {
                              mapController = controller;
                            },
                            polylines: Set<Polyline>.of(polylines.values)),
                      )),
                  Center(
                      child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Text(
                            "Rate this Gym",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                      // rating(),
                      RatingBar.builder(
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        // allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            RateGym(rating);
                            // newRating = rating;
                          });
                        },
                      ),
                      for (var row = 5; row > 0; --row)
                        Container(
                          margin: const EdgeInsets.only(top: 20.0, left: 10.0),
                          child: Row(
                            children: [
                              for (var i = 0; i < row; ++i)
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              Spacer(),
                              LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width - 150,
                                // width: 100.0,
                                lineHeight: 8.0,
                                percent: displayRating[row - 1].toDouble(),
                                progressColor: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ))
                ],
              ),
            ),
          ],
        ));
  }
}
