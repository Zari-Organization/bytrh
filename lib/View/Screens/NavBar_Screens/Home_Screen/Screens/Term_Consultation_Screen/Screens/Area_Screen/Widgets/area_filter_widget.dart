import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';

class AreaWidgetFilter extends StatelessWidget {
  AreaWidgetFilter({Key? key}) : super(key: key);
  final termConsultationsController = Get.find<TermConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (termConsultationsController.isLoadingAreas.value) {
        return const CustomCircleProgress();
      } else {
        if (termConsultationsController.areasList.isEmpty) {
          return const SizedBox();
        } else if (termConsultationsController.selectedAreaValue.value ==
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
              items: termConsultationsController.areasList
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
              value: termConsultationsController.selectedAreaValue.value,
              onChanged: (value) {
                termConsultationsController.selectedAreaValue.value =
                    value as String;
                termConsultationsController.getConsultationsDoctors();
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
