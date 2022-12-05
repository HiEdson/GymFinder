import 'package:flutter/material.dart';
import 'components/gym_component.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import './components/rating.dart';

class singleGym extends StatefulWidget {
  final String gymInfo;
  const singleGym(this.gymInfo);

  @override
  State<StatefulWidget> createState() {
    return _singleGymState();
  }
}

class _singleGymState extends State<singleGym> {
  @override
  // double rating = 0;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Furkan's navbar goes hire"),
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
                  child: FittedBox(
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/map.jpg'),
                  )),
              Center(
                  child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text(
                        "Rate this Gym {$rating}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      )),
                  // rating()
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
                      print(rating);
                    },
                  )
                ],
              ))
            ],
          )),
        ));
  }
}
