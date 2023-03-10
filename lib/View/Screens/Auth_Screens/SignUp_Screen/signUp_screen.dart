import 'dart:developer';
import 'dart:io';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../Logic/controllers/auth_controller.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_bottom_sheets.dart';
import '../../../../Utils/app_colors.dart';
import '../../../Widgets/auth_button.dart';
import '../../../Widgets/custom_circle_progress.dart';
import '../../../Widgets/titled_textField.dart';
import 'Widgets/signUp_bottom_sheets.dart';

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
              Obx(
                () {
                  if (authController.isLoadingAnimalsCategory.value) {
                    return const CustomCircleProgress();
                  } else {
                    if (authController.animalsCategoryList.isEmpty) {
                      return const SizedBox();
                    } else if (authController
                            .selectedAnimalsCategoryValue.value ==
                        "") {
                      return const CustomCircleProgress();
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("فئتك المفضلة"),
                          DropdownButtonHideUnderline(
                            child: Container(
                              color: AppColors.GREY_Light_COLOR,
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Text(
                                  'اختر التصنيف',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: authController.animalsCategoryList
                                    .map((item) => DropdownMenuItem<String>(
                                          value:
                                              item.idAnimalCategory.toString(),
                                          child: Text(
                                            item.animalCategoryName,
                                            style: const TextStyle(),
                                          ),
                                        ))
                                    .toList(),
                                value: authController
                                    .selectedAnimalsCategoryValue.value,
                                onChanged: (value) {
                                  authController.selectedAnimalsCategoryValue
                                      .value = value as String;
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }
                },
              ),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text("الدولة"),
                    ListTile(
                      onTap: () {
                        SignUpBottomSheets().countriesBottomSheet(context);
                      },
                      title: Text(authController.countryNameController.value),
                      tileColor: AppColors.GREY_Light_COLOR,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(height: 10),
                    const Text("المدينة"),
                    ListTile(
                      onTap: () {
                        SignUpBottomSheets().citiesBottomSheet(context);
                      },
                      title: Text(authController.cityNameController.value),
                      tileColor: AppColors.GREY_Light_COLOR,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Obx(
                () {
                  if (authController.isLoadingLocation.value) {
                    return const SizedBox();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("رقم الجوال"),
                        const SizedBox(height: 10),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: IntlPhoneField(
                            controller: authController
                                .loginPhoneWithoutCodeController.value,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.GREY_Light_COLOR,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            // style: TextStyle(color: AppColors.WHITE_COLOR),
                            dropdownTextStyle:
                                TextStyle(color: AppColors.BLACK_COLOR),
                            cursorColor: AppColors.MAIN_COLOR,
                            initialCountryCode:
                                authController.locationCountryCode.value,
                            onChanged: (phone) {
                              if (phone.number.length == 1) {
                                if (phone.number[0] == "0") {
                                  authController
                                      .loginPhoneWithoutCodeController.value
                                      .clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 2),
                                      content: Text("num_without_zero".tr),
                                    ),
                                  );
                                }
                              } else {
                                authController
                                    .registerClientPhoneController
                                    .value
                                    .text = phone.completeNumber.toString();
                                authController.registerClientPhoneCodeController
                                    .value.text = phone.countryCode.toString();
                                log(authController
                                    .registerClientPhoneController.value.text);
                              }
                            },
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
              // TitledTextField(
              //   controller:authController.registerClientPhoneController.value,
              //   title: "رقم الجوال",
              //   hintText: "رقم الجوال........",
              //   fillColor: AppColors.GREY_Light_COLOR,
              //   // controller: profileController.brandNameEnController.value,
              // ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                child: TitledTextField(
                  validator: validateEmail,
                  controller:
                      authController.registerClientEmailController.value,
                  textDirection: TextDirection.ltr,
                  title: "الإيميل",
                  hintText: "الإيميل......",
                  fillColor: AppColors.GREY_Light_COLOR,
                  // controller: profileController.brandNameEnController.value,
                ),
              ),
              Obx(() => Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TitledTextField(
                      validator: validatePassword,
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
                        icon: SvgPicture.asset(
                          authController.isSecureRegisterPass.value
                              ? AppIcons.hide_pass_icon
                              : AppIcons.show_pass_icon,
                          color: AppColors.GREY_COLOR,
                        ),
                        color: AppColors.GREY_COLOR,
                      ),
                      // controller: profileController.brandNameEnController.value,
                    ),
                  )),
              Obx(
                () => Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TitledTextField(
                    validator: validatePassword,
                    obscureText:
                        authController.isSecureRegisterConfirmPass.value,
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
                      icon: SvgPicture.asset(
                        authController.isSecureRegisterConfirmPass.value
                            ? AppIcons.hide_pass_icon
                            : AppIcons.show_pass_icon,
                        color: AppColors.GREY_COLOR,
                      ),
                      color: AppColors.GREY_COLOR,
                    ),
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
                      activeColor: AppColors.SECOND_COLOR,
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
                            fontSize: 12, color: AppColors.SECOND_COLOR),
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
                    backgroundColor: AppColors.SECOND_COLOR,
                    borderSideColor: AppColors.SECOND_COLOR,
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
                  // IconButton(
                  //   onPressed: () {
                  //     authController.facebookSignUp(context);
                  //   },
                  //   icon: SvgPicture.asset(AppIcons.facebook_icon),
                  //   padding: EdgeInsets.zero,
                  // ),
                  // if(Platform.isIOS)
                  //   IconButton(
                  //     onPressed: () {},
                  //     icon: SvgPicture.asset(AppIcons.apple_icon),
                  //     padding: EdgeInsets.zero,
                  //   ),
                  IconButton(
                    onPressed: () {
                      authController.googleSignUp(context);
                      // Get.toNamed(Routes.socialSignUpScreen);
                    },
                    icon: SvgPicture.asset(AppIcons.google_icon),
                    padding: EdgeInsets.zero,
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: SvgPicture.asset(AppIcons.twitter_icon),
                  //   padding: EdgeInsets.zero,
                  // ),
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
                          fontSize: 12, color: AppColors.SECOND_COLOR),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
    // else if (authController.cityID.value == "") {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       duration: const Duration(seconds: 2),
    //       content: Text("من فضلك ادخل الدولة والمدينة".tr),
    //     ),
    //   );
    // }
    else if (authController.registerClientPhoneController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Enter_Mobile".tr),
        ),
      );
    } else if (authController.registerClientEmailController.value.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("من فضلك ادخل البريد الالكتروني".tr),
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
    } else if (authController.registerClientPasswordController.value.text !=
        authController.registerClientPasswordConfirmController.value.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("password_does_not_match".tr),
        ),
      );
    } else if (!authController.termsCheck.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text("Check_Terms".tr),
        ),
      );
    } else {
      authController.register(
        authController.registerClientEmailController.value.text,
        authController.registerClientPhoneController.value.text,
        authController.registerClientPhoneCodeController.value.text,
        authController.registerClientPasswordController.value.text,
        authController.registerClientNameController.value.text,
        "MANUAL",
        "ar",
        Platform.isAndroid ? "ANDROID" : "IOS",
        "GMS",
        authController.cityID.value == ""
            ? authController.defaultCity.value
            : authController.cityID.value,
        authController.selectedAnimalsCategoryValue.value,
        context,
      );
      log(authController.defaultCity.value);
    }
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'من فضلك ادخل البريد الالكتروني صحيح'
        : null;
  }

  String? validatePassword(String? value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,}$';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Use upper,lower,number and Special character'
        : null;
  }
}
