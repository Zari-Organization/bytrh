import 'dart:developer';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';

class AnimalsGenderFilter extends StatelessWidget {
  AnimalsGenderFilter({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
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
                'اختر الجنس',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: adoptionController.adoptionAnimalsGenderList
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item=="MALE"?"ذكر":"انثي",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
                  .toList(),
              value: adoptionController.selectedAdoptionAnimalsGenderValue.value,
              onChanged: (value) {
                adoptionController.selectedAdoptionAnimalsGenderValue.value = value as String;
                log(adoptionController.selectedAdoptionAnimalsGenderValue.value);
              },
            ),
          ),
        );
      },
    );
  }
}
