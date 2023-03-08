import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../Logic/controllers/main_controller.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_icons.dart';

class MainScreen extends StatelessWidget {
  final mainController = Get.find<MainController>();
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: mainController.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.SECOND_COLOR,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.home_icon,
                    color: mainController.currentIndex.value == 0
                        ? AppColors.SECOND_COLOR
                        : AppColors.GREY_COLOR),
                label: 'الرئيسية'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.category_icon,
                    color: mainController.currentIndex.value == 1
                        ? AppColors.SECOND_COLOR
                        : AppColors.GREY_COLOR),
                label: 'المنتجات'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.auction_icon,
                    color: mainController.currentIndex.value == 2
                        ? AppColors.SECOND_COLOR
                        : AppColors.GREY_COLOR),
                label: 'مزاد'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.user_icon,
                    color: mainController.currentIndex.value == 3
                        ? AppColors.SECOND_COLOR
                        : AppColors.GREY_COLOR),
                label: 'حسابي'),
          ],
          onTap: (index) {
            mainController.currentIndex.value = index;
            if(mainController.currentIndex.value==1){
              productsController.getProductsCategory();
            }
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
