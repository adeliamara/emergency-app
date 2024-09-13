import 'dart:async';

import 'package:emergency_app/core/router.dart';
import 'package:emergency_app/firebase_options.dart';
import 'package:emergency_app/modules/call/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();

  print("FCM Token: $token");
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('message ${{
    'lat': message.data['lat']!,
    'long': message.data['long']!,
    'userName': message.data['name']!,
  }}');
  LocalNotificationService.showFullScreenNotification(
    lat: message.data['lat']!,
    long: message.data['long']!,
    userName: message.data['name']!,
  );

  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await getToken();
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
