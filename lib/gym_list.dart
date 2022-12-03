import 'package:flutter/material.dart';
import 'components/gym_component.dart';

// void main() {
//   runApp(GymList());
// }

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
            width: 1000.0,
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
                        filled: true, //<-- SEE HERE
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
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club'),
                GymComp('Avcilar Gym Club')
              ],
            ))
      ],
    ));
  }
}
