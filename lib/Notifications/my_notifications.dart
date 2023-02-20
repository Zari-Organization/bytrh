import 'dart:developer';

import 'package:bytrh/Notifications/notification_model.dart';
import 'package:chat_package/models/chat_message.dart';
import 'package:chat_package/models/media/chat_media.dart';
import 'package:chat_package/models/media/media_type.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../Logic/controllers/Chat_Controllers/chat_controllers.dart';
import '../Utils/app_alerts.dart';

// Background message
Future<NotificationsModel?> backgroundHandler(RemoteMessage message) async {
  try {
    log("Got a message from backgroundHandler --> ${message.data}");
    return NotificationsModel.fromJson(message.data);
  } catch (e) {
    log(e.toString());
  }
}

// On Background Notification Click
Future<void> onNotificationClickHandler() async {
  try{
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      backgroundHandler(message).then((value) {
        log("Got a message from onNotificationClickHandler --> ${value!.screen}");
        handlingOnClickNotification(value);
      });
    });
  }catch(e){
    log(e.toString());
  }
}

// Handling On Click Notification
void handlingOnClickNotification(NotificationsModel value) {
  log(value.screen);
}

// On Background Notification Click
Future<void> onForegroundNotificationClickHandler() async {
  try{
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        FirebaseMessaging.onMessage.listen(
              (RemoteMessage message) {
            log("Got a message from onForegroundNotificationClickHandler --> ${message.data}");
            NotificationsModel.fromJson(message.data);
          },
        );
      },
    );
  }catch(e){
    log(e.toString());
  }
}

// Foreground
Future<void> foregroundHandler() async {
  try{
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) {
            log("Got a message from foregroundHandler --> ${message.data}");
        NotificationsModel.fromJson(message.data);
        handlingOnRefreshScreens(message);
      },
    );
  }catch(e){
    log(e.toString());
  }
}

void handlingOnRefreshScreens(RemoteMessage message)async {
  try{
    log("handlingOnRefreshScreens ----> ${message.data['Screen']}");
    if (message.data['Screen'] == "/consultChatScreen") {
      final consultationsChatController = Get.find<ConsultationsChatController>();
      consultationsChatController.receiveMessageFromChatAdmin(message.data['DataType'],message.data['Message']);
    }
  }catch(e){
    log(e.toString());
  }
}

//On Notification initialMessage
Future<void> onNotificationInitialMessage() async {
  try{
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      final routeFromMessage = message!.data;
      log("Got a message from onNotificationInitialMessage --> ${routeFromMessage}");
    });
  }catch(e){
    log(e.toString());
  }
}
