import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../../Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import '../../../../../../../Utils/app_colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  CustomTextFieldWidget(
      {Key? key,
      required this.hintText,
      this.controller,
      this.maxLines,
      this.keyboardType})
      : super(key: key);

  String hintText;
  TextEditingController? controller;
  int? maxLines;
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: AppColors.MAIN_COLOR, height: .8),
        cursorColor: AppColors.BLACK_COLOR,
        // textAlign: TextAlign.end,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.MAIN_COLOR),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.GREY_COLOR, fontSize: 13)),
        onChanged: (text) {},
      ),
    );
  }
}
