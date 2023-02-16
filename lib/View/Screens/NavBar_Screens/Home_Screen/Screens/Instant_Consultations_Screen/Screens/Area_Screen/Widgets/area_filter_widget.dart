import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';

class AreaWidgetFilter extends StatelessWidget {
  AreaWidgetFilter({Key? key}) : super(key: key);
  final instantConsultationsController =
      Get.find<InstantConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (instantConsultationsController.isLoadingAreas.value) {
        return const CustomCircleProgress();
      } else {
        if (instantConsultationsController.areasList.isEmpty) {
          return const SizedBox();
        } else if (instantConsultationsController.selectedAreaValue.value ==
            "") {
          return const CustomCircleProgress();
        } else {
          return DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Text(
                'اختر المنطقة',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: instantConsultationsController.areasList
                  .map((item) => DropdownMenuItem<String>(
                        value: item.idArea.toString(),
                        child: Text(
                          item.areaName,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: instantConsultationsController.selectedAreaValue.value,
              onChanged: (value) {
                instantConsultationsController.selectedAreaValue.value =
                    value as String;
                instantConsultationsController.getConsultationsDoctors();
              },
              // buttonHeight: 40,
              // buttonWidth: 200,
              // itemHeight: 40,
              // dropdownMaxHeight: 200,
            ),
          );
        }
      }
    });
  }
}
