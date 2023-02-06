import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Models/Auth_Models/login_model.dart';
import '../../Models/Auth_Models/register_model.dart';
import '../../Routes/routes.dart';
import '../../Services/auth_services.dart';
import '../../Utils/app_colors.dart';
import 'dart:developer';

class AuthController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }


  var isLogInLoading = false.obs;
  var termsCheck = false.obs;
  var isSecureLoginPass = true.obs;
  var loginUserNameController = TextEditingController().obs;
  var loginPasswordController = TextEditingController().obs;
  var loginPhoneWithoutCodeController = TextEditingController().obs;
  final authBox = GetStorage();

  Future login(
      String UserName,
      String Password,
      String LoginBy,
      String ClientAppLanguage,
      String ClientDeviceType,
      String ClientMobileService,
      BuildContext context) async {
    try {
      isLogInLoading(true);
      LoginModel loginModel = await AuthServices().loginAPI(
          UserName,
          Password,
          LoginBy,
          ClientAppLanguage,
          ClientDeviceType,
          ClientMobileService,
          context);
      if (loginModel.success) {
        log(
          loginModel.apiMsg,
        );

        authBox.write(
            'AccessToken', "Bearer ${loginModel.response!.accessToken}");
        authBox.write('userName', loginModel.response!.clientName);
        GetStorage().read<String>('AccessToken')!;
        Get.offAllNamed(Routes.mainScreen);
      } else {}
    } finally {
      isLogInLoading(false);
    }
  }

  var isSecureRegisterPass = true.obs;
  var isSecureRegisterConfirmPass = true.obs;
  var isRegisterLoading = false.obs;
  var registerClientEmailController = TextEditingController().obs;
  var registerClientPhoneController = TextEditingController().obs;
  var registerClientPhoneFlagController = TextEditingController().obs;
  var registerClientPasswordController = TextEditingController().obs;
  var registerClientPasswordConfirmController = TextEditingController().obs;
  var registerClientNameController = TextEditingController().obs;
  var registerLoginByController = TextEditingController().obs;
  var registerClientAppLanguageController = TextEditingController().obs;
  var registerClientDeviceTypeController = TextEditingController().obs;
  var registerClientMobileServiceController = TextEditingController().obs;


  Future register(
      String ClientEmail,
      String ClientPhone,
      String ClientPhoneFlag,
      String ClientPassword,
      String ClientName,
      String LoginBy,
      String ClientAppLanguage,
      String ClientDeviceType,
      String ClientMobileService,
      BuildContext context,
      ) async {
    try {
      isRegisterLoading(true);
      RegisterModel registerModel = await AuthServices().registerAPI(
          ClientEmail,
          ClientPhone,
          ClientPhoneFlag,
          ClientPassword,
          ClientName,
          LoginBy,
          ClientAppLanguage,
          ClientDeviceType,
          ClientMobileService,
          context);
      if (registerModel.success==true) {
        authBox.write(
            'AccessToken', "Bearer ${registerModel.response!.accessToken}");
        authBox.write('userName', registerModel.response!.clientName);
        GetStorage().read<String>('AccessToken')!;
        Get.offAllNamed(Routes.personalDataScreen);
      } else {}
    } finally {
      isRegisterLoading(false);
    }
  }
}
