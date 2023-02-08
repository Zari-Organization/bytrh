import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../Logic/controllers/verification_controller.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_icons.dart';
import '../../../../Widgets/titled_textField.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({Key? key}) : super(key: key);
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
          title: Text("save_new_pass".tr),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 50),
              TitledTextField(
                // titleStyle: const TextStyle(color: AppColors.WHITE_COLOR),
                title: "New_Password".tr,
                obscureText: verificationController.isSecurePass.value,
                controller: verificationController.newPassController.value,
                suffixIcon: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    verificationController.isSecurePass.value =
                        !verificationController.isSecurePass.value;
                  },
                  icon: SvgPicture.asset(
                    verificationController.isSecurePass.value
                        ? AppIcons.hide_pass_icon
                        : AppIcons.show_pass_icon,
                    color: AppColors.BLACK_COLOR,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TitledTextField(
                // titleStyle: const TextStyle(color: AppColors.WHITE_COLOR),
                title: "Confirm_New_Password".tr,
                obscureText: verificationController.isSecurePass.value,
                controller:
                    verificationController.newPassConfirmController.value,
                suffixIcon: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    verificationController.isSecurePass.value =
                        !verificationController.isSecurePass.value;
                  },
                  icon: SvgPicture.asset(
                    verificationController.isSecurePass.value
                        ? AppIcons.hide_pass_icon
                        : AppIcons.show_pass_icon,
                    color: AppColors.BLACK_COLOR,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ConditionalBuilder(
                condition: !verificationController.isChangePassLoading.value,
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
                      if (verificationController.newPassController.value.text !=
                          verificationController
                              .newPassConfirmController.value.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text(
                              "password_does_not_match".tr,
                            ),
                          ),
                        );
                      } else {
                        verificationController.changePassword(
                          verificationController.phoneController.value.text,
                          verificationController.newPassController.value.text,
                          verificationController.newPassConfirmController.value.text,
                          context,
                        );
                      }
                    },
                    child: Text("save".tr),
                  ),
                ),
                fallback: (context) => const CustomCircleProgress(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
