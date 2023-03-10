import 'dart:developer';

import 'package:bytrh/Utils/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:bytrh/Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import 'package:intl/intl.dart';
import '../../../../../../../../Logic/controllers/Chat_Controllers/chat_controllers.dart';
import '../../../../../../../../Routes/routes.dart';
import '../../../../../../../../Utils/app_colors.dart';
import '../../../../../../../../Utils/app_images.dart';
import '../../../../../../../Widgets/custom_circle_progress.dart';

class InstantsConsultationsCartScreen extends StatelessWidget {
  InstantsConsultationsCartScreen({Key? key}) : super(key: key);
  final instantConsultationsController =
      Get.find<InstantConsultationsController>();
  final consultationsChatController = Get.find<ConsultationsChatController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (instantConsultationsController.isLoadingConsultationsCart.value) {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("أستشاراتي الفورية"),
            centerTitle: true,
          ),
          body: const CustomCircleProgress(),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("أستشاراتي الفورية"),
            centerTitle: true,
          ),
          body: instantConsultationsController.consultationsCartList.isEmpty
              ? Center(
                  child: Text("لم تقم بعمل أستشارات بعد ."),
                )
              : ListView.separated(
                  itemCount: instantConsultationsController
                      .consultationsCartList.length,
                  // itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    var countDown = instantConsultationsController
                        .consultationsCartList[index].consultCountDown!;
                    return InkWell(
                      onTap: () async {
                        if (instantConsultationsController
                                .consultationsCartList[index].consultStatus ==
                            "PENDING_TIME") {
                          instantConsultationsController
                              .setConsultationsDoctorReservationTime(
                                  instantConsultationsController
                                      .consultationsCartList[index].idConsult
                                      .toString());
                        } else {
                          if (instantConsultationsController
                                  .consultationsCartList[index].consultStatus ==
                              "ONGOING"||instantConsultationsController
                              .consultationsCartList[index].consultStatus ==
                              "ENDED") {
                            consultationsChatController.consultStatus.value = instantConsultationsController.consultationsCartList[index].consultStatus;
                            await consultationsChatController.getConsultationsChatDetails(
                              instantConsultationsController
                                  .consultationsCartList[index].idConsult
                                  .toString(),
                            );
                            Get.toNamed(Routes.consultationsChatScreenScreen);
                          }
                          else if(instantConsultationsController
                              .consultationsCartList[index].consultStatus ==
                              "ACCEPTED"){
                            null;
                          }
                          else{
                            instantConsultationsController.checkConsultStatus(
                              instantConsultationsController
                                  .consultationsCartList[index].idConsult
                                  .toString(),
                              instantConsultationsController
                                  .consultationsCartList[index].consultStatus,
                              "URGENT_CONSULT",
                              context,
                            );
                          }
                        }

                        // if (instantConsultationsController
                        //         .consultationsCartList[index].consultStatus !=
                        //     "PENDING") {
                        //   // ScaffoldMessenger.of(context).showSnackBar(
                        //   //   SnackBar(
                        //   //     duration: Duration(seconds: 2),
                        //   //     backgroundColor: AppColors.MAIN_COLOR,
                        //   //     content: Text(
                        //   //       "تم حجز هذة الاستشارة بالفعل".tr,
                        //   //     ),
                        //   //   ),
                        //   // );
                        //   Get.toNamed(Routes.consultationsChatScreenScreen);
                        // } else {
                        //   instantConsultationsController
                        //       .setConsultationsDoctorReservationTime(
                        //     instantConsultationsController
                        //         .consultationsCartList[index].idConsult
                        //         .toString(),
                        //   );
                        // }
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
                                    getStatus(instantConsultationsController
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
                                        backgroundColor: AppColors.MAIN_COLOR,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            width: 40,
                                            // height: double.infinity,
                                            imageUrl: instantConsultationsController
                                                .consultationsCartList[index]
                                                .doctorPicture ??
                                                "",
                                            placeholder: (context, url) => Image.asset(
                                              width: 20,
                                              color: AppColors.BLACK_COLOR,
                                              // height: double.infinity,
                                              AppImages.user_placeholder,
                                            ),
                                            errorWidget: (context, url, error) =>
                                                Image.asset(
                                                  width: 20,
                                                  color: AppColors.WHITE_COLOR,
                                                  // height: double.infinity,
                                                  AppImages.user_placeholder,
                                                ),
                                          ),
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
                                            instantConsultationsController
                                                    .consultationsCartList[
                                                        index]
                                                    .doctorName ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.SECOND_COLOR,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        instantConsultationsController
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
                              if (instantConsultationsController
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
                                      "${DateFormat.jm(Localizations.localeOf(context).languageCode).format(instantConsultationsController.consultationsCartList[index].consultDate!)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text("-"),
                                    SizedBox(width: 5),
                                    Text(
                                      "${DateFormat.yMMMMEEEEd(Localizations.localeOf(context).languageCode).format(instantConsultationsController.consultationsCartList[index].consultDate!)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 8),
                              if (instantConsultationsController
                                      .consultationsCartList[index]
                                      .consultCountDown!
                                      .minutes != null)
                                Row(
                                  children: [
                                    Text(
                                      getCountDownTitle(
                                          instantConsultationsController
                                              .consultationsCartList[index]
                                              .consultStatus),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.GREY_COLOR),
                                    ),
                                    SizedBox(width: 5),
                                    countDown.days != 0
                                        ? Text("${countDown.days} يوم",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                        : Text(""),
                                    countDown.hours != 0
                                        ? Text("${countDown.hours} ساعة",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                        : Text(""),
                                    countDown.minutes != 0
                                        ? Text(
                                            "${countDown.minutes} دقيقة",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text("اقل من دقيقة",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
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

  String getStatus(status) {
    switch (status) {
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
      case "EXPIRED":
        return " انتهت صلاحيتها";
      case "NO_RESPONSE":
        return " لم يستجب الدكتور";
      case "SKIPPED":
        return " تم التخطي من قبل الدكتور";
      case "CANCELLED":
        return " تم الغاء الاستشارة";
      default:
        return "";
    }
  }

  String getCountDownTitle(status) {
    switch (status) {
      case "ACCEPTED":
        return "ستبدأ المحادثة بعد :";
      case "ONGOING":
        return "ستنتهي المحادثة بعد :";
      default:
        return "";
    }
  }
}
