import 'package:emergency_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        navigatorKey.currentState!.pushReplacementNamed(
          '/notification_alert',
        );
      },
    );
  }

  static Future<void> showFullScreenNotification({
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'full_screen_channel',
      'Full Screen Notifications',
      channelDescription: 'This channel is used for full screen notifications.',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
      color: Colors.amber,
      playSound: true,
      enableVibration: true, // Ensure vibration is enabled
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
      payload: 'fullscreen_notification',
    );
  }
}
