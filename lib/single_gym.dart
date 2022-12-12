import 'package:flutter/material.dart';
import 'components/gym_component.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gymfinder/drawers/PrimaryDrawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import './secretKey.dart';
class singleGym extends StatefulWidget {
  final String gymInfo;
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
  //from here
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  List<PointLatLng> Allpoints=[];
  Map<PolylineId, Polyline> polylines = {};
  //to here
  

  void tryPoly()async{
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(googleAPiKey,
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
        // print(result.points);
  }

  @override
  void initState(){
    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'My Custom Title ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(showLocation2.toString()),
      position: showLocation2, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'My Custom Title 2',
        snippet: 'My Custom Subtitle 2',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    //you can add more markers here
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
                      widget.gymInfo,
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
                  margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 7),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/background.jpeg'),
                  )),
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
                      polylines: Set<Polyline>.of(polylines.values)
                    ),
                  )
                  ),
              Center(
                  child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text(
                        "Rate this Gym $newRating",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      )),
                  // rating(),
                  RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        newRating = rating;
                      });
                      //save the value to database
                      // print(rating);
                    },
                  ),
                ],
              ))
            ],
          )),
        ));
  }
}
