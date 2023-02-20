import 'dart:developer';

import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../../../Routes/routes.dart';
import '../../../../../../../Utils/app_colors.dart';

class ConsultationsDoctorsListWidget extends StatelessWidget {
  ConsultationsDoctorsListWidget({Key? key}) : super(key: key);
  final termConsultationsController = Get.find<TermConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (termConsultationsController.isLoadingConsultationsDoctors.value) {
        return const CustomCircleProgress();
      } else {
        return ListView.separated(
          itemCount:
              termConsultationsController.consultationsDoctorsList.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 16),
          itemBuilder: (BuildContext context, index) {
            return Obx(() {
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
                          termConsultationsController
                              .consultationsDoctorsList[index].doctorPicture,
                        ),
                      ),
                      title: Text(
                        termConsultationsController
                            .consultationsDoctorsList[index].doctorName,
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Column(
                        children: [
                          Row(
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
                          Expanded(
                            child: Checkbox(
                              onChanged: (value) {
                                termConsultationsController.onSelectedDoctor(value!,termConsultationsController.consultationsDoctorsList[index].idDoctor);
                              },
                              activeColor: AppColors.MAIN_COLOR,
                              value: termConsultationsController.doctorChecked.contains(termConsultationsController.consultationsDoctorsList[index].idDoctor),
                            ),
                          ),
                        ],
                      ),
                    ),
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
