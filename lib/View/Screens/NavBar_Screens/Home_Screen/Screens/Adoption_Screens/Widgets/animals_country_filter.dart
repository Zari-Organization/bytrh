import 'dart:developer';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';

class AnimalsCountryFilter extends StatelessWidget {
  AnimalsCountryFilter({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (adoptionController.isLoadingCountries.value) {
          return const CustomCircleProgress();
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
                    'اختر الدولة',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: adoptionController.countriesList
                      .map((item) => DropdownMenuItem<String>(
                    value: item.idCountry.toString(),
                    child: Text(
                      item.countryName,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: adoptionController.idCountry.value,
                  onChanged: (value) {
                    adoptionController.idCountry.value = value as String;
                    adoptionController.getCities();
                    log(adoptionController.idCountry.value);
                  },
                ),
              ),
            );
          }
        }
    );
  }
}
