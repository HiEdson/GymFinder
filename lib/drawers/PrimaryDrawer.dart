import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymfinder/screens/register_screen.dart';

import '../gym_list.dart';
import '../screens/new_gym_screen.dart';

class PrimaryDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrimaryDrawerState();
  }
}

class _PrimaryDrawerState extends State<PrimaryDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage("assets/images/gym.jpg")),
            ),
            child: Text('')),
        ListTile(
          title: const Text('Gym List'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GymList(),
              ),
            );
            // Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Register'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
        ),
        ListTile(
          title: const Text('New Gym'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NewGymScreen()));
          },
        ),
      ],
    ));
  }
}
