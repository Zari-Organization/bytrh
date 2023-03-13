import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../../Logic/controllers/Chat_Controllers/chat_controllers.dart';
import '../../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../../../../Routes/routes.dart';
import '../../../../../../../../Utils/app_colors.dart';
import '../../../../../../../../Utils/app_images.dart';
import '../../../../../../../Widgets/custom_circle_progress.dart';

class TermConsultationsListScreen extends StatelessWidget {
  TermConsultationsListScreen({Key? key}) : super(key: key);
  final termConsultationsController = Get.find<TermConsultationsController>();
  final consultationsChatController = Get.find<ConsultationsChatController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (termConsultationsController.isLoadingConsultationsList.value) {
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
          body: termConsultationsController.consultationsList.isEmpty
              ? Center(
                  child: Text("لم تقم بعمل أستشارات بعد ."),
                )
              : ListView.separated(
                  itemCount:
                      termConsultationsController.consultationsList.length,
                  // itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    var countDown = termConsultationsController
                        .consultationsList[index].consultCountDown!;
                    return InkWell(
                      onTap: () async {
                        if (termConsultationsController
                                .consultationsList[index].consultStatus ==
                            "PENDING_TIME") {
                          termConsultationsController.setDataDoctorProfile(
                            termConsultationsController
                                .consultationsList[index].idConsult
                                .toString(),
                            "CONSULT",
                          );
                        } else {
                          if (termConsultationsController
                                      .consultationsList[index]
                                      .consultStatus ==
                                  "ONGOING" ||
                              termConsultationsController
                                      .consultationsList[index]
                                      .consultStatus ==
                                  "ENDED") {
                            consultationsChatController.consultStatus.value =
                                termConsultationsController
                                    .consultationsList[index].consultStatus;
                            await consultationsChatController
                                .getConsultationsChatDetails(
                              termConsultationsController
                                  .consultationsList[index].idConsult
                                  .toString(),
                            );
                            Get.toNamed(Routes.consultationsChatScreenScreen);
                          } else if (termConsultationsController
                                  .consultationsList[index].consultStatus ==
                              "ACCEPTED") {
                            null;
                          } else {
                            termConsultationsController.checkConsultStatus(
                              termConsultationsController
                                  .consultationsList[index].idConsult
                                  .toString(),
                              termConsultationsController
                                  .consultationsList[index].consultStatus,
                              "CONSULT",
                              context,
                            );
                          }
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
                                        .consultationsList[index]
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            width: 40,
                                            // height: double.infinity,
                                            imageUrl:
                                                termConsultationsController
                                                        .consultationsList[
                                                            index]
                                                        .doctorPicture ??
                                                    "",
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              width: 20,
                                              color: AppColors.BLACK_COLOR,
                                              // height: double.infinity,
                                              AppImages.user_placeholder,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
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
                                            termConsultationsController
                                                    .consultationsList[
                                                        index]
                                                    .doctorName ??
                                                "غير متاح حالياً",
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
                                        termConsultationsController
                                            .consultationsList[index]
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
                                      .consultationsList[index]
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
                                      "${DateFormat.jm(Localizations.localeOf(context).languageCode).format(termConsultationsController.consultationsList[index].consultDate!)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text("-"),
                                    SizedBox(width: 5),
                                    Text(
                                      "${DateFormat.yMMMMEEEEd(Localizations.localeOf(context).languageCode).format(termConsultationsController.consultationsList[index].consultDate!)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 8),
                              if (termConsultationsController
                                      .consultationsList[index]
                                      .consultCountDown!
                                      .minutes !=
                                  null)
                                Row(
                                  children: [
                                    Text(
                                      getCountDownTitle(
                                          termConsultationsController
                                              .consultationsList[index]
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
