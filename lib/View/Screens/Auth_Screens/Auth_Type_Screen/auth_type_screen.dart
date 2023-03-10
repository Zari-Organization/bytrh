import 'dart:io';
import 'dart:math';
import 'package:bytrh/Utils/app_constants.dart';
import 'package:bytrh/Utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_colors.dart';
import '../../../Widgets/auth_button.dart';

class AuthTypeScreenScreen extends StatelessWidget {
  AuthTypeScreenScreen({Key? key}) : super(key: key);

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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: AppConstants.mediaHeight(context) / 4),
                    const Center(
                        child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        AppImages.bytrh_logo,
                      ),
                    )),
                    SizedBox(height: AppConstants.mediaHeight(context) * 0.05),
                    Column(
                      children: [
                        CustomButton(
                          title: "تسجيل دخول",
                          backgroundColor: AppColors.SECOND_COLOR,
                          foregroundColor: AppColors.WHITE_COLOR,
                          borderSideColor: AppColors.SECOND_COLOR,
                          overlayColor: AppColors.WHITE_COLOR,
                          onPress: () {
                            Get.toNamed(Routes.loginScreen);
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          title: "إنشاء حساب",
                          backgroundColor: AppColors.WHITE_COLOR,
                          foregroundColor: AppColors.SECOND_COLOR,
                          borderSideColor: AppColors.SECOND_COLOR,
                          overlayColor: AppColors.MAIN_COLOR,
                          onPress: () {
                            // Get.toNamed(Routes.signUpTypeScreen);
                            Get.toNamed(Routes.signUpScreen);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: AppConstants.mediaHeight(context) * 0.05),
                    // TextButton(
                    //   onPressed: () {
                    //     Get.toNamed(Routes.mainScreen);
                    //   },
                    //   child: const Text(
                    //     "تخطي",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       color: AppColors.SECOND_COLOR,
                    //       decoration: TextDecoration.underline,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
