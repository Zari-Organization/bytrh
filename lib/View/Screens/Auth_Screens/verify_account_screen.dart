import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import '../../../../../Logic/controllers/verification_controller.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../Logic/controllers/auth_controller.dart';

class VerifyAccountScreen extends StatelessWidget {
  VerifyAccountScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  final verificationController = Get.find<VerificationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text("confirmation".tr),
          backgroundColor: AppColors.MAIN_COLOR,
          centerTitle: true,
          elevation: 1,
        ),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 45),
                Text(
                  "enter_code".tr,
                  style:  const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: VerificationCode(
                      fillColor: Color(0xffEFEFF0),
                      fullBorder: true,
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        color: AppColors.MAIN_COLOR,
                      ),

                      keyboardType: TextInputType.number,
                      underlineColor: AppColors.MAIN_COLOR,
                      length: 4,
                      cursorColor: AppColors.MAIN_COLOR,
                      onCompleted: (String value) {
                        verificationController.verificationResetPassCode.value =
                            value;
                      if(verificationController.verifyLogin.value){
                        verificationController.confirmCodeToVerifyAccountAndLogin(
                          verificationController.phoneController.value.text,
                          verificationController.verificationResetPassCode.value,
                          context,
                        );
                      }
                      else{
                        verificationController.confirmCodeToVerifyAccountAndRegister(
                          verificationController.phoneController.value.text,
                          verificationController
                              .verificationResetPassCode.value,
                          context,
                        );
                      }
                      },
                      onEditing: (bool value) {},
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                ConditionalBuilder(
                  condition: !verificationController.verificationLoading.value,
                  builder: (context) => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppColors.MAIN_COLOR,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          AppColors.WHITE_COLOR,
                        ),
                      ),
                      onPressed: () {
                        if(verificationController.verifyLogin.value){
                          verificationController.confirmCodeToVerifyAccountAndLogin(
                            verificationController.phoneController.value.text,
                            verificationController
                                .verificationResetPassCode.value,
                            context,
                          );
                        }
                        else{
                          verificationController.confirmCodeToVerifyAccountAndRegister(
                            verificationController.phoneController.value.text,
                            verificationController.verificationResetPassCode.value,
                            context,
                          );
                        }
                      },
                      child: Text("confirm".tr),
                    ),
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(color: AppColors.MAIN_COLOR),
                  ),
                ),
                const SizedBox(height: 25),
                verificationController.resendStatus.value
                    ? InkWell(
                        onTap: () {
                          verificationController.startTimer();
                          verificationController.sendCodeToResetPassword(
                              verificationController.phoneController.value.text,
                              context);
                        },
                        child: Text(
                          "resend".tr,
                          style: const TextStyle(
                            color: AppColors.WHITE_COLOR,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    : Text(
                        "00 : ${verificationController.start.value}",
                      ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      );
    });
  }
}
