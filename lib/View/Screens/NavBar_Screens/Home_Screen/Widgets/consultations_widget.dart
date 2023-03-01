import 'package:bytrh/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:developer';

import '../../../../../Logic/controllers/Advertisements_Controllers/advertisements_controller.dart';
import '../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../Notifications/local_notifications.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_icons.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../Widgets/custom_circle_progress.dart';

class ConsultationWidget extends StatelessWidget {
  ConsultationWidget({Key? key}) : super(key: key);
  final instantConsultationsController =
      Get.find<InstantConsultationsController>();
  final termConsultationsController = Get.find<TermConsultationsController>();
  final advertisementsController = Get.find<AdvertisementsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الإستشارات",
          style: TextStyle(color: AppColors.BLACK_COLOR, fontSize: 20),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () async {
                await instantConsultationsController.getGeoLocationPosition();
                advertisementsController.advertisementLocation.value = "INNER_PAGES";
                advertisementsController.advertisementService.value = "URGENT_CONSULT";
                await Get.toNamed(Routes.instantConsultationsScreen);
              },
              child: SizedBox(
                height: 150,
                child: Obx(() => Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: instantConsultationsController
                              .isLoadingLocation.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomCircleProgress(),
                                Text(
                                  "جاري الحصول علي موقعك ...",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppIcons.instant_consultation_icon,
                                  height: 50,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "إستشارة فورية",
                                  style: TextStyle(
                                    color: AppColors.MAIN_COLOR,
                                  ),
                                ),
                              ],
                            ),
                    ))),
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () async {
                await termConsultationsController.getGeoLocationPosition();
                advertisementsController.advertisementLocation.value = "INNER_PAGES";
                advertisementsController.advertisementService.value = "CONSULT";
                await Get.toNamed(Routes.termConsultationsScreen);
              },
              child: SizedBox(
                height: 150,
                child: Obx(
                  () => Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: termConsultationsController.isLoadingLocation.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomCircleProgress(),
                                Text(
                                  "جاري الحصول علي موقعك ...",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppIcons.term_consultation_icon,
                                  height: 50,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "إستشارة آجلة",
                                  style: TextStyle(
                                    color: AppColors.MAIN_COLOR,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ],
    );
  }
}
