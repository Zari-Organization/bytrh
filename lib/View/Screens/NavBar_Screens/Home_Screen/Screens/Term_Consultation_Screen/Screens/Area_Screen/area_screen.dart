import 'package:bytrh/Utils/app_colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../../../Widgets/custom_circle_progress.dart';
import '../../../../../Widgets/advertisements_Widget.dart';
import '../../Widgets/animals_category_filter_widget.dart';
import 'Widgets/area_filter_widget.dart';
import '../../Widgets/area_textField_widget.dart';
import '../../Widgets/consultations_doctors_list_widget.dart';

class AreaScreen extends StatelessWidget {
  AreaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AreaWidgetFilter(),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: AnimalsCategoryWidgetFilter(),
                ),
              ],
            ),
            AreaTextFieldWidget(),
            SizedBox(
              height: 16,
            ),
            AdvertisementsWidget(),
            SizedBox(height: 30),
            Text(
              "الأطباء :",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(height: 16),
            ConsultationsDoctorsListWidget(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
