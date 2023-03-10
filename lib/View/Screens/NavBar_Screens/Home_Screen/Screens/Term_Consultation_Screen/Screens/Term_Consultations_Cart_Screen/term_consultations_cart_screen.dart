import 'dart:developer';
import 'package:bytrh/Utils/app_alerts.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../../Logic/controllers/Chat_Controllers/chat_controllers.dart';
import '../../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../../../../Routes/routes.dart';
import '../../../../../../../../Utils/app_colors.dart';
import '../../../../../../../../Utils/app_images.dart';
import '../../../../../../../Widgets/custom_circle_progress.dart';

class TermConsultationsCartScreen extends StatelessWidget {
  TermConsultationsCartScreen({Key? key}) : super(key: key);
  final termConsultationsController = Get.find<TermConsultationsController>();
  final consultationsChatController = Get.find<ConsultationsChatController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (termConsultationsController.isLoadingConsultationsCart.value) {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("السلة"),
            centerTitle: true,
          ),
          body: const CustomCircleProgress(),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("السلة"),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      termConsultationsController.removeConsultationsCart(
                        IDConsultCart: "",
                        context: context,
                      );
                    },
                    icon: SvgPicture.asset(
                      AppIcons.delete_icon,
                      color: AppColors.RED_COLOR,
                    ),
                    splashRadius: 25,
                  ),
                  backgroundColor: AppColors.WHITE_COLOR,
                  radius: 17,
                ),
              )
            ],
          ),
          body: Obx(() {
            if(termConsultationsController.consultationsCartList.isEmpty){
              return Center(
                child: Text("لم تقم بعمل أستشارات بعد ."),
              );
            }
            else{
              return Stack(
                children: [
                  ListView.separated(
                      itemCount:
                      termConsultationsController.consultationsCartList.length,
                      // itemCount: 2,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16),
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        // var countDown = termConsultationsController
                        //     .consultationsCartList[index].consultCountDown!;
                        return InkWell(
                          onTap: () async {
                            //   if (termConsultationsController
                            //           .consultationsCartList[index].consultStatus ==
                            //       "PENDING_TIME") {
                            //     termConsultationsController.setDataDoctorProfile(
                            //       termConsultationsController
                            //           .consultationsCartList[index].idConsult
                            //           .toString(),
                            //       "CONSULT",
                            //     );
                            //   } else {
                            //     if (termConsultationsController
                            //                 .consultationsCartList[index]
                            //                 .consultStatus ==
                            //             "ONGOING" ||
                            //         termConsultationsController
                            //                 .consultationsCartList[index]
                            //                 .consultStatus ==
                            //             "ENDED") {
                            //       consultationsChatController.consultStatus.value = termConsultationsController.consultationsCartList[index].consultStatus;
                            //       await consultationsChatController
                            //           .getConsultationsChatDetails(
                            //         termConsultationsController
                            //             .consultationsCartList[index].idConsult
                            //             .toString(),
                            //       );
                            //       Get.toNamed(Routes.consultationsChatScreenScreen);
                            //     } else if (termConsultationsController
                            //             .consultationsCartList[index].consultStatus ==
                            //         "ACCEPTED") {
                            //       null;
                            //     } else{
                            //       termConsultationsController.checkConsultStatus(
                            //         termConsultationsController
                            //             .consultationsCartList[index].idConsult
                            //             .toString(),
                            //         termConsultationsController
                            //             .consultationsCartList[index].consultStatus,
                            //         "CONSULT",
                            //         context,
                            //       );
                            //     }
                            //   }
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
                                      // Text(
                                      //   "الحالة :",
                                      //   style: TextStyle(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      CircleAvatar(
                                        child: IconButton(
                                          onPressed: () {
                                            termConsultationsController
                                                .removeConsultationsCart(
                                              IDConsultCart:
                                              termConsultationsController
                                                  .consultationsCartList[index]
                                                  .idConsultCart
                                                  .toString(),
                                              context: context,
                                            );
                                          },
                                          icon: SvgPicture.asset(
                                            AppIcons.delete_icon,
                                            color: AppColors.WHITE_COLOR,
                                          ),
                                          splashRadius: 25,
                                        ),
                                        backgroundColor: AppColors.RED_COLOR,
                                        radius: 17,
                                      )
                                      // Text(
                                      //   getStatus(termConsultationsController
                                      //       .consultationsCartList[index]
                                      //       .consultStatus),
                                      //   style: TextStyle(
                                      //       fontSize: 14,
                                      //       color: AppColors.GREY_COLOR),
                                      // ),
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
                                                    .consultationsCartList[
                                                index]
                                                    .doctorPicture,
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
                                                    .consultationsCartList[index]
                                                    .doctorName,
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
                                          "${DateFormat.jm(Localizations.localeOf(context).languageCode).format(termConsultationsController.consultationsCartList[index].consultDate)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text("-"),
                                        SizedBox(width: 5),
                                        Text(
                                          "${DateFormat.yMMMMEEEEd(Localizations.localeOf(context).languageCode).format(termConsultationsController.consultationsCartList[index].consultDate)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(height: 8),
                                  // if (termConsultationsController
                                  //         .consultationsCartList[index]
                                  //         .consultCountDown!
                                  //         .minutes !=
                                  //     null)
                                  //   Row(
                                  //     children: [
                                  //       Text(
                                  //         getCountDownTitle(
                                  //             termConsultationsController
                                  //                 .consultationsCartList[index]
                                  //                 .consultStatus),
                                  //         style: TextStyle(
                                  //             fontSize: 14,
                                  //             color: AppColors.GREY_COLOR),
                                  //       ),
                                  //       SizedBox(width: 5),
                                  //       countDown.days != 0
                                  //           ? Text("${countDown.days} يوم",
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.bold))
                                  //           : Text(""),
                                  //       countDown.hours != 0
                                  //           ? Text("${countDown.hours} ساعة",
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.bold))
                                  //           : Text(""),
                                  //       countDown.minutes != 0
                                  //           ? Text(
                                  //               "${countDown.minutes} دقيقة",
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.bold),
                                  //             )
                                  //           : Text("اقل من دقيقة",
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.bold)),
                                  //     ],
                                  //   )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  Align(alignment: AlignmentDirectional.bottomCenter,child: ConditionalBuilder(
                    condition:
                    !termConsultationsController.isLoadingTermRequestConsult.value,
                    builder: (context) =>  Container(
                        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                              // termConsultationsController.termRequestConsult(
                              //     listDays: termConsultationsController.doctorChecked,
                              //     context: context);
                              AppAlerts().termsRequestConsultationsNotePop(context);
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
                            backgroundColor: MaterialStateProperty.all(
                                 AppColors.SECOND_COLOR),
                            foregroundColor: MaterialStateProperty.all(AppColors.WHITE_COLOR),
                          ),
                          child: Text(
                            "طلب إستشارة",
                          ),
                        ),
                      ),

                    fallback: (context) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(
                        color: AppColors.SECOND_COLOR,
                      ),
                    ),
                  ),),
                ],
              );
            }
          })
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
