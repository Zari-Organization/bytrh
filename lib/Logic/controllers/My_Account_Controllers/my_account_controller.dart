import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:chat_package/models/chat_message.dart';
import 'package:chat_package/models/media/chat_media.dart';
import 'package:chat_package/models/media/media_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Models/AboutUs_Models/about_us_model.dart' as about_us_import;
import '../../../Models/AboutUs_Models/chat_support_model.dart'as chat_support_import;
import '../../../Routes/routes.dart';
import '../../../Services/My_Account_Services/change_password_services.dart';
import '../../../Services/My_Account_Services/my_account_services.dart';
import '../../../Utils/app_colors.dart';

class MyAccountController extends GetxController {
  RxBool isLoading = false.obs;
  var oldPasswordController = TextEditingController().obs;
  var newPasswordController = TextEditingController().obs;
  var confirmNewPasswordController = TextEditingController().obs;

  RxBool isSecureOldPass = true.obs;
  RxBool isSecureNewPass = true.obs;
  RxBool isSecureConfirmPass = true.obs;

  @override
  void onInit() async {
    super.onInit();
    getAboutUs();
  }

  logout(BuildContext context) async {
    try {
      isLoading(true);
      var data = await MyAccountServices.logout();
      if (data["Success"]) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.MAIN_COLOR,
            content: Text(
              "تم تسجيل الخروج".tr,
            ),
          ),
        );
        GetStorage authBox = GetStorage();
        authBox.remove('AccessToken');
        final _googleSignIn = GoogleSignIn();
         _googleSignIn.disconnect();
         FacebookAuth.instance.logOut();
        void _goNext() => Get.offAllNamed(Routes.loginScreen);
        Timer(const Duration(seconds: 1), _goNext);
      } else {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(
              data["ApiMsg"].toString(),
            ),
          ),
        );
        GetStorage authBox = GetStorage();
        authBox.remove('AccessToken');
        final _googleSignIn = GoogleSignIn();
        _googleSignIn.disconnect();
        FacebookAuth.instance.logOut();
        void _goNext() => Get.offAllNamed(Routes.loginScreen);
        Timer(const Duration(seconds: 1), _goNext);
      }
    } finally {
      isLoading(false);
    }
  }

  var aboutUsData = about_us_import.Response().obs;

  getAboutUs() async {
    try {
      isLoading(true);
      var response = await MyAccountServices.getAboutUs();
      if (response.success) {
        aboutUsData.value = response.response;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> openMap(double? latitude, double? longitude, context) async {
    if (latitude == null || longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.WHITE_COLOR,
          duration: const Duration(seconds: 2),
          content: Text(
            "Location_not_provided".tr,
            style: const TextStyle(color: AppColors.BLACK_COLOR),
          ),
        ),
      );
    } else {
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await launch(googleUrl)) {
        await canLaunch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
  }

  void openEmail(String path) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: path,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  var isLoadingSendContactUs = false.obs;
  var contactUserNameController = TextEditingController().obs;
  var contactEmailController = TextEditingController().obs;
  var contactMssgController = TextEditingController().obs;

  sendToContactUs(
    String UserName,
    String Email,
    String Message,
    BuildContext context,
  ) async {
    try {
      isLoadingSendContactUs(true);
      var response = await MyAccountServices().sentToContactUs(
        UserName,
        Email,
        Message,
      );
      if (response["Success"]) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // backgroundColor: AppColors.GREEN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
        contactUserNameController.value.clear();
        contactEmailController.value.clear();
        contactMssgController.value.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // backgroundColor: AppColors.GREEN_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
      }
    } finally {
      isLoadingSendContactUs(false);
    }
  }

  void launchWhatsApp({
    required String phone,
    required String message,
  }) async {
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  // Chat Support Functions

  var chatSupportScrollController = ScrollController().obs;

  var isLoadingChatSupport = false.obs;
  requestChatSupport(BuildContext context) async {
    try {
      isLoadingChatSupport(true);
      var response = await MyAccountServices.requestChatSupport();
      if (response["Success"]) {
        await getChatSupportDetails(
          response["Response"].toString(),
        );
        Get.toNamed(Routes.chatSupportScreen);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.MAIN_COLOR,
            content: Text(
              response["ApiMsg"].toString(),
            ),
          ),
        );
      }
    } finally {
      isLoadingChatSupport(false);
    }
  }

  var isLoadingChatSupportDetails = false.obs;
  var chatSupportDetails = chat_support_import.Response().obs;
  var chatSupportDetailsList = <chat_support_import.ChatDetail>[].obs;


  getChatSupportDetails(String idChat) async {
    try {
      isLoadingChatSupportDetails(true);
      var response = await MyAccountServices.getChatSupportDetails(idChat: idChat);
      if (response.success) {
        chatSupportDetails.value = response.response;
        chatSupportDetailsList.value = response.response.chatDetails!;
        chatSupportMessages.clear();
        await addApiMessagesToChatUi();
      }
    } finally {
      isLoadingChatSupportDetails(false);
    }
  }
  addApiMessagesToChatUi() {
    for (int i = 0; i < chatSupportDetailsList.length; i++) {
      if (chatSupportDetailsList[i].chatSupportType == "TEXT") {
        chatSupportMessages.add(ChatMessage(
          isSender: chatSupportDetailsList[i].chatSupportSender == "USER"
              ? false
              : true,
          text: chatSupportDetailsList[i].chatSupportMessage,
        ));
      } else if (chatSupportDetailsList[i].chatSupportType == "IMAGE") {
        chatSupportMessages.add(ChatMessage(
          isSender:
          chatSupportDetailsList[i].chatSupportSender == "USER"
              ? false
              : true,
          chatMedia: ChatMedia(
            url: chatSupportDetailsList[i].chatSupportMessage,
            mediaType: const MediaType.imageMediaType(),
          ),
        ));
      } else if (chatSupportDetailsList[i].chatSupportType == "AUDIO") {
        chatSupportMessages.add(ChatMessage(
          isSender:
          chatSupportDetailsList[i].chatSupportSender == "USER"
              ? false
              : true,
          chatMedia: ChatMedia(
            url: chatSupportDetailsList[i].chatSupportMessage,
            mediaType: const MediaType.audioMediaType(),
          ),
        ));
      }
    }
  }
  var chatSupportMessages = <ChatMessage>[].obs;

  var isLoadingSendAdoptionChatMessage = false.obs;

  sendChatMessageText({
    required String IDClientChatSupport,
    required String ChatSupportType,
    required String ChatSupportMessage,
  }) async {
    try {
      isLoadingSendAdoptionChatMessage(true);
      var response = await MyAccountServices.sendChatSupportMessageText(
        IDClientChatSupport: IDClientChatSupport,
        ChatSupportType: ChatSupportType,
        ChatSupportMessage: ChatSupportMessage,
        // context: context,
      );
      log(response["Success"].toString());
      if (response["Success"]) {
        log(response["Success"].toString());
      } else {
        log(response["Success"].toString());
      }
    } finally {
      isLoadingSendAdoptionChatMessage(false);
    }
  }

  sendChatMessageFile({
    required String IDClientChatSupport,
    required String ChatSupportType,
    XFile? ChatSupportMessage,
    required BuildContext context,
  }) async {
    try {
      isLoadingSendAdoptionChatMessage(true);
      var response = await MyAccountServices.sendChatSupportMessageFile(
        IDClientChatSupport: IDClientChatSupport,
        ChatSupportType: ChatSupportType,
        ChatSupportMessage: ChatSupportMessage,
        context: context,
      );
      log(response["Success"].toString());
      if (response["Success"]) {
        log(response["Success"].toString());
      } else {
        log(response["Success"].toString());
      }
    } finally {
      isLoadingSendAdoptionChatMessage(false);
    }
  }

  chatSupportReceiveMessage(String messageType, String message) {
    if (messageType == "TEXT") {
      chatSupportMessages.add(ChatMessage(
        isSender: false,
        text: message,
      ));
      chatSupportScrollController.value.jumpTo(
        chatSupportScrollController.value.position.maxScrollExtent + 50,
      );
    }
    if (messageType == "IMAGE") {
      chatSupportMessages.add(ChatMessage(
        isSender: false,
        chatMedia: ChatMedia(
          url: message,
          mediaType: const MediaType.imageMediaType(),
        ),
      ));
      chatSupportScrollController.value.jumpTo(
        chatSupportScrollController.value.position.maxScrollExtent + 300,
      );
    }
    if (messageType == "AUDIO") {
      chatSupportMessages.add(ChatMessage(
        isSender: false,
        chatMedia: ChatMedia(
          url: message,
          mediaType: const MediaType.audioMediaType(),
        ),
      ));
      chatSupportScrollController.value.jumpTo(
        chatSupportScrollController.value.position.maxScrollExtent + 90,
      );
    }
    if(chatSupportDetails.value.userName==null){
      getChatSupportDetails(chatSupportDetails.value
          .idClientChatSupport.toString());
    }
    log("Chat Messages List ----> ${chatSupportMessages.toString()}");
  }

  var isLoadingEndChatSupport = false.obs;

  endChatSupport(String id, BuildContext context) async {
    try {
      isLoadingEndChatSupport(true);
      var response = await MyAccountServices.endChatSupport(
        id,
      );
      if (response["Success"]) {

        Timer(const Duration(seconds: 1), () => Get.back());
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
      isLoadingEndChatSupport(false);
    }
  }

}
