import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../Routes/routes.dart';
import '../../Widgets/auth_button.dart';
import '../../Widgets/titled_textField.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitledTextField(
                  title: "الأسم",
                  hintText: "الأسم بالكامل ...",
                  fillColor: AppColors.GREY_Light_COLOR,
                  // controller: profileController.brandNameEnController.value,
                ),
                TitledTextField(
                  title: "رقم الجوال",
                  hintText: "رقم الجوال........",
                  fillColor: AppColors.GREY_Light_COLOR,
                  // controller: profileController.brandNameEnController.value,
                ),
                TitledTextField(
                  title: "الإيميل",
                  hintText: "الإيميل......",
                  fillColor: AppColors.GREY_Light_COLOR,
                  // controller: profileController.brandNameEnController.value,
                ),
                TitledTextField(
                  title: "كلمة المرور",
                  hintText: "كلمة المرور........",
                  fillColor: AppColors.GREY_Light_COLOR,
                  suffixIcon: IconButton(
                    splashRadius: 20,
                    onPressed: () {},
                    icon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye),
                      color: AppColors.GREY_COLOR,
                    ),
                  ),
                  // controller: profileController.brandNameEnController.value,
                ),
                TitledTextField(
                  title: "تأكيد كلمة المرور",
                  hintText: "كلمة المرور........",
                  fillColor: AppColors.GREY_Light_COLOR,
                  suffixIcon: IconButton(
                    splashRadius: 20,
                    onPressed: () {},
                    icon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye),
                      color: AppColors.GREY_COLOR,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      side: const BorderSide(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      value: true,
                      onChanged: (_) {},
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
                const SizedBox(height: 16),
                CustomButton(
                  title: "إنشاء حساب",
                  backgroundColor: AppColors.MAIN_COLOR,
                  foregroundColor: AppColors.WHITE_COLOR,
                  overlayColor: AppColors.WHITE_COLOR,
                  onPress: () {},
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
                      onPressed: () {},
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
}
