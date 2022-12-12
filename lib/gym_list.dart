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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            // width: 1000.0,
            height: 1000.0,
            child: MyCustomForm(),
          ),
        ));
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});
  @override
  Widget build(BuildContext context) {
    const gymList = [
      'Avcilar Gym Club1',
      'Avcilar Gym Club2',
      'Avcilar Gym Club3',
      'Avcilar Gym Club4',
      'Avcilar Gym Club5',
      'Avcilar Gym Club6'
    ];
    final TextEditingController inputInfo = TextEditingController();
    final Allgyms = FirebaseFirestore.instance.collection('users');

  print('is it working');
    FirebaseFirestore.instance
        .collection('gyms')
        .get()
        .then((QuerySnapshot querySnapshot) {
          print('..............done................');
          print(querySnapshot.docs);
      querySnapshot.docs.forEach((doc) {
        print('--------------------------------------------------------');
        print(doc["name"]);
        print('--------------------------------------------------------');
      });
    });

      @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      inputInfo.dispose();
      // super.dispose();
    }
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            width: 500,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                  child: Column(children: <Widget>[
                    TextField(
                      controller: inputInfo,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
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

                //it will be mapped
                //test the gest detect with the first element
                //fetch from database
                // FirebaseAnimatedList()
                ...(gymList).map((g) {
                  //(gymList as List<String>)
                  return (GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => singleGym(g)));
                    },
                    child: GymComp(g),
                  ));
                }).toList(),
              ],
            ))
      ],
    ));
  }
}
