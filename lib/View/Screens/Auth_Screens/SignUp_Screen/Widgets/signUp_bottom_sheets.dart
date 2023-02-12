import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Logic/controllers/auth_controller.dart';
import '../../../../../Utils/app_colors.dart';


class SignUpBottomSheets {
  countriesBottomSheet(BuildContext context) {
    return Get.bottomSheet(isScrollControlled: true, Obx(() {
      final authController = Get.find<AuthController>();
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
                      authController.idCountry.value = authController.countriesList[index].idCountry.toString();
                      authController.countryNameController.value = authController.countriesList[index].countryName;
                      authController.citiesList.clear();
                      authController.cityNameController.value = "";
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
                    authController.cityID.value = authController.citiesList[index].idCity.toString();
                    authController.cityNameController.value = authController.citiesList[index].cityName.toString();
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
