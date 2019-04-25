import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: TextTheme(title: TextStyle(fontSize: 22)),
        title: Text("Info/Settings"),
      ),
      body: Center(
        child: Text('vagi'),
      ),
    );
  }
}