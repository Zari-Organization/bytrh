import 'package:bytrh/Utils/app_icons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:bytrh/Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import 'package:intl/intl.dart';
import '../../../../../../../../Routes/routes.dart';
import '../../../../../../../../Utils/app_colors.dart';
import '../../../../../../../Widgets/custom_circle_progress.dart';

class InstantsConsultationsCartScreen extends StatelessWidget {
  InstantsConsultationsCartScreen({Key? key}) : super(key: key);
  final instantConsultationsController =
      Get.find<InstantConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (instantConsultationsController.isLoadingConsultationsCart.value) {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.MAIN_COLOR,
            title: const Text("أستشاراتي"),
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
          body: ListView.separated(
            itemCount:
                instantConsultationsController.consultationsCartList.length,
            // itemCount: 2,
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            physics: BouncingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if(instantConsultationsController
                      .consultationsCartList[index].consultStatus!="PENDING"){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: AppColors.MAIN_COLOR,
                        content: Text(
                          "تم حجز هذة الاستشارة بالفعل".tr,
                        ),
                      ),
                    );
                  }else{
                    instantConsultationsController.setConsultationsDoctorReservationTime(
                      instantConsultationsController
                          .consultationsCartList[index].idConsult
                          .toString(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "الحالة :",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              instantConsultationsController
                                  .consultationsCartList[index].consultStatus,
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.GREY_COLOR),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppColors.MAIN_COLOR,
                                  backgroundImage: NetworkImage(
                                    instantConsultationsController
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
                                      instantConsultationsController
                                          .consultationsCartList[index]
                                          .doctorName,
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
                                .consultationsCartList[index].consultDate !=
                            DateTime(0))
                          Row(
                            children: [
                              Text(
                                "موعد الحجز:",
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.GREY_COLOR),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${DateFormat('yyyy-MM-dd , HH:mm').format(instantConsultationsController.consultationsCartList[index].consultDate!)}",
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
}
