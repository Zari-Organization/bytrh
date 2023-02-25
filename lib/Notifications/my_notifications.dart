import 'dart:developer';

import 'package:bytrh/Notifications/notification_model.dart';
import 'package:chat_package/models/chat_message.dart';
import 'package:chat_package/models/media/chat_media.dart';
import 'package:chat_package/models/media/media_type.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../Logic/controllers/Chat_Controllers/chat_controllers.dart';
import '../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../Routes/routes.dart';
import '../Utils/app_alerts.dart';
import 'local_notifications.dart';

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
void handlingOnClickNotification(NotificationsModel value) async{
  if (value.screen == "/consultChatScreen" ) {
    final consultationsChatController = Get.find<ConsultationsChatController>();
    await consultationsChatController.getConsultationsChatDetails(value.idData.toString());
    Get.toNamed(Routes.consultationsChatScreenScreen);
  }
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
        // NotificationsModel.fromJson(message.data);
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
      NotificationService().showLocalNotification(title: "Bytrh",body: message.data['Message'].toString(),payload: "");
    }
    if (message.data['Screen'] == "/urgentactivechatScreen") {
      Get.put(InstantConsultationsController());
      final instantConsultationsController = Get.find<InstantConsultationsController>();
      final consultationsChatController = Get.find<ConsultationsChatController>();
      await instantConsultationsController.getConsultationsCart();
      onClickNotification(String? payload) async{
          await consultationsChatController
              .getConsultationsChatDetails(
            message.data['IDData'],
          );
      }
      await NotificationService().listenNotifications(onClickNotification: onClickNotification);
      NotificationService().showLocalNotification(title: "Bytrh",body: message.data['Message'].toString());
      // await consultationsChatController.getConsultationsChatDetails(message.data['IDData'].toString());
      // Get.toNamed(Routes.consultationsChatScreenScreen);
    }
    if (message.data['Screen'] == "/activechatScreen") {
      Get.put(TermConsultationsController());
      final termConsultationsController = Get.find<TermConsultationsController>();
      await termConsultationsController.getConsultationsCart();
      NotificationService().showLocalNotification(title: "Bytrh", body:message.data['Message'].toString(),);
      // await consultationsChatController.getConsultationsChatDetails(message.data['IDData'].toString());
      // Get.toNamed(Routes.consultationsChatScreenScreen);
    }
    if (message.data['Screen'] == "/urgentScreen") {
      try{
        Get.put(InstantConsultationsController());
        final instantConsultationsController = Get.find<InstantConsultationsController>();
        await instantConsultationsController.getConsultationsCart();
        onClickNotification(String? payload) {
          try {
            Get.toNamed(Routes.instantsConsultationsCartScreen);
          } catch (e) {
            log(e.toString());
          }
        }
        await NotificationService().listenNotifications(onClickNotification: onClickNotification);
        NotificationService().showLocalNotification(title: "Bytrh",body: message.data['Message'].toString());
      }catch(e){
        log(e.toString());
      }
      // await consultationsChatController.getConsultationsChatDetails(message.data['IDData'].toString());
      // Get.toNamed(Routes.consultationsChatScreenScreen);
    }
    if (message.data['Screen'] == "/urgenttimeScreen") {
      try{
        Get.put(InstantConsultationsController());
        final instantConsultationsController = Get.find<InstantConsultationsController>();
        await instantConsultationsController.getConsultationsCart();
        onClickNotification(String? payload) {
          try {
            instantConsultationsController.setConsultationsDoctorReservationTime(message.data['IDData']);
          } catch (e) {
            log(e.toString());
          }
        }
        await NotificationService().listenNotifications(onClickNotification: onClickNotification);
        NotificationService().showLocalNotification(title: "Bytrh", body:message.data['Message'].toString(),);
      }catch(e){
        log(e.toString());
      }
      // await consultationsChatController.getConsultationsChatDetails(message.data['IDData'].toString());
      // Get.toNamed(Routes.consultationsChatScreenScreen);
    }
    if (message.data['Screen'] == "/normaltimeScreen") {
      Get.put(TermConsultationsController());
      final termConsultationsController = Get.find<TermConsultationsController>();
      await termConsultationsController.getConsultationsCart();
      NotificationService().showLocalNotification(title:"Bytrh",body: message.data['Message'].toString());
      // await consultationsChatController.getConsultationsChatDetails(message.data['IDData'].toString());
      // Get.toNamed(Routes.consultationsChatScreenScreen);
    }
    if (message.data['Screen'] == "/normalconsultScreen") {
      Get.put(TermConsultationsController());
      final termConsultationsController = Get.find<TermConsultationsController>();
      await termConsultationsController.getConsultationsCart();
      NotificationService().showLocalNotification(title:  "Bytrh",body: message.data['Message'].toString(),);
      // await consultationsChatController.getConsultationsChatDetails(message.data['IDData'].toString());
      // Get.toNamed(Routes.consultationsChatScreenScreen);
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
