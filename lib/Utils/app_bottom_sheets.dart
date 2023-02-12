import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Logic/controllers/My_Account_Controllers/personal_data_controller.dart';
import '../Logic/controllers/auth_controller.dart';
import 'app_colors.dart';

class AppBottomSheets {
  countriesBottomSheet(BuildContext context) {
    return Get.bottomSheet(isScrollControlled: true, Obx(() {
      final authController = Get.find<AuthController>();
      final personalDataController = Get.find<PersonalDataController>();
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.WHITE_COLOR,
        ),
        // height: AppConstants.mediaHeight(context) / 1.3,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
            child: ListView.separated(
              itemCount: authController.countriesList.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                return Obx(() {
                  return ListTile(
                    onTap: () async {
                      // personalDataController.countryID.value = authController.countriesList[index].idCountry.toString();
                      authController.idCountry.value = authController
                          .countriesList[index].idCountry
                          .toString();
                      personalDataController.countryNameController.value =
                          authController.countriesList[index].countryName;
                      authController.citiesList.clear();
                      personalDataController.cityNameController.value = "";
                      await authController.getCities();
                      Get.back();
                    },
                    title: Text(
                      authController.countriesList[index].countryName,
                    ),
                    trailing: Text(
                      authController.defaultCountry.value ==
                              authController.countriesList[index].idCountry
                                  .toString()
                          ? "افتراضي"
                          : "",
                      style: TextStyle(color: AppColors.GREEN_COLOR),
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: AppColors.BLACK_COLOR,
                );
              },
            ),
          ),
        ),
      );
    }));
  }

  citiesBottomSheet(BuildContext context) {
    return Get.bottomSheet(isScrollControlled: true, Obx(() {
      final authController = Get.find<AuthController>();
      final personalDataController = Get.find<PersonalDataController>();
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.WHITE_COLOR,
        ),
        // height: AppConstants.mediaHeight(context) / 1.3,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
            child: ListView.separated(
              itemCount: authController.citiesList.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  onTap: () {
                    personalDataController.cityID.value = authController.citiesList[index].idCity.toString();
                    personalDataController.cityNameController.value = authController.citiesList[index].cityName.toString();
                    Get.back();
                  },
                  title: Text(authController.citiesList[index].cityName),
                  trailing: Text(
                    authController.defaultCity.value ==
                        authController.citiesList[index].idCity
                            .toString()
                        ? "افتراضي"
                        : "",
                    style: TextStyle(color: AppColors.GREEN_COLOR),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: AppColors.GREY_Light_COLOR,
                );
              },
            ),
          ),
        ),
      );
    }));
  }
}
