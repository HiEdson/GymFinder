import 'package:flutter/material.dart';
import 'components/gym_component.dart';
import './single_gym.dart';
import 'package:firebase_core/firebase_core.dart';

//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';

class GymList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GymListState();
  }
}

class _GymListState extends State<GymList> {
  var allGyms=[];
  @override
  void initState() {
    var tempist = [];
    FirebaseFirestore.instance
        .collection('gyms')
        .get()
        .then((QuerySnapshot querySnapshot) {
      // print('..............done................');
      // print(querySnapshot.docs);
      querySnapshot.docs.forEach((doc) {
        print('..............done................');
        print(doc.data());
        tempist.add(doc.data());
        print('added');
        print(tempist);
      });
      setState(() {
        allGyms = List.from(tempist);
      });
      print('--------------------------------------------------------');
      print(allGyms);
      print('--------------------------------------------------------');
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputInfo.dispose();
    super.dispose();
  }

  // var gymList = [
  //   'Avcilar Gym Club1',
  //   'Avcilar Gym Club2',
  //   'Avcilar Gym Club3',
  //   'Avcilar Gym Club4',
  //   'Avcilar Gym Club5',
  //   'Avcilar Gym Club6'
  // ];
  final TextEditingController inputInfo = TextEditingController();

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
          // resizeToAvoidBottomPadding: false
          padding: const EdgeInsets.only(),
          decoration: 
          BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            // width: 1000.0,
            height: 1000.0,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 500,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 16),
                          child: Column(children: <Widget>[
                            TextField(
                              controller: inputInfo,
                              decoration: InputDecoration(
                                icon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(45)),
                                ),
                                hintText: 'Try Avcilar, bench press, 100tl',
                                filled: true,
                                fillColor: Colors.white,
                                // suffixIcon: Align(
                                //   widthFactor: 1.0,
                                //   heightFactor: 1.0,
                                //   child: Icon(
                                //   Icons.search,
                                // ),)
                              ),
                            ),
                          ]),
                        ),
                        ListView.builder(
                          itemCount: allGyms.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var currentItem = allGyms[index];
                            return (GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => singleGym(currentItem)));
                              },
                              child: GymComp(currentItem),
                            ));
                          },
                        ),
                      ],
                    ))
              ],
            )),
          ),
        ));
  }
}