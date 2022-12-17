import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(41.0070391276, 28.6817442045);
  LatLng showLocation2 = LatLng(40.9895, 28.7243);
  double newRating = 1;
  String googleAPiKey = googleMapsKey; //from my local file containing this key
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  List<PointLatLng> Allpoints = [];
  Map<PolylineId, Polyline> polylines = {};
  var imgUrl = [];
  var currentScore;
  var exist;
  List displayRating = [0, 0, 0, 0, 0];

  void tryPoly() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(showLocation.latitude, showLocation.longitude),
        PointLatLng(showLocation2.latitude, showLocation2.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      Allpoints = result.points;
    });
  }

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

  @override
  void initState() {
    showLocation2 = LatLng(widget.gymInfo["location"]["latitude"],
        widget.gymInfo["location"]["longitude"]);
    imgUrl = widget.gymInfo["images"];

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'My location',
        snippet: '',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    //second marker, destination
    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(showLocation2.toString()),
      position: showLocation2, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Gyms location',
        snippet: '',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    //set The destination location
    tryPoly();
    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    // Adding the polyline to the map
    polylines[id] = polyline;
    var gymId = widget.gymInfo["id"];
    checkExist(gymId);
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
        body: Container(
          constraints: BoxConstraints.expand(),
          padding: const EdgeInsets.only(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
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
                // padding: const EdgeInsets.only(),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                // margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 7),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...(imgUrl).map((img) {
                      return Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          // width: 550.0,
                          color: Colors.black,
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            imageUrl: img,
                          ));
                    })
                  ],
                ),
                // FittedBox(
                //   fit: BoxFit.fill,
                //   alignment: Alignment.center,
                //   child: Image.asset('assets/images/background.jpeg'),
                // )
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  // padding: const EdgeInsets.only(),
                  margin:
                      const EdgeInsets.only(left: 25.0, right: 25.0, top: 40.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 7),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    // height: MediaQuery.of(context).size.height / 3,
                    // width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                        zoomGesturesEnabled: true, //enable Zoom in, out on map
                        initialCameraPosition: CameraPosition(
                          target: showLocation,
                          zoom: 14.0,
                        ),
                        markers: markers, //markers to show on map
                        mapType: MapType.normal, //map type
                        onMapCreated: (controller) {
                          //method called when map is created
                          setState(() {
                            mapController = controller;
                          });
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
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 150,
                          // width: 100.0,
                          lineHeight: 8.0,
                          percent: displayRating[4].toDouble(),
                          progressColor: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  //4 stars
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 24.0),
                          child: LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 150,
                            lineHeight: 8.0,
                            percent: displayRating[3].toDouble(),
                            progressColor: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  //3 star
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 47.0),
                          child: LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 150,
                            lineHeight: 8.0,
                            percent: displayRating[2].toDouble(),
                            progressColor: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  //2 star
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 69.0),
                          child: LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 150,
                            lineHeight: 8.0,
                            percent: displayRating[1].toDouble(),
                            progressColor: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  // 1 star
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 91.0),
                          child: LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 150,
                            lineHeight: 8.0,
                            percent: displayRating[0].toDouble(),
                            progressColor: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))
            ],
          )),
        ));
  }
}
