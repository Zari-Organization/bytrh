import 'package:bytrh/Utils/app_bottom_sheets.dart';
import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.MAIN_COLOR),
                              child: personalDataController
                                      .profileImageFile.value!.path.isEmpty
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundColor: AppColors.MAIN_COLOR,
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
                                  backgroundColor: AppColors.WHITE_COLOR,
                                  child: SvgPicture.asset(AppIcons.camera_icon),
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
                TitledTextField(
                  title: "رقم الجوال",
                  controller: personalDataController.phoneController.value,
                  fillColor: AppColors.GREY_Light_COLOR,
                  textDirection: TextDirection.ltr,
                ),
                TitledTextField(
                  title: "الإيميل",
                  controller: personalDataController.emailController.value,
                  fillColor: AppColors.GREY_Light_COLOR,
                  textDirection: TextDirection.ltr,
                  // controller: profileController.brandNameEnController.value,
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
                  builder: (context) => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      title: "حفظ",
                      backgroundColor: AppColors.MAIN_COLOR,
                      foregroundColor: AppColors.WHITE_COLOR,
                      overlayColor: AppColors.WHITE_COLOR,
                      onPress: () {
                        personalDataController.editClientInfo(
                          personalDataController.userNameController.value.text,
                          personalDataController.emailController.value.text,
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
}
