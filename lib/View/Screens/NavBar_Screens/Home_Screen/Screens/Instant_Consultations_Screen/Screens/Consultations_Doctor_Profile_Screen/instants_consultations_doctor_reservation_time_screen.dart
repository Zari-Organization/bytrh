import 'dart:developer';

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

class InstantsConsultationsDoctorReservationTimeScreen extends StatelessWidget {
  InstantsConsultationsDoctorReservationTimeScreen({Key? key})
      : super(key: key);
  final instantConsultationsController =
      Get.find<InstantConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (instantConsultationsController
          .isLoadingConsultationsDoctorProfile.value) {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("اختر الوقت"),
            centerTitle: true,
          ),
          body: const CustomCircleProgress(),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("اختر الوقت"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await instantConsultationsController.getConsultationsCart();
                  await Get.toNamed(Routes.instantsConsultationsCartScreen);
                },
                icon: Icon(Icons.shopping_cart),
              )
            ],
          ),
          bottomSheet: ConditionalBuilder(
            condition: !instantConsultationsController
                .isLoadingConsultationsDoctorReservationTime.value,
            builder: (context) => Container(
              color: AppColors.WHITE_COLOR,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  instantConsultationsController.selectConsultationTime(context);
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
                  "تأكيد",
                  style: const TextStyle(color: AppColors.WHITE_COLOR),
                ),
              ),
            ),
            fallback: (context) => Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              color: AppColors.WHITE_COLOR,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomCircleProgress(),
                ],
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
                                        .consultationsDoctorReservationTimeData
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
                                      .consultationsDoctorReservationTimeData
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
                                          .consultationsDoctorReservationTimeData
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
                                      "${instantConsultationsController.consultationsDoctorReservationTimeData.value.doctorPricing ?? ""}",
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "المواعيد المتاحة",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.separated(
                        itemCount: instantConsultationsController
                            .consultationsDoctorReservationTimeList.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (BuildContext context, index) {
                          return Obx(() {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.zero,
                              elevation: 2,
                              child: ListTile(
                                onTap: (){
                                  instantConsultationsController.changeTimeSelectedIndex(index);
                                },
                                leading: Checkbox(
                                  side:  BorderSide(color: AppColors.GREY_COLOR),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                  value: instantConsultationsController
                                      .timeSelectedIndex.value ==
                                      index
                                      ? true
                                      : false,
                                  onChanged: (value) {},
                                  activeColor: AppColors.MAIN_COLOR,
                                ),
                                title: Text(
                                  instantConsultationsController
                                      .consultationsDoctorReservationTimeList[
                                          index]
                                      .consultTimeValue
                                      .toString(),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                tileColor: AppColors.GREY_Light_COLOR,
                              ),
                            );
                          });
                        },
                      )
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
