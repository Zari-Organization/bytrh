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
class SocialSignUpScreen extends StatelessWidget {
  SocialSignUpScreen({Key? key}) : super(key: key);
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
                Text("رقم الجوال"),
                const SizedBox(
                  height: 10,
                ),
                IntlPhoneField(
                  controller: authController.googleRegisterPhoneWithoutCodeController.value,
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
                        authController.googleRegisterPhoneWithoutCodeController.value.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text("num_without_zero".tr),
                          ),
                        );
                      }
                    } else {
                      authController.googleRegisterClientPhoneController.value.text = phone.completeNumber.toString();
                      authController.googleRegisterClientPhoneCodeController.value.text = phone.countryCode.toString();
                    }

                  },
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
                        onPressed: () {
                          Get.toNamed(Routes.termsScreen);
                        },
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

    if (authController.googleRegisterClientPhoneController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Enter_Mobile".tr),
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
      authController.googleSignUp(context);
    }
  }
}
