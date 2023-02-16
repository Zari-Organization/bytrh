import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../../../../Utils/app_colors.dart';

class AreaTextFieldWidget extends StatelessWidget {
  AreaTextFieldWidget({Key? key}) : super(key: key);
  final instantConsultationsController =
      Get.find<InstantConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        style: TextStyle(color: AppColors.BLACK_COLOR, height: .8),
        // textAlign: TextAlign.end,
        decoration: InputDecoration(
            fillColor: AppColors.GREY_Light_COLOR,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            hintText: 'أبحث عن دكتور ب الإسم او بسعر الاستشارة .....',
            suffixIcon: Icon(
              Icons.search,
              color: AppColors.MAIN_COLOR,
            ),
            hintStyle: TextStyle(color: AppColors.GREY_COLOR, fontSize: 13)),
        onChanged: (text) {
          instantConsultationsController.areaTextFieldValue.value = text;
        },
      ),
    );
  }
}
