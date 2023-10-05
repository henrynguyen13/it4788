import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // Navigator.of(Context).push(), pop()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: const Color(0xff3a57e8),
        body: Column(
          children: [Text("Home Page")],
        ));
  }
}
