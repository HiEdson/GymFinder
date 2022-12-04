import 'package:flutter/material.dart';

class GymComp extends StatelessWidget {
  final gymData;
  GymComp(this.gymData);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // color: Colors.red,
                child: Text(
                  gymData,
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
                      Text(
                        "1 km",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        "2000 tl",
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
