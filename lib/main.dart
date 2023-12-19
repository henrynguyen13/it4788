import 'package:flutter/material.dart';
import 'package:it4788/home/home_screen.dart';
import 'package:it4788/sign_up/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anti Facebook',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const HomeScreen(),
      // routes: <String, WidgetBuilder>{
      //   '/home': (BuildContext context) => new HomeScreen(),
      // },
    );
  }
}
