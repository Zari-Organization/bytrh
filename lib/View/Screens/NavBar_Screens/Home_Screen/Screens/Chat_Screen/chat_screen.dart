import 'dart:developer';

import 'package:bytrh/Utils/app_alerts.dart';
import 'package:bytrh/Utils/app_constants.dart';
import 'package:chat_package/chat_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../Logic/controllers/Chat_Controllers/chat_controllers.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../../Utils/app_icons.dart';

class ConsultationsChatScreen extends StatefulWidget {
  const ConsultationsChatScreen({Key? key}) : super(key: key);

  @override
  State<ConsultationsChatScreen> createState() => _ConsultationsChatScreenState();
}

class _ConsultationsChatScreenState extends State<ConsultationsChatScreen> {
  final consultationsChatController = Get.find<ConsultationsChatController>();

  @override
  void initState() {
    super.initState();
    consultationsChatController.inChatScreen.value=true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      log("build list --> ${consultationsChatController.messages.length}");
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          title: Text(
              "المحادثة مع ${consultationsChatController.consultationsChatDetails.value.doctorName}"),
          centerTitle: true,
          actions: [
            consultationsChatController.consultStatus.value == "ENDED"
                ? SizedBox()
                : PopupMenuButton(
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
                          consultationsChatController.endConsultChat(
                              consultationsChatController
                                  .consultId.value,
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
                  PopupMenuItem(
                    value: 3,
                    child: InkWell(
                      onTap: () async {
                        Get.back();
                        AppAlerts().chatComplaintPop(
                            consultationsChatController
                                .consultationsChatDetails
                                .value
                                .idConsult
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
        body: WillPopScope(
          onWillPop: () => onWillPop()!,
          child: SingleChildScrollView(
            child: Column(
              children: [
                consultationsChatController.consultStatus.value == "ENDED"
                    ? SizedBox(
                  height: 80,
                )
                    : Column(
                  children: [
                    Text(getCountDownTitle(
                        consultationsChatController.consultStatus.value)),
                    SizedBox(height: 10),
                    TimerCountdown(
                      format: CountDownTimerFormat.daysHoursMinutes,
                      daysDescription: "يوم",
                      hoursDescription: "ساعة",
                      minutesDescription: "دقيقة",
                      endTime: DateTime.now().add(
                        Duration(
                          days: consultationsChatController
                              .consultationsChatDetails
                              .value
                              .consultCountDown!
                              .days,
                          hours: consultationsChatController
                              .consultationsChatDetails
                              .value
                              .consultCountDown!
                              .hours,
                          minutes: consultationsChatController
                              .consultationsChatDetails
                              .value
                              .consultCountDown!
                              .minutes,
                        ),
                      ),
                      onEnd: () {
                        print("Timer finished");
                      },
                    ),
                  ],
                ),
                SizedBox(
                    height: AppConstants.mediaHeight(context) / 1.3,
                    child: ChatScreen(
                      disableInput:
                      consultationsChatController.consultStatus.value ==
                          "ENDED"
                          ? true
                          : false,
                      messageContainerTextStyle:
                      TextStyle(color: AppColors.RED_COLOR),
                      sendMessageHintText: "اكتب رسالتك",
                      scrollController:
                      consultationsChatController.scrollController.value,
                      messages: consultationsChatController.messages,
                      senderColor: AppColors.MAIN_COLOR,
                      onSlideToCancelRecord: () {
                        log('not sent');
                      },
                      onTextSubmit: (textMessage) {
                        try {
                          consultationsChatController.messages.add(textMessage);
                          consultationsChatController.scrollController.value
                              .jumpTo(
                            consultationsChatController.scrollController.value
                                .position.maxScrollExtent +
                                50,
                          );
                          consultationsChatController.sendChatMessageText(
                            IDConsult: consultationsChatController
                                .consultationsChatDetails.value.idConsult
                                .toString(),
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
                          consultationsChatController.scrollController.value
                              .jumpTo(
                            consultationsChatController.scrollController.value
                                .position.maxScrollExtent +
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
                          consultationsChatController.scrollController.value
                              .jumpTo(
                            consultationsChatController.scrollController.value
                                .position.maxScrollExtent +
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
                    ))
              ],
            ),
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
  Future<bool>? onWillPop() async {
    consultationsChatController.inChatScreen.value=false;
    return true;
  }
}
