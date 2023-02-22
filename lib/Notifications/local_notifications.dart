import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_flutternotification');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, int seconds) async {
   try{
     await flutterLocalNotificationsPlugin.zonedSchedule(
       id,
       title,
       body,
       tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
       const NotificationDetails(
         android: AndroidNotificationDetails(
             'main_channel', 'Main channel notifications',
             importance: Importance.max,
             playSound: true,
             priority: Priority.max,
             icon: '@drawable/ic_flutternotification'),
         iOS: DarwinNotificationDetails(
           sound: 'default.wav',
           presentAlert: true,
           presentBadge: true,
           presentSound: true,
         ),
       ),
       uiLocalNotificationDateInterpretation:
       UILocalNotificationDateInterpretation.absoluteTime,
       androidAllowWhileIdle: true,
     );
   }catch(e){
     log(e.toString());
   }
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
