import 'package:bytrh/Utils/app_colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../Logic/controllers/Consultations_Controllers/term_consultations_controller.dart';
import '../../../../../../../Widgets/custom_circle_progress.dart';
import '../../Widgets/animals_category_filter_widget.dart';
import 'Widgets/area_filter_widget.dart';
import '../../Widgets/area_textField_widget.dart';
import '../../Widgets/consultations_doctors_list_widget.dart';

class AreaScreen extends StatelessWidget {
  AreaScreen({Key? key}) : super(key: key);
  final termConsultationsController = Get.find<TermConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SingleChildScrollView(
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
                  "الأطباء المتاحون الآن",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(height: 16),
                ConsultationsDoctorsListWidget(),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
        Obx(
          () => ConditionalBuilder(
            condition:
                !termConsultationsController.isLoadingTermRequestConsult.value,
            builder: (context) => Obx(
              () => Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (termConsultationsController.doctorChecked.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            "اختر دكتور او اكثر لطلب الاستشارة",
                          ),
                        ),
                      );
                    } else {
                      termConsultationsController.termRequestConsult(
                          listDays: termConsultationsController.doctorChecked,
                          context: context);
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 15),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        termConsultationsController.doctorChecked.isEmpty
                            ? AppColors.GREY_COLOR
                            : AppColors.MAIN_COLOR),
                    foregroundColor:
                        MaterialStateProperty.all(AppColors.WHITE_COLOR),
                  ),
                  child: Text(
                    "طلب إستشارة",
                  ),
                ),
              ),
            ),
            fallback: (context) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(
                color: AppColors.MAIN_COLOR,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
