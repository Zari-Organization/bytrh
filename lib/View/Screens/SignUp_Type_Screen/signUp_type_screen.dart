import 'dart:io';
import 'dart:math';
import 'package:bytrh/Utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../Utils/app_colors.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_icons.dart';
import '../../Widgets/auth_button.dart';

class SignUpTypeScreen extends StatelessWidget {
  SignUpTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.BLACK_COLOR,
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                AppImages.background_white,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    title: "إنشاء الحساب كعميل",
                    backgroundColor: AppColors.MAIN_COLOR,
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
                    foregroundColor: AppColors.MAIN_COLOR,
                    overlayColor: AppColors.MAIN_COLOR,
                    onPress: (){},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: "إنشاء الحساب كقائد مركبة أو ناقل",
                    backgroundColor: AppColors.WHITE_COLOR,
                    foregroundColor: AppColors.MAIN_COLOR,
                    overlayColor: AppColors.MAIN_COLOR,
                    onPress: (){},
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
