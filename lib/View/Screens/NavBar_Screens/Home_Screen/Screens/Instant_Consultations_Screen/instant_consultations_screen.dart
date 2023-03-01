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
import '../../Widgets/instant_consultations_cart_icon.dart';
import 'Screens/Location_Screen/location_screen.dart';
import 'Screens/Area_Screen/area_screen.dart';

class InstantConsultationsScreen extends StatelessWidget {
  InstantConsultationsScreen({Key? key}) : super(key: key);
  final instantConsultationsController = Get.find<InstantConsultationsController>();
  final advertisementsController = Get.find<AdvertisementsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.MAIN_COLOR,
        centerTitle: true,
        title: Text("إستشارة فورية"),
        actions: [InstantConsultationsCartIcon()],
      ),
      body: WillPopScope(
        onWillPop: () =>onWillPop()!,
        child: Column(
          children: [
            TabBar(
              controller: instantConsultationsController.tabController.value,
              unselectedLabelColor: AppColors.GREY_COLOR,
              labelColor: AppColors.MAIN_COLOR,
              indicatorColor: AppColors.MAIN_COLOR,
              labelStyle: TextStyle(fontSize: 20),
              unselectedLabelStyle: TextStyle(fontSize: 17),
              onTap: (index) async {
                if (index == 0) {
                  instantConsultationsController.userLatitude.value = '';
                  instantConsultationsController.userLongitude.value = '';
                  instantConsultationsController.onInit();
                } else {
                  instantConsultationsController.selectedAreaValue.value = "";
                  Position position = await instantConsultationsController
                      .getGeoLocationPosition();
                  instantConsultationsController.userLatitude.value =
                      position.latitude.toString();
                  instantConsultationsController.userLongitude.value =
                      position.longitude.toString();
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
                controller: instantConsultationsController.tabController.value,
                children: [
                  AreaScreen(),
                  LocationScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<bool>? onWillPop() async {
    advertisementsController.advertisementLocation.value = "HOME";
    advertisementsController.advertisementService.value = "NONE";
    advertisementsController.getAdvertisements();
    return true;
  }
}
