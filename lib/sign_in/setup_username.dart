import 'package:flutter/material.dart';

class SetUsernamePage extends StatefulWidget {
  const SetUsernamePage({super.key});

  @override
  State<SetUsernamePage> createState() => _SetUsernamePageState();
}

class _SetUsernamePageState extends State<SetUsernamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Đặt tên người dùng tại đây !"),
    );
  }
}
