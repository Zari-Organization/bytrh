import 'dart:developer';

import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../../../Routes/routes.dart';
import '../../../../../../../Utils/app_colors.dart';
import '../../../../../../../Utils/app_images.dart';

class ConsultationsDoctorsListWidget extends StatelessWidget {
  ConsultationsDoctorsListWidget({Key? key}) : super(key: key);
  final termConsultationsController = Get.find<TermConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (termConsultationsController.isLoadingConsultationsDoctors.value) {
        return const CustomCircleProgress();
      } else if (termConsultationsController.consultationsDoctorsList.isEmpty) {
        return const Center(
          child: Text("لايوجد اطباء ."),
        );
      } else {
        return ListView.separated(
          itemCount:
              termConsultationsController.consultationsDoctorsList.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 16),
          itemBuilder: (BuildContext context, index) {
            return Obx(
              () {
                if (termConsultationsController
                        .consultationsDoctorsList[index].doctorName
                        .toLowerCase()
                        .startsWith(termConsultationsController
                            .areaTextFieldValue.value
                            .toLowerCase()) ||
                    termConsultationsController
                        .consultationsDoctorsList[index].doctorPricing
                        .toString()
                        .toLowerCase()
                        .startsWith(termConsultationsController
                            .areaTextFieldValue.value
                            .toLowerCase())) {
                  return InkWell(
                    onTap: () {
                      termConsultationsController.setDataDoctorProfileFromAdvertisement(
                        termConsultationsController
                            .consultationsDoctorsList[index].idDoctor
                            .toString(),
                        "CONSULT",
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.zero,
                      elevation: 2,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        tileColor: Color(0xffFAFAFA),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.MAIN_COLOR,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                              imageUrl: termConsultationsController
                                  .consultationsDoctorsList[index]
                                  .doctorPicture,
                              placeholder: (context, url) => Image.asset(
                                width: 20,
                                // height: double.infinity,
                                AppImages.user_placeholder,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                width: 20,
                                color: AppColors.WHITE_COLOR,
                                // height: double.infinity,
                                AppImages.user_placeholder,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          termConsultationsController
                              .consultationsDoctorsList[index].doctorName,
                          style: TextStyle(
                              fontSize: 16, color: AppColors.SECOND_COLOR),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${termConsultationsController.consultationsDoctorsList[index].doctorPricing}",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "ر.س",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            );
          },
        );
      }
    });
  }
}
