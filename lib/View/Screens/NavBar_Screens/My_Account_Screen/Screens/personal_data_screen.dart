import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Logic/controllers/My_Account_Controllers/personal_data_controller.dart';
import '../../../../Widgets/auth_button.dart';
import '../../../../Widgets/titled_textField.dart';


class PersonalDataScreen extends StatelessWidget {
  PersonalDataScreen({Key? key}) : super(key: key);
  final personalDataController = Get.find<PersonalDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        title: const Text("بياناتي الشخصية"),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (personalDataController.isLoading.value) {
            return const CustomCircleProgress();
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitledTextField(
                      title: "الأسم",
                      controller:
                          personalDataController.userNameController.value,
                      fillColor: AppColors.GREY_Light_COLOR,
                    ),
                    TitledTextField(
                      title: "رقم الجوال",
                      controller: personalDataController.phoneController.value,
                      fillColor: AppColors.GREY_Light_COLOR,
                    ),
                    TitledTextField(
                      title: "الإيميل",
                      controller: personalDataController.emailController.value,
                      fillColor: AppColors.GREY_Light_COLOR,
                      // controller: profileController.brandNameEnController.value,
                    ),
                    TitledTextField(
                      title: "المدينة الحالية",
                      controller: personalDataController.cityController.value,
                      fillColor: AppColors.GREY_Light_COLOR,
                      // controller: profileController.brandNameEnController.value,
                    ),
                    const SizedBox(height: 16),
                    ConditionalBuilder(
                      condition: !personalDataController.isLoadingEditData.value,
                      builder: (context) => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child:  CustomButton(
                          title: "حفظ",
                          backgroundColor: AppColors.MAIN_COLOR,
                          foregroundColor: AppColors.WHITE_COLOR,
                          overlayColor: AppColors.WHITE_COLOR,
                          onPress: () {
                            personalDataController.editClientInfo(
                              personalDataController.userNameController.value.text,
                              // personalDataController.phoneController.value.text,
                              personalDataController.emailController.value.text,
                              personalDataController.cityController.value.text,
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
            );
          }
        },
      ),
    );
  }
}
