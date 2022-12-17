import 'package:flutter/material.dart';
import 'package:gymfinder/drawers/PrimaryDrawer.dart';
import 'package:gymfinder/screens/new_gym_screen.dart';
import 'package:gymfinder/screens/search_results.dart';
import '../gym_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var search = "";
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                onChanged: (value) {
                  search = value;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => SearchResults(search)));
                      }),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(45)),
                  ),
                  hintText: 'Enter name',
                  filled: true, //<-- SEE HERE
                  fillColor: Colors.white,
                ),
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
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => NewGymScreen()));
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
