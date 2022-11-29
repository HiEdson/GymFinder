import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymFinder',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: const Color(0xFF151026),
          )
      ),
      home: const MyHomePage(title: 'GymFinder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage("assets/images/background.jpeg") ,
            fit: BoxFit.cover,

          ),

        ),
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
              height: 50.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 45),
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'try Avcilar,pushdown,100 tl ...',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )
                ],
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 150),
              padding: EdgeInsets.all(10.0),

              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: <Widget>[

                  Text(
                    'Start Here',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),


          ],
        ),
      ),

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/gym.jpg")),

              ),

              child: Text('')
            ),
            ListTile(
              title: const Text('Register'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Gym List '),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Add Gym'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
