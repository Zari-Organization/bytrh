import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../Screens/Terms_Consultations_Doctor_Profile_Screen/Widgets/reservation_day_picker.dart';

class DoctorProfileDaysWidgetFilter extends StatelessWidget {
  DoctorProfileDaysWidgetFilter({Key? key}) : super(key: key);
  final termConsultationsController = Get.find<TermConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "اختر يوم الحجز",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  selectReservationDay(context);
                },
                tileColor: AppColors.GREY_Light_COLOR,
                title: termConsultationsController.selectedDoctorDay.value ==
                            '' ||
                        termConsultationsController.selectedDoctorDate.value ==
                            ''
                    ? Text(
                        "اختر يوم الحجز",
                        style: TextStyle(color: AppColors.GREY_COLOR),
                      )
                    : Text(
                        "${termConsultationsController.selectedDoctorDateLocale.value} , ${termConsultationsController.selectedDoctorDayLocale.value} "),
                trailing: Icon(Icons.arrow_drop_down_outlined),
              ),
              const SizedBox(height: 20),
              termConsultationsController
                      .isLoadingConsultationsDoctorsDays.value
                  ? const CustomCircleProgress()
                  : termConsultationsController
                          .consultationsDoctorsDaysList.isEmpty
                      ? const Center(
                          child: Text("عفوا لا يوجد مواعيد في هذا اليوم"),
                        )
                      : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "اختر الموعد",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: termConsultationsController.consultationsDoctorsDaysList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final time = TimeOfDay(
                          hour: int.parse(termConsultationsController
                              .consultationsDoctorsDaysList[index]
                              .doctorStartHour
                              .split(":")[0]),
                          minute: int.parse(termConsultationsController
                              .consultationsDoctorsDaysList[index]
                              .doctorStartHour
                              .split(":")[1]));
                      return Obx(() {
                        return InkWell(
                          onTap: () {
                            termConsultationsController
                                .changeSelectedIndex(
                              index,
                              termConsultationsController
                                  .consultationsDoctorsDaysList[index]
                                  .idDoctorHour
                                  .toString(),
                            );
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: termConsultationsController
                                    .daySelectedIndex.value ==
                                    index
                                    ? AppColors.SECOND_COLOR
                                    : AppColors.GREY_Light_COLOR,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                time.format(context),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
