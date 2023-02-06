import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../Logic/controllers/auth_controller.dart';
import '../../../Logic/controllers/personal_data_controller.dart';
import '../../../Routes/routes.dart';
import '../../Widgets/auth_button.dart';
import '../../Widgets/titled_textField.dart';

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
      body: Obx(() {
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
                    hintText: personalDataController.clientData.value.clientName,
                    fillColor: AppColors.GREY_Light_COLOR,
                  ),
                  TitledTextField(
                    title: "رقم الجوال",
                    hintText: personalDataController.clientData.value.clientPhone,
                    fillColor: AppColors.GREY_Light_COLOR,
                  ),
                  TitledTextField(
                    title: "الإيميل",
                    hintText: personalDataController.clientData.value.clientEmail,
                    fillColor: AppColors.GREY_Light_COLOR,
                    // controller: profileController.brandNameEnController.value,
                  ),
                  TitledTextField(
                    title: "المدينة الحالية",
                    hintText: personalDataController.clientData.value.idClient.toString(),
                    fillColor: AppColors.GREY_Light_COLOR,
                    // controller: profileController.brandNameEnController.value,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    title: "حفظ",
                    backgroundColor: AppColors.MAIN_COLOR,
                    foregroundColor: AppColors.WHITE_COLOR,
                    overlayColor: AppColors.WHITE_COLOR,
                    onPress: () {},
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
