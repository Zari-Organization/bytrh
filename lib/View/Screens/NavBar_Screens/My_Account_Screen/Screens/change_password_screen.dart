import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Logic/controllers/My_Account_Controllers/change_password_controller.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_constants.dart';
import '../../../../../Utils/app_icons.dart';
import '../../../../Widgets/auth_button.dart';
import '../../../../Widgets/custom_circle_progress.dart';
import '../../../../Widgets/titled_textField.dart';


class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final changePasswordController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          centerTitle: true,
          elevation: 1,
          title: Text(
            "Change_Password".tr,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                TitledTextField(
                  obscureText: changePasswordController.isSecureOldPass.value,
                  controller: changePasswordController.oldPasswordController.value,
                  title: "Old_Password".tr,
                  hintText: "كلمة المرور........",
                  suffixIcon: IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      changePasswordController.isSecureOldPass.value =
                      !changePasswordController.isSecureOldPass.value;
                    },
                    icon: SvgPicture.asset(
                      changePasswordController.isSecureOldPass.value
                          ? AppIcons.hide_pass_icon
                          : AppIcons.show_pass_icon,
                      color: AppColors.GREY_COLOR,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TitledTextField(
                  obscureText: changePasswordController.isSecureNewPass.value,
                  controller: changePasswordController.newPasswordController.value,
                  title: "New_Password".tr,
                  hintText: "كلمة المرور........",
                  suffixIcon: IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      changePasswordController.isSecureNewPass.value =
                      !changePasswordController.isSecureNewPass.value;
                    },
                    icon: SvgPicture.asset(
                      changePasswordController.isSecureNewPass.value
                          ? AppIcons.hide_pass_icon
                          : AppIcons.show_pass_icon,
                      color: AppColors.GREY_COLOR,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TitledTextField(
                  obscureText: changePasswordController.isSecureConfirmPass.value,
                  controller: changePasswordController.confirmNewPasswordController.value,
                  title: "Confirm_Password".tr,
                  hintText: "كلمة المرور........",
                  suffixIcon: IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      changePasswordController.isSecureConfirmPass.value =
                      !changePasswordController.isSecureConfirmPass.value;
                    },
                    icon: SvgPicture.asset(
                      changePasswordController.isSecureConfirmPass.value
                          ? AppIcons.hide_pass_icon
                          : AppIcons.show_pass_icon,
                      color: AppColors.GREY_COLOR,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                ConditionalBuilder(
                  condition: !changePasswordController.isLoading.value,
                  builder: (context) => SizedBox(
                    width: AppConstants.mediaWidth(context),
                    height: 50,
                    child: CustomButton(
                      title: "حفظ",
                      backgroundColor: AppColors.MAIN_COLOR,
                      foregroundColor: AppColors.WHITE_COLOR,
                      overlayColor: AppColors.WHITE_COLOR,
                      onPress: () {
                        handleLoginRequest(context);
                      },
                    ),
                  ),
                  fallback: (context) => const CustomCircleProgress(),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
  handleLoginRequest(BuildContext context) {
    if (changePasswordController
        .oldPasswordController.value.text.isEmpty ||
        changePasswordController
            .newPasswordController.value.text.isEmpty ||
        changePasswordController.confirmNewPasswordController.value
            .text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            "fill_fields".tr,
          ),
        ),
      );
    } else {
      changePasswordController.changePassword(
        changePasswordController.oldPasswordController.value.text,
        changePasswordController.newPasswordController.value.text,
        changePasswordController.confirmNewPasswordController.value.text,
        context,
      );
    }
  }
}
