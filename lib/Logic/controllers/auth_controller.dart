import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Models/auth_model.dart';
import '../../Routes/routes.dart';
import '../../Services/auth_services.dart';

class AuthController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  var isLoading = false.obs;

  var isLogInLoading = false.obs;
  var termsCheck = false.obs;
  var policyCheck = false.obs;
  var rememberCheck = false.obs;
  var isSecureLoginPass = true.obs;
  var isSecureRegisterPass = true.obs;
  var isSecureRegisterConfirmPass = true.obs;
  var loginUserNameController = TextEditingController().obs;
  var loginPasswordController = TextEditingController().obs;
  var loginPhoneWithoutCodeController = TextEditingController().obs;
  final authBox = GetStorage();

  Future login(String UserName, String Password, String LoginBy,String ClientAppLanguage, String ClientDeviceType, String ClientMobileService,
      BuildContext context) async {
    try {
      isLogInLoading(true);
      AuthModel loginModel = await AuthServices()
          .loginAPI(UserName, Password, LoginBy,ClientAppLanguage, ClientDeviceType, ClientMobileService, context);
      if (loginModel.success) {
        if (kDebugMode) {
          print(
            loginModel.apiMsg,
          );
        }

        authBox.write(
            'AccessToken', "Bearer ${loginModel.response!.accessToken}");
        authBox.write('userName', loginModel.response!.clientName);
        GetStorage().read<String>('AccessToken')!;
        Get.toNamed(Routes.personalDataScreen);
      } else {}
    } finally {
      isLogInLoading(false);
    }
  }

}
