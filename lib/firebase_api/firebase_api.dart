import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:it4788/model/notification.dart';
import 'package:it4788/personal_page/personal_page.dart';
import 'package:it4788/service/profile_sevice.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  late AndroidNotificationChannel channel;
  final _firebaseMessaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("NOTIFIIIII ${message.notification!.body}");
    showFlutterNotification(message);
  }

  Future<void> showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      print("NOTIFIIIII ${message.notification!.body}");
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              priority: Priority.high,
              importance: Importance.max,
              icon: 'app_icon',
            ),
          ),
          payload: message.data['json']);
    }
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    const initalizeSetting = InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
        iOS: DarwinInitializationSettings());

    channel = const AndroidNotificationChannel(
        'id', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      initalizeSetting,
      onDidReceiveNotificationResponse: (details) {
        handleClickPushNotification(details);
      },
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((event) {
      showFlutterNotification(event);
    });
  }

  Future<void> setDevTokenFirebase() async {
    await FirebaseMessaging.instance.deleteToken();
    final token = await _firebaseMessaging.getToken();
    print('TOKENNNNN $token');
    ProfileSevice().setDevToken(token!);
  }

  @pragma('vm:entry-point')
  Future<void> handleClickPushNotification(
      NotificationResponse notiResponse) async {
    var data = notificationFromJson(notiResponse.payload!);
    print('TESTTTT ${data.notificationId}');
  }
}
