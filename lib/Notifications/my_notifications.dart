import 'dart:developer';

import 'package:bytrh/Notifications/notification_model.dart';
import 'package:chat_package/models/chat_message.dart';
import 'package:chat_package/models/media/chat_media.dart';
import 'package:chat_package/models/media/media_type.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
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
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    backgroundHandler(message).then((value) {
      print("On Click id data --> ${value!.idData}");
      print("On Click Notification Type --> ${value.notificationType}");
      print("On Click Notification Screen --> ${value.screen}");
      handlingOnClickNotification(value);
    });
  });
}

// Handling On Click Notification
void handlingOnClickNotification(NotificationsModel value) async{
  if (value.screen == "/consultChatScreen" ) {
try{
  Get.put(ConsultationsChatController());
  final consultationsChatController = Get.find<ConsultationsChatController>();
  await consultationsChatController
      .getConsultationsChatDetails(
    value.idData,
  );
  Get.toNamed(Routes.consultationsChatScreenScreen);
}catch(e){
  log(e.toString());
}
  }
  if (value.screen == "/urgentScreen" ) {
    Get.put(InstantConsultationsController());
    final instantConsultationsController = Get.find<InstantConsultationsController>();
    await instantConsultationsController.getConsultationsCart();
    Get.toNamed(Routes.instantsConsultationsCartScreen);
  }
  if (value.screen == "/urgenttimeScreen" ) {
    Get.put(InstantConsultationsController());
    final instantConsultationsController = Get.find<InstantConsultationsController>();
    await instantConsultationsController.getConsultationsCart();
    instantConsultationsController.setConsultationsDoctorReservationTime(value.idData);
  }
  if (value.screen == "/urgentactivechatScreen" ) {
    Get.put(InstantConsultationsController());
    Get.put(ConsultationsChatController());
    final instantConsultationsController = Get.find<InstantConsultationsController>();
    final consultationsChatController = Get.find<ConsultationsChatController>();
    await instantConsultationsController.getConsultationsCart();
    consultationsChatController.consultStatus.value ="ONGOING";
    await consultationsChatController
        .getConsultationsChatDetails(
      value.idData,
    );
    Get.toNamed(Routes.consultationsChatScreenScreen);
  }
  if (value.screen == "/normalconsultScreen" ) {
    Get.put(TermConsultationsController());
    final termConsultationsController = Get.find<TermConsultationsController>();
    await termConsultationsController.getConsultationsCart();
    Get.toNamed(Routes.termConsultationsCartScreen);
  }
  if (value.screen == "/normaltimeScreen" ) {
    Get.put(TermConsultationsController());
    final termConsultationsController = Get.find<TermConsultationsController>();
    await termConsultationsController.getConsultationsCart();
    termConsultationsController.setDataDoctorProfile(value.idData,"CONSULT");
  }
  if (value.screen == "/activechatScreen" ) {
    Get.put(TermConsultationsController());
    Get.put(ConsultationsChatController());
    final termConsultationsController = Get.find<TermConsultationsController>();
    final consultationsChatController = Get.find<ConsultationsChatController>();
    await termConsultationsController.getConsultationsCart();
    consultationsChatController.consultStatus.value ="ONGOING";
    await consultationsChatController
        .getConsultationsChatDetails(
     value.idData,
    );
    Get.toNamed(Routes.consultationsChatScreenScreen);
  }
  if (value.screen == "/adoptionStatusScreen" ) {
    Get.put(AdoptionController());
    final adoptionController = Get.find<AdoptionController>();
    await adoptionController.getMyAdoptionsList();
    adoptionController.setDataToAdoptionMyAnimalsDetails(value.idData);
  }
}

// On Background Notification Click
Future<void> onForegroundNotificationClickHandler() async {
  try{
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {FirebaseMessaging.onMessage.listen(
              (RemoteMessage message) {
            log("Got a message from onForegroundNotificationClickHandler --> ${message.data}");
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
        log(message.data['IDData']);
        onClickNotification(String? payload) {
          try {
            log(message.data['IDData']);
            instantConsultationsController.setConsultationsDoctorReservationTime(message.data['IDData']);
          } catch (e) {
            log(e.toString());
          }
        }
        await NotificationService().listenNotifications(onClickNotification: onClickNotification);
        NotificationService().showLocalNotification(title: "Bytrh", body:message.data['Message'].toString(),payload: "/urgenttimeScreen");
      }catch(e){
        log(e.toString());
      }
    }
    if (message.data['Screen'] == "/urgentactivechatScreen") {
      Get.put(InstantConsultationsController());
      final instantConsultationsController = Get.find<InstantConsultationsController>();
      final consultationsChatController = Get.find<ConsultationsChatController>();
      await instantConsultationsController.getConsultationsCart();
      consultationsChatController.consultStatus.value ="ONGOING";
      onClickNotification(String? payload) async{
          await consultationsChatController
              .getConsultationsChatDetails(
            message.data['IDData'],
          );
          Get.toNamed(Routes.consultationsChatScreenScreen);
      }
      await NotificationService().listenNotifications(onClickNotification: onClickNotification);
      NotificationService().showLocalNotification(title: "Bytrh",body: message.data['Message'].toString(),payload: "/urgentconsultationsChatScreenScreen");
      // Get.toNamed(Routes.consultationsChatScreenScreen);
    }
    if (message.data['Screen'] == "/activechatScreen") {
      Get.put(TermConsultationsController());
      final termConsultationsController = Get.find<TermConsultationsController>();
      final consultationsChatController = Get.find<ConsultationsChatController>();
      await termConsultationsController.getConsultationsCart();
      consultationsChatController.consultStatus.value ="ONGOING";
      onClickNotification(String? payload) async{
        await consultationsChatController
            .getConsultationsChatDetails(
          message.data['IDData'],
        );
        Get.toNamed(payload!);
      }
      await NotificationService().listenNotifications(onClickNotification: onClickNotification);
      NotificationService().showLocalNotification(title: "Bytrh", body:message.data['Message'].toString(),payload: "/consultationsChatScreenScreen");
      // await consultationsChatController.getConsultationsChatDetails(message.data['IDData'].toString());
      // Get.toNamed(Routes.consultationsChatScreenScreen);
    }
    if (message.data['Screen'] == "/normaltimeScreen") {
      Get.put(TermConsultationsController());
      final termConsultationsController = Get.find<TermConsultationsController>();
      await termConsultationsController.getConsultationsCart();
      onClickNotification(String? payload) {
        try {
          termConsultationsController.setDataDoctorProfile(message.data['IDData'],"CONSULT");
        } catch (e) {
          log(e.toString());
        }
      }
      await NotificationService().listenNotifications(onClickNotification: onClickNotification);
      NotificationService().showLocalNotification(title:"Bytrh",body: message.data['Message'].toString(),payload: "normaltimeScreen");
      // await consultationsChatController.getConsultationsChatDetails(message.data['IDData'].toString());
      // Get.toNamed(Routes.consultationsChatScreenScreen);
    }
    if (message.data['Screen'] == "/normalconsultScreen") {
      Get.put(TermConsultationsController());
      final termConsultationsController = Get.find<TermConsultationsController>();
      await termConsultationsController.getConsultationsCart();
      onClickNotification(String? payload) {
        try {
          Get.toNamed(payload!);
        } catch (e) {
          log(e.toString());
        }
      }
      await NotificationService().listenNotifications(onClickNotification: onClickNotification);
      NotificationService().showLocalNotification(title:  "Bytrh",body: message.data['Message'].toString(),payload: "/termConsultationsCartScreen");
      // await consultationsChatController.getConsultationsChatDetails(message.data['IDData'].toString());
      // Get.toNamed(Routes.consultationsChatScreenScreen);
    }
    if (message.data['Screen'] == "/adoptionStatusScreen" ) {
      Get.put(AdoptionController());
      final adoptionController = Get.find<AdoptionController>();
      await adoptionController.getMyAdoptionsList();
      onClickNotification(String? payload) {
        try {
          adoptionController.setDataToAdoptionMyAnimalsDetails(message.data['idData']);
        } catch (e) {
          log(e.toString());
        }
      }
      await NotificationService().listenNotifications(onClickNotification: onClickNotification);
      NotificationService().showLocalNotification(title:  "Bytrh",body: message.data['Message'].toString(),payload: "/adoptionStatusScreen");
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
