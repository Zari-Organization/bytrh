import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bytrh/Services/Consultations_Services/chat_services.dart';
import 'package:bytrh/Utils/app_colors.dart';
import 'package:chat_package/models/chat_message.dart';
import 'package:chat_package/models/media/chat_media.dart';
import 'package:chat_package/models/media/media_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Models/Consultations_Models/consultations_chat_messages_model.dart'
    as payment_methods_import;
import '../../../Models/Consultations_Models/consultations_chat_messages_model.dart'
    as consultations_chat_messages_import;
import '../Consultations_Controllers/instant_consultations_controller.dart';
import '../Consultations_Controllers/term_consultations_controller.dart';

class ConsultationsChatController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }
  var inChatScreen = false.obs;

  receiveMessageFromChatAdmin(String messageType, String message) {
    if (messageType == "TEXT") {
      messages.add(ChatMessage(
        isSender: false,
        text: message,
      ));
      if(inChatScreen.value){
        scrollController.value.jumpTo(
          scrollController.value.position.maxScrollExtent + 50,
        );
      }
    }
    if (messageType == "IMAGE") {
      messages.add(ChatMessage(
        isSender: false,
        chatMedia: ChatMedia(
          url: message,
          mediaType: const MediaType.imageMediaType(),
        ),
      ));
      if(inChatScreen.value){
        scrollController.value.jumpTo(
          scrollController.value.position.maxScrollExtent + 300,
        );
      }
    }
    if (messageType == "AUDIO") {
      messages.add(ChatMessage(
        isSender: false,
        chatMedia: ChatMedia(
          url: message,
          mediaType: const MediaType.audioMediaType(),
        ),
      ));
      if(inChatScreen.value){
        scrollController.value.jumpTo(
          scrollController.value.position.maxScrollExtent + 90,
        );
      }
    }
    log("Chat Messages List ----> ${messages.toString()}");
  }

  var scrollController = ScrollController().obs;
  var messages = <ChatMessage>[].obs;

  var isLoadingConsultationsChatDetail = false.obs;
  var consultationsChatDetails = consultations_chat_messages_import.Response().obs;
  var consultationsChatDetailsList = <consultations_chat_messages_import.ChatDetail>[].obs;

  var consultStatus = ''.obs;
  var consultId = ''.obs;

  getConsultationsChatDetails(String idConsult) async {
    try {
      askPermission();
      consultId.value = idConsult;
      isLoadingConsultationsChatDetail(true);
      var response = await ChatServices.getConsultationsChatDetails(
        idConsult: idConsult,
      );
      if (response.success) {
        consultationsChatDetails.value = response.response;
        consultationsChatDetailsList.value = response.response.chatDetails!;
        messages.clear();
        await addApiMessagesToChatUi();
      }
    } finally {
      isLoadingConsultationsChatDetail(false);
    }
  }

  addApiMessagesToChatUi() {
    for (int i = 0; i < consultationsChatDetailsList.length; i++) {
      if (consultationsChatDetailsList[i].consultChatType == "TEXT") {
        messages.add(ChatMessage(
          isSender:
              consultationsChatDetailsList[i].consultChatSender == "DOCTOR"
                  ? false
                  : true,
          text: consultationsChatDetailsList[i].consultChatMessage,
        ));
      } else if (consultationsChatDetailsList[i].consultChatType == "IMAGE") {
        messages.add(ChatMessage(
          isSender:
              consultationsChatDetailsList[i].consultChatSender == "DOCTOR"
                  ? false
                  : true,
          chatMedia: ChatMedia(
            url: consultationsChatDetailsList[i].consultChatMessage,
            mediaType: const MediaType.imageMediaType(),
          ),
        ));
      } else if (consultationsChatDetailsList[i].consultChatType == "AUDIO") {
        messages.add(ChatMessage(
          isSender:
              consultationsChatDetailsList[i].consultChatSender == "DOCTOR"
                  ? false
                  : true,
          chatMedia: ChatMedia(
            url: consultationsChatDetailsList[i].consultChatMessage,
            mediaType: const MediaType.audioMediaType(),
          ),
        ));
      }
    }
  }

  var isLoadingSendChatMessage = false.obs;

  sendChatMessageText({
    required String IDConsult,
    required String ConsultChatType,
    required String ConsultChatMessageText,
    // required BuildContext context,
  }) async {
    try {
      isLoadingSendChatMessage(true);
      var response = await ChatServices.sendChatMessageText(
        IDConsult: IDConsult,
        ConsultChatType: ConsultChatType,
        ConsultChatMessageText: ConsultChatMessageText,
        // context: context,
      );
      log(response["Success"].toString());
      if (response["Success"]) {
        log(response["Success"].toString());
      } else {
        log(response["Success"].toString());
      }
    } finally {
      isLoadingSendChatMessage(false);
    }
  }

  sendChatMessageFile({
    required String IDConsult,
    required String ConsultChatType,
    XFile? ConsultChatMessage,
    required BuildContext context,
  }) async {
    try {
      isLoadingSendChatMessage(true);
      var response = await ChatServices.sendChatMessageFile(
        IDConsult: IDConsult,
        ConsultChatType: ConsultChatType,
        ConsultChatMessage: ConsultChatMessage,
        context: context,
      );
      log(response["Success"].toString());
      if (response["Success"]) {
        log(response["Success"].toString());
      } else {
        log(response["Success"].toString());
      }
    } finally {
      isLoadingSendChatMessage(false);
    }
  }

  var isLoadingEndConsultChat = false.obs;

  final instantConsultationsController =
      Get.find<InstantConsultationsController>();
  final termConsultationsController = Get.find<TermConsultationsController>();

  endConsultChat(String id, BuildContext context) async {
    try {
      isLoadingEndConsultChat(true);
      var response = await ChatServices.endConsultChat(
        id,
      );
      if (response["Success"]) {
        void _goNext() async {
          await instantConsultationsController.getConsultationsCart();
          await termConsultationsController.getConsultationsCart();
          Get.back();
        }

        Timer(const Duration(seconds: 1), _goNext);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text("تم انهاء المحادثة"),
          ),
        );
        Timer(const Duration(seconds: 1), () => Get.back());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
      }
    } finally {
      isLoadingEndConsultChat(false);
    }
  }

  var isLoadingSendComplaint = false.obs;
  var chatComplaintController = TextEditingController().obs;

  sendComplaintConsultChat(
      String idConsult, String complainBody, BuildContext context) async {
    try {
      isLoadingSendComplaint(true);
      var response = await ChatServices.sendComplaintConsultChat(
        idConsult,
        complainBody,
      );
      if (response["Success"]) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: AppColors.MAIN_COLOR,
            content: Text(
              "تم إرسال شكوتك",
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
      }
    } finally {
      isLoadingSendComplaint(false);
    }
  }
  Future<bool> askPermission() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status.isDenied == true) {
      askPermission();
      return false;
    } else {
      return true;
    }
  }
}
