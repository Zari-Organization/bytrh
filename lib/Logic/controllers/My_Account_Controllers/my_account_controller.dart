import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Models/about_us_model.dart'as about_us_import;
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
        void _goNext() => Get.offAllNamed(Routes.loginScreen);
        Timer(const Duration(seconds: 1), _goNext);
      } else {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(data["ApiMsg"].toString(),),
          ),
        );
        GetStorage authBox = GetStorage();
        authBox.remove('AccessToken');
        final _googleSignIn = GoogleSignIn();
        _googleSignIn.disconnect();
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

  Future<void> openMap(double? latitude, double? longitude,context) async {
    if(latitude==null||longitude==null){
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
    }else{
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await launch(googleUrl)) {
        await canLaunch(googleUrl);
      }  else {
        throw 'Could not open the map.';
      }
    }
  }

  void openEmail(String path) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: path,
    );
    String  url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print( 'Could not launch $url');
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
      }else{
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
  void launchWhatsApp(
      {required String phone,
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
}
