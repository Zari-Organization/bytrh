import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';

class AnimalsCategoryWidgetFilter extends StatelessWidget {
  AnimalsCategoryWidgetFilter({Key? key}) : super(key: key);
  final termConsultationsController = Get.find<TermConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (termConsultationsController.isLoadingAnimalsCategory.value) {
          return const CustomCircleProgress();
        } else {
          if (termConsultationsController.animalsCategoryList.isEmpty) {
            return const SizedBox();
          } else if (termConsultationsController.selectedAnimalsCategoryValue.value ==
              "") {
            return const CustomCircleProgress();
          } else {
            return DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text(
                  'اختر التصنيف',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: termConsultationsController.animalsCategoryList
                    .map((item) => DropdownMenuItem<String>(
                          value: item.idAnimalCategory.toString(),
                          child: Text(
                            item.animalCategoryName,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: termConsultationsController
                    .selectedAnimalsCategoryValue.value,
                onChanged: (value) {
                  termConsultationsController.selectedAnimalsCategoryValue.value = value as String;
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
      },
    );
  }
}
