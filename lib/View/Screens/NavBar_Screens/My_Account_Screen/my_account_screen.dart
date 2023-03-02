import 'dart:developer';

import 'package:bytrh/Routes/routes.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../Logic/controllers/My_Account_Controllers/personal_data_controller.dart';
import '../../../../Utils/app_alerts.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_images.dart';
import 'Widgets/custom_listTile.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final personalDataController = Get.find<PersonalDataController>();
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: const Text("حسابي"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(() {
              if (personalDataController.isLoading.value) {
                return const Card(
                  elevation: 0.2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    child: CustomCircleProgress(),
                  ),
                );
              } else {
                return Card(
                  margin: EdgeInsets.zero,
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 60,
                        height: double.infinity,
                        imageUrl: personalDataController
                            .clientData.value.clientPicture,
                        placeholder: (context, url) => Image.asset(
                          width: 60,
                          height: double.infinity,
                          AppImages.user_placeholder,
                        ),
                        errorWidget: (context, url, error) =>
                            Image.asset(
                              width: 60,
                              height: double.infinity,
                              AppImages.user_placeholder,
                            ),
                      ),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "هلا",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        const SizedBox(width: 10),
                        Text(personalDataController
                            .userNameController.value.text),
                      ],
                    ),
                    subtitle:
                        Text(personalDataController
                            .emailController.value.text),
                  ),
                );
              }
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  CustomListTile(
                    icon: AppIcons.user_icon,
                    title: "بياناتي الشخصية",
                    onTap: () async {
                       personalDataController.onInit();
                      Get.toNamed(Routes.personalDataScreen);
                    },
                  ),
                  CustomListTile(
                    icon: AppIcons.animals_icon,
                    title: "حيواناتي",
                    onTap: () async{
                      adoptionController.getMyAdoptionsList();
                      Get.toNamed(Routes.adoptionMyAnimalsScreen);
                    },
                  ),
                  // CustomListTile(
                  //   icon: AppIcons.calendar_icon,
                  //   title: "مواعيدي",
                  //   onTap: () {},
                  // ),
                  // CustomListTile(
                  //   icon: AppIcons.box_icon,
                  //   title: "طلباتي",
                  //   onTap: () {},
                  // ),
                  CustomListTile(
                    icon: AppIcons.wallet_icon,
                    title: "المحفظة",
                    onTap: () {
                      Get.toNamed(Routes.walletScreen);
                    },
                  ),
                  // CustomListTile(
                  //   icon: AppIcons.location_icon,
                  //   title: "العناوين",
                  //   onTap: () {},
                  // ),
                  // CustomListTile(
                  //   icon: AppIcons.favorite_icon,
                  //   title: "المنتجات المفضلة",
                  //   onTap: () {},
                  // ),
                  // CustomListTile(
                  //   icon: AppIcons.category_icon,
                  //   title: "الفئات المفضلة",
                  //   onTap: () {},
                  // ),
                  CustomListTile(
                    icon: AppIcons.lock_icon,
                    title: "تغيير كلمة المرور",
                    onTap: () {
                      Get.toNamed(Routes.changePasswordScreen);
                    },
                  ),
                  // CustomListTile(
                  //   icon: AppIcons.setting_icon,
                  //   title: "الإعدادت",
                  //   onTap: () {},
                  // ),
                  CustomListTile(
                    icon: AppIcons.Info_icon,
                    title: "حولنا",
                    onTap: () {
                      Get.toNamed(Routes.aboutUsScreen);
                    },
                  ),
                  CustomListTile(
                    icon: AppIcons.call_icon,
                    title: "تواصل معنا",
                    onTap: () {
                      Get.toNamed(Routes.contactUsScreen);
                    },
                  ),
                  CustomListTile(
                    icon: AppIcons.logout_icon,
                    iconColor: AppColors.RED_COLOR,
                    titleColor: AppColors.RED_COLOR,
                    title: "تسجيل خروج",
                    onTap: () {
                      // log("hello");
                      AppAlerts().logoutPop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
