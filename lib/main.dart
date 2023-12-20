import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:it4788/firebase_api/firebase_api.dart';
import 'package:it4788/home/home_screen.dart';
import 'package:it4788/sign_in/reset_password.dart';
import 'package:it4788/sign_in/verify_reset_password.dart';
import 'package:it4788/sign_up/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anti Facebook',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const SignUpPage(),
      // routes: <String, WidgetBuilder>{
      //   '/home': (BuildContext context) => new HomeScreen(),
      // },
    );
  }
}
