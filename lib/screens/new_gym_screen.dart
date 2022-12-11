import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gymfinder/components/add_images.dart';
import 'package:gymfinder/components/add_materials.dart';
import 'package:gymfinder/dialogs/select_location.dart';
import 'package:gymfinder/utils/gym.dart';

import '../components/dark_image.dart';
import '../models/address.dart';

class NewGymScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewGymScreenState();
  }
}

class _NewGymScreenState extends State<NewGymScreen> {
  var name = "";
  List<String> materials = [];
  var address = Address();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("GymFinder")),
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
            CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Gym Name",
                            fillColor: Colors.white,
                            filled: true),
                        onChanged: (value) => setState(() {
                          name = value;
                        }),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => SelectLocation(
                                      onAddressChange: (Address address) {
                                    setState(() {
                                      this.address = address;
                                    });
                                  }));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(address.province.length > 1
                              ? "${address.mahalle}/${address.district}, ${address.province}"
                              : ""),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: AddMaterials((List<String> mats) {
                        materials = mats;
                      }),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "Images",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 10)
                            ]),
                      ),
                    )
                  ]),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  sliver: AddImages(),
                ),
                SliverToBoxAdapter(
                  child: Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          saveGym(name, materials, address, context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          textStyle: TextStyle(fontSize: 24),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text("Add"),
                      )),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 10))
              ],
            )
          ],
        ));
  }
}
