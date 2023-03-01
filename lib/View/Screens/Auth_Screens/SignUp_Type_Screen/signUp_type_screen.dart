import 'dart:io';
import 'dart:math';
import 'package:bytrh/Utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Notifications/local_notifications.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_constants.dart';
import '../../../Widgets/auth_button.dart';

class SignUpTypeScreen extends StatelessWidget {
  SignUpTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.BLACK_COLOR,
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  AppImages.background_white,
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: AppConstants.mediaHeight(context)/4),
                      const Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              AppImages.bytrh_logo,
                            ),
                          )
                      ),
                      SizedBox(height: AppConstants.mediaHeight(context)*0.05),
                      Column(
                        children: [
                          CustomButton(
                            title: "إنشاء الحساب كعميل",
                            backgroundColor: AppColors.SECOND_COLOR,
                            borderSideColor: AppColors.SECOND_COLOR,
                            foregroundColor: AppColors.WHITE_COLOR,
                            overlayColor: AppColors.WHITE_COLOR,
                            onPress: (){
                              Get.toNamed(Routes.signUpScreen);
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            title: "إنشاء الحساب كطبيب أو مركز طبي",
                            backgroundColor: AppColors.WHITE_COLOR,
                            borderSideColor: AppColors.SECOND_COLOR,
                            foregroundColor: AppColors.SECOND_COLOR,
                            overlayColor: AppColors.MAIN_COLOR,
                            onPress: (){},
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            title: "إنشاء الحساب كقائد مركبة أو ناقل",
                            backgroundColor: AppColors.WHITE_COLOR,
                            borderSideColor: AppColors.SECOND_COLOR,
                            foregroundColor: AppColors.SECOND_COLOR,
                            overlayColor: AppColors.MAIN_COLOR,
                            onPress: (){},
                          ),
                        ],
                      ),
                      SizedBox(height: AppConstants.mediaHeight(context)*0.05),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
