import 'dart:math';

import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../Logic/controllers/verification_controller.dart';
import '../../../../../Routes/routes.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_constants.dart';


class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  final verificationController = Get.find<VerificationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          centerTitle: true,
          elevation: 1,
          title: Text(
            "restore_pass".tr,
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 44),
                  child: Text(
                    textAlign: TextAlign.center,
                    "restore_code_disc".tr,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 45),
                IntlPhoneField(
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
                    verificationController.phoneController.value.text =
                        phone.completeNumber.toString();
                    log(verificationController.phoneController.value.text as num);
                  },
                ),
                const SizedBox(height: 45),
                ConditionalBuilder(
                  condition: !verificationController.sendCodeLoading.value,
                  builder: (context) => SizedBox(
                    width: AppConstants.mediaWidth(context),
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        backgroundColor: MaterialStateProperty.all(
                          AppColors.MAIN_COLOR,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          AppColors.WHITE_COLOR,
                        ),
                      ),
                      onPressed: () {
                        // Get.toNamed(Routes.verifyResetPassCodeScreen);
                        verificationController.sendCodeToResetPassword(
                            verificationController.phoneController.value.text,
                            context);
                      },
                      child: Text("send_code".tr),
                    ),
                  ),
                  fallback: (context) => const CustomCircleProgress()
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
