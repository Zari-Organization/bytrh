import 'dart:developer';
import 'dart:io';

import 'package:bytrh/Services/Consultations_Services/chat_services.dart';
import 'package:chat_package/models/chat_message.dart';
import 'package:chat_package/models/media/chat_media.dart';
import 'package:chat_package/models/media/media_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Models/Consultations_Models/consultations_chat_messages_model.dart'
    as payment_methods_import;
import '../../../Models/Consultations_Models/consultations_chat_messages_model.dart'
    as consultations_chat_messages_import;

class ConsultationsChatController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  receiveMessageFromChatAdmin(String messageType,String message) {
    if (messageType == "TEXT") {
      messages.add(ChatMessage(
        isSender: false,
        text: message,
      ));
      scrollController.value.jumpTo(
        scrollController.value.position.maxScrollExtent +
            50,
      );
    }
    if (messageType == "IMAGE") {
      messages.add(ChatMessage(
        isSender: false,
        chatMedia: ChatMedia(
          url: message,
          mediaType: const MediaType.imageMediaType(),
        ),
      ));
      scrollController.value.jumpTo(
        scrollController.value.position.maxScrollExtent +
            300,
      );
    }
    if (messageType == "AUDIO") {
      messages.add(ChatMessage(
        isSender: false,
        chatMedia: ChatMedia(
          url: message,
          mediaType: const MediaType.audioMediaType(),
        ),
      ));
      scrollController.value.jumpTo(
        scrollController.value.position.maxScrollExtent +
            90,
      );
    }
    log("Chat Messages List ----> ${messages.toString()}");
  }

  var scrollController = ScrollController().obs;
  var messages = <ChatMessage>[].obs;

  var isLoadingConsultationsChatDetail = false.obs;
  var consultationsChatDetails =
      consultations_chat_messages_import.Response().obs;
  var consultationsChatDetailsList =
      <consultations_chat_messages_import.ChatDetail>[].obs;

  getConsultationsChatDetails(String idConsult) async {
    try {
      isLoadingConsultationsChatDetail(true);
      var response = await ChatServices.getConsultationsChatDetails(
        idConsult: idConsult,
      );
      if (response.success) {
        consultationsChatDetails.value = response.response;
        consultationsChatDetailsList.value = response.response.chatDetails!;
        messages.clear();
        await addApiMessagesToChatUi();
        Get.back();
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
}
