import 'dart:developer';

import 'package:bytrh/Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../../../Logic/controllers/Advertisements_Controllers/advertisements_controller.dart';
import '../../../../../../Routes/routes.dart';
import '../../../../../Logic/controllers/Products_Controllers/products_controller.dart';
import '../../../../../Logic/controllers/my_animals_controller.dart';
import '../../Home_Screen/Screens/Adoption_Screens/adoption_my_animals_screen.dart';
import '../../Products_Screen/products_my_animals_screen.dart';

class MyAnimalsScreen extends StatelessWidget {
  MyAnimalsScreen({Key? key}) : super(key: key);
  final myAnimalsController = Get.find<MyAnimalsController>();
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: Text("حيواناتي"),
      ),
      body: WillPopScope(
        onWillPop: () => onWillPop()!,
        child: Column(
          children: [
            TabBar(
              controller: myAnimalsController.tabController.value,
              unselectedLabelColor: AppColors.GREY_COLOR,
              labelColor: AppColors.SECOND_COLOR,
              indicatorColor: AppColors.SECOND_COLOR,
              labelStyle: TextStyle(fontSize: 20),
              unselectedLabelStyle: TextStyle(fontSize: 17),
              onTap: (index) async {
                if (index == 0) {}
                if (index == 1) {
                  productsController.getProductsMyAnimals();
                }
              },
              tabs: [
                Tab(child: Text("للتبني")),
                Tab(child: Text("للبيع")),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: myAnimalsController.tabController.value,
                children: [
                  AdoptionMyAnimalsScreen(),
                  ProductsMyAnimalsScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool>? onWillPop() async {
    return true;
  }
}
