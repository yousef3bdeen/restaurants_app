import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../resources/assets_manager.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> notifications = [];

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User Granted permission');
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          'Title: ${message.notification?.title} | Body: ${message.notification?.body}');
    });
  }

  @override
  void initState() {
    super.initState();
    requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        final title = message.notification?.title ?? 'No Title';
        final body = message.notification?.body ?? 'No Body';
        final notificationText = 'Title: $title | Body: $body';
        notifications.add(notificationText);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}
