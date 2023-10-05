import 'package:flutter/material.dart';
import 'package:it4788/sign_up/account.dart';

import 'sign_in/save_info.dart';
import 'sign_up/verify_email.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VeryfyEmailPage(title: ''),
    );
  }
}
