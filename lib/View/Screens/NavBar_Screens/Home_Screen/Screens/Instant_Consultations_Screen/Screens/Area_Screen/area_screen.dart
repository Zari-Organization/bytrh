import 'package:bytrh/Utils/app_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://images.unsplash.com/photo-1644675272883-0c4d582528d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
            ),
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
