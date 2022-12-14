import 'package:flutter/material.dart';
import 'package:gymfinder/drawers/PrimaryDrawer.dart';
import '../gym_list.dart';
import 'new_gym_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.grey,
          size: 55.0,
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Find a gym,find your new body',
              style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 30,
                  color: Colors.white),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                ),
                hintText: 'Try Avcilar, bench press, 100tl',
                filled: true, //<-- SEE HERE
                fillColor: Colors.white,
                icon: Icon(Icons.search),

                // suffixIcon: Align(
                //   widthFactor: 1.0,
                //   heightFactor: 1.0,
                //   child: Icon(
                //   Icons.search,
                // ),)
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Text(
              'Are you a gym owner?',
              style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 20,
                  color: Colors.white),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewGymScreen()),
                )
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 24),
                minimumSize: Size(150, 35),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: Text("Start Here"),
            )
          ],
        )),
      ),

      endDrawer:
          PrimaryDrawer(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
