import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gymfinder/single_gym.dart';
import 'package:gymfinder/utils/maps.dart';
import 'package:synchronized/synchronized.dart';

class GymComp extends StatelessWidget {
  static final lock = Lock();
  final gymData;
  GymComp(this.gymData, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => singleGym(gymData)));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // color: Colors.red,
                child: Text(
                  gymData["name"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder(
                          future: GymComp.lock.synchronized(() => getDistance(
                              gymData["location"]["latitude"] as double,
                              gymData["location"]["longitude"] as double)),
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text(
                                snapshot.data ?? "1 km away",
                                style: TextStyle(fontSize: 18),
                              );
                            }
                            return Text(
                              "...km away",
                              style: TextStyle(fontSize: 18),
                            );
                          }),
                      Text(
                        "${gymData["price"]} tl",
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> getDistance(double latitude, double longitude) async {
  var position = await getCurrentLocation();
  if (position == null) return "";
  double distance = Geolocator.distanceBetween(
      latitude, longitude, position.latitude, position.longitude);
  return "${(distance / 1000).toStringAsFixed(0)} km away";
}
