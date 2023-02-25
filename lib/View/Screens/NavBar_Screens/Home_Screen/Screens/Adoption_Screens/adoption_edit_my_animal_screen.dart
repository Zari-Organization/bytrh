import 'dart:developer';
import 'dart:io';

import 'package:bytrh/Utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../../../Utils/app_icons.dart';
import '../../../../../../Utils/app_images.dart';
import '../../../../../Widgets/auth_button.dart';
import '../../../../../Widgets/custom_circle_progress.dart';
import 'Widgets/animals_category_filter.dart';
import 'Widgets/animals_city_filter.dart';
import 'Widgets/animals_country_filter.dart';
import 'Widgets/animals_gender_filter.dart';
import 'Widgets/custom_textField_widget.dart';
import 'Widgets/pet_details_widget.dart';

class AdoptionEditMyAnimalScreen extends StatelessWidget {
  AdoptionEditMyAnimalScreen({Key? key}) : super(key: key);
  final adoptionController = Get.find<AdoptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.MAIN_COLOR,
            centerTitle: true,
            title: Text("تعديل"),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  adoptionController.editNewAnimalImageFile.value!.path.isEmpty?
                  Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Color(0xffEFEEEE),
                              borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  adoptionController.adoptionsMyAnimalsDetails.value.petPicture
                              )
                            )
                          ),
                        ),
                          CircleAvatar(
                            backgroundColor: AppColors.WHITE_COLOR,
                            child: IconButton(
                              onPressed: () {
                                adoptionController.pickNewAnimalImage();
                              },
                              icon: SvgPicture.asset(
                                AppIcons.upload_icon,
                                color: AppColors.RED_COLOR,
                              ),
                            ),
                          )
                      ],
                    ):
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          adoptionController.pickNewAnimalImage();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Color(0xffEFEEEE),
                              borderRadius: BorderRadius.circular(15)),
                          child: adoptionController
                                  .editNewAnimalImageFile.value!.path.isEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.upload_icon,
                                      color: AppColors.MAIN_COLOR,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "إضافة صورة",
                                      style: TextStyle(
                                        color: AppColors.MAIN_COLOR,
                                      ),
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                      adoptionController.editNewAnimalImageFile.value!,
                                      fit: BoxFit.fill),
                                ),
                        ),
                      ),
                      if (adoptionController
                          .editNewAnimalImageFile.value!.path.isNotEmpty)
                        CircleAvatar(
                          backgroundColor: AppColors.WHITE_COLOR,
                          child: IconButton(
                            onPressed: () {
                              adoptionController.editNewAnimalImageFile.value =
                                  File("");
                            },
                            icon: SvgPicture.asset(
                              AppIcons.delete_icon,
                              color: AppColors.RED_COLOR,
                            ),
                          ),
                        )
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextFieldWidget(
                    hintText: "أسم الحيوان",
                    controller:
                        adoptionController.editAnimalNameController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "السلالة",
                    controller:
                        adoptionController.editAnimalStrainController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText:
                        "السن : مثال (1=عام واحد & 1.2=عام وشهرين & 0.5= 5 اشهر)",
                    keyboardType: TextInputType.number,
                    controller:
                        adoptionController.editAnimalAgeController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "اللون : مثال ( ابيض او White )",
                    controller:
                        adoptionController.editAnimalColorController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "الحجم : مثال ( كبير او Big )",
                    controller:
                        adoptionController.editAnimalSizeController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "الحالة : مثال ( نظيف او Clean )",
                    controller:
                        adoptionController.editAnimalConditionController.value,
                  ),
                  CustomTextFieldWidget(
                    hintText: "الوصف",
                    maxLines: 3,
                    controller: adoptionController
                        .editAnimalDescriptionController.value,
                  ),
                  AnimalsCategoryFilter(),
                  AnimalsGenderFilter(),
                  AnimalsCountryFilter(),
                  AnimalsCityFilter(),
                  SizedBox(height: 20),
                  Text(
                    "الألبوم",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          adoptionController.editAnimalGallery.isEmpty
                              ? SizedBox()
                              : ListView.separated(
                                  itemCount: adoptionController
                                      .editAnimalGallery.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: AppColors.RED_COLOR,
                                          child: IconButton(
                                            onPressed: () {
                                              adoptionController
                                                  .removeFromAnimalGallery(
                                                      adoptionController
                                                          .editAnimalGallery[
                                                              index]
                                                          .idAdoptionGallery,
                                                      index,
                                                      context);
                                            },
                                            icon: SvgPicture.asset(
                                              AppIcons.delete_icon,
                                              color: AppColors.WHITE_COLOR,
                                              // height: 10,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Color(0xffEFEEEE),
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    adoptionController
                                                        .editAnimalGallery[
                                                            index]
                                                        .adoptionGalleryPath),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 8),
                                ),
                          SizedBox(width: 8),
                          adoptionController.editNewAnimalGallery.isEmpty
                              ? SizedBox()
                              : ListView.separated(
                                  itemCount: adoptionController
                                      .editNewAnimalGallery.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: AppColors.RED_COLOR,
                                          child: IconButton(
                                            onPressed: () {
                                              adoptionController
                                                  .editNewAnimalGallery
                                                  .remove(adoptionController
                                                          .editNewAnimalGallery[
                                                      index]);
                                            },
                                            icon: SvgPicture.asset(
                                              AppIcons.delete_icon,
                                              color: AppColors.WHITE_COLOR,
                                              // height: 10,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Color(0xffEFEEEE),
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: FileImage(
                                                  File(
                                                    adoptionController
                                                        .editNewAnimalGallery[
                                                            index]
                                                        .path,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 8),
                                ),
                          InkWell(
                            onTap: () {
                              adoptionController.pickNewAnimalGallery();
                            },
                            child: Container(
                              width: 120,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Color(0xffEFEEEE),
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.upload_icon,
                                    color: AppColors.MAIN_COLOR,
                                  ),
                                  Text(
                                    "إضافة صورة",
                                    style: TextStyle(
                                      color: AppColors.MAIN_COLOR,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  ConditionalBuilder(
                    condition:
                        !adoptionController.isLoadingAddAdoptionAnimal.value,
                    builder: (context) => CustomButton(
                        title: "حفظ",
                        backgroundColor: AppColors.MAIN_COLOR,
                        foregroundColor: AppColors.WHITE_COLOR,
                        overlayColor: AppColors.WHITE_COLOR,
                        onPress: () {
                          var age = adoptionController
                              .addAnimalAgeController.value.text;
                          var year = '';
                          var month = '';
                          if (age.contains('.')) {
                            year = age.split('.')[0] == ''
                                ? "0"
                                : adoptionController
                                    .addAnimalAgeController.value.text
                                    .split('.')[0];
                            month = age.split('.')[1] == ''
                                ? "0"
                                : adoptionController
                                    .addAnimalAgeController.value.text
                                    .split('.')[1];
                          } else {
                            year = age;
                            month = "0";
                          }
                          adoptionController.addAdoptionAnimal(
                            IDAnimalSubCategory: adoptionController
                                .selectedAdoptionAnimalsCategoryValue.value,
                            IDCity: adoptionController.idCity.value,
                            PetName: adoptionController
                                .addAnimalNameController.value.text,
                            PetStrain: adoptionController
                                .addAnimalStrainController.value.text,
                            PetColor: adoptionController
                                .addAnimalColorController.value.text,
                            PetGender: adoptionController
                                .selectedAdoptionAnimalsGenderValue.value,
                            PetAgeMonth: month,
                            PetAgeYear: year,
                            PetSize: adoptionController
                                .addAnimalSizeController.value.text,
                            PetCondition: adoptionController
                                .addAnimalConditionController.value.text,
                            PetDescription: adoptionController
                                .addAnimalDescriptionController.value.text,
                            AdoptionContact: "1",
                            PetPicture:
                                adoptionController.animalImageFile.value!,
                            AdoptionGalleryList:
                                adoptionController.animalGallery,
                            context: context,
                          );
                        }),
                    fallback: (context) => const CustomCircleProgress(),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
