import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:it4788/firebase_api/firebase_api.dart';
import 'package:it4788/home/post_detail_screen.dart';
import 'package:it4788/model/notification.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/sign_up/sign_up.dart';
import 'package:path_provider/path_provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.notification!.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String hivePath = appDocDir.path + '/hive_data';
  Directory(hivePath).createSync();
  Hive.init(hivePath);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void handleOnMessageOpenedApp(RemoteMessage message) async {
    var data = notificationFromJson(message.data['json']);
    MyApp.navigatorKey.currentState?.push(
      MaterialPageRoute(
          builder: (context) => PostDetailScreen(id: data.post.id)),
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleOnMessageOpenedApp(message);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      title: 'Anti Facebook',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const SignUpPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
