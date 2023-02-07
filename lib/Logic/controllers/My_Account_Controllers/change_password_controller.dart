import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Routes/routes.dart';
import '../../../Services/change_password_services.dart';
import '../../../Utils/app_colors.dart';

class ChangePasswordController extends GetxController {
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
  }

  changePassword(String OldPassword, String NewPassword,
      String PasswordConfirmation, BuildContext context) async {
    try {
      isLoading(true);
      var editData = await ChangePasswordServices.changePassword(
        OldPassword,
        NewPassword,
        PasswordConfirmation,
      );
      if (editData["Success"]) {
        // if (kDebugMode) {
        //   print(
        //     editData["Success"].toString(),
        //   );
        // }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: AppColors.MAIN_COLOR,
            content: Text(
              "Password_changed".tr,
            ),
          ),
        );
        GetStorage authBox = GetStorage();
        authBox.remove('AccessToken');
        void _goNext() => Get.offAllNamed(Routes.loginScreen);
        Timer(const Duration(seconds: 2), _goNext);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(editData["ApiMsg"].toString(),),
          ),
        );
      }
    } finally {
      isLoading(false);
    }
  }
}
