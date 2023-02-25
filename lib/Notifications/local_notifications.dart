import 'dart:developer';
import 'package:bytrh/Routes/routes.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

class NotificationService {

  // Handling OnClick

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future _onNotificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'main_channel',
        'Main channel notifications',
        importance: Importance.max,
        playSound: true,
        priority: Priority.max,
        icon: '@drawable/ic_flutternotification',
      ),
      iOS: DarwinNotificationDetails(
        sound: 'default.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  Future<void> showLocalNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      FlutterLocalNotificationsPlugin().show(
        id,
        title,
        body,
        await _onNotificationDetails(),
        payload: payload,
      );

  static final onNotifications = BehaviorSubject<String?>();

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      log('notification payload: $payload');
      onNotifications.add(payload);
    }
  }

  Future init({bool isScheduled = false}) async {
    final android =
        AndroidInitializationSettings('@drawable/ic_flutternotification');
    final ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    final settings = InitializationSettings(android: android, iOS: ios);

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  listenNotifications({onClickNotification}) {
    onNotifications.stream.listen(onClickNotification);
  }
}
