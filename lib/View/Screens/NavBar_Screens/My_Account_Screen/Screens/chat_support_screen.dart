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
import '../../../../../Logic/controllers/My_Account_Controllers/my_account_controller.dart';

class ChatSupportScreen extends StatelessWidget {
  ChatSupportScreen({Key? key}) : super(key: key);

  final myAccountController = Get.find<MyAccountController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      log("build list --> ${myAccountController.chatSupportMessages.length}");
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          title:myAccountController.chatSupportDetails.value
              .userName==null?Text("في انتظار الدعم .."): Text(
              "المحادثة مع ${myAccountController.chatSupportDetails.value.userName}"),
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
                              myAccountController.endChatSupport(
                                  myAccountController.chatSupportDetails.value
                                      .idClientChatSupport
                                      .toString(),
                                  context);
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
                    ]),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              myAccountController.chatSupportDetails.value
                  .userName==null? Padding(padding: EdgeInsets.only(top: 10),child: Center(
                child: Text("اكتب رسالتك وسيتم الرد عليك من الدعم .."),
              ),):SizedBox(),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: AppConstants.mediaHeight(context) / 1.2,
                  child: ChatScreen(
                    messageContainerTextStyle:
                        TextStyle(color: AppColors.RED_COLOR),
                    sendMessageHintText: "اكتب رسالتك",
                    scrollController:
                        myAccountController.chatSupportScrollController.value,
                    messages: myAccountController.chatSupportMessages,
                    senderColor: AppColors.MAIN_COLOR,
                    onSlideToCancelRecord: () {
                      log('not sent');
                    },
                    onTextSubmit: (textMessage) {
                      try {
                        myAccountController.chatSupportMessages
                            .add(textMessage);
                        myAccountController.chatSupportScrollController.value
                            .jumpTo(
                          myAccountController.chatSupportScrollController.value
                                  .position.maxScrollExtent +
                              50,
                        );
                        myAccountController.sendChatMessageText(
                          IDClientChatSupport: myAccountController
                              .chatSupportDetails.value.idClientChatSupport
                              .toString(),
                          ChatSupportType: "TEXT",
                          ChatSupportMessage: textMessage.text,
                          // context: context,
                        );
                        log(textMessage.text);
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    handleRecord: (audioMessage, canceled) {
                      if (!canceled) {
                        myAccountController.chatSupportMessages
                            .add(audioMessage!);
                        myAccountController.chatSupportScrollController.value
                            .jumpTo(
                          myAccountController.chatSupportScrollController.value
                                  .position.maxScrollExtent +
                              90,
                        );
                        log(audioMessage.chatMedia!.url);
                        var file = XFile(audioMessage.chatMedia!.url);
                        myAccountController.sendChatMessageFile(
                          IDClientChatSupport: myAccountController
                              .chatSupportDetails.value.idClientChatSupport
                              .toString(),
                          ChatSupportType: "AUDIO",
                          ChatSupportMessage: file,
                          context: context,
                          // context: context,
                        );
                      }
                    },
                    handleImageSelect: (imageMessage) async {
                      if (imageMessage != null) {
                        myAccountController.chatSupportMessages.add(
                          imageMessage,
                        );
                        myAccountController.chatSupportScrollController.value
                            .jumpTo(
                          myAccountController.chatSupportScrollController.value
                                  .position.maxScrollExtent +
                              300,
                        );
                        var file = XFile(imageMessage.chatMedia!.url);
                        myAccountController.sendChatMessageFile(
                          IDClientChatSupport: myAccountController
                              .chatSupportDetails.value.idClientChatSupport
                              .toString(),
                          ChatSupportType: "IMAGE",
                          ChatSupportMessage: file,
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
