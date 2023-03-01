import 'dart:developer';

import 'package:bytrh/Utils/app_alerts.dart';
import 'package:bytrh/Utils/app_constants.dart';
import 'package:chat_package/chat_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../../Utils/app_colors.dart';
import '../../../../../../../Utils/app_icons.dart';


class AdoptionChatScreen extends StatelessWidget {
  AdoptionChatScreen({Key? key}) : super(key: key);

  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      log("build list --> ${adoptionController.adoptionMessages.length}");
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          title: Text(
              "المحادثة مع ${adoptionController.adoptionChatDetails.value.clientName}"),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                    onSelected: (value) async {},
                    elevation: 20,
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 3,
                            child: InkWell(
                                onTap: () {
                                  // consultationsChatController.endConsultChat(
                                  //     consultationsChatController
                                  //         .consultId.value,
                                  //     context);
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.end_chat_icon,
                                      color: AppColors.BLACK_COLOR,
                                      height: 30,
                                    ),
                                    SizedBox(width: 5),
                                    Text("انهاء المحادثة"),
                                  ],
                                )),
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: InkWell(
                              onTap: () async {
                                Get.back();
                                AppAlerts().chatComplaintPop(
                                    adoptionController
                                        .adoptionChatDetails
                                        .value
                                        .idAdoptionChat
                                        .toString(),
                                    context);
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.Info_icon,
                                    color: AppColors.BLACK_COLOR,
                                    height: 30,
                                  ),
                                  SizedBox(width: 5),
                                  Text("ارسال شكوي"),
                                ],
                              ),
                            ),
                          ),
                        ]),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: AppConstants.mediaHeight(context) / 1.15,
                  child: ChatScreen(
                    messageContainerTextStyle:
                        TextStyle(color: AppColors.RED_COLOR),
                    sendMessageHintText: "اكتب رسالتك",
                    scrollController:
                    adoptionController.scrollController.value,
                    messages: adoptionController.adoptionMessages,
                    senderColor: AppColors.MAIN_COLOR,
                    onSlideToCancelRecord: () {
                      log('not sent');
                    },
                    onTextSubmit: (textMessage) {
                      try {
                        adoptionController.adoptionMessages.add(textMessage);
                        adoptionController.scrollController.value
                            .jumpTo(
                          adoptionController.scrollController.value
                                  .position.maxScrollExtent +
                              50,
                        );
                        adoptionController.sendChatMessageText(
                          ClientType: "ADOPTER",
                          IDAdoptionChat: adoptionController.adoptionChatDetails.value.idAdoptionChat.toString(),
                          AdoptionChatType: "TEXT",
                          AdoptionChatMessage: textMessage.text,
                          // context: context,
                        );
                        log(textMessage.text);
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    handleRecord: (audioMessage, canceled) {
                      if (!canceled) {
                        adoptionController.adoptionMessages.add(audioMessage!);
                        adoptionController.scrollController.value
                            .jumpTo(
                          adoptionController.scrollController.value
                                  .position.maxScrollExtent +
                              90,
                        );
                        log(audioMessage.chatMedia!.url);
                        var file = XFile(audioMessage.chatMedia!.url);
                        adoptionController.sendChatMessageFile(
                          ClientType: "ADOPTER",
                          IDAdoptionChat: adoptionController.adoptionChatDetails.value.idAdoptionChat.toString(),
                          AdoptionChatType: "AUDIO",
                          AdoptionChatMessage: file,
                          context: context,
                          // context: context,
                        );
                      }
                    },
                    handleImageSelect: (imageMessage) async {
                      if (imageMessage != null) {
                        adoptionController.adoptionMessages.add(
                          imageMessage,
                        );
                        adoptionController.scrollController.value
                            .jumpTo(
                          adoptionController.scrollController.value
                                  .position.maxScrollExtent +
                              300,
                        );
                        var file = XFile(imageMessage.chatMedia!.url);
                        adoptionController.sendChatMessageFile(
                          ClientType: "ADOPTER",
                          IDAdoptionChat: adoptionController.adoptionChatDetails.value.idAdoptionChat.toString(),
                          AdoptionChatType: "IMAGE",
                          AdoptionChatMessage: file,
                          context: context,
                          // context: context,
                        );
                      }
                    },
                  ))
            ],
          ),
        ),
      );
    });
  }

  String getCountDownTitle(status) {
    switch (status) {
      case "ACCEPTED":
        return "ستبدأ المحادثة بعد";
      case "ONGOING":
        return "ستنتهي المحادثة بعد";
      default:
        return "";
    }
  }
}
