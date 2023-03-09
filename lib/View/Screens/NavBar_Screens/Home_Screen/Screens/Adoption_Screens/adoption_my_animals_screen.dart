import 'dart:developer';

import 'package:bytrh/Routes/routes.dart';
import 'package:bytrh/Utils/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../../Utils/app_images.dart';
import '../../../../../Widgets/auth_button.dart';
import '../../../../../Widgets/custom_circle_progress.dart';
import 'Widgets/adoption_list_widget.dart';

class AdoptionMyAnimalsScreen extends StatelessWidget {
  AdoptionMyAnimalsScreen({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (adoptionController.isLoadingMyAdoptions.value) {
        return CustomCircleProgress();
      } else if (adoptionController.myAdoptionsList.isEmpty) {
        return Center(
          child: Text("لايوجد لديك حيوانات متاحة للتبني"),
        );
      } else {
        return Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemCount: adoptionController.myAdoptionsList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await adoptionController
                              .setDataToAdoptionMyAnimalsDetails(
                                  adoptionController
                                      .myAdoptionsList[index].idAdoption
                                      .toString());
                          Get.toNamed(Routes.adoptionMyAnimalsDetailsScreen);
                        },
                        child: Card(
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.GREY_Light_COLOR,
                            ),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(17),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                      imageUrl: adoptionController
                                          .myAdoptionsList[index].petPicture,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        AppImages.placeholder,
                                        width: 100,
                                        // height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        AppImages.placeholder,
                                        width: 100,
                                        // height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        adoptionController
                                            .myAdoptionsList[index].petName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        " ${adoptionController.myAdoptionsList[index].animalSubCategoryName} / ${adoptionController.myAdoptionsList[index].petStrain}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppIcons.location_icon,
                                            color: AppColors.GREY_COLOR,
                                          ),
                                          Text(
                                            adoptionController
                                                .myAdoptionsList[index]
                                                .cityName,
                                            style: TextStyle(
                                                color: AppColors.GREY_COLOR),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    if (adoptionController
                                            .myAdoptionsList[index]
                                            .adoptionStatus !=
                                        "ADOPTED")
                                      DropdownButton<String>(
                                        icon: SvgPicture.asset(
                                            AppIcons.list_icon),
                                        underline: SizedBox(),
                                        items: adoptionController
                                                    .myAdoptionsList[index]
                                                    .adoptionStatus ==
                                                "PENDING"
                                            ? <String>[
                                                'تعديل',
                                                'حذف',
                                              ].map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()
                                            : <String>[
                                                'تعديل',
                                                'حذف',
                                                'تم التبني'
                                              ].map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        onChanged: (value) async {
                                          log(value.toString());
                                          if (value == "تعديل") {
                                            await adoptionController
                                                .setDataToAdoptionMyAnimalsDetails(
                                                    adoptionController
                                                        .myAdoptionsList[index]
                                                        .idAdoption
                                                        .toString());
                                            await adoptionController
                                                .getAdoptionAnimalsCategory();
                                            adoptionController
                                                    .selectedAdoptionAnimalsGenderValue
                                                    .value =
                                                adoptionController
                                                    .adoptionAnimalsGenderList[
                                                        0]
                                                    .toString();
                                            await adoptionController
                                                .getCountries();
                                            adoptionController.idCountry.value =
                                                adoptionController
                                                    .adoptionsMyAnimalsDetails
                                                    .value
                                                    .idCountry
                                                    .toString();
                                            adoptionController.idCity.value =
                                                adoptionController
                                                    .adoptionsMyAnimalsDetails
                                                    .value
                                                    .idCity
                                                    .toString();
                                            await adoptionController
                                                .getCities();
                                            adoptionController
                                                    .selectedAdoptionAnimalsCategoryValue
                                                    .value =
                                                adoptionController
                                                    .adoptionsMyAnimalsDetails
                                                    .value
                                                    .idAnimalSubCategory
                                                    .toString();
                                            Get.toNamed(Routes
                                                .adoptionEditMyAnimalScreen);
                                          } else {
                                            await adoptionController
                                                .addMyAdoptionAnimalStatus(
                                              adoptionController
                                                  .myAdoptionsList[index]
                                                  .idAdoption
                                                  .toString(),
                                              value == "حذف"
                                                  ? "CANCELLED"
                                                  : "ADOPTED",
                                              context,
                                            );
                                            adoptionController
                                                .getMyAdoptionsList();
                                          }
                                        },
                                      ),
                                    Text(
                                      getCountDownTitle(adoptionController
                                          .myAdoptionsList[index]
                                          .adoptionStatus),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.GREY_COLOR,
                                        // overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(16),child: Align(alignment: AlignmentDirectional.bottomCenter,child: ConditionalBuilder(
              condition: (!adoptionController
                  .isLoadingAdoptionAnimalsCategory.value &&
                  !adoptionController.isLoadingCountries.value &&
                  !adoptionController.isLoadingCountries.value),
              builder: (context) => CustomButton(
                title: "إضافة حيوان جديد",
                backgroundColor: AppColors.WHITE_COLOR,
                onPress: () async {
                  await adoptionController.getAdoptionAnimalsCategory();
                  adoptionController
                      .selectedAdoptionAnimalsGenderValue.value =
                      adoptionController.adoptionAnimalsGenderList[0]
                          .toString();
                  await adoptionController.getCountries();
                  await adoptionController.getCities();
                  adoptionController.idCity.value =
                      adoptionController.citiesList[0].idCity.toString();
                  Get.toNamed(Routes.adoptionAddAnimalScreen);
                },
              ),
              fallback: (context) => const CustomCircleProgress(),
            ),),),
          ],
        );
      }
    });
  }

  String getCountDownTitle(status) {
    switch (status) {
      case "PENDING":
        return "في انتظار موافقة الأدمن";
      case "ADOPTED":
        return "تم التبني";
      case "CANCELLED":
        return "غير نشط";
      default:
        return "";
    }
  }
}
