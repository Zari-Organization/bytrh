import 'package:bytrh/Utils/app_colors.dart';
import 'package:bytrh/View/Widgets/custom_circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Logic/controllers/auth_controller.dart';

class TermsScreen extends StatelessWidget {
  TermsScreen({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        title: const Text("حولنا"),
        centerTitle: true,
      ),
      body: Obx(() {
        return authController.termsData?.value == null
            ? const CustomCircleProgress()
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${authController.termsData?.value}"),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}
