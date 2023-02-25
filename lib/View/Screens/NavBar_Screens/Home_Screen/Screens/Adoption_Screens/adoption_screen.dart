import 'package:bytrh/Routes/routes.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../Widgets/auth_button.dart';
import '../../../../../Widgets/custom_circle_progress.dart';
import 'Widgets/adoption_list_widget.dart';

class AdoptionScreen extends StatelessWidget {
  AdoptionScreen({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.MAIN_COLOR,
          centerTitle: true,
          title: Text("تبني الحيوانات"),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Obx(
                  () => ConditionalBuilder(
                    condition: (!adoptionController
                            .isLoadingAdoptionAnimalsCategory.value &&
                        !adoptionController.isLoadingCountries.value &&
                        !adoptionController.isLoadingCountries.value),
                    builder: (context) => CustomButton(
                      title: "إضافة حيوان للتبني",
                      backgroundColor: AppColors.WHITE_COLOR,
                      foregroundColor: AppColors.MAIN_COLOR,
                      overlayColor: AppColors.MAIN_COLOR,
                      onPress: () async {
                        await adoptionController.getAdoptionAnimalsCategory();
                        adoptionController.selectedAdoptionAnimalsGenderValue.value = adoptionController.adoptionAnimalsGenderList[0].toString();
                        await adoptionController.getCountries();
                        await adoptionController.getCities();
                        adoptionController.idCity.value = adoptionController.citiesList[0].idCity.toString();
                        Get.toNamed(Routes.adoptionAddAnimalScreen);
                      },
                    ),
                    fallback: (context) => const CustomCircleProgress(),
                  ),
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      "https://images.unsplash.com/photo-1644675272883-0c4d582528d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
                ),
                SizedBox(height: 30),
                AdoptionListWidget(),
              ],
            ),
          ),
        ));
  }
}
