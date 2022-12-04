import 'package:flutter/material.dart';
import 'components/gym_component.dart';
import './single_gym.dart';

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
          title: Text("Furkan's navbar goes hire"),
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
          child: /* add child content here */
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
            // width: 1000.0,
            height: 1000.0,
            child: MyCustomForm(),
            // child: Row(
            //   // children: const <Widget>[
            //   //   ,
            //   //   // const MyCustomForm(),

            //   // ],
            // )
          ),
        ));
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Column(children: const <Widget>[
                    TextField(
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
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => singleGym("Avcilar Gym Club1")));
                  },
                  child: GymComp('Avcilar Gym Club1'),
                ),

                GymComp('Avcilar Gym Club1'),
                GymComp('Avcilar Gym Club2'),
                GymComp('Avcilar Gym Club3'),
                GymComp('Avcilar Gym Club4'),
                GymComp('Avcilar Gym Club5'),
                GymComp('Avcilar Gym Club5'),
                GymComp('Avcilar Gym Club6'),
                GymComp('Avcilar Gym Club7'),
                GymComp('Avcilar Gym Club8'),
                GymComp('Avcilar Gym Club9'),
                GymComp('Avcilar Gym Club10'),
                GymComp('Avcilar Gym Club11'),
                GymComp('Avcilar Gym Club12')
              ],
            ))
      ],
    ));
  }
}
