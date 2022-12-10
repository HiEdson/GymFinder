import 'package:flutter/material.dart';

class LoginDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  var email = "";
  var password = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Email", style: TextStyle(color: Colors.white, fontSize: 20)),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Password",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: 24),
            minimumSize: Size(200, 60),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Text("Login"),
        )
      ],
    )));
  }
}

void showLoginDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => LoginDialog());
}
