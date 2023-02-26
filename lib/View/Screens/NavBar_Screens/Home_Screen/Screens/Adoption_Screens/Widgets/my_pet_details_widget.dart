import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../../Utils/app_colors.dart';

class MyPetDetailsWidget extends StatelessWidget {
  MyPetDetailsWidget({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if(adoptionController.adoptionsMyAnimalsDetails.value.petAgeYear!=null||adoptionController.adoptionsMyAnimalsDetails.value.petAgeMonth!=null)
          Container(
            height: 70,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.BLACK_COLOR)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${adoptionController.adoptionsMyAnimalsDetails.value.petAgeYear}.${adoptionController.adoptionsMyAnimalsDetails.value.petAgeMonth}",
                      style: TextStyle(color: AppColors.MAIN_COLOR),
                    ),
                    SizedBox(width: 5),
                    Text("سنة",style: TextStyle(color: AppColors.MAIN_COLOR),),
                  ],
                ),
                Text("السن"),
              ],
            ),
          ),
          SizedBox(width: 5),
          if(adoptionController.adoptionsMyAnimalsDetails.value.petColor!=null)
          Container(
            height: 70,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.BLACK_COLOR)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(
            "${adoptionController.adoptionsMyAnimalsDetails.value.petColor}",
              style: TextStyle(color: AppColors.MAIN_COLOR),
            ),
                Text("اللون"),
              ],
            ),
          ),
          SizedBox(width: 5),
          if(adoptionController.adoptionsMyAnimalsDetails.value.petGender!=null)
          Container(
            height: 70,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.BLACK_COLOR)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(
            adoptionController.adoptionsMyAnimalsDetails.value.petGender=="MALE"?"ذكر":"انثي",
              style: TextStyle(color: AppColors.MAIN_COLOR),
            ),
                Text("النوع"),
              ],
            ),
          ),
          SizedBox(width: 5),
          if(adoptionController.adoptionsMyAnimalsDetails.value.petSize!=null)
          Container(
            height: 70,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.BLACK_COLOR)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${adoptionController.adoptionsMyAnimalsDetails.value.petSize}",
                  style: TextStyle(color: AppColors.MAIN_COLOR),
                ),
                Text("الحجم"),
              ],
            ),
          ),
          SizedBox(width: 5),
          if(adoptionController.adoptionsMyAnimalsDetails.value.petCondition!=null)
          Container(
            height: 70,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.BLACK_COLOR)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${adoptionController.adoptionsMyAnimalsDetails.value.petCondition}",
                  style: TextStyle(color: AppColors.MAIN_COLOR),
                ),
                Text("الحالة"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
