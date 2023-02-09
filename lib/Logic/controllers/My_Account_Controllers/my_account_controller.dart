import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        // GetStorage authBox = GetStorage();
        // authBox.remove('AccessToken');
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
}
