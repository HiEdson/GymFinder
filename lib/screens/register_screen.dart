import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymfinder/dialogs/dialog.dart';
import 'package:gymfinder/utils/user.dart';

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
  var name = "";
  final auth = FirebaseAuth.instance;
  String? emailError;
  bool registering = false;

  Future<bool> registerUser() async {
    try {
      setState(() {
        emailError = null;
      });
      var creds = await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      creds.user?.updateDisplayName(name.trim());
      if (creds.user != null) return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        setState(() {
          emailError = "Email in use";
        });
      }
      print(e);
      print(e.code);
      return false;
    }
    return false;
  }

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
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name",
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
                            name = value;
                          }),
                        )
                      ]),
                ),
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
                              errorText: emailError,
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
                Align(
                    child: ElevatedButton(
                  onPressed: registering
                      ? null
                      : () async {
                          setState(() {
                            registering = true;
                          });
                          var result = await registerUser();
                          setState(() {
                            registering = false;
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
                  ]),
                ))
              ],
            )
          ],
        ));
  }
}

void _showDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => MyDialog());
}
