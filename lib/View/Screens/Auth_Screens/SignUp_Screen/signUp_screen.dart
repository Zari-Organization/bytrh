import 'dart:developer';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
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
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          title: const Text("إنشاء حساب"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitledTextField(
                  controller: authController.registerClientNameController.value,
                  title: "الأسم",
                  hintText: "الأسم بالكامل ...",
                  fillColor: AppColors.GREY_Light_COLOR,
                  // controller: profileController.brandNameEnController.value,
                ),
                Text("رقم الجوال"),
                const SizedBox(
                  height: 10,
                ),
                IntlPhoneField(
                  controller: authController.loginPhoneWithoutCodeController.value,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.GREY_Light_COLOR,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // style: TextStyle(color: AppColors.WHITE_COLOR),
                  dropdownTextStyle: TextStyle(color: AppColors.BLACK_COLOR),
                  cursorColor: AppColors.MAIN_COLOR,
                  initialCountryCode: 'SA',
                  onChanged: (phone) {

                    if (phone.number.length == 1) {
                      if (phone.number[0] == "0") {
                        authController.loginPhoneWithoutCodeController.value.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text("num_without_zero".tr),
                          ),
                        );
                      }
                    } else {
                      authController.registerClientPhoneController.value.text = phone.completeNumber.toString();
                      authController.registerClientPhoneCodeController.value.text = phone.countryCode.toString();
                      log( authController.registerClientPhoneController.value.text);
                    }

                  },
                ),
                // TitledTextField(
                //   controller:
                //       authController.registerClientPhoneController.value,
                //   title: "رقم الجوال",
                //   hintText: "رقم الجوال........",
                //   fillColor: AppColors.GREY_Light_COLOR,
                //   // controller: profileController.brandNameEnController.value,
                // ),
                TitledTextField(
                  controller:
                      authController.registerClientEmailController.value,
                  title: "الإيميل",
                  hintText: "الإيميل......",
                  fillColor: AppColors.GREY_Light_COLOR,
                  // controller: profileController.brandNameEnController.value,
                ),
                Obx(
                  () => TitledTextField(
                    obscureText: authController.isSecureRegisterPass.value,
                    controller:
                        authController.registerClientPasswordController.value,
                    title: "كلمة المرور",
                    hintText: "كلمة المرور........",
                    fillColor: AppColors.GREY_Light_COLOR,
                    suffixIcon: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        authController.isSecureRegisterPass.value =
                            !authController.isSecureRegisterPass.value;
                      },
                        icon:SvgPicture.asset(
                          authController.isSecureRegisterPass.value
                              ? AppIcons.hide_pass_icon
                              : AppIcons.show_pass_icon,
                          color: AppColors.GREY_COLOR,
                        ),
                        color: AppColors.GREY_COLOR,

                    ),
                    // controller: profileController.brandNameEnController.value,
                  ),
                ),
                Obx(
                  () => TitledTextField(
                    obscureText: authController.isSecureRegisterConfirmPass.value,
                    controller: authController
                        .registerClientPasswordConfirmController.value,
                    title: "تأكيد كلمة المرور",
                    hintText: "كلمة المرور........",
                    fillColor: AppColors.GREY_Light_COLOR,
                    suffixIcon: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        authController.isSecureRegisterConfirmPass.value =
                            !authController.isSecureRegisterConfirmPass.value;
                      },
                      icon:    SvgPicture.asset(
                        authController.isSecureRegisterConfirmPass.value
                            ? AppIcons.hide_pass_icon
                            : AppIcons.show_pass_icon,
                        color: AppColors.GREY_COLOR,
                      ),
                        color: AppColors.GREY_COLOR,

                    ),
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      Checkbox(
                        side: const BorderSide(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        value: authController.termsCheck.value,
                        onChanged: (_) {
                          authController.termsCheck.value =
                              !authController.termsCheck.value;
                        },
                        // checkColor: AppColors.MAIN_COLOR,
                        activeColor: AppColors.MAIN_COLOR,
                      ),
                      const Text(
                        "أوافق على",
                        style: TextStyle(fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "الشروط والأحكام",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.MAIN_COLOR),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => ConditionalBuilder(
                    condition: !authController.isRegisterLoading.value,
                    builder: (context) => CustomButton(
                      title: "إنشاء حساب",
                      backgroundColor: AppColors.MAIN_COLOR,
                      foregroundColor: AppColors.WHITE_COLOR,
                      overlayColor: AppColors.WHITE_COLOR,
                      onPress: () {
                        handleSignUpRequest(context);
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
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppIcons.facebook_icon),
                      padding: EdgeInsets.zero,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppIcons.apple_icon),
                      padding: EdgeInsets.zero,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.socialSignUpScreen);
                      },
                      icon: SvgPicture.asset(AppIcons.google_icon),
                      padding: EdgeInsets.zero,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppIcons.twitter_icon),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "لديك حساب بالفعل؟",
                      style:
                          TextStyle(fontSize: 12, color: AppColors.BLACK_COLOR),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.loginScreen);
                      },
                      child: const Text(
                        "تسجيل الدخول",
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

  handleSignUpRequest(BuildContext context) {

     if (authController.registerClientNameController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Enter_Name".tr),
        ),
      );
    }
    else if (authController.registerClientPhoneController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Enter_Mobile".tr),
        ),
      );
    }
    else if (authController.registerClientEmailController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Enter_Email".tr),
        ),
      );
    } else if (authController.registerClientPasswordController.value.text ==
            "" ||
        authController.registerClientPasswordConfirmController.value.text ==
            "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Enter_pass".tr),
        ),
      );
    }
   else  if (authController.registerClientPasswordController.value.text !=
         authController.registerClientPasswordConfirmController.value.text) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           duration: const Duration(seconds: 2),
           content: Text("password_does_not_match".tr),
         ),
       );
     }
    else if (!authController.termsCheck.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Check_Terms".tr),
        ),
      );
    }  else {
      authController.register(
        authController.registerClientEmailController.value.text,
        authController.registerClientPhoneController.value.text,
        authController.registerClientPhoneCodeController.value.text,
        authController.registerClientPasswordController.value.text,
        authController.registerClientNameController.value.text,
        "MANUAL",
        "en",
        "ANDROID",
        "GMS",
        "1",
        context,
      );
    }
  }
}
