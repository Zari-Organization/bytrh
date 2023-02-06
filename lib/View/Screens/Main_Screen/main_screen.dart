import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../Logic/controllers/main_controller.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_icons.dart';

class MainScreen extends StatelessWidget {
  final mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: mainController.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.MAIN_COLOR,
          items:  [
            BottomNavigationBarItem(icon: SvgPicture.asset(AppIcons.home_icon), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppIcons.category_icon), label: 'المنتجات'),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppIcons.auction_icon), label: 'مزاد'),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppIcons.user_icon), label: 'حسابي'),
          ],
          onTap: (index) {
            mainController.currentIndex.value = index;
          },
        ),
        body: IndexedStack(
          index: mainController.currentIndex.value,
          children: mainController.tabs,
        ),
      );
    });
  }
}
