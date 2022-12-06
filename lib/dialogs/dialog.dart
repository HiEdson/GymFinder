import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Hello"),
      content: Container(
        color: Colors.yellow,
        height: 500,
        width: 500,
      ),
    );
  }
}
