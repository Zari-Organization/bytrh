import 'dart:developer';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';

class AnimalsCategoryFilter extends StatelessWidget {
  AnimalsCategoryFilter({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (adoptionController.isLoadingAdoptionAnimalsCategory.value) {
          return const CustomCircleProgress();
        } else {
          if (adoptionController.adoptionAnimalsCategoryList.isEmpty) {
            return const SizedBox();
          } else {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.GREY_COLOR),
                borderRadius: BorderRadius.circular(10)
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    'اختر النوع',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: adoptionController.adoptionAnimalsCategoryList
                      .map((item) => DropdownMenuItem<String>(
                    value: item.idAnimalSubCategory.toString(),
                    child: Text(
                      item.animalSubCategoryName,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: adoptionController
                      .selectedAdoptionAnimalsCategoryValue.value,
                  onChanged: (value) {
                    adoptionController.selectedAdoptionAnimalsCategoryValue.value = value as String;
                    log(adoptionController.selectedAdoptionAnimalsCategoryValue.value);
                  },
                ),
              ),
            );
          }
        }
      },
    );
  }
}
