import 'dart:developer';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:bytrh/View/Screens/NavBar_Screens/Home_Screen/Screens/Term_Consultation_Screen/Screens/Area_Screen/area_screen.dart';
import 'package:bytrh/View/Screens/NavBar_Screens/Home_Screen/Screens/Term_Consultation_Screen/Screens/Location_Screen/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../Widgets/instant_consultations_cart_icon.dart';
import '../../Widgets/term_consultations_cart_icon.dart';

class TermConsultationsScreen extends StatelessWidget {
  TermConsultationsScreen({Key? key}) : super(key: key);
  final termConsultationsController = Get.find<TermConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.MAIN_COLOR,
          centerTitle: true,
          title: Text("إستشارة آجلة"),
          actions: [
            TermConsultationsCartIcon(),
          ],
        ),
        body: Column(
          children: [
            TabBar(
              controller: termConsultationsController.tabController.value,
              unselectedLabelColor: AppColors.GREY_COLOR,
              labelColor: AppColors.MAIN_COLOR,
              indicatorColor: AppColors.MAIN_COLOR,
              labelStyle: TextStyle(fontSize: 20),
              unselectedLabelStyle: TextStyle(fontSize: 17),
              onTap: (index) async {
                if (index == 0) {
                  termConsultationsController.userLatitude.value = '';
                  termConsultationsController.userLongitude.value = '';
                  termConsultationsController.onInit();
                } else {
                  termConsultationsController.selectedAreaValue.value = "";
                  Position position = await termConsultationsController.getGeoLocationPosition();
                  termConsultationsController.userLatitude.value = position.latitude.toString();
                  termConsultationsController.userLongitude.value = position.longitude.toString();
                }
              },
              tabs: [
                Tab(child: Text("المنطقة")),
                Tab(child: Text("الموقع")),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: termConsultationsController.tabController.value,
                children: [
                  AreaScreen(),
                  LocationScreen(),
                ],
              ),
            ),
          ],
        ));
  }
}
