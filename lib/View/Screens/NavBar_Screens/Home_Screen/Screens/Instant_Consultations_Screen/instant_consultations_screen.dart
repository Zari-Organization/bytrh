import 'package:bytrh/Logic/controllers/Consultations_Controllers/instant_consultations_controller.dart';
import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'Widgets/doctors_widget.dart';
import 'Widgets/specialization_widget.dart';

class InstantConsultationsScreen extends StatelessWidget {
  InstantConsultationsScreen({Key? key}) : super(key: key);
  final instantConsultationsController =
      Get.find<InstantConsultationsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.MAIN_COLOR,
          centerTitle: true,
          title: Text("إستشارة فورية"),
        ),
        body: Column(
          children: [
            TabBar(
              controller: instantConsultationsController.tabController.value,
              unselectedLabelColor: AppColors.GREY_COLOR,
              labelColor: AppColors.MAIN_COLOR,
              indicatorColor: AppColors.MAIN_COLOR,
              labelStyle: TextStyle(fontSize: 20),
              unselectedLabelStyle: TextStyle(fontSize: 17),
              tabs: [
                Tab(child: Text("التخصص")),
                Tab(child: Text("الأطباء")),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: instantConsultationsController.tabController.value,
                children: [
                  SpecializationWidget(),
                  DoctorsWidget(),
                ],
              ),
            ),
          ],
        ));
  }
}
