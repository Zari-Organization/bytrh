import 'dart:developer';

import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../../../../Routes/routes.dart';
import '../../../../../../../Utils/app_colors.dart';

class ConsultationsDoctorsListWidget extends StatelessWidget {
  ConsultationsDoctorsListWidget({Key? key}) : super(key: key);
  final instantConsultationsController = Get.find<
      InstantConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (instantConsultationsController.isLoadingConsultationsDoctors.value) {
        return const CustomCircleProgress();
      } else {
        return ListView.separated(
          itemCount:
          instantConsultationsController.consultationsDoctorsList.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 16),
          itemBuilder: (BuildContext context, index) {
            return Obx(() {
              if (instantConsultationsController.consultationsDoctorsList[index]
                  .doctorName.toLowerCase()
                  .startsWith(
                  instantConsultationsController.areaTextFieldValue.value
                      .toLowerCase())||instantConsultationsController.consultationsDoctorsList[index]
                  .doctorPricing.toString().toLowerCase()
                  .startsWith(
                  instantConsultationsController.areaTextFieldValue.value
                      .toLowerCase())) {
                return InkWell(
                  onTap: () {
                    instantConsultationsController.setDataDoctorProfile(
                      instantConsultationsController.consultationsDoctorsList[index].idDoctor.toString(),
                      "URGENT_CONSULT",
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
                          radius: 25,
                          backgroundColor: AppColors.MAIN_COLOR,
                          backgroundImage: NetworkImage(
                            instantConsultationsController
                                .consultationsDoctorsList[index].doctorPicture,
                          ),
                        ),
                        title: Text(
                          instantConsultationsController
                              .consultationsDoctorsList[index].doctorName,
                          style: TextStyle(fontSize: 16),
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
              return Center(child: Text("لا يوجد دكاترة"),);
            });
          },
        );
      }
    });
  }
}
