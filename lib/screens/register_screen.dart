import 'package:flutter/material.dart';
import 'package:gymfinder/dialogs/dialog.dart';

import '../components/dark_image.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  var email = "";
  var password = "";
  bool registering = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("GymFinder")),
        body: Stack(
          children: [
            DarkImage(
              alpha: 80,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.jpeg"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              fillColor: Colors.white,
                              filled: true),
                          onChanged: (value) => setState(() {
                            email = value;
                          }),
                        )
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Password",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              fillColor: Colors.white,
                              filled: true),
                          obscureText: true,
                          onChanged: (value) => setState(() {
                            password = value;
                          }),
                        )
                      ]),
                ),
                ElevatedButton(
                    onPressed: registering
                        ? null
                        : () async {
                            setState(() {
                              registering = true;
                            });
                            Future.delayed(Duration(seconds: 3), () {
                              setState(() {
                                registering = false;
                              });
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 40),
                      disabledBackgroundColor: Colors.grey,
                      textStyle: TextStyle(fontSize: 24),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text("Register"),
                      SizedBox(width: 20),
                      if (registering) CircularProgressIndicator()
                    ]))
              ],
            )
          ],
        ));
  }
}

void _showDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => MyDialog());
}
