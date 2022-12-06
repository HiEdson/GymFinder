import 'package:flutter/material.dart';
import 'package:gymfinder/components/add_images.dart';

class NewGymScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewGymScreenState();
  }
}

class _NewGymScreenState extends State<NewGymScreen> {
  var email = "";
  var password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("GymFinder")),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.jpeg"),
                    fit: BoxFit.cover),
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Add New Gym",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 10)
                            ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Gym Name",
                            fillColor: Colors.white,
                            filled: true),
                        onChanged: (value) => setState(() {
                          email = value;
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Location",
                            fillColor: Colors.white,
                            filled: true),
                        onChanged: (value) => setState(() {
                          email = value;
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    hintText: "Materials",
                                    fillColor: Colors.white,
                                    filled: true),
                                onChanged: (value) => setState(() {
                                      email = value;
                                    })),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            style:
                                ElevatedButton.styleFrom(shape: CircleBorder()),
                            child: Icon(Icons.add),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Images",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 10)
                              ])),
                    )
                  ]),
                ),
                AddImages(),
                SliverToBoxAdapter(
                    child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 24),
                    minimumSize: Size(200, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text("Add"),
                ))
              ],
            )
          ],
        ));
  }
}
