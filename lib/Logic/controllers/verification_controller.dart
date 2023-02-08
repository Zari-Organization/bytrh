import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Models/Auth_Models/register_model.dart';
import '../../Routes/routes.dart';
import '../../Services/verification_services.dart';
import '../../Utils/app_colors.dart';
import 'auth_controller.dart';

class VerificationController extends GetxController {
  var verificationCode = "".obs;
  var resendStatus = true.obs;
  var verificationLoading = false.obs;
  var sendCodeLoading = false.obs;
  var isChangePassLoading = false.obs;
  var phoneController = TextEditingController().obs;
  var newPassController = TextEditingController().obs;
  var newPassConfirmController = TextEditingController().obs;
  RxBool isSecurePass = true.obs;
  var verificationResetPassCode = "".obs;

  Timer? timer;
  final start = 60.obs;

  void startTimer() {
    print(resendStatus.value.toString());
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          resendStatus(true);
          start.value = 60;
          timer.cancel();
        } else {
          resendStatus(false);
          start.value--;
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    timer!.cancel();
    super.onInit();
  }

  getVerificationCode(context) async {
    var verificationCode = await VerificationServices.getVerificationCode();
    if (verificationCode["success"]) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(verificationCode["apiMsgEn"].toString()),
        ),
      );
    }
  }

  confirmCode(String code, context) async {
    var codeConfirmation = await VerificationServices().confirmCode(code);
    if (verificationCode.isEmpty || verificationCode.value.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Enter verification Code!"),
        ),
      );
    } else {
      if (codeConfirmation["Success"] == true) {
        GetStorage authBox = GetStorage();
        authBox.write('UserVerified', 1);
        Get.toNamed(Routes.mainScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(codeConfirmation["ApiMsgEn"].toString()),
          ),
        );
      }
    }
  }


  sendCodeToVerifyAccount(String phone, context) async {
    var codeConfirmation = await VerificationServices().sendCodeToResetPassword(phone);
    if (codeConfirmation["Success"] == true) {
      Get.toNamed(Routes.verifyAccountScreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(codeConfirmation["ApiMsg"].toString()),
        ),
      );
    }
  }

  sendCodeToResetPassword(String phone, context) async {
    var codeConfirmation =
        await VerificationServices().sendCodeToResetPassword(phone);
    if (codeConfirmation["Success"] == true) {
      Get.toNamed(Routes.verifyResetPassCodeScreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(codeConfirmation["ApiMsg"].toString()),
        ),
      );
    }
  }



  confirmCodeToResetPass(String userPhone, String code, context) async {
    var codeConfirmation =
        await VerificationServices().confirmCodeToResetPass(userPhone, code);
    if (verificationResetPassCode.isEmpty ||
        verificationResetPassCode.value.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Enter verification Code!"),
        ),
      );
    } else {
      if (codeConfirmation["Success"] == true) {
        Get.toNamed(Routes.newPassScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(codeConfirmation["ApiMsg"].toString()),
          ),
        );
      }
    }
  }

  var verifyLogin =true.obs;
  confirmCodeToVerifyAccountAndLogin(String userPhone, String code, context) async {
    if (verificationResetPassCode.isEmpty ||
        verificationResetPassCode.value.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Enter verification Code!"),
        ),
      );
    } else {
      final authController = Get.find<AuthController>();
      var codeConfirmation = await VerificationServices().confirmCodeToResetPass(userPhone, code);
      if (codeConfirmation["Success"] == true) {
        authController.login(
          authController.loginUserNameController.value.text,
          authController.loginPasswordController.value.text,
          "MANUAL",
          "ar",
          "ANDROID",
          "GMS",
          context,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(codeConfirmation["ApiMsg"].toString()),
          ),
        );
      }
    }
  }

  var accessToken = ''.obs;

  confirmCodeToVerifyAccountAndRegister(String userPhone, String code, context) async {
    if (verificationResetPassCode.isEmpty ||
        verificationResetPassCode.value.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Enter verification Code!"),
        ),
      );
    } else {
      var codeConfirmation = await VerificationServices().confirmCodeToResetPass(userPhone, code);
      if (codeConfirmation["Success"] == true) {
        final authBox = GetStorage();
        authBox.write('AccessToken', accessToken.value);
        log(" Verify Controller -->${accessToken.value}");
        GetStorage().read<String>('AccessToken')!;
        Get.offAllNamed(Routes.mainScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(codeConfirmation["ApiMsg"].toString()),
          ),
        );
      }
    }
  }

  changePassword(
      String UserPhone, String UserPassword, PasswordConfirmation, BuildContext context) async {
    var editData =
        await VerificationServices().changePassword(UserPhone, UserPassword,PasswordConfirmation);

    if (editData["Success"]) {
      if (kDebugMode) {
        print(
          editData["Success"].toString(),
        );
        print(
          editData.toString(),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.MAIN_COLOR,
          duration: const Duration(seconds: 2),
          content: Text(
            "Password_changed".tr,
            // style: TextStyle(color: AppColors.WHITE_COLOR),
          ),
        ),
      );
      newPassController.value.clear();
      newPassConfirmController.value.clear();
      Get.offAndToNamed(Routes.loginScreen);
    }
  }
}
