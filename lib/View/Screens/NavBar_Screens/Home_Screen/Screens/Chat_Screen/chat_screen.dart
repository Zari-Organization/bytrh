import 'dart:developer';

import 'package:chat_package/chat_package.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../Logic/controllers/Chat_Controllers/chat_controllers.dart';
import '../../../../../../Utils/app_colors.dart';


class ConsultationsChatScreen extends StatelessWidget {
  ConsultationsChatScreen({Key? key}) : super(key: key);

  final consultationsChatController = Get.find<ConsultationsChatController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      log("build list --> ${consultationsChatController.messages.length}");
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          title: const Text("المحادثة مع الطبيب"),
          centerTitle: true,
        ),
        body: ChatScreen(
          messageContainerTextStyle: TextStyle(color: AppColors.RED_COLOR),
          sendMessageHintText: "اكتب رسالتك",
          scrollController: consultationsChatController.scrollController.value,
          messages: consultationsChatController.messages,
          senderColor: AppColors.MAIN_COLOR,
          onSlideToCancelRecord: () {
            log('not sent');
          },
          onTextSubmit: (textMessage) {
            try {
              consultationsChatController.messages.add(textMessage);
              consultationsChatController.scrollController.value.jumpTo(
                consultationsChatController
                    .scrollController.value.position.maxScrollExtent +
                    50,
              );
              consultationsChatController.sendChatMessageText(
                IDConsult: consultationsChatController
                    .consultationsChatDetails.value.idConsult.toString(),
                ConsultChatType: "TEXT",
                ConsultChatMessageText: textMessage.text,
                // context: context,
              );
              log(textMessage.text);
            } catch (e) {
              log(e.toString());
            }
          },
          handleRecord: (audioMessage, canceled) {
            if (!canceled) {
                consultationsChatController.messages.add(audioMessage!);
                consultationsChatController.scrollController.value.jumpTo(
                  consultationsChatController
                      .scrollController.value.position.maxScrollExtent +
                      90,
                );
                log(audioMessage.chatMedia!.url);
                var file = XFile(audioMessage.chatMedia!.url);
                consultationsChatController.sendChatMessageFile(
                  IDConsult: consultationsChatController
                      .consultationsChatDetails.value.idConsult
                      .toString(),
                  ConsultChatType: "AUDIO",
                  ConsultChatMessage: file,
                  context: context,
                );
            }
          },
          handleImageSelect: (imageMessage) async {
            if (imageMessage != null) {
                consultationsChatController.messages.add(
                  imageMessage,
                );
                consultationsChatController.scrollController.value.jumpTo(
                  consultationsChatController
                      .scrollController.value.position.maxScrollExtent +
                      300,
                );
                var file = XFile(imageMessage.chatMedia!.url);
                consultationsChatController.sendChatMessageFile(
                  IDConsult: consultationsChatController
                      .consultationsChatDetails.value.idConsult
                      .toString(),
                  ConsultChatType: "IMAGE",
                  ConsultChatMessage: file,
                  context: context,
                );
            }
          },
        ),
      );
    });
  }
}
