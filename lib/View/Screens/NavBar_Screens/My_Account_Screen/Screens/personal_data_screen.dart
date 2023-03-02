import 'dart:developer';

import 'package:bytrh/Utils/app_bottom_sheets.dart';
import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../Logic/controllers/My_Account_Controllers/personal_data_controller.dart';
import '../../../../../Logic/controllers/auth_controller.dart';
import '../../../../Widgets/auth_button.dart';
import '../../../../Widgets/titled_textField.dart';

class PersonalDataScreen extends StatelessWidget {
  PersonalDataScreen({Key? key}) : super(key: key);
  final personalDataController = Get.find<PersonalDataController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.MAIN_COLOR,
          title: const Text("بياناتي الشخصية"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.SECOND_COLOR,
                                  ),
                              child: personalDataController
                                  .profileImageFile.value!.path.isEmpty
                                  ? CircleAvatar(
                                radius: 60,
                                backgroundColor: AppColors.SECOND_COLOR,
                                backgroundImage: NetworkImage(
                                    personalDataController.clientData
                                        .value.clientPicture ??
                                        ""),
                                child: Text(
                                  personalDataController.clientData.value
                                      .clientPicture ==
                                      null
                                      ? "أضف صورة"
                                      : "",
                                  style: const TextStyle(
                                    color: AppColors.WHITE_COLOR,
                                  ),
                                ),
                              )
                                  : CircleAvatar(
                                radius: 60,
                                backgroundColor: AppColors.MAIN_COLOR,
                                backgroundImage: FileImage(
                                  personalDataController
                                      .profileImageFile.value!,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                personalDataController.getProfileImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  //border corner radius
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      //color of shadow
                                      spreadRadius: 5,
                                      //spread radius
                                      blurRadius: 7,
                                      // blur radius
                                      offset: const Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.SECOND_COLOR,
                                  child: SvgPicture.asset(AppIcons.camera_icon,color: AppColors.WHITE_COLOR,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                TitledTextField(
                  title: "الأسم",
                  controller: personalDataController.userNameController.value,
                  fillColor: AppColors.GREY_Light_COLOR,
                ),
                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("رقم الجوال"),
                    const SizedBox(
                      height: 10,
                    ),
                    Directionality(textDirection: TextDirection.ltr, child: IntlPhoneField(
                      controller: personalDataController.phoneController.value,
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
                      dropdownTextStyle: const TextStyle(
                          color: AppColors.BLACK_COLOR),
                      cursorColor: AppColors.MAIN_COLOR,
                      initialCountryCode: personalDataController.countryFlag.value,
                      onChanged: (phone) {
                        if (phone.number.length == 1) {
                          if (phone.number[0] == "0") {
                            personalDataController.phoneController
                                .value
                                .clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text("num_without_zero".tr),
                              ),
                            );
                          }
                        } else {
                          personalDataController.completePhoneNumber.value.text =
                              phone.completeNumber.toString();
                          personalDataController.phoneCodeController.value
                              .text = phone.countryCode.toString();
                          log("completePhoneNumber -->${personalDataController.completePhoneNumber.value.text}");
                          log("phoneCodeController -->${personalDataController.phoneCodeController.value.text}");
                        }
                      },
                    ))
                  ],
                ),),

                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TitledTextField(
                    validator: validateEmail,
                    title: "الإيميل",
                    controller: personalDataController.emailController.value,
                    fillColor: AppColors.GREY_Light_COLOR,
                    textDirection: TextDirection.ltr,
                    // controller: profileController.brandNameEnController.value,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("الدولة"),
                ListTile(
                  onTap: () {
                    AppBottomSheets().countriesBottomSheet(context);
                  },
                  title:
                  Text(personalDataController.countryNameController.value),
                  tileColor: AppColors.GREY_Light_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 10),
                const Text("المدينة"),
                ListTile(
                  onTap: () {
                    AppBottomSheets().citiesBottomSheet(context);
                  },
                  title: Text(personalDataController.cityNameController.value),
                  tileColor: AppColors.GREY_Light_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 16),
                ConditionalBuilder(
                  condition: !personalDataController.isLoadingEditData.value,
                  builder: (context) =>
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          title: "حفظ",
                          foregroundColor: AppColors.WHITE_COLOR,
                          overlayColor: AppColors.WHITE_COLOR,
                          onPress: () {
                            personalDataController.editClientInfo(
                              personalDataController.userNameController.value
                                  .text,
                              personalDataController.emailController.value.text,
                              personalDataController.completePhoneNumber.value.text,
                              personalDataController.phoneCodeController.value
                                  .text,
                              personalDataController.cityID.value == ""
                                  ? authController.defaultCity.value
                                  : personalDataController.cityID.value,
                              personalDataController.profileImageFile.value,
                              context,
                            );
                          },
                        ),
                      ),
                  fallback: (context) => const CustomCircleProgress(),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    });
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
}
