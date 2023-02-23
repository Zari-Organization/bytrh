import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../../../../Utils/app_colors.dart';
import '../../../../../../../Widgets/custom_circle_progress.dart';

class TermConsultationsCartScreen extends StatelessWidget {
  TermConsultationsCartScreen({Key? key}) : super(key: key);
  final termConsultationsController = Get.find<TermConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (termConsultationsController.isLoadingConsultationsCart.value) {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("أستشاراتي الآجلة"),
            centerTitle: true,
          ),
          body: const CustomCircleProgress(),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("أستشاراتي الآجلة"),
            centerTitle: true,
          ),
          body: termConsultationsController.consultationsCartList.isEmpty
              ? Center(
                  child: Text("لم تقم بعمل أستشارات بعد ."),
                )
              : ListView.separated(
                  itemCount:
                      termConsultationsController.consultationsCartList.length,
                  // itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (termConsultationsController
                                .consultationsCartList[index].consultStatus ==
                            "PENDING_TIME") {
                          termConsultationsController.setDataDoctorProfile(
                            termConsultationsController
                                .consultationsCartList[index].idConsult
                                .toString(),
                            "CONSULT",
                          );
                        }
                        else if (termConsultationsController
                            .consultationsCartList[index].consultStatus ==
                            "ACCEPTED"||termConsultationsController
                            .consultationsCartList[index].consultStatus ==
                            "ONGOING"||termConsultationsController
                            .consultationsCartList[index].consultStatus ==
                            "ENDED"||termConsultationsController
                            .consultationsCartList[index].consultStatus ==
                            "REJECTED"){
                          termConsultationsController.checkConsultStatus(
                            termConsultationsController.consultationsCartList[index].idConsult.toString(),
                            termConsultationsController.consultationsCartList[index].consultStatus,
                            "CONSULT",
                            context,
                          );
                        }
                      },
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: AppColors.GREY_Light_COLOR,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "الحالة :",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    getStatus(termConsultationsController
                                        .consultationsCartList[index]
                                        .consultStatus),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.GREY_COLOR),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: AppColors.MAIN_COLOR,
                                        backgroundImage: NetworkImage(
                                          termConsultationsController
                                                  .consultationsCartList[index]
                                                  .doctorPicture ??
                                              "",
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Row(
                                        children: [
                                          Text(
                                            "الدكتور:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.GREY_COLOR),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            termConsultationsController
                                                    .consultationsCartList[
                                                        index]
                                                    .doctorName ??
                                                "غير متاح حالياً",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.MAIN_COLOR,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        termConsultationsController
                                            .consultationsCartList[index]
                                            .consultAmount
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "ر.س",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              if (termConsultationsController
                                      .consultationsCartList[index]
                                      .consultDate !=
                                  DateTime(0))
                                Row(
                                  children: [
                                    Text(
                                      "موعد الحجز:",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.GREY_COLOR),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "${DateFormat('yyyy-MM-dd , HH:mm').format(termConsultationsController.consultationsCartList[index].consultDate!)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      }
    });
  }

 String getStatus(status){
    switch(status) {
      case "ONGOING":
        return "جارية";
      case "PENDING":
        return "معلقه";
      case "PENDING_TIME":
        return "في انتظار تحديد الوقت";
      case "ACCEPTED":
        return "تم قبول الإستشارة";
      case "REJECTED":
        return "تم رفض الإستشارة";
      case "ENDED":
        return "انتهت";
      default:
        return "";
    }
  }

}
