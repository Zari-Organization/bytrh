import 'dart:developer';

import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../../../../Routes/routes.dart';
import '../../../../../../../Utils/app_colors.dart';
import '../../../../../../../Utils/app_images.dart';

class ConsultationsDoctorsListWidget extends StatelessWidget {
  ConsultationsDoctorsListWidget({Key? key}) : super(key: key);
  final instantConsultationsController = Get.find<InstantConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (instantConsultationsController.isLoadingConsultationsDoctors.value) {
        return const CustomCircleProgress();
      } else if (instantConsultationsController.consultationsDoctorsList.isEmpty) {
        return const Center(child: Text("لايوجد اطباء ."),);
      } else {
        return ListView.separated(
          itemCount: instantConsultationsController.consultationsDoctorsList.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 16),
          itemBuilder: (BuildContext context, index) {
            return Obx(() {
              if (instantConsultationsController
                      .consultationsDoctorsList[index].doctorName
                      .toLowerCase()
                      .startsWith(instantConsultationsController
                          .areaTextFieldValue.value
                          .toLowerCase()) ||
                  instantConsultationsController
                      .consultationsDoctorsList[index].doctorPricing
                      .toString()
                      .toLowerCase()
                      .startsWith(instantConsultationsController
                          .areaTextFieldValue.value
                          .toLowerCase())) {
                return InkWell(
                  onTap: () {
                    if(instantConsultationsController
                        .consultationsDoctorsList[index]
                        .doctorStatus !=
                        "ACTIVE"){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            "الدكتور غير متاح حالياً",
                          ),
                        ),
                      );
                    }else{
                      instantConsultationsController.setDataDoctorProfile(
                        instantConsultationsController
                            .consultationsDoctorsList[index].idDoctor
                            .toString(),
                        "URGENT_CONSULT",
                      );
                    }

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
                        leading: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.MAIN_COLOR,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                  imageUrl: instantConsultationsController
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
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: AppColors.WHITE_COLOR,
                              child: Icon(
                                size: 12,
                                Icons.circle,
                                color: instantConsultationsController
                                            .consultationsDoctorsList[index]
                                            .doctorStatus ==
                                        "ACTIVE"
                                    ? AppColors.GREEN_COLOR
                                    : AppColors.RED_COLOR,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          instantConsultationsController
                              .consultationsDoctorsList[index].doctorName,
                          style: TextStyle(fontSize: 16,color: AppColors.SECOND_COLOR),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${instantConsultationsController.consultationsDoctorsList[index].doctorPricing}",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "ر.س",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        )),
                  ),
                );
              }
              return SizedBox();
            });
          },
        );
      }
    });
  }
}
