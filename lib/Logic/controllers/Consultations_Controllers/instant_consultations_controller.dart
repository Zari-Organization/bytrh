import 'package:flutter/material.dart';
import 'package:get/get.dart';



class InstantConsultationsController extends GetxController with GetSingleTickerProviderStateMixin {
  late Rx<TabController> tabController =TabController(length: 2, vsync: this).obs;

  @override
  void onInit() async {
    super.onInit();
    tabController.value = TabController(length: 2, vsync: this);
  }
}
