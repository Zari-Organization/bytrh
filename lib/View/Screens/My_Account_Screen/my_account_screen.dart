import 'package:bytrh/Routes/routes.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Logic/controllers/personal_data_controller.dart';
import '../../../Utils/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    padding: EdgeInsets.symmetric(
                        vertical: 30, horizontal: 10),
                    child: CustomCircleProgress(),
                  ),
                );
              } else {
                return Card(
                  elevation: 0.2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("هلا",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                        const SizedBox(width: 10),
                        Text(personalDataController.userNameController.value.text),
                      ],
                    ),
                    subtitle:
                        Text(personalDataController.emailController.value.text),
                  ),
                );
              }
            }),
            CustomListTile(
              icon: AppIcons.user_icon,
              title: "بياناتي الشخصية",
              onTap: () {
                Get.toNamed(Routes.personalDataScreen);
              },
            ),
            CustomListTile(
              icon: AppIcons.animals_icon,
              title: "حيواناتي",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.calendar_icon,
              title: "مواعيدي",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.box_icon,
              title: "طلباتي",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.wallet_icon,
              title: "المحفظة",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.location_icon,
              title: "العناوين",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.favorite_icon,
              title: "المنتجات المفضلة",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.category_icon,
              title: "الفئات المفضلة",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.lock_icon,
              title: "تغيير كلمة المرور",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.setting_icon,
              title: "الإعدادت",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.Info_icon,
              title: "حولنا",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.call_icon,
              title: "تواصل معنا",
              onTap: () {},
            ),
            CustomListTile(
              icon: AppIcons.logout_icon,
              iconColor: AppColors.RED_COLOR,
              titleColor: AppColors.RED_COLOR,
              title: "تسجيل خروج",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
