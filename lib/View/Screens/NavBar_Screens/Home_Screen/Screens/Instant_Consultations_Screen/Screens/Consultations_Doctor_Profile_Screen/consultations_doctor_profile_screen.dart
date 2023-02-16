import 'package:bytrh/Utils/app_alerts.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:bytrh/Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';

import '../../../../../../../../Routes/routes.dart';
import '../../../../../../../../Utils/app_colors.dart';
import '../../../../../../../Widgets/custom_circle_progress.dart';

class ConsultationsDoctorProfileScreen extends StatelessWidget {
  ConsultationsDoctorProfileScreen({Key? key}) : super(key: key);
  final instantConsultationsController = Get.find<InstantConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (instantConsultationsController
          .isLoadingConsultationsDoctorProfile.value) {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("صفحة الدكتور"),
            centerTitle: true,
          ),
          body: const CustomCircleProgress(),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("صفحة الدكتور"),
            centerTitle: true,
            actions: [
              IconButton(
                  splashRadius: 25,
                  onPressed: () async {
                    await instantConsultationsController.getConsultationsCart();
                    await Get.toNamed(Routes.instantsConsultationsCartScreen);
                  },
                  icon: SvgPicture.asset(AppIcons.cart_icon),
              )
            ],
          ),
          bottomSheet: ConditionalBuilder(
            condition: !instantConsultationsController
                .isLoadingRequestConsultation.value,
            builder: (context) => Container(
              color: AppColors.WHITE_COLOR,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  instantConsultationsController.requestConsultation(
                    instantConsultationsController
                        .consultationsDoctorProfileData.value.idDoctor
                        .toString(),
                    context,
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 15),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.MAIN_COLOR),
                  foregroundColor:
                      MaterialStateProperty.all(AppColors.WHITE_COLOR),
                ),
                child: Text(
                  "طلب إستشارة",
                  style: const TextStyle(color: AppColors.WHITE_COLOR),
                ),
              ),
            ),
            fallback: (context) => Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              color: AppColors.WHITE_COLOR,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [CustomCircleProgress()],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                    margin: EdgeInsets.zero,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: AppColors.MAIN_COLOR,
                                backgroundImage: NetworkImage(
                                  instantConsultationsController
                                          .consultationsDoctorProfileData
                                          .value
                                          .doctorPicture ??
                                      "",
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    instantConsultationsController
                                        .consultationsDoctorProfileData
                                        .value
                                        .doctorName,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.location_icon,
                                        color: AppColors.BLACK_COLOR,
                                        height: 18,
                                        width: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        instantConsultationsController
                                            .consultationsDoctorProfileData
                                            .value
                                            .location,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.dollar_icon,
                                        color: AppColors.MAIN_COLOR,
                                        height: 18,
                                        width: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${instantConsultationsController.consultationsDoctorProfileData.value.doctorPricing ?? ""}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.MAIN_COLOR),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "ر.س",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.MAIN_COLOR),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     Row(
                          //       children: [
                          //         SvgPicture.asset(
                          //           AppIcons.star_icon,
                          //           height: 18,
                          //           width: 18,
                          //         ),
                          //         SizedBox(
                          //           width: 5,
                          //         ),
                          //         const Text(
                          //           "4.9",
                          //           style: TextStyle(
                          //               fontSize: 12,
                          //               color: AppColors.GOLD_COLOR),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: 5,
                          //     ),
                          //     const Text(
                          //       "1700 زائر",
                          //       style: TextStyle(fontSize: 12),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "السيرة الذاتية",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.GREY_Light_COLOR),
                        child: Text(
                          instantConsultationsController
                                  .consultationsDoctorProfileData
                                  .value
                                  .doctorBiography ??
                              "",
                          style: TextStyle(color: AppColors.GREY_COLOR),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }
}
