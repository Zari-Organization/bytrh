import 'dart:developer';
import 'dart:io';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../Logic/controllers/auth_controller.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_colors.dart';
import '../../../Widgets/auth_button.dart';
import '../../../Widgets/custom_circle_progress.dart';
import '../../../Widgets/titled_textField.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          title: const Text("تسجيل الدخول"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                      () {
                    if(authController.isLoadingLocation.value){
                      return const SizedBox();
                    }else{
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("رقم الجوال"),
                          const SizedBox(
                            height: 10,
                          ),
                          IntlPhoneField(
                            controller:
                            authController.loginPhoneWithoutCodeController.value,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.GREY_Light_COLOR,
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            // style: TextStyle(color: AppColors.WHITE_COLOR),
                            dropdownTextStyle: const TextStyle(color: AppColors.BLACK_COLOR),
                            cursorColor: AppColors.MAIN_COLOR,
                            initialCountryCode: authController.locationCountryCode.value,
                            onChanged: (phone) {
                              if (phone.number.length == 1) {
                                if (phone.number[0] == "0") {
                                  authController.loginPhoneWithoutCodeController.value
                                      .clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 2),
                                      content: Text("num_without_zero".tr),
                                    ),
                                  );
                                }
                              } else {
                                authController.loginUserNameController.value.text =
                                    phone.completeNumber.toString();
                                authController.loginClientPhoneCodeController.value
                                    .text = phone.countryCode.toString();
                                log(authController
                                    .registerClientPhoneController.value.text);
                              }
                            },
                          )
                        ],
                      );
                    }
                  },
                ),
                Obx(
                  () => TitledTextField(
                    obscureText: authController.isSecureLoginPass.value,
                    controller: authController.loginPasswordController.value,
                    title: "كلمة المرور",
                    hintText: "كلمة المرور........",
                    fillColor: AppColors.GREY_Light_COLOR,
                    suffixIcon: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        authController.isSecureLoginPass.value =
                            !authController.isSecureLoginPass.value;
                      },
                      icon: SvgPicture.asset(
                        authController.isSecureLoginPass.value
                            ? AppIcons.hide_pass_icon
                            : AppIcons.show_pass_icon,
                        color: AppColors.GREY_COLOR,
                      ),
                    ),
                    // controller: profileController.brandNameEnController.value,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.forgetPasswordScreen);
                        },
                        child: Column(
                          children: [
                            const Text(
                              "نسيت كلمة المرور؟",
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.BLACK_COLOR),
                            ),
                            Container(
                              color: AppColors.BLACK_COLOR,
                              width: 80,
                              height: 0.5,
                            ),
                          ],
                        ))
                  ],
                ),
                const SizedBox(height: 16),
                Obx(
                  () => ConditionalBuilder(
                    condition: !authController.isLogInLoading.value,
                    builder: (context) => CustomButton(
                      title: "تسجيل الدخول",
                      backgroundColor: AppColors.MAIN_COLOR,
                      foregroundColor: AppColors.WHITE_COLOR,
                      overlayColor: AppColors.WHITE_COLOR,
                      onPress: () {
                        handleLoginRequest(context);
                      },
                    ),
                    fallback: (context) => const CustomCircleProgress(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: AppColors.BLACK_COLOR,
                      width: 80,
                      height: 0.5,
                    ),
                    const Text(
                      "أو تسجيل الدخول عبر",
                      style: TextStyle(fontSize: 12),
                    ),
                    Container(
                      color: AppColors.BLACK_COLOR,
                      width: 80,
                      height: 0.5,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // IconButton(
                    //   onPressed: () async{
                    //     // authController.facebookLogin();
                    //     authController.facebookLogin2();
                    //     // await FacebookAuth.instance.logOut();
                    //   },
                    //   icon: SvgPicture.asset(AppIcons.facebook_icon),
                    //   padding: EdgeInsets.zero,
                    // ),
                    // if(Platform.isIOS)
                    //   IconButton(
                    //     onPressed: () {},
                    //     icon: SvgPicture.asset(AppIcons.apple_icon),
                    //     padding: EdgeInsets.zero,
                    //   ),
                    IconButton(
                      onPressed: () => googleSignIn(context),
                      icon: SvgPicture.asset(AppIcons.google_icon),
                      padding: EdgeInsets.zero,
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: SvgPicture.asset(AppIcons.twitter_icon),
                    //   padding: EdgeInsets.zero,
                    // ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "ليس لديك حساب؟",
                      style:
                          TextStyle(fontSize: 12, color: AppColors.BLACK_COLOR),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.signUpScreen);
                      },
                      child: const Text(
                        "إنشاء حساب",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.MAIN_COLOR),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  handleLoginRequest(BuildContext context) {
    if (authController.loginUserNameController.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Enter_Mobile".tr),
        ),
      );
    } else if (authController.loginPasswordController.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Enter_Pass".tr),
        ),
      );
    } else {
      authController.login(
        authController.loginUserNameController.value.text,
        authController.loginPasswordController.value.text,
        "MANUAL",
        "ar",
        "ANDROID",
        "GMS",
        context,
      );
    }
  }

  Future googleSignIn(context) async {
    await authController.googleLogin(context);
    // await authController.newGoogleLogin(context);
    // await authController.signInwithGoogle();
  }
}
